from faker import Faker


fake=Faker()

def create_fake_data(file):
    for n in file:
        file[n]= fake.text()

    for i in file:
        print(i , " ", file[i])

    return file


