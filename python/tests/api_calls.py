import requests

import OpenFile

response = requests.delete("https://spring-boot-issue-tracker.herokuapp.com/api/issues/147")
print(response)
print(response.text)


myDictionary = OpenFile.openFile("myfile.json")
for i in myDictionary:
    print(i," ",myDictionary[i])



