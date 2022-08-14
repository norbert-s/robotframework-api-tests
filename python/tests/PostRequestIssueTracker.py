import requests
import OpenFile
import create_file_with_fake_data
from hamcrest import assert_that, equal_to

try:
    myDictionary = OpenFile.openFile("issuetracker.json")
except:
    print('could not open')

myFile = create_file_with_fake_data.create_fake_data(myDictionary)
# for i in myFile:
#     print(i, " ", myFile[i])

response = requests.post("https://spring-boot-issue-tracker.herokuapp.com/api/issues", json=myFile)
print(response.json())
assert_that(response.status_code,equal_to(200))

