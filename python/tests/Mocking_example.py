import requests
from hamcrest import assert_that, equal_to

response = requests.get("https://1f039692-0e8c-437d-a03f-fea5c10f39e9.mock.pstmn.io/jsonexample/donut")
print(response.json())
assert_that(response.status_code,equal_to(200))

