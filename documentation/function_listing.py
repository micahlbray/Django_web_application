# -*- coding: utf-8 -*-
"""
Created on Thu Oct  4 18:25:16 2018

@author: mbray201
"""
import pandas as pd

in_file_path = '//miBuilds/directory_listing.xlsx'
out_file_path = '//miBuilds/function_listing.xlsx'
base_path = '//projects/miBuilds_app_dev/'


out_df = pd.DataFrame()
data = {}
failed_files = []

in_df = pd.read_excel(in_file_path)
nrows = in_df.shape[0]
for i in range(nrows):
    row = in_df.iloc[i]
    folder = row['folder']
    filename = row['filename']
    path = base_path + folder + '/' + filename
    if filename[-3:] == '.py' and filename not in ['admin.py','manage.py','backends.py','decorators.py']:
        functionNames, returnValues = parse_python_file(path)
        data['folder'] = folder
        data['filename'] = filename
        data['function'] = functionNames
        data['return_value'] = returnValues
        try:
            df = pd.DataFrame.from_dict(data)
            out_df = out_df.append(df, ignore_index=True)
        except:
            failed_files.append(filename)
    elif filename[-3:] == '.js':
        functionNames = parse_js_file(path)
        returnValues = ['' for i in functionNames]
        data['folder'] = folder
        data['filename'] = filename
        data['function'] = functionNames
        data['return_value'] = returnValues
        try:
            df = pd.DataFrame.from_dict(data)
            out_df = out_df.append(df, ignore_index=True)
        except:
            failed_files.append(filename)
    else:
        continue

out_df.to_excel(out_file_path)
print(failed_files)


### FOR PYTHON FILES
def parse_python_file(path):
    functionNames = []
    returnValues = []
    with open(path) as in_file:
        for line in in_file:
            if line.startswith('def'):
                functionNames.append(line.strip())
            if 'return' in line:
                returnValues.append(line.strip())
    return functionNames, returnValues
            
### FOR JS FILES
def parse_js_file(path):
    functionNames = []
    with open(path) as in_file:
        for line in in_file:
            if line.startswith('function'):
                functionNames.append(line.strip())
    return functionNames

out_path = '/miBuilds/complete_listing.xlsx'
df1_path = '//miBuilds/directory_listing.xlsx'
df2_path = '//miBuilds/function_listing.xlsx'
df1 = pd.read_excel(df1_path)
df2 = pd.read_excel(df2_path)
df_out = pd.merge(df1, df2, how='left', on=['folder','filename'])
df_out.to_excel(out_path)
