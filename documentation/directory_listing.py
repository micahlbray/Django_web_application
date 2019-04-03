# -*- coding: utf-8 -*-
"""
Created on Thu Oct  4 16:39:15 2018

@author: mbray201
"""

import os
import pandas as pd

path = '//cable/west-groups/DIV/BSG/miPlatform/Analysis/126 miWebApps/projects/miBuilds_app_dev'
out_path = 'directory_listing.xlsx'

file_names = []
folders = []
files = []
for dirname, dirnames, filenames in os.walk(path):
    # print path to all subdirectories first.
    for subdirname in dirnames:
        print(os.path.join(dirname, subdirname))

    # print path to all filenames.
    for filename in filenames:
        print(os.path.join(dirname, filename))
        file_names.append(os.path.join(dirname, filename))

    # Advanced usage:
    # editing the 'dirnames' list will stop os.walk() from recursing into there.
    if '.git' in dirnames:
        # don't go into any .git directories.
        dirnames.remove('.git')
        
print('Start of Files')
for file in file_names:
    x = file.split('\\')
    if len(x) == 2:
        folders.append('root')
        files.append(x[1])
    if len(x) == 3:
        folders.append(x[1])
        files.append(x[2])
    if len(x) == 4:
        folders.append(x[1] + '/' + x[2])
        files.append(x[3])
    if len(x) == 5:
        folders.append(x[1] + '/' + x[2] + '/' + x[3])
        files.append(x[4])
    if len(x) > 5:
        i = 0
        i += 1
        print(i)
            
df = pd.DataFrame(
            {'folder': folders,
             'filename': files
            })
df.to_excel(out_path)
