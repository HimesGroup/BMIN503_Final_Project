# -*- coding: utf-8 -*-
import pandas as pd
import numpy as np
import string
import os

#path = r'/Users/sauravbose/Data Science/Bioinformatics/Aircasting Data/sessions_20171113232917/'
#path = r'/Users/sauravbose/Data Science/Bioinformatics/Aircasting Data/sessions_20171113233300/'

#path = r'/Users/sauravbose/Data Science/Bioinformatics/Aircasting Data/sessions_20171208180831/'
#path = r'/Users/sauravbose/Data Science/Bioinformatics/Aircasting Data/sessions_20171208181130/'
#path = r'/Users/sauravbose/Data Science/Bioinformatics/Aircasting Data/sessions_20171208181316/'
path = r'/Users/sauravbose/Data Science/Bioinformatics/Aircasting Data/sessions_20171208203726/'

#files = ['test2.csv', 'data.xlsx','session_37219_greys_ferry_blue_20171113-12198-emi888.csv']
#files = os.listdir(r"/Users/sauravbose/Data Science/Bioinformatics/Aircasting Data/sessions_20171113232917")

files = os.listdir(r"/Users/sauravbose/Data Science/Bioinformatics/Aircasting Data/sessions_20171208203726/")

for f in range(1,len(files)):
    
    
    #For excel files
    #df=pd.read_excel(path+files[1], sep = '',header=None)
    #df = df.applymap(str)
    
    #For CSV files
    df=pd.read_csv(path+files[f], sep = ',',header=None)
    df=df.dropna()
    
    
    #df.index=df[0].map(lambda x: not x.isdigit()).cumsum()
    
    
       
    truth = df[3].map(lambda x: not x.replace('.','').isdigit())
    
    counter = 1
    counter_temp = 1
    
    idx = []
    
    for i in range(truth.size):
        if (truth[i] == True):
            idx.append(counter) 
            if (truth[i+1] == False):
                counter_temp+=1
        elif (truth[i] == False):
            idx.append(counter) 
            if (i!= truth.size-1 and truth[i+1] == True):
                counter = counter_temp
    
    df.index = idx
    
    gp=df.groupby(df.index)
    
    #df2=np.hstack([gp.get_group(i) for i in gp.groups])
    
    
    
    data = {}
    
    for i in gp.groups:
        data[str(i)]  = pd.DataFrame(np.array(gp.get_group(i))[1:], columns = np.array(gp.get_group(i))[0])
        
     
    keys = data.keys()
    response = []
    units=[]
    for i in keys:
        response.append(data["{}".format(i)]["sensor:capability"][0])                  
        units.append(data["{}".format(i)]["sensor:units"][0])      
        
        
    output_title = [a+b+c+d for a,b,c,d in zip(response,["("]*len(response),units,[")"]*len(response))]    
    
        
    for i in range(len(keys)):
        data["{}".format(keys[i])]["sensor:units"][1] = output_title[i]    
        
        
    for i in keys:
        data["{}".format(i)].columns = data["{}".format(i)].iloc[1]   
        data["{}".format(i)] = data["{}".format(i)].reindex(data["{}".format(i)].index.drop([0,1]))    
       
        
    for i in range(len(keys)):
        with open(r'/Users/sauravbose/Data Science/Bioinformatics/Aircasting Data/Clean_Data/{}.csv'.format(response[i]), 'a') as f:
                 data["{}".format(keys[i])].to_csv(f, header=False,index = False)
        #data["{}".format(keys[i])].to_csv(r'/Users/sauravbose/Data Science/Bioinformatics/Aircasting Data/Clean_Data/{}.csv'.format(response[i]), index = False)                                  
    
