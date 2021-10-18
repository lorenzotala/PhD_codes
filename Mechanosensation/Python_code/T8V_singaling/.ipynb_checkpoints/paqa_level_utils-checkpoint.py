"""
Utilities to extract PaQa and RFP fluorescence values from csv files generated by Bacstalk
The csv files must be called "exportedData_<strain-name-with-dash-separation>_<Fluorescent-reporter-with-dash-separation>_<growth-condition>_BR=<biological-replicate-number>.csv"
As an example: "exportedData_fliC-_PaQa_liq_BR=1.csv"
"""
import numpy as np
import math
import os
import glob
import pandas as pd

import bokeh.io
import bokeh.plotting
import bokeh.palettes

from bokeh.transform import jitter
from bokeh.models import HoverTool, Range1d
from bokeh.models import ColumnDataSource
from bokeh.palettes import Spectral6
from bokeh.layouts import row

bokeh.io.output_notebook()

def combineDataSets(data_path, data_summary_path, working_path):
    name = data_path.split('\\')
    if not name[-1]:
        name.pop()
    output_name = name[-1].split('_',1)[1]
    os.chdir(working_path)
    #Check if it exist and create the working data path
    working_data_path = os.path.join(data_summary_path,'Enhanced_' + output_name)
    if not os.path.exists(working_data_path):
        os.mkdir(working_data_path)
    #Find all csv files within the folder and subfolders
    os.chdir(data_path)
    extension = 'csv'
    list_csv = []
    for root, dirs, files in os.walk(data_path, topdown=False):
        for name in files:
            if extension in name:
                list_csv.append(os.path.join(root, name))
    #Open each csv file as a dataframe and add metadata information from file name and saves an "enhanced" version in working_data_path
    for file in list_csv:
        df_temp = pd.read_csv(file, sep=',', na_values='*')
        split_name=file.rsplit('Data_',2)[1].rsplit('_PaQa',100)
        file_name = file.rsplit("\\",2)[2]
        df_temp['Strain'] = split_name[0]
        if 'sol' in file:
            df_temp['Growth']='Solid'
        else:
            df_temp['Growth']='Liquid'
        df_temp['Bio_Rep']=int(split_name[len(split_name)-1].rsplit('BR=', 2)[1].rsplit('.',2)[0])
        df_temp.to_csv(os.path.join(working_data_path, 'enhanced_' + file_name), index = None, header=True)
    #Get the list of enhanced files
    list_enhanced_csv = []
    for root, dirs, files in os.walk(working_data_path, topdown=False):
        for name in files:
            if extension in name:
                list_enhanced_csv.append(os.path.join(root, name))
    #Create a combined csv file with all strain information
    combined_csv = pd.concat([pd.read_csv(f) for f in list_enhanced_csv ], sort=False)
    os.chdir(data_summary_path)
    output_filename = 'Summary_' + output_name + '_PaQa.csv'
    combined_csv.to_csv( output_filename, index=False, encoding='utf-8-sig')
    return output_filename

def plottingData(df, means, wt, order, strain_to_remove, growth, param, colors, scale, GraphTitle, graph_size):
    df2 = df.copy()
    means2 = means.copy()
    if isinstance(growth, list):
        #Removing unwanted strains from plot
        if len(strain_to_remove) > 0:
            for strain in strain_to_remove:
                df2 = df2.drop(df2[(df2['Strain'] == strain)].index)
                means2 = means2.drop(means2[(means2['Strain'] == strain)].index)
        #Generate a new DataFrame for the filtered dataset
        df3=df2.copy()
        means3=means2.copy()
        #Initialization of data labels and condition indexes
        labels = [None]*(2+len(order)*2)
        indexes = [None]*(2+len(order)*2)
        n=0
        #Extracting data for the user-defined WT strain on liquid
        WT_mean=np.array(means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), param])
        if WT_mean.any():
            Norm_mean=WT_mean/np.mean(WT_mean)
            means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), param]=Norm_mean
            df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), param] = df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), param]/np.mean(WT_mean)
            if '-' in wt:
                strain_name=wt.replace('-', '')
                labels[n] = chr(916)+strain_name + ' ' + 'Liquid'
            else:
                strain_name=wt
                labels[n] = strain_name + ' ' + 'Liquid'
            indexes[n] = ((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid'))
            print(wt+' Liquid biorep means='+str(WT_mean) + ', mean='+str(np.mean(WT_mean)) )
            n=n+1
        #Extracting data for the user-defined WT strain on Solid
        Strain_mean=np.array(means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), param])
        if Strain_mean.any():
            Norm_mean=Strain_mean/np.mean(WT_mean)
            means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), param]=Norm_mean
            df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), param] = df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), param]/np.mean(WT_mean)
            if '-' in wt:
                strain_name=wt.replace('-', '')
                labels[n] = chr(916)+strain_name + ' ' + 'Solid'
            else:
                strain_name=wt
                labels[n] = strain_name + ' ' + 'Solid'
            indexes[n] = ((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid'))
            print(wt+' Solid biorep means='+str(Strain_mean) + ', mean='+str(np.mean(Strain_mean)) )
            print(wt+' Solid ref fold increase = '+str(Strain_mean/np.mean(WT_mean)) + ', mean = ' + str(np.mean(Strain_mean/np.mean(WT_mean))))
            ref_fold = np.divide(Strain_mean, WT_mean)
            print(wt+' Solid biorep fold increase='+str(ref_fold) + ', mean = ' + str(np.mean(ref_fold)))
            n=n+1
        #Extracting data for the other selected strains
        for o, ordering in enumerate(order):
            for a, g in enumerate(growth):
                #Check if data is acquired for the specific growth condition
                Strain_mean=np.array(means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(g)), param])
                if Strain_mean.any():
                    #Normalize each biological mean by the WT liquid mean and store it in the new means3 dataframe
                    Norm_mean=Strain_mean/np.mean(WT_mean)
                    means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(g)), param]=Norm_mean
                    print(ordering+' '+g+' biorep means='+str(Strain_mean) + ', mean='+str(np.mean(Strain_mean)))
                    print(ordering+' '+g+' ref fold increase = '+str(Strain_mean/np.mean(WT_mean)) + ', mean = ' + str(np.mean(Strain_mean/np.mean(WT_mean))))
                    if len(WT_mean)==len(Strain_mean):
                        ref_fold = np.divide(Strain_mean, WT_mean)
                        print(ordering+' '+g+' biorep fold increase='+str(ref_fold) + ', mean = ' + str(np.mean(ref_fold)))
                    #Normalize each datapoint by the WT liquid mean
                    df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(g)), param] = df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(g)), param]/np.mean(WT_mean)
                    #Recording labels of dataset
                    if '-' in ordering:
                        strain_name=ordering.replace('-', '')
                        labels[n] = chr(916)+strain_name + ' ' +g
                    else:
                        strain_name=ordering
                        labels[n] = strain_name + ' ' +g
                    #Recording the indexes of the dataframe corresponding to the correct strain and growth condition
                    indexes[n] = ((df3['Strain'] == (ordering)) & df3['Growth'].str.match(g))
                    n=n+1
        #Shorten the labels and indexes variables by removing all 'None' values related to the initialization
        labels = list(filter(None, labels))
        indexes = [i for i in indexes if not isinstance(i, type(None))]
        #Setting the ploting order of the WT liquid and solid datasets
        val = len(labels) - 0.5
        if WT_mean.any():
            df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), 'Labels'] = val
            means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), 'Labels'] = val
            val = val - 1
        Strain_mean=np.array(means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), param])
        if Strain_mean.any():
            df3.loc[((df2['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), 'Labels'] = val
            means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), 'Labels'] = val
            val = val - 1
        #Setting the plotting order of the selected strains
        for o, ordering in enumerate(order):
            for a, g in enumerate(growth):
                #Check if data is acquired for the specific growth condition
                Strain_mean=np.array(means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(g)), param])
                if Strain_mean.any():
                    df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(g)), 'Labels'] = val
                    means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(g)), 'Labels'] = val
                    val = val - 1
        lookupdf2=df3.groupby(['Strain', 'Growth', 'Labels', 'Bio_Rep'])[param].median().to_frame().reset_index()
        strain_mean = means3.groupby(['Strain', 'Growth', 'Labels'])[param].mean().to_frame().reset_index()
        p = bokeh.plotting.figure(
            width=graph_size[0], 
            height=graph_size[1], 
            y_range=np.flip(labels), 
            x_axis_type=scale,
            x_axis_label = 'Relative PaQa level',
            title=GraphTitle+" "+param+" on "+growth[0]+" vs. "+growth[1]+" in "+scale+" scale"
        )
        p.yaxis.major_label_text_font_size = "9pt"
        for i, index in enumerate(indexes):
            p.circle(
                source=df3.loc[index, :],
                x=param,
                y=jitter('Labels', width=0.3, range=p.y_range), 
                color = colors[i],
                alpha=0.3,
            )
        p.circle(
            source = means3,
            x = param,
            y = 'Labels',
            size = 10,
            line_color = 'black',
            fill_color = 'white',
            legend = "means of replicates"
        )
        p.circle(
            source = strain_mean,
            x = param,
            y = 'Labels',
            size = 10,
            line_color = 'black',
            fill_color = 'black',
            legend = "means across replicates"
        )
        p.add_tools(HoverTool(
                tooltips=[
                    ('Strain', '@{Strain}'),
                    ('Growth condition', '@{Growth}'),
                    (param, '@{'+param+'}'),
                    ('Biological replicate', '@{Bio_Rep}')
                ],
        ))
        p.line(
            x = [1, 1],
            y = [0, len(labels)],
            line_width = 2,
            line_color = 'red',
            legend = "Reference"
        )
    else:
        print('Not a list')
        if growth == 'Liquid':
            ungrowth = 'Solid'
        else:
            ungrowth = 'Liquid'
        if len(strain_to_remove) > 0:
            for strain in strain_to_remove:
                df2 = df2.drop(df2[(df2['Strain'] == strain)].index)
                means2 = means2.drop(means2[(means2['Strain'] == strain)].index)    
        for strain in order:
            df3 = df2.drop(df2[((df2['Strain'] == strain) & (df2['Growth'] == ungrowth))].index)
            means2 = means2.drop(means2[((means2['Strain'] == strain) & (means2['Growth'] == ungrowth))].index)
        means3=means2
        val = 0.5+len(order)+1
        labels = [None]*(2+len(order))
        indexes = [None]*(2+len(order))
        df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), 'Labels'] = val
        means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), 'Labels'] = val
        WT_mean=np.array(means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), param])
        Norm_mean=WT_mean/np.mean(WT_mean)
        means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), param]=Norm_mean
        df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), param] = df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), param]/np.mean(WT_mean)
        labels[len(labels)-1] = 'WT'+' '+'Liquid'
        indexes[0] = ((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid'))
        print(wt+' Liquid mean='+str(WT_mean))
        df3.loc[((df2['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), 'Labels'] = (val-1)
        means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), 'Labels'] = (val-1)
        Strain_mean=np.array(means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), param])
        Norm_mean=Strain_mean/np.mean(WT_mean)
        means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), param]=Norm_mean
        df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), param] = df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), param]/np.mean(WT_mean)
        labels[len(labels)-2] = 'WT'+' '+'Solid'
        indexes[1] = ((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid'))
        print(wt+' Solid mean='+str(Strain_mean))
        print(wt+' Solid fold increase='+str(Strain_mean/np.mean(WT_mean)))
        val = val - 2
        for o, ordering in enumerate(order):
            df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(growth)), 'Labels'] = val
            means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(growth)), 'Labels'] = val
            Strain_mean=np.array(means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(growth)), param])
            Norm_mean=Strain_mean/np.mean(WT_mean)
            means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(growth)), param]=Norm_mean
            print(ordering+' mean='+str(Strain_mean))
            print(ordering+' fold increase='+str(Strain_mean/np.mean(WT_mean)))
            df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(growth)), param] = df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(growth)), param]/np.mean(WT_mean)
            if '-' in ordering:
                strain_name=ordering.replace('-', '')
                labels[len(labels)-3-o] = chr(916)+strain_name
            else:
                strain_name=ordering
                labels[len(labels)-3-o] = strain_name
            indexes[o+2] = ((df3['Strain'] == (ordering)) & df3['Growth'].str.match(growth))
            val = val - 1
        lookupdf2=df3.groupby(['Strain', 'Growth', 'Labels', 'Bio_Rep'])[param].median().to_frame().reset_index()
        strain_mean = means3.groupby(['Strain', 'Growth', 'Labels'])[param].mean().to_frame().reset_index()
        p = bokeh.plotting.figure(
            width=graph_size[0], 
            height=graph_size[1],  
            y_range=labels, 
            x_axis_type=scale,
            x_axis_label = 'Relative PaQa level',
            title=GraphTitle+" "+param+" on "+growth
        )
        p.yaxis.major_label_text_font_size = "9pt"
        for i, index in enumerate(indexes):
            p.circle(
                source=df3.loc[index, :],
                x=param,
                y=jitter('Labels', width=0.3, range=p.y_range), 
                color = colors[i],
                alpha=0.3,
            )
        p.circle(
            source = means3,
            x = param,
            y = 'Labels',
            size = 10,
            line_color = 'black',
            fill_color = 'white',
        )
        p.circle(
            source = strain_mean,
            x = param,
            y = 'Labels',
            size = 10,
            line_color = 'black',
            fill_color = 'black',
        )
        p.add_tools(HoverTool(
                tooltips=[
                    ('Strain', '@{Strain}'),
                    ('Growth condition', '@{Growth}'),
                    (param, '@{'+param+'}'),
                    ('Biological replicate', '@{Bio_Rep}')
                ],
        ))
        p.line(
            x = [1, 1],
            y = [0, len(labels)],
            line_width = 2,
            line_color = 'red',
            legend = "Reference"
        )
    return p, means3, df3

def plottingBioReps(df, means, wt, order, strain_to_remove, growth, param, colors, scale, GraphTitle, graph_size):
    df2 = df.copy()
    means2 = means.copy()
    if isinstance(growth, list):
        #Removing unwanted strains from plot
        if len(strain_to_remove) > 0:
            for strain in strain_to_remove:
                df2 = df2.drop(df2[(df2['Strain'] == strain)].index)
                means2 = means2.drop(means2[(means2['Strain'] == strain)].index)
        #Generate a new DataFrame for the filtered dataset
        df3=df2.copy()
        means3=means2.copy()
        #Initialization of data labels and condition indexes
        labels = [None]*(2+len(order)*2)
        indexes = [None]*(2+len(order)*2)
        n=0
        #Extracting data for the user-defined WT strain on liquid
        WT_mean=np.array(means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), param])
        if WT_mean.any():
            Norm_mean=WT_mean/np.mean(WT_mean)
            means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), param]=Norm_mean
            df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), param] = df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), param]/np.mean(WT_mean)
            if '-' in wt:
                strain_name=wt.replace('-', '')
                labels[n] = chr(916)+strain_name + ' ' + 'Liquid'
            else:
                strain_name=wt
                labels[n] = strain_name + ' ' + 'Liquid'
            indexes[n] = ((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid'))
            print(wt+' Liquid mean='+str(WT_mean) + ', mean='+str(np.mean(WT_mean)))
            n=n+1
        #Extracting data for the user-defined WT strain on Solid
        Strain_mean=np.array(means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), param])
        if Strain_mean.any():
            Norm_mean=Strain_mean/np.mean(WT_mean)
            means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), param]=Norm_mean
            df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), param] = df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), param]/np.mean(WT_mean)
            if '-' in wt:
                strain_name=wt.replace('-', '')
                labels[n] = chr(916)+strain_name + ' ' + 'Solid'
            else:
                strain_name=wt
                labels[n] = strain_name + ' ' + 'Solid'
            indexes[n] = ((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid'))
            print(wt+' Solid mean='+str(Strain_mean) + ', mean='+str(np.mean(Strain_mean)))
            print(wt+' Solid ref fold increase = '+str(Strain_mean/np.mean(WT_mean)) + ', mean = ' + str(np.mean(Strain_mean/np.mean(WT_mean))))
            ref_fold = np.divide(Strain_mean, WT_mean)
            print(wt+' Solid biorep fold increase='+str(ref_fold) + ', mean = ' + str(np.mean(ref_fold)))
            n=n+1
        #Extracting data for the other selected strains
        for o, ordering in enumerate(order):
            for a, g in enumerate(growth):
                #Check if data is acquired for the specific growth condition
                Strain_mean=np.array(means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(g)), param])
                if Strain_mean.any():
                    #Normalize each biological mean by the WT liquid mean and store it in the new means3 dataframe
                    Norm_mean=Strain_mean/np.mean(WT_mean)
                    means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(g)), param]=Norm_mean
                    print(ordering+' '+g+' mean='+str(Strain_mean) + ', mean='+str(np.mean(Strain_mean)))
                    print(ordering+' '+g+' ref fold increase = '+str(Strain_mean/np.mean(WT_mean)) + ', mean = ' + str(np.mean(Strain_mean/np.mean(WT_mean))))
                    if len(WT_mean)==len(Strain_mean):
                        ref_fold = np.divide(Strain_mean, WT_mean)
                        print(ordering+' '+g+' biorep fold increase='+str(ref_fold) + ', mean = ' + str(np.mean(ref_fold)))
                    #Normalize each datapoint by the WT liquid mean
                    df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(g)), param] = df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(g)), param]/np.mean(WT_mean)
                    #Recording labels of dataset
                    if '-' in ordering:
                        strain_name=ordering.replace('-', '')
                        labels[n] = chr(916)+strain_name + ' ' +g
                    else:
                        strain_name=ordering
                        labels[n] = strain_name + ' ' +g
                    #Recording the indexes of the dataframe corresponding to the correct strain and growth condition
                    indexes[n] = ((df3['Strain'] == (ordering)) & df3['Growth'].str.match(g))
                    n=n+1
        #Shorten the labels and indexes variables by removing all 'None' values related to the initialization
        labels = list(filter(None, labels))
        indexes = [i for i in indexes if not isinstance(i, type(None))]
        #Setting the ploting order of the WT liquid and solid datasets
        val = len(labels) - 0.5
        if WT_mean.any():
            df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), 'Labels'] = val
            means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), 'Labels'] = val
            val = val - 1
        Strain_mean=np.array(means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), param])
        if Strain_mean.any():
            df3.loc[((df2['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), 'Labels'] = val
            means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), 'Labels'] = val
            val = val - 1
        #Setting the plotting order of the selected strains
        for o, ordering in enumerate(order):
            for a, g in enumerate(growth):
                #Check if data is acquired for the specific growth condition
                Strain_mean=np.array(means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(g)), param])
                if Strain_mean.any():
                    df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(g)), 'Labels'] = val
                    means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(g)), 'Labels'] = val
                    val = val - 1
        lookupdf2=df3.groupby(['Strain', 'Growth', 'Labels', 'Bio_Rep'])[param].median().to_frame().reset_index()
        strain_mean = means3.groupby(['Strain', 'Growth', 'Labels'])[param].mean().to_frame().reset_index()
        p = bokeh.plotting.figure(
            width=graph_size[0], 
            height=graph_size[1], 
            y_range=np.flip(labels), 
            x_axis_type=scale,
            x_axis_label = 'Relative PaQa level',
            title=GraphTitle+" "+param+" on "+growth[0]+" vs. "+growth[1]+" in "+scale+" scale"
        )
        p.yaxis.major_label_text_font_size = "9pt"
        p.circle(
            source = means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid'))],
            x = param,
            y = 'Labels',
            size = 10,
            line_color = 'black',
            fill_color = colors[0]
        )
        p.line(
            x = [np.mean(strain_mean.loc[((strain_mean['Strain'] == (wt)) & strain_mean['Growth'].str.match('Liquid')), 'PaQa_ratio']), np.mean(strain_mean.loc[((strain_mean['Strain'] == (wt)) & strain_mean['Growth'].str.match('Liquid')), 'PaQa_ratio'])],
            y = [np.mean(strain_mean.loc[((strain_mean['Strain'] == (wt)) & strain_mean['Growth'].str.match('Liquid')), 'Labels'])-0.2, np.mean(strain_mean.loc[((strain_mean['Strain'] == (wt)) & strain_mean['Growth'].str.match('Liquid')), 'Labels'])+0.2],
            line_width = 3,
            line_color = 'black',
            legend = "mean"
        )
        p.circle(
            source = means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid'))],
            x = param,
            y = 'Labels',
            size = 10,
            line_color = 'black',
            fill_color = colors[1]
        )
        p.line(
            x = [np.mean(strain_mean.loc[((strain_mean['Strain'] == (wt)) & strain_mean['Growth'].str.match('Solid')), 'PaQa_ratio']), np.mean(strain_mean.loc[((strain_mean['Strain'] == (wt)) & strain_mean['Growth'].str.match('Solid')), 'PaQa_ratio'])],
            y = [np.mean(strain_mean.loc[((strain_mean['Strain'] == (wt)) & strain_mean['Growth'].str.match('Solid')), 'Labels'])-0.2, np.mean(strain_mean.loc[((strain_mean['Strain'] == (wt)) & strain_mean['Growth'].str.match('Solid')), 'Labels'])+0.2],
            line_width = 3,
            line_color = 'black',
        )
        for o, ordering in enumerate(order):
            p.circle(
                source = means3.loc[((means3['Strain'] == ordering) & means3['Growth'].str.match('Liquid'))],
                x = param,
                y = 'Labels',
                size = 10,
                line_color = 'black',
                fill_color = colors[o+2],
                legend = "means of replicates"
            )
            p.line(
                x = [np.mean(strain_mean.loc[((strain_mean['Strain'] == ordering) & strain_mean['Growth'].str.match('Liquid')), 'PaQa_ratio']), np.mean(strain_mean.loc[((strain_mean['Strain'] == ordering) & strain_mean['Growth'].str.match('Liquid')), 'PaQa_ratio'])],
                y = [np.mean(strain_mean.loc[((strain_mean['Strain'] == ordering) & strain_mean['Growth'].str.match('Liquid')), 'Labels'])-0.2, np.mean(strain_mean.loc[((strain_mean['Strain'] == ordering) & strain_mean['Growth'].str.match('Liquid')), 'Labels'])+0.2],
                line_width = 3,
                line_color = 'black'
            )
        p.add_tools(HoverTool(
                tooltips=[
                    ('Strain', '@{Strain}'),
                    ('Growth condition', '@{Growth}'),
                    (param, '@{'+param+'}'),
                    ('Biological replicate', '@{Bio_Rep}')
                ],
        ))
        p.line(
            x = [1, 1],
            y = [0, len(labels)],
            line_width = 1,
            line_color = 'black',
            line_dash = 'dotted',
            legend = "Reference"
        )
    else:
        print('Not a list')
        if growth == 'Liquid':
            ungrowth = 'Solid'
        else:
            ungrowth = 'Liquid'
        if len(strain_to_remove) > 0:
            for strain in strain_to_remove:
                df2 = df2.drop(df2[(df2['Strain'] == strain)].index)
                means2 = means2.drop(means2[(means2['Strain'] == strain)].index)    
        for strain in order:
            df3 = df2.drop(df2[((df2['Strain'] == strain) & (df2['Growth'] == ungrowth))].index)
            means2 = means2.drop(means2[((means2['Strain'] == strain) & (means2['Growth'] == ungrowth))].index)
        means3=means2
        val = 0.5+len(order)+1
        labels = [None]*(2+len(order))
        indexes = [None]*(2+len(order))
        df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), 'Labels'] = val
        means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), 'Labels'] = val
        WT_mean=np.array(means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), param])
        Norm_mean=WT_mean/np.mean(WT_mean)
        means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid')), param]=Norm_mean
        df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), param] = df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid')), param]/np.mean(WT_mean)
        labels[len(labels)-1] = 'WT'+' '+'Liquid'
        indexes[0] = ((df3['Strain'] == (wt)) & df3['Growth'].str.match('Liquid'))
        print(wt+' Liquid mean='+str(WT_mean) + ', mean='+str(np.mean(WT_mean)))
        df3.loc[((df2['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), 'Labels'] = (val-1)
        means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), 'Labels'] = (val-1)
        Strain_mean=np.array(means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), param])
        Norm_mean=Strain_mean/np.mean(WT_mean)
        means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid')), param]=Norm_mean
        df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), param] = df3.loc[((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid')), param]/np.mean(WT_mean)
        labels[len(labels)-2] = 'WT'+' '+'Solid'
        indexes[1] = ((df3['Strain'] == (wt)) & df3['Growth'].str.match('Solid'))
        print(wt+' Solid mean='+str(Strain_mean) + ', mean='+str(np.mean(Strain_mean)))
        print(wt+' Solid fold increase='+str(Strain_mean/np.mean(WT_mean)))
        val = val - 2
        for o, ordering in enumerate(order):
            df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(growth)), 'Labels'] = val
            means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(growth)), 'Labels'] = val
            Strain_mean=np.array(means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(growth)), param])
            Norm_mean=Strain_mean/np.mean(WT_mean)
            means3.loc[((means3['Strain'] == (ordering)) & means3['Growth'].str.match(growth)), param]=Norm_mean
            print(ordering+' mean='+str(Strain_mean) + ', mean='+str(np.mean(Strain_mean)))
            print(ordering+' fold increase='+str(Strain_mean/np.mean(WT_mean)))
            df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(growth)), param] = df3.loc[((df2['Strain'] == (ordering)) & df3['Growth'].str.match(growth)), param]/np.mean(WT_mean)
            if '-' in ordering:
                strain_name=ordering.replace('-', '')
                labels[len(labels)-3-o] = chr(916)+strain_name
            else:
                strain_name=ordering
                labels[len(labels)-3-o] = strain_name
            indexes[o+2] = ((df3['Strain'] == (ordering)) & df3['Growth'].str.match(growth))
            val = val - 1
        lookupdf2=df3.groupby(['Strain', 'Growth', 'Labels', 'Bio_Rep'])[param].median().to_frame().reset_index()
        strain_mean = means3.groupby(['Strain', 'Growth', 'Labels'])[param].mean().to_frame().reset_index()
        p = bokeh.plotting.figure(
            width=graph_size[0], 
            height=graph_size[1],  
            y_range=labels, 
            x_axis_type=scale,
            x_axis_label = 'Relative PaQa level',
            title=GraphTitle+" "+param+" on "+growth
        )
        p.yaxis.major_label_text_font_size = "9pt"
        p.circle(
            source = means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Liquid'))],
            x = param,
            y = 'Labels',
            size = 10,
            line_color = 'black',
            fill_color = colors[0]
        )
        p.circle(
            source = means3.loc[((means3['Strain'] == (wt)) & means3['Growth'].str.match('Solid'))],
            x = param,
            y = 'Labels',
            size = 10,
            line_color = 'black',
            fill_color = colors[1]
        )
        for o, ordering in enumerate(order):
            p.circle(
            source = means3.loc[((means3['Strain'] == ordering) & means3['Growth'].str.match('Liquid'))],
            x = param,
            y = 'Labels',
            size = 10,
            line_color = 'black',
            fill_color = colors[o+2],
            legend = "means of replicates"
            )
        p.circle(
            source = strain_mean,
            x = param,
            y = 'Labels',
            size = 10,
            line_color = 'black',
            fill_color = 'black',
        )
        p.add_tools(HoverTool(
                tooltips=[
                    ('Strain', '@{Strain}'),
                    ('Growth condition', '@{Growth}'),
                    (param, '@{'+param+'}'),
                    ('Biological replicate', '@{Bio_Rep}')
                ],
        ))
        p.line(
            x = [1, 1],
            y = [0, len(labels)],
            line_width = 2,
            line_color = 'red',
            legend = "Reference"
        )
    return p, means3, df3

def getDFStats(df, param):
    Strains=list(df.Strain.unique())
    Growth=list(df.Growth.unique())
    Reps=list(df.Bio_Rep.unique())
    inds = [None]*(len(Strains)*len(Growth))
    labels = [None]*(len(Strains)*len(Growth))
    labelsAll = [None]*(len(Strains)*len(Growth)*len(Reps))
    indexes = [None]*(len(Strains)*len(Growth)*len(Reps))
    n = 0
    m = 0
    for strain in Strains:
        for growth in Growth:
            inds[n] = (df['Strain'] == strain) & (df['Growth'] == growth)
            labels[n] = strain+' '+growth
            n= n + 1
            for rep in Reps:
                indexes[m] = (df['Strain'] == strain) & (df['Growth'] == growth) & (df['Bio_Rep'] == rep)
                labelsAll[m] = strain+' '+growth
                m = m + 1
    df['Labels'] = 0
    #df.insert(2, "Labels", 0, True)
    vertical_position = [None]*len(labels)
    val=0.5        
    for s, strain in enumerate(labels):
        vertical_position[s] = val
        df.loc[inds[s], 'Labels'] = val
        val = val+1        
    means = df.groupby(['Strain', 'Growth', 'Labels', 'Bio_Rep'])[param].agg(['median', 'count']).rename(columns={'median': param, 'count': 'N'}).reset_index()
    #means = df.groupby(['Strain', 'Growth', 'Labels', 'Bio_Rep'])[param].median().to_frame().reset_index()
    stds = df.groupby(['Strain', 'Growth', 'Labels', 'Bio_Rep'])[param].std().to_frame().reset_index()
    return means, stds, indexes, labels

print('paqa_level_utils loaded correctfully')