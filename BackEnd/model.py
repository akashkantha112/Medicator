import data
import os
import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.neural_network import MLPClassifier
from sklearn.cluster import KMeans
from operator import itemgetter
from gensim.test.utils import common_texts, get_tmpfile
from gensim.models import Word2Vec


print(os.getcwd())

def flatten(arr):
    
    flattened = []
    
    for x in arr:
        if isinstance(x,list):
            flattened.extend(flatten(x))
        else:
            flattened.append(x)
    return flattened
            
print(flatten([[1,2,3,[5,6,7],[12,4],0,[192]]]))

def getAllSymptoms(data):
    
    return list(set(flatten([ data[x] for x in data.keys() ])))

symptoms = getAllSymptoms(data.data)

symptoms = list(filter(lambda x: len(x.strip())>0,symptoms))

symptomMatrix = []

for disease in data.data.keys():
    
    hotEncoder = [0]*(len(symptoms)+1)
    
    hotEncoder[-1] = disease.strip()
    
    print(data.data[disease])
    
    for symptomName in data.data[disease]:
        try:
            if len(symptomName.strip())==0:
                continue
            
            index = symptoms.index(symptomName.strip())
            hotEncoder[index]= 1
        except Exception as e:
            print("Error ",e,symptomName)
            
    symptomMatrix.append(hotEncoder)

df = pd.DataFrame(symptomMatrix,columns=symptoms+["DiseaseName"])

X = df.drop(columns=["DiseaseName"])
y = df["DiseaseName"]

UserSymptoms=list(input().split())
count=-1
pos=0

def getDiseaseSuggestion(symptoms):
    
    diseases = []
    
    for disease in data.data.keys():
        
        count = 0
        for symptom in symptoms:
            if symptom in data.data[disease]:
                count += 1
        if count >= len(data.data[disease])*0.2:
            diseases.append((disease.capitalize(),(count/len(data.data[disease])*100)))
            
    diseases.sort(key=itemgetter(1),reverse=True)        
    
    return diseases[:3] if len(arr)>3 else diseases

arr  = getDiseaseSuggestion((["worry"]*5))
print(arr)
        



for symps in UserSymptoms:
    for i in range(149):
        temp=0
        for j in range(405):
            if df.iloc[i,j]==1:
                temp+=1
        if temp>count:
            count=temp
            pos=i
print(pos)
print(df.iloc[i,404])