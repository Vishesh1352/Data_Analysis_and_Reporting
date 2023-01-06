import os

import matplotlib.pyplot as plt
import MySQLdb
from dotenv import load_dotenv

load_dotenv()
HOST=os.environ.get('HOST')
USER=os.environ.get('USER')
PASSWORD=os.environ.get('PASSWORD')
DATABASE=os.environ.get('DATABASE')
mydb = MySQLdb.connect(host=HOST,user=USER,password=PASSWORD,database=DATABASE)
mycursor = mydb.cursor()
mycursor.execute("SELECT movie_finance.prod_prize, movie_finance.movie_collect, movie_react.rating from movie_finance INNER JOIN movie_react ON movie_react.mid = movie_finance.mid")
result=mycursor.fetchall()

prod_prize=[]
box_collect=[]
rating=[]
for row in result:
  prod_prize.append(row[0])
  box_collect.append(row[1])
  rating.append(row[2])

plt.bar(prod_prize,box_collect)
plt.xlabel("Producation prize in millions")
plt.ylabel("Total collection of the movie in millions")
plt.title("Production prize to Collection ratio Graph") 
plt.show()

plt.stem(rating,prod_prize)
plt.xlabel("Movie Rating")
plt.ylabel("Movie producatio prize in millions")
plt.title("Rating to Producation Bar Graph")
plt.show()

mydb.close()