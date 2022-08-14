from xmlrpc.client import boolean
import robot.api.deco as deco

from robot.api.deco import keyword, library
import json

__version__ = '1.0.0'

@library
class CheckingString():
    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = 'TEST CASE'

    @keyword("check response")
    def check_string(self, response: str, expected: str, id_here: str) -> boolean:
        if (expected in response and id_here in response):
            try:
                print('string is in the response')
                print('response: ' + response)
                print('expected: ' + expected)
                print('id ' + id_here)
                return True
            except:
                print("failed logging")
        else:
            return False



