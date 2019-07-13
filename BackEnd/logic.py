import data
from operator import itemgetter

def getDiseaseSuggestion(symptoms):
    
    diseases = []
    
    for disease in data.data.keys():
        
        count = 0
        for symptom in symptoms:
            if symptom.lower() in data.data[disease]:
                count += 1
        if count >= 1:#len(data.data[disease])*0.0:
            diseases.append((disease,(count/len(data.data[disease])*100)))
            
    diseases.sort(key=itemgetter(1),reverse=True)        
    
    return diseases[:3] if len(disease)>3 else diseases

n = int(input())
symptoms = []
for _ in range(n):
    symptoms.append(input())
arr  = getDiseaseSuggestion(symptoms)
xyz = []
print("[")


for item,chance in arr:
    xyz.append("{\"name\":\""+item+"\",\"chance\":"+"%.2f"%chance+"}")
    #print("{\"name\":\""+item+"\",\"chance\":"+str(chance)+"}")

print(",".join(xyz))
print("]")
        
