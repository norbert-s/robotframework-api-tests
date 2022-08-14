import json


def openFile(file):
    # Opening JSON file
    f = open(file, "r")

    # returns JSON object as 
    # a dictionary
    data = json.load(f)

    # Iterating through the json
    # list
    for i in data:
        print(i, "", data[i])

    # Closing file
    f.close()
    return data
