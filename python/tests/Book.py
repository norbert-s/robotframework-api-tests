import array
import json
from dataclasses import dataclass
__version__ = '1.0.0'



# {"isbn": "123-456-222",
#  "author":{"lastname": "Doe","firstname": "Jane"},
# "editor":{"lastname": "Smith","firstname": "Jane"},
#   "title": "The Ultimate Database Study Guide",
#   "category": ["Non-Fiction", "Technology"]
#  }
@dataclass
class Book:
    isbn:int
    author_firstname:str
    author_lastname:str
    editor_firstname:str
    editor_lastname:str
    title:str
    category:str
        
    def print(self):
        print(self.author_firstname)

    
b = Book(isbn=1234,author_firstname='victor',author_lastname='hugo'
         ,editor_firstname='Marie',editor_lastname='Antoinette',title='Nyomorultak',
         category='literature')
b.print()

def encoder_book(book):
    if isinstance(book, Book):
        return {'isbn':book.isbn,'author':{'firstname':book.author_firstname,
                'lastname':book.author_lastname},
                'editor':{'firstname':book.editor_firstname,
                'lastname':book.editor_lastname}, 'title':book.title,'category':book.category}
    raise TypeError(f'Object {book} is not tpye person')

jsonified = json.dumps(b,default=encoder_book)
    
print(jsonified)

