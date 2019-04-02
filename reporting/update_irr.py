# -*- coding: utf-8 -*-
"""
Created on Sun Mar  4 21:08:06 2018

@author: mbray201
"""
import numpy as np
import pandas as pd
import sqlalchemy, pyodbc, urllib

connection = pyodbc.connect('DRIVER={SQL Server Native Client 11.0};'
                      'SERVER=WestBIS-RPT;DATABASE=BI_MIP;'
                      'Trusted_Connection=yes')

######################################################################
# Utility functions
######################################################################
def ifnull(var, val):
  if var in (None,'', [], False):
    return val
  return var

######################################################################
# Prep SMB and ENT data inputs for future use
######################################################################
def prep_smb_ent_inputs(probuild_id):
    
    sql = ('''EXEC miBuilds.update_rpt_Cashflow_SMB_ENT_df
                   @probuild_id = {}
           ''').format(probuild_id)
    df = pd.read_sql(sql, connection)
    
    ### Extract inputs from the GET request
    #probuild_id = df['probuild_id'].values[0]
    customer_contribution = float(ifnull(df['customer_contribution'].values[0], 0))
    access_fees_one_time = float(ifnull(df['access_fees_one_time'].values[0], 0))
    access_fees_monthly = float(ifnull(df['access_fees_monthly'].values[0], 0))
    row_est_build_cost = float(ifnull(df['row_est_build_cost'].values[0], 0))
    headend_cost = float(ifnull(df['headend_cost'].values[0], 0))
    transport_cost = float(ifnull(df['transport_cost'].values[0], 0))
    private_property_cost = float(ifnull(df['private_property_cost'].values[0], 0))
    lat_construct_upfront_pct = float(ifnull(df['lat_construct_upfront_pct'].values[0], 0))
    smb_arpu = float(ifnull(df['smb_arpu'].values[0], 0))
    ent_arpu = float(ifnull(df['ent_arpu'].values[0], 0))
    smb_12mo_pen = float(ifnull(df['smb_12mo_pen'].values[0], 0))
    smb_36mo_pen = float(ifnull(df['smb_36mo_pen'].values[0], 0))
    ent_12mo_pen = float(ifnull(df['ent_12mo_pen'].values[0], 0))
    ent_36mo_pen = float(ifnull(df['ent_36mo_pen'].values[0], 0))


    ################################### Building count inputs ###################################
    building_sql = (''' SELECT	COUNT(Record_Id) as record_ct
                                ,COUNT(DISTINCT lower(Address)) as address_ct
								,SUM(IIF(Address IS NULL, 1, 0)) as address_null
                        		,SUM(IIF(Dwelling_Type_Id = 2, 1, 0)) as multi_tenant_building_ct
                        		,SUM(IIF(Building_Type_Id = 2, 1, 0)) as mdu_building_ct
                        FROM BI_MIP.miBuilds.app_Building
                        WHERE Probuild_Id = {}
                                and ISNULL(Deleted, 0) = 0'''
                    )
    building_sql = building_sql.format(probuild_id)
    building_df = pd.read_sql(building_sql, connection)

    ### Assign Variables ###
    record_ct = float(ifnull(building_df['record_ct'].values[0], 0))
    address_ct = float(ifnull(building_df['address_ct'].values[0], 0))
    address_null = float(ifnull(building_df['address_null'].values[0], 0))
    if address_null > 0:
        building_ct = address_ct + address_null
    elif record_ct > address_ct:
        building_ct = address_ct
    else:
        building_ct = record_ct
    multi_tenant_building_ct = float(ifnull(building_df['multi_tenant_building_ct'].values[0], 0))
    mdu_building_ct = float(ifnull(building_df['mdu_building_ct'].values[0], 0))
    building_ct_less_multi = building_ct - multi_tenant_building_ct

    ################################### Business count inputs ###################################
    business_sql = (''' SELECT	COUNT(Record_Id) as business_ct
                        		,SUM(IIF(ISNULL(Revised_Segment_Type_Id, Segment_Type_Id) = 1, 1, 0)) as smb_qb_ct
                                ,SUM(IIF(ISNULL(Revised_Segment_Type_Id, Segment_Type_Id) <> 1, 1, 0)) as ent_qb_ct
                        FROM BI_MIP.miBuilds.app_Business
                        WHERE Probuild_Id = {}
                                and ISNULL(Deleted, 0) = 0'''
                    )
    business_sql = business_sql.format(probuild_id)
    business_df = pd.read_sql(business_sql, connection)

    ### Assign Variables ###
    business_ct = float(ifnull(business_df['business_ct'].values[0], 0))
    smb_qb_ct = float(ifnull(business_df['smb_qb_ct'].values[0], 0))
    ent_qb_ct = float(ifnull(business_df['ent_qb_ct'].values[0], 0))

    ################################### Lateral calculation variables ###################################
    if building_ct == 0:
        lat_cost_per_building = 0
    else:
        lat_cost_per_building = private_property_cost / building_ct

    if multi_tenant_building_ct == 0:
        lat_cost_per_multi_tenant = 0
    elif (multi_tenant_building_ct - mdu_building_ct) == 0:
        lat_cost_per_multi_tenant = 0
    elif business_ct == 0:
        lat_cost_per_multi_tenant = 0
    elif (business_ct - building_ct_less_multi) == 0:
        lat_cost_per_multi_tenant = 0
    elif (
            ((business_ct - building_ct_less_multi) / (multi_tenant_building_ct - mdu_building_ct))
            *
            (smb_36mo_pen * smb_qb_ct / business_ct + ent_36mo_pen * ent_qb_ct / business_ct)
        ) == 0:
        lat_cost_per_multi_tenant = 0
    else:
        lat_cost_per_multi_tenant = (
                                    lat_cost_per_building
                                    /
                                    (
                                    ((business_ct - building_ct_less_multi) / (multi_tenant_building_ct - mdu_building_ct))
                                    *
                                    (smb_36mo_pen * smb_qb_ct / business_ct + ent_36mo_pen * ent_qb_ct / business_ct)
                                    )
                                    )

    if lat_construct_upfront_pct:
        lat_construct_upfront_pct = lat_construct_upfront_pct
    elif private_property_cost == 0:
        lat_construct_upfront_pct = 0
    elif business_ct == 0:
        lat_construct_upfront_pct = 0
    elif building_ct == 0:
        lat_construct_upfront_pct = 0
    else:
        lat_construct_upfront_pct = ((multi_tenant_building_ct
                                    + building_ct_less_multi
                                    * (smb_36mo_pen * smb_qb_ct / business_ct
                                    + ent_36mo_pen * ent_qb_ct / business_ct))
                                    / building_ct
                                    )

    if private_property_cost == 0:
        exp_lat_construct_upfront_pct = 0
    elif business_ct == 0:
        exp_lat_construct_upfront_pct = 0
    elif building_ct == 0:
        exp_lat_construct_upfront_pct = 0
    else:
        exp_lat_construct_upfront_pct = ((multi_tenant_building_ct
                                        + building_ct_less_multi
                                        * (smb_36mo_pen * smb_qb_ct / business_ct
                                        + ent_36mo_pen * ent_qb_ct / business_ct))
                                        / building_ct
                                        )

    if business_ct == 0:
        passing_cost_per = 0
    else:
        passing_cost_per = ((row_est_build_cost + headend_cost
                       + transport_cost + private_property_cost)
                       / business_ct
                       )

    if business_ct == 0:
        lat_cost_per_connect = 0
    else:
        lat_cost_per_connect = ((lat_cost_per_building
                           * building_ct_less_multi
                           / business_ct)
                           + lat_cost_per_multi_tenant
                           * (business_ct - building_ct_less_multi)
                           / business_ct
                           )

    ################################### Deal In Hand inputs ###################################
    deal_in_hand_sql = (''' SELECT	ISNULL(SUM(IIF(Segment_Type_Id = 1, 1, 0)), 0) as smb_deal_in_hand_ct
                            		,ISNULL(SUM(IIF(Segment_Type_Id = 1, MRR, 0)), 0) as smb_deal_in_hand_mrc
                            		,ISNULL(SUM(IIF(Segment_Type_Id <> 1, 1, 0)), 0) as ent_deal_in_hand_ct
                            		,ISNULL(SUM(IIF(Segment_Type_Id <> 1, MRR, 0)), 0) as ent_deal_in_hand_mrc
                            FROM BI_MIP.miBuilds.app_SF_DealInHand
                            WHERE Probuild_Id = {}
                                    and ISNULL(Deleted, 0) = 0'''
                    )
    deal_in_hand_sql = deal_in_hand_sql.format(probuild_id)
    deal_in_hand_df = pd.read_sql(deal_in_hand_sql, connection)

    ### Assign Variables ###
    smb_deal_in_hand_ct = float(ifnull(deal_in_hand_df['smb_deal_in_hand_ct'].values[0], 0))
    smb_deal_in_hand_mrc = float(ifnull(deal_in_hand_df['smb_deal_in_hand_mrc'].values[0], 0))
    ent_deal_in_hand_ct = float(ifnull(deal_in_hand_df['ent_deal_in_hand_ct'].values[0], 0))
    ent_deal_in_hand_mrc = float(ifnull(deal_in_hand_df['ent_deal_in_hand_mrc'].values[0], 0))

    ################################### SMB Assumptions ###################################
    smb_assump_sql = ('''   SELECT	Capex_Data_and_Install as smb_capex_data
                            		,Capex_Voice_and_Install as smb_capex_voice
                            		,Capex_Video_and_Install as smb_capex_video
                            		,Opex_Load as smb_opex_load
                            		,Churn as smb_churn
                            FROM BI_MIP.miBuilds.assump_Segment
                            WHERE Segment_Type_Id = 1
                            	and IsActive = 1'''
                        )
    smb_assump_df = pd.read_sql(smb_assump_sql, connection)

    ################################### SMB Costing variables ###################################
    smb_capex_data = float(ifnull(smb_assump_df['smb_capex_data'].values[0], 0))
    smb_capex_voice = float(ifnull(smb_assump_df['smb_capex_voice'].values[0], 0))
    smb_capex_video = float(ifnull(smb_assump_df['smb_capex_video'].values[0], 0))
    smb_opex_load = float(ifnull(smb_assump_df['smb_opex_load'].values[0], 0))
    smb_churn = float(ifnull(smb_assump_df['smb_churn'].values[0], 0))
    smb_capex = (
                            smb_capex_data
                            + (smb_capex_voice * 0.7)
                            + (smb_capex_video * 0.6)
                            )
    smb_nrr = -1 * (smb_arpu * 0.25)
    smb_commission = smb_arpu * 0.6
    smb_total_upfront_cost = smb_capex + smb_nrr + smb_commission
    if business_ct == 0:
        smb_add_osp_lat_cost = 0
    else:
        smb_add_osp_lat_cost = (
                            lat_cost_per_building
                            * building_ct_less_multi
                            / business_ct
                            + lat_cost_per_multi_tenant
                            * (business_ct - building_ct_less_multi)
                            / business_ct
                            )
    smb_cost = smb_total_upfront_cost + smb_add_osp_lat_cost

    ################################### ENT Assumptions ###################################
    ent_assump_sql = ('''   SELECT	Capex as ent_capex
                            		,Maint_Opex as ent_maint_opex
                            		,Opex_Load as ent_opex_load
                            		,Churn as ent_churn
                            FROM BI_MIP.miBuilds.assump_Segment
                            WHERE Segment_Type_Id <> 1
                            	and IsActive = 1'''
                        )
    ent_assump_df = pd.read_sql(ent_assump_sql, connection)
    
    ent_div_sql = ('''
                   SELECT ent_arpu 
                   FROM assump_Region 
                   WHERE Region_Id = 7
                   ''')
    ent_div_df = pd.read_sql(ent_div_sql, connection)
    

    ################################### ENT Costing variables ###################################
    ent_capex = float(ifnull(ent_assump_df['ent_capex'].values[0], 0))
    ent_maint_opex = float(ifnull(ent_assump_df['ent_maint_opex'].values[0], 0))
    ent_opex_load = float(ifnull(ent_assump_df['ent_opex_load'].values[0], 0))
    ent_churn = float(ifnull(ent_assump_df['ent_churn'].values[0], 0))
    ent_arpu_div = float(ifnull(ent_div_df['ent_arpu'].values[0], 0))
    ent_bandwidth_cost = 4.24 * 85 * ent_arpu / ent_arpu_div
    ent_nrr = -1 * (ent_arpu * 0.25)
    ent_commission = ent_arpu * 0.6
    ent_total_upfront_cost = ent_capex + ent_maint_opex + ent_bandwidth_cost + ent_nrr + ent_commission
    if business_ct == 0:
        ent_add_osp_lat_cost = 0
    else:
        ent_add_osp_lat_cost = (
                            lat_cost_per_building
                            * building_ct_less_multi
                            / business_ct
                            + lat_cost_per_multi_tenant
                            * (business_ct - building_ct_less_multi)
                            / business_ct
                            )
    ent_cost = ent_total_upfront_cost + ent_add_osp_lat_cost

    ################### Random Counts #######################
    ct_sql = ('''   SELECT	
                        		dealinhand_ct =
                        			(	
                        				SELECT COUNT(SF_DealInHand_Id) 
                        				FROM miBuilds.app_SF_DealInHand
                        				WHERE Probuild_Id = {} and ISNULL(Deleted,0) = 0
                        			)
                        		,mdu_ct =
                        			(	
                        				SELECT COUNT(MDU_Id) 
                        				FROM miBuilds.app_MDU
                        				WHERE Probuild_Id = {} and ISNULL(Deleted,0) = 0
                        			)
                        		,datacenter_ct =
                        			(	
                        				SELECT COUNT(DataCenter_Id) 
                        				FROM miBuilds.app_DataCenter 
                        				WHERE Probuild_Id = {} and ISNULL(Deleted,0) = 0
                        			)
                    ''').format(probuild_id, probuild_id, probuild_id)
    ct_df = pd.read_sql(ct_sql, connection)
    dealinhand_ct = float(ifnull(ct_df['dealinhand_ct'].values[0], 0))
    mdu_ct = float(ifnull(ct_df['mdu_ct'].values[0], 0))
    datacenter_ct = float(ifnull(ct_df['datacenter_ct'].values[0], 0))


    ################### BUILD INPUTS DICTIONARY ###################
    inputs = {}
    inputs['probuild_id'] = probuild_id
    inputs['customer_contribution'] = customer_contribution
    inputs['access_fees_one_time'] = access_fees_one_time
    inputs['access_fees_monthly'] = access_fees_monthly
    inputs['row_est_build_cost'] = row_est_build_cost
    inputs['headend_cost'] = headend_cost
    inputs['transport_cost'] = transport_cost
    inputs['private_property_cost'] = private_property_cost
    inputs['smb_arpu'] = smb_arpu
    inputs['ent_arpu'] = ent_arpu
    inputs['smb_12mo_pen'] = smb_12mo_pen
    inputs['smb_36mo_pen'] = smb_36mo_pen
    inputs['ent_12mo_pen'] = ent_12mo_pen
    inputs['ent_36mo_pen'] = ent_36mo_pen
    inputs['smb_qb_ct'] = smb_qb_ct
    inputs['ent_qb_ct'] = ent_qb_ct
    inputs['business_ct'] = business_ct
    inputs['multi_tenant_building_ct'] = multi_tenant_building_ct
    inputs['building_ct'] = building_ct
    inputs['building_ct_less_multi'] = building_ct_less_multi
    inputs['mdu_building_ct'] = mdu_building_ct
    inputs['dealinhand_ct'] = dealinhand_ct
    inputs['mdu_ct'] = mdu_ct
    inputs['datacenter_ct'] = datacenter_ct
    inputs['smb_churn'] = smb_churn
    inputs['smb_deal_in_hand_ct'] = smb_deal_in_hand_ct
    inputs['smb_deal_in_hand_mrc'] = smb_deal_in_hand_mrc
    inputs['ent_churn'] = ent_churn
    inputs['ent_deal_in_hand_ct'] = ent_deal_in_hand_ct
    inputs['ent_deal_in_hand_mrc'] = ent_deal_in_hand_mrc
    inputs['lat_cost_per_building'] = lat_cost_per_building
    inputs['lat_cost_per_multi_tenant'] = lat_cost_per_multi_tenant
    inputs['lat_construct_upfront_pct'] = lat_construct_upfront_pct
    inputs['exp_lat_construct_upfront_pct'] = exp_lat_construct_upfront_pct
    inputs['passing_cost_per'] = passing_cost_per
    inputs['lat_cost_per_connect'] = lat_cost_per_connect
    inputs['smb_cost'] = smb_cost
    inputs['smb_opex_load'] = smb_opex_load
    inputs['ent_cost'] = ent_cost
    inputs['ent_opex_load'] = ent_opex_load

    #print(inputs)

    smb_ent_inputs = {}
    smb_ent_inputs = inputs.copy()

    return smb_ent_inputs

######################################################################
# Define Arrays
######################################################################
def prep_smb_ent_curves():

    smb_ent_curves = {}

    smb_ent_curves['smb_pen'] = np.zeros(37)
    smb_ent_curves['smb_rev'] = np.zeros(181)
    smb_ent_curves['ent_pen'] = np.zeros(37)
    smb_ent_curves['ent_rev'] = np.zeros(181)
    smb_ent_curves['smb_ent_cost'] = np.zeros(181)
    smb_ent_curves['smb_ent_cashflow'] = np.zeros(181)
    smb_ent_curves['smb_ent_cashflow_less_he_trnsprt'] = np.zeros(181)

    return smb_ent_curves

######################################################################
# Build pentration curve for SMB
######################################################################
def build_smb_pen_curve(smb_ent_inputs, smb_ent_curves):

    smb_calc_pen = smb_ent_curves['smb_pen']
    inputs = smb_ent_inputs

    delta_24mo = inputs['smb_36mo_pen'] - inputs['smb_12mo_pen']
    for i in range(37):
        if i<=1:
            smb_calc_pen[i] = 0
        elif i>=2 and i<=12:
            smb_calc_pen[i] = inputs['smb_12mo_pen'] * (i / 12)
        elif i>=13 and i<=36:
            smb_calc_pen[i] = (inputs['smb_12mo_pen']
                                + delta_24mo
                                * (i - 12)/24
                                )
        else:
            print('Pentration curve months:', i, 'Error fall through')
            #sys.exit()

    smb_ent_curves['smb_pen'] = smb_calc_pen

    return smb_ent_curves

######################################################################
# Build pentration curve for ENT
######################################################################
def build_ent_pen_curve(smb_ent_inputs, smb_ent_curves):

    ent_calc_pen = smb_ent_curves['ent_pen']
    inputs = smb_ent_inputs

    delta_24mo = inputs['ent_36mo_pen'] - inputs['ent_12mo_pen']
    for i in range(37):
        if i<=2:
            ent_calc_pen[i] = 0
        elif i>=3 and i<=12:
            ent_calc_pen[i] = inputs['ent_12mo_pen'] * (i / 12)
        elif i>=13 and i<=36:
            ent_calc_pen[i] = (inputs['ent_12mo_pen']
                                + delta_24mo
                                * (i - 12)/24
                                )
        else:
            print('Pentration curve months:', i, ' Error fall through')
            #sys.exit()

    smb_ent_curves['ent_pen'] = ent_calc_pen
    return smb_ent_curves

######################################################################
# Build revenue flows for SMB
######################################################################
def build_smb_rev_flow(smb_ent_inputs, smb_ent_curves):

    smb_calc_rev = smb_ent_curves['smb_rev']
    inputs = smb_ent_inputs

    for i in range(181):
        if i<=1:
            smb_calc_rev[i] = 0
        elif i>=2 and i<=36:
            smb_calc_rev[i] = (
                               ((inputs['smb_qb_ct']
                               - inputs['smb_deal_in_hand_ct'])
                               * smb_ent_curves['smb_pen'][i]
                               * inputs['smb_arpu'])
                               + inputs['smb_deal_in_hand_mrc']
                               )
        elif i==37:
            smb_calc_rev[i] = (
                               (smb_calc_rev[i-1]
                               - inputs['smb_deal_in_hand_mrc'])
                               * (1 - inputs['smb_churn'])
                               )
        else:
            smb_calc_rev[i] = (
                                smb_calc_rev[i-1]
                                * (1 - inputs['smb_churn'])
                              )

    smb_ent_curves['smb_rev'] = smb_calc_rev
    return smb_ent_curves

######################################################################
# Build revenue flows for ENT
######################################################################
def build_ent_rev_flow(probuild_id, smb_ent_inputs, smb_ent_curves):

    ent_calc_rev = smb_ent_curves['ent_rev']
    inputs = smb_ent_inputs
    data_center_rev, data_center_opex, data_center_cashflow = build_data_center_consol_curves(probuild_id)

    for i in range(181):
        if i<=2:
            ent_calc_rev[i] = 0
        elif i>=3 and i<=36:
            ent_calc_rev[i] = (
                               ((inputs['ent_qb_ct']
                               - inputs['ent_deal_in_hand_ct'])
                               * smb_ent_curves['ent_pen'][i]
                               * inputs['ent_arpu'])
                               + inputs['ent_deal_in_hand_mrc']
                               + data_center_rev[i]
                               )
        elif i==37:
            ent_calc_rev[i] = (
                               (ent_calc_rev[i-1]
                               - inputs['ent_deal_in_hand_mrc'])
                               * (1 - inputs['ent_churn'])
                               + (data_center_rev[i] - data_center_rev[i-1])
                               )
        else:
            ent_calc_rev[i] = (ent_calc_rev[i-1]
                               * (1 - inputs['ent_churn'])
                               + (data_center_rev[i] - data_center_rev[i-1])
                               )
    smb_ent_curves['ent_rev'] = ent_calc_rev
    return smb_ent_curves

######################################################################
# Build Cost Flows for SMB and ENT
######################################################################
def build_smb_ent_cost_flow(probuild_id, smb_ent_inputs, smb_ent_curves):

    calc_cost = smb_ent_curves['smb_ent_cost']
    inputs = smb_ent_inputs
    curves = smb_ent_curves
    data_center_rev, data_center_opex, data_center_cashflow = build_data_center_consol_curves(probuild_id)

    delta_pen_smb = inputs['smb_36mo_pen'] - inputs['smb_12mo_pen']
    delta_pen_ent = inputs['ent_36mo_pen'] - inputs['ent_12mo_pen']

    for i in range(181):
        if i==0:
            calc_cost[i] = -1 * (inputs['row_est_build_cost']
                                 + inputs['headend_cost']
                                 + inputs['transport_cost']
                                 + inputs['access_fees_one_time']
                                 + inputs['access_fees_monthly']
                                 - inputs['customer_contribution']
                                 - data_center_cashflow[i]
                                 )
        elif i==1 or i > 36:
            calc_cost[i] = -1 * (inputs['smb_opex_load']
                                 * curves['smb_rev'][i]
                                 + inputs['ent_opex_load']
                                 * curves['ent_rev'][i]
                                 + inputs['access_fees_monthly']
                                 - data_center_opex[i]
                                 )
        elif i==2:
            calc_cost[i] = -1 * (inputs['smb_12mo_pen'] * i / 12
                                 * (inputs['smb_qb_ct']
                                 - inputs['smb_deal_in_hand_ct'])
                                 * inputs['smb_cost']
                                 + inputs['smb_opex_load']
                                 * curves['smb_rev'][i]
                                 #+ inputs['ent_opex_load']
                                 #* curves['ent_rev'][i]
                                 + inputs['access_fees_monthly']
                                 + inputs['smb_deal_in_hand_ct']
                                 * inputs['smb_cost']
                                 - data_center_opex[i]
                                 )
        elif i==3:
            calc_cost[i] = -1 * (inputs['smb_12mo_pen'] / 12
                                 * (inputs['smb_qb_ct']
                                 - inputs['smb_deal_in_hand_ct'])
                                 * inputs['smb_cost']
                                 + inputs['smb_opex_load']
                                 * curves['smb_rev'][i]
                                 + inputs['ent_12mo_pen'] * i / 12
                                 * (inputs['ent_qb_ct']
                                 - inputs['ent_deal_in_hand_ct'])
                                 * inputs['ent_cost']
                                 + inputs['ent_opex_load']
                                 * (curves['ent_rev'][i]
                                 - data_center_rev[i])
                                 + inputs['access_fees_monthly']
                                 + inputs['ent_deal_in_hand_ct']
                                 * inputs['ent_cost']
                                 - data_center_opex[i]
                                 )
        elif i>=4 and i<=12:
            calc_cost[i] = -1 * (inputs['smb_12mo_pen'] / 12
                                * (inputs['smb_qb_ct']
                                - inputs['smb_deal_in_hand_ct'])
                                * inputs['smb_cost']
                                + inputs['smb_opex_load']
                                * curves['smb_rev'][i]
                                + inputs['ent_12mo_pen'] / 12
                                * (inputs['ent_qb_ct']
                                - inputs['ent_deal_in_hand_ct'])
                                * inputs['ent_cost']
                                + inputs['ent_opex_load']
                                * (curves['ent_rev'][i]
                                - data_center_rev[i])
                                + inputs['access_fees_monthly']
                                - data_center_opex[i]
                                )
        elif i>=13 and i<=36:
            calc_cost[i] = -1 * (delta_pen_smb / 24
                                 * (inputs['smb_qb_ct']
                                 - inputs['smb_deal_in_hand_ct'])
                                 * inputs['smb_cost']
                                 + inputs['smb_opex_load']
                                 * curves['smb_rev'][i]
                                 + delta_pen_ent / 24
                                 * (inputs['ent_qb_ct']
                                 - inputs['ent_deal_in_hand_ct'])
                                 * inputs['ent_cost']
                                 + inputs['ent_opex_load']
                                 * (curves['ent_rev'][i]
                                 - data_center_rev[i])
                                 + inputs['access_fees_monthly']
                                 - data_center_opex[i]
                                 )

    smb_ent_curves['smb_ent_cost'] = calc_cost
    return smb_ent_curves

######################################################################
# Build Cashflows for SMB and ENT
######################################################################
def build_smb_ent_cashflow(smb_ent_inputs, smb_ent_curves):

    calc_cashflow = smb_ent_curves['smb_ent_cashflow']
    calc_cashflow_less_he_trnsprt = smb_ent_curves['smb_ent_cashflow_less_he_trnsprt']
    inputs = smb_ent_inputs
    curves = smb_ent_curves

    for i in range(181):
        calc_cashflow[i] = (curves['smb_rev'][i]
                            + curves['ent_rev'][i]
                            + curves['smb_ent_cost'][i]
                            )
    smb_ent_curves['smb_ent_cashflow'] = calc_cashflow

    calc_cashflow_less_he_trnsprt = list(calc_cashflow)
    calc_cashflow_less_he_trnsprt[0] = (calc_cashflow_less_he_trnsprt[0]
                                        + inputs['headend_cost']
                                        + inputs['transport_cost']
                                        )
    smb_ent_curves['smb_ent_cashflow_less_he_trnsprt'] = calc_cashflow_less_he_trnsprt

    return smb_ent_curves

######################################################################
# Build Cashflows for SMB and ENT
######################################################################
def build_smb_ent_curves(probuild_id):
    smb_ent_inputs = prep_smb_ent_inputs(probuild_id)
    smb_ent_curves = prep_smb_ent_curves()
    smb_ent_curves = build_smb_pen_curve(smb_ent_inputs, smb_ent_curves)
    smb_ent_curves = build_ent_pen_curve(smb_ent_inputs, smb_ent_curves)
    smb_ent_curves = build_smb_rev_flow(smb_ent_inputs, smb_ent_curves)
    smb_ent_curves = build_ent_rev_flow(probuild_id, smb_ent_inputs, smb_ent_curves)
    smb_ent_curves = build_smb_ent_cost_flow(probuild_id, smb_ent_inputs, smb_ent_curves)
    smb_ent_curves = build_smb_ent_cashflow(smb_ent_inputs, smb_ent_curves)

    return smb_ent_curves

######################################################################
# Build SMB and ENT Dicts
######################################################################
def build_smb_ent_dicts(probuild_id):
    ### Call function to build the smb_ent_curves ###
    smb_ent_curves = build_smb_ent_curves(probuild_id)

    ### Build initial dicts before customizing with data ###
    smb_pen, smb_rev, ent_pen, ent_rev, smb_ent_cost, smb_ent_cashflow  = (
                    {} for i in range(6))

    for i in range(181):
        month = "Month_" + str(i)
        smb_rev[month] = round(smb_ent_curves['smb_rev'][i], 2)
        ent_rev[month] = round(smb_ent_curves['ent_rev'][i], 2)
        smb_ent_cost[month] = round(smb_ent_curves['smb_ent_cost'][i], 2)
        smb_ent_cashflow[month] = round(smb_ent_curves['smb_ent_cashflow'][i], 2)

    for i in range(37):
        month = "Month_" + str(i)
        smb_pen[month] = round(smb_ent_curves['smb_pen'][i], 3)
        ent_pen[month] = round(smb_ent_curves['ent_pen'][i], 3)

    return smb_pen, smb_rev, ent_pen, ent_rev, smb_ent_cost, smb_ent_cashflow

######################################################################
# Store Calc Data in tables
######################################################################
def build_smb_ent_df(probuild_id):
    ### Get data from request based on request method ###
    smb_pen, smb_rev, ent_pen, ent_rev, smb_ent_cost, smb_ent_cashflow = build_smb_ent_dicts(probuild_id)

    list_dicts = [smb_pen, smb_rev, ent_pen, ent_rev,
                    smb_ent_cost, smb_ent_cashflow]
    list_dicts = [dict.update({'Probuild_Id': probuild_id})
                    for dict in list_dicts]

    engine = sqlalchemy.create_engine('mssql+pyodbc:///?odbc_connect={}'
                .format(urllib.parse.quote_plus('DRIVER={SQL Server Native Client 11.0};'
                                    'SERVER=WestBIS-RPT;DATABASE=BI_MIP;'
                                    'Trusted_Connection=yes;')
                    )
            )

    smb_pen.update({'Cashflow_Category': 'Estimated SMB Penetration'})
    smb_rev.update({'Cashflow_Category': 'Estimated SMB MRC'})
    ent_pen.update({'Cashflow_Category': 'Estimated ENT Penetration'})
    ent_rev.update({'Cashflow_Category': 'Estimated ENT MRC'})
    smb_ent_cost.update({'Cashflow_Category': 'Estimated Costs'})
    smb_ent_cashflow.update({'Cashflow_Category': 'Estimated Cash Flow'})

    smb_pen_df = pd.DataFrame(smb_pen, index=[0])
    smb_rev_df = pd.DataFrame(smb_rev, index=[0])
    ent_pen_df = pd.DataFrame(ent_pen, index=[0])
    ent_rev_df = pd.DataFrame(ent_rev, index=[0])
    smb_ent_cost_df = pd.DataFrame(smb_ent_cost, index=[0])
    smb_ent_cashflow_df = pd.DataFrame(smb_ent_cashflow, index=[0])

    smb_pen_df.to_sql(name='rpt_Cashflow_SMB_ENT',con=engine,schema='miBuilds',
                        if_exists='append',index=False)
    smb_rev_df.to_sql(name='rpt_Cashflow_SMB_ENT',con=engine,schema='miBuilds',
                        if_exists='append',index=False)
    ent_pen_df.to_sql(name='rpt_Cashflow_SMB_ENT',con=engine,schema='miBuilds',
                        if_exists='append',index=False)
    ent_rev_df.to_sql(name='rpt_Cashflow_SMB_ENT',con=engine,schema='miBuilds',
                        if_exists='append',index=False)
    smb_ent_cost_df.to_sql(name='rpt_Cashflow_SMB_ENT',con=engine,schema='miBuilds',
                        if_exists='append',index=False)
    smb_ent_cashflow_df.to_sql(name='rpt_Cashflow_SMB_ENT',con=engine,schema='miBuilds',
                        if_exists='append',index=False)

######################################################################
# Prep Data Center data inputs for future use
######################################################################
def prep_data_center_inputs(probuild_id):
    datacenter_sql = ('''   SELECT DISTINCT
                                  datacenter_id
                            FROM BI_MIP.miBuilds.app_DataCenter as a
                            WHERE probuild_id = {}
                                and ISNULL(Deleted, 0) = 0'''
                    ).format(probuild_id)
    datacenter_df = pd.read_sql(datacenter_sql, connection)
    
    datacenter_id_list = datacenter_df['datacenter_id'].tolist()
    inputs = {}
    data_center_inputs = {}

    i = 0
    while i < len(datacenter_id_list):
        datacenter_id = datacenter_id_list[i]

        # Create data frame
        inputs_sql = (''' SELECT data_center_type_id as data_center_type
                                ,rack as rack
                                ,equip_opex as equip_opex
                                ,colo_fee as colo
                                ,connect_cost as connect
                                ,mrr_per_circ_avg as mrr
                                ,equip_capex as equip_capex
                                ,opex_pct as opex_pct
                        FROM BI_MIP.miBuilds.app_DataCenter as a
                        WHERE datacenter_id = {}
                                and ISNULL(Deleted, 0) = 0'''
                    )
        inputs_sql = inputs_sql.format(datacenter_id)
        inputs_df = pd.read_sql(inputs_sql, connection)

        # Create variables from data frame
        type = inputs_df['data_center_type'].values[0]

        circuits_sql = (''' SELECT  circuit_ct as circuit_ct
                            FROM    BI_MIP.miBuilds.assump_Data_Center_Circuit_EOY as a
                            WHERE   data_center_type_id = {}
                                    and IsActive = 1'''
                        )
        circuits_sql = circuits_sql.format(type)
        circuits_df = pd.read_sql(circuits_sql, connection)

        inputs['rack'] = inputs_df['rack'].values[0]
        inputs['power'] = inputs_df['equip_opex'].values[0]
        inputs['colo'] = inputs_df['colo'].values[0]
        inputs['connect'] = inputs_df['connect'].values[0]
        inputs['mrr'] = inputs_df['mrr'].values[0]
        inputs['opex_pct'] = inputs_df['opex_pct'].values[0]
        inputs['capex'] = inputs_df['equip_capex'].values[0]
        inputs['eoy_circuit_ct'] = circuits_df.to_dict('list')

        name = 'data_center' + str(i)
        data_center_inputs[name] = {}
        data_center_inputs[name].update(inputs)

        i += 1

    return data_center_inputs

########################################################################################################
# Build Circuit curves for each Data Center and combine one Dict (data_center_circuits)
########################################################################################################
def build_data_center_circuits(data_center_inputs):
    data_center_circuits = {}
    data_center_calc_circuit = np.zeros(181)

    x = 0
    while x < len(data_center_inputs): # the number of data centers
        name = 'data_center' + str(x)
        data = data_center_inputs[name]

        i = 0
        for i in range(181):
            if i<=2:
                data_center_calc_circuit[i] = 0
            elif i>=3 and i<=12:
                if i % 3 == 0:
                    data_center_calc_circuit[i] = (
                                                    (data['eoy_circuit_ct']['circuit_ct'][0] / 4)
                                                    + data_center_calc_circuit[i - 1]
                                                    )
                else:
                    data_center_calc_circuit[i] = data_center_calc_circuit[i - 1]
            elif i>=13 and i<=24:
                diff = (data['eoy_circuit_ct']['circuit_ct'][1]
                            - data['eoy_circuit_ct']['circuit_ct'][0]
                            )
                if i % 3 == 0:
                    data_center_calc_circuit[i] = (diff / 4) + data_center_calc_circuit[i - 1]
                else:
                    data_center_calc_circuit[i] = data_center_calc_circuit[i - 1]
            elif i>=25 and i<=36:
                diff = (data['eoy_circuit_ct']['circuit_ct'][2]
                            - data['eoy_circuit_ct']['circuit_ct'][1]
                            )
                if i % 3 == 0:
                    data_center_calc_circuit[i] = (diff / 4) + data_center_calc_circuit[i - 1]
                else:
                    data_center_calc_circuit[i] = data_center_calc_circuit[i - 1]
            elif i>=37 and i<=48:
                diff = (data['eoy_circuit_ct']['circuit_ct'][3]
                            - data['eoy_circuit_ct']['circuit_ct'][2]
                            )
                if i % 3 == 0:
                    data_center_calc_circuit[i] = (diff / 4) + data_center_calc_circuit[i - 1]
                else:
                    data_center_calc_circuit[i] = data_center_calc_circuit[i - 1]
            elif i>=49 and i<=60:
                diff = (data['eoy_circuit_ct']['circuit_ct'][4]
                            - data['eoy_circuit_ct']['circuit_ct'][3]
                            )
                if i % 3 == 0:
                    data_center_calc_circuit[i] = (diff / 4) + data_center_calc_circuit[i - 1]
                else:
                    data_center_calc_circuit[i] = data_center_calc_circuit[i - 1]

            elif i>=61:
                data_center_calc_circuit[i] = data_center_calc_circuit[i - 1]

        data_center_circuits[name] = data_center_calc_circuit.copy()


        x += 1

    return data_center_circuits

# if i % 12 == 3: gives you the point after 12 where diff changes

########################################################################################################
# Build Rev, Opex, and Cashflow curves for each Data Center and combine into one Dict (data_center_curves)
########################################################################################################
def build_data_center_curves(data_center_inputs, data_center_circuits):
    data_center_curves = {}
    data_center_curves['rev'] = {}
    data_center_curves['opex'] = {}
    data_center_curves['cashflow'] = {}

    data_center_calc_rev = np.zeros(181)
    data_center_calc_opex = np.zeros(181)
    data_center_calc_cashflow = np.zeros(181)

    x = 0
    while x < len(data_center_inputs): # the number of data centers
        name = 'data_center' + str(x)
        inputs = data_center_inputs[name]
        circuits = data_center_circuits[name]

        i = 0
        for i in range(181):
            data_center_calc_rev[i] = inputs['mrr'] * circuits[i]
            i += 1

        data_center_curves['rev'][name] = data_center_calc_rev.copy()

        i = 0
        for i in range(181):
            if i < 1:
                data_center_calc_opex[i] = 0
            else:
                data_center_calc_opex[i] = ( -1 *
                                        (inputs['rack']
                                        + inputs['power']
                                        + inputs['colo']
                                        + (inputs['connect'] * (circuits[i] - circuits[i - 1]))
                                        + (data_center_calc_rev[i] * inputs['opex_pct'])
                                        )
                                        )

        data_center_curves['opex'][name] = data_center_calc_opex.copy()

        i = 0
        for i in range(181):
            if i < 1:
                data_center_calc_cashflow[i] = (
                                        ( -1 * inputs['capex'] )
                                        + data_center_calc_opex[i]
                                        + data_center_calc_rev[i]
                                        )
            else:
                data_center_calc_cashflow[i] = (data_center_calc_opex[i]
                                          + data_center_calc_rev[i])

        data_center_curves['cashflow'][name] = data_center_calc_cashflow.copy()

        x += 1

    return data_center_curves

########################################################################################################
# Build Data Center consolidated (possible n number of Data Centers) Cashflow from data_center_curves
########################################################################################################
def build_data_center_consol_rev(data_center_curves):
    data_center_consol_rev = np.zeros(181)

    x = 0
    while x < len(data_center_curves['rev']):
        name = 'data_center' + str(x)

        i = 0
        for i in range(181):
            data_center_consol_rev[i] = (data_center_consol_rev[i]
                                      + data_center_curves['rev'][name][i])

            i += 1

        x += 1

    return data_center_consol_rev

########################################################################################################
# Build Data Center consolidated (possible n number of Data Centers) Cashflow from data_center_curves
########################################################################################################
def build_data_center_consol_opex(data_center_curves):
    data_center_consol_opex = np.zeros(181)

    x = 0
    while x < len(data_center_curves['opex']):
        name = 'data_center' + str(x)

        i = 0
        for i in range(181):
            data_center_consol_opex[i] = (data_center_consol_opex[i]
                                      + data_center_curves['opex'][name][i])

            i += 1

        x += 1

    return data_center_consol_opex

########################################################################################################
# Build Data Center consolidated (possible n number of Data Centers) Cashflow from data_center_curves
########################################################################################################
def build_data_center_consol_cashflow(data_center_curves):
    data_center_consol_cashflow = np.zeros(181)

    x = 0
    while x < len(data_center_curves['cashflow']):
        name = 'data_center' + str(x)

        i = 0
        for i in range(181):
            data_center_consol_cashflow[i] = (data_center_consol_cashflow[i]
                                      + data_center_curves['cashflow'][name][i])

            i += 1

        x += 1

    return data_center_consol_cashflow

######################################################################
# Build Cashflows for SMB and ENT
######################################################################
def build_data_center_consol_curves(probuild_id):
    data_center_inputs = prep_data_center_inputs(probuild_id)
    data_center_circuits = build_data_center_circuits(data_center_inputs)
    data_center_curves = build_data_center_curves(data_center_inputs, data_center_circuits)
    data_center_consol_rev = build_data_center_consol_rev(data_center_curves)
    data_center_consol_opex = build_data_center_consol_opex(data_center_curves)
    data_center_consol_cashflow = build_data_center_consol_cashflow(data_center_curves)

    return data_center_consol_rev, data_center_consol_opex, data_center_consol_cashflow


######################################################################
# Define Arrays
######################################################################
def prep_child_consol_curves():

    consol_curves = {}

    consol_curves['rev'] = np.zeros(181)
    consol_curves['opex'] = np.zeros(181)
    consol_curves['cost'] = np.zeros(181)
    consol_curves['cashflow'] = np.zeros(181)
    consol_curves['cashflow_less_he_trnsprt'] = np.zeros(181)

    return consol_curves



######################################################################
# Build consolidated Cashflow for SMB, ENT, Data Centers, and MDUs
######################################################################
def build_child_consol_curves(request):
    smb_ent_curves = build_smb_ent_curves(request)

    data_center_inputs = prep_data_center_inputs(request)
    data_center_circuits = build_data_center_circuits(data_center_inputs)
    data_center_curves = build_data_center_curves(data_center_inputs, data_center_circuits)
    data_center_consol_cashflow = build_data_center_consol_cashflow(data_center_curves)

    #mdu_inputs = child_mdu.prep_child_mdu_inputs(request)
    #mdu_curves = child_mdu.build_child_mdu_curves(mdu_inputs)
    #mdu_consol_cashflow = child_mdu.build_child_mdu_consol_cashflow(mdu_curves)

    consol_curves = prep_child_consol_curves()
    calc_cashflow = consol_curves['cashflow']
    calc_cashflow_less_he_trnsprt = consol_curves['cashflow_less_he_trnsprt']

    for i in range(181):
        calc_cashflow[i] = (smb_ent_curves['smb_ent_cashflow'][i]
                            #+ mdu_consol_cashflow[i]
                            )
        calc_cashflow_less_he_trnsprt[i] = (
                            smb_ent_curves['smb_ent_cashflow_less_he_trnsprt'][i]
                            #+ mdu_consol_cashflow[i]
                            )


    consol_curves['cashflow'] = calc_cashflow
    consol_curves['cashflow_less_he_trnsprt'] = calc_cashflow_less_he_trnsprt
    return consol_curves

######################################################################
# Calc NPV and IRR
######################################################################
def calc_child_NPV_IRR(consol_curves):
    cost_cap_pct = 0.1
    cost_cap_time = IRR_time = 12
    WACC = cost_cap_pct / cost_cap_time
    NaN_Value_NPV = -99999999.99
    NaN_Value_IRR = -99.999
    NaN_Value_IRR_HE_Trnsprt = -99.999

    NPV = np.npv(WACC, consol_curves['cashflow'])
    NPV_Less_HE_Trnsprt = np.npv(WACC, consol_curves['cashflow_less_he_trnsprt'])
    IRR = ((1 + np.irr(consol_curves['cashflow']))
                ** IRR_time
                - 1
                )
    IRR_Less_HE_Trnsprt = ((1 + np.irr(consol_curves['cashflow_less_he_trnsprt']))
                            ** IRR_time
                            - 1
                            )

    if np.isnan(NPV):
        NPV = NaN_Value_NPV
    if np.isnan(NPV_Less_HE_Trnsprt):
        NPV_Less_HE_Trnsprt = NaN_Value_NPV
    if np.isnan(IRR):
        IRR = NaN_Value_IRR
    if np.isnan(IRR_Less_HE_Trnsprt):
        IRR_Less_HE_Trnsprt = NaN_Value_IRR_HE_Trnsprt

    return NPV, NPV_Less_HE_Trnsprt, IRR, IRR_Less_HE_Trnsprt

######################################################################
# Calc CAR Value
######################################################################
def calc_CAR(probuild_id):
    smb_ent_inputs = prep_smb_ent_inputs(probuild_id)
    data_center_inputs = prep_data_center_inputs(probuild_id)

    data_center_capex = 0
    i = 0
    while i < len(data_center_inputs):
        name = 'data_center' + str(i)
        data_center_capex = (data_center_capex
                            + data_center_inputs[name]['capex']
                            )
        i += 1

    ROW_CAR = (smb_ent_inputs['row_est_build_cost']
                  + smb_ent_inputs['headend_cost']
                  + smb_ent_inputs['transport_cost']
                  + data_center_capex
                  ##### per Chris' email from 2/16/2018
                  ##### change made 5/2/2018
                  #+ (smb_ent_inputs['building_ct']
                  #* smb_ent_inputs['lat_construct_upfront_pct']
                  #* smb_ent_inputs['lat_cost_per_building'])
                  #+ smb_ent_inputs['access_fees_one_time']
                  )
    Lat_CAR = (smb_ent_inputs['building_ct']
                * smb_ent_inputs['lat_construct_upfront_pct']
                * smb_ent_inputs['lat_cost_per_building']
                )
    Total_CAR = ifnull(ROW_CAR,0) + ifnull(Lat_CAR,0)

    return ROW_CAR, Lat_CAR, Total_CAR

######################################################################
# Calc Payback Month
######################################################################
def calc_payback_mo(consol_curves):
    cashflow = consol_curves['cashflow']
    cum_cashflow = 0
    payback_mo = 0

    for i in range(181):
        cum_cashflow = cum_cashflow + cashflow[i]
        if cum_cashflow >= 0:
            payback_mo = i
            break
        else:
            payback_mo = ''

    return payback_mo

######################################################################
# Calc ROE Gate
######################################################################
def calc_roe_gate(request):
    probuild_id = request.GET.get('probuild_id', None)
    sql = (''' EXEC BI_MIP.miBuilds.calculations_child_roe_gate_df
                            @probuild_id = {}
                    ''').format(probuild_id)
    df = pd.read_sql(sql, connection)

    business_ct = float(ifnull(df['business_ct'].values[0], 0))
    roe_acquired = float(ifnull(df['roe_acquired'].values[0], 0))

    if business_ct == 0:
        roe_target = 1
    else:
        roe_target = round(business_ct * 0.3, 0)
    roe_needed = roe_target - roe_acquired

    return roe_target, roe_acquired, roe_needed

######################################################################
# Calc Max Capital
######################################################################
def calc_business_resi_capital_pct(probuild_id):
    smb_ent_curves = build_smb_ent_curves(probuild_id)

    #mdu_inputs = child_mdu.prep_child_mdu_inputs(request)
    #mdu_curves = child_mdu.build_child_mdu_curves(mdu_inputs)
    #mdu_consol_cashflow = child_mdu.build_child_mdu_consol_cashflow(mdu_curves)

    WACC = 1 ** (1/12) - 1
    NaN_Value_NPV = 0

    Business_NPV = np.npv(WACC, smb_ent_curves['smb_ent_cashflow_max_cap'])
    Resi_NPV = np.npv(WACC, mdu_consol_cashflow)

    if np.isnan(Business_NPV):
        Business_NPV = NaN_Value_NPV
    if np.isnan(Resi_NPV):
        Resi_NPV = NaN_Value_NPV

    Total_NPV = Business_NPV #+ Resi_NPV

    if Total_NPV == 0:
        Business_Pct = 0
        Resi_Pct = 0
    else:
        Business_Pct = Business_NPV / Total_NPV
        Resi_Pct = Resi_NPV / Total_NPV

    return Business_NPV, Resi_NPV, Business_Pct, Resi_Pct

######################################################################
# Update SMB ENT Cashflow
######################################################################           
def update_irr():
    sql = ('''  SELECT DISTINCT 
                		Probuild_Id
                FROM app_Probuild
                WHERE Name in (
                				SELECT [Project Name]
                				FROM miBuilds.houston_update_irr_list
                				WHERE [MDU Passings] = 0
                						and IRR < 0.2
                						and IRR >= 0.1
                			)
                    AND ISNULL(Deleted,0) = 0
                ''')
    df = pd.read_sql(sql, connection)
    
    for i in range(len(df.index)):
        probuild_id = df['probuild_id'].values[i]
        build_smb_ent_df(probuild_id)