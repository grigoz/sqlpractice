import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://postgres:@{}:{}'.format('127.0.0.1', '5431'))

num_people = pd.read_sql('select count( distinct id) from characteristics;',engine)
print(num_people)

federer_games = pd.read_sql("select distinct games from public.games INNER JOIN public.characteristics On characteristics.id=games.id where name='Roger Federer' ;",engine)
print(federer_games)

top_tall = pd.read_sql("select DISTINCT id, name ,height from characteristics where height!='NA' ORDER BY height DESC limit 5;",engine)
print(top_tall)

avg_age = pd.read_sql("select AVG(cast(age as integer)) from characteristics where age !='NA';",engine)
print(avg_age)

avg_age_gold = pd.read_sql("select AVG(cast(age as integer)) from public.characteristics INNER JOIN public.medals On characteristics.id=medals.id where age!='NA'and medal='Gold';",engine)
print(avg_age_gold)
