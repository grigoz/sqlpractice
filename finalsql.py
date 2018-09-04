import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://postgres:@{}:{}'.format('127.0.0.1', '5431'))
characteristics = pd.read_sql('select * from characteristics', engine)
medals = pd.read_sql('select* from medals', engine)
games = pd.read_sql('select*from games',engine)

num_people = pd.read_sql('select count( distinct id) from characteristics;',engine)
num_people_2 = characteristics.groupby(by=['id'])['id'].count().drop_duplicates
print(num_people)
print(num_people_2)

federer_games = pd.read_sql("select distinct games from public.games INNER JOIN public.characteristics On characteristics.id=games.id where name='Roger Federer' ;",engine)
gam_char = characteristics.merge(games, how='inner', left_on='id',right_on='id')
federer_games_2 = gam_char[(gam_char.name == 'Roger Federer')].games.unique()
print(federer_games)
print(federer_games_2)

top_tall = pd.read_sql("select DISTINCT id, name ,height from characteristics where height!='NA' ORDER BY height DESC limit 5;",engine)
top_tall_2 = characteristics[(characteristics.height!='NA')].sort_values('height',ascending=False).head(5)
print(top_tall)
print(top_tall_2)

avg_age = pd.read_sql("select AVG(cast(age as integer)) from characteristics where age !='NA';",engine)
avg_age_w = characteristics.agg({'age':['mean']})
print(avg_age)
print(avg_age_2)


avg_age_gold = pd.read_sql("select AVG(cast(age as integer)) from public.characteristics INNER JOIN public.medals On characteristics.id=medals.id where age!='NA'and medal='Gold';",engine)
char_med = characteristics.merge(medals, how='inner', left_on='id',right_on='id')
avg_age_gold_2 = char_med[(char_med.medal=='Gold')].agg({'age':['mean']})
print(avg_age_gold)
print(avg_age_gold_2)

export_csv = top_tall.to_csv('/Users/alexanderzayonts/Documents/top_tall.csv')
