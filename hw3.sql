SELECT('Григорий Зайонц');

--первое задание
SELECT DISTINCT userId,movieid,
       (rating - MIN(rating) OVER (PARTITION BY userId))/((MAX(rating) OVER (PARTITION BY userId)) - 
       (MIN(rating) OVER (PARTITION BY userid)))normed_rating, AVG(rating) OVER (PARTITION BY userId) avg_rating
   from ratings
   ORDER BY userId LIMIT 30;
   
   
   --второе задание
   psql --host $APP_POSTGRES_HOST -U postgres -c "CREATE TABLE IF NOT EXISTS keywords(id INT, tags VARCHAR)"
   psql --host $APP_POSTGRES_HOST -U postgres -c "\\copy keywords FROM '/data/k
eywords.csv' DELIMITER ',' CSV HEADER"

WITH top_rated as (SELECT movieid, AVG(rating) as avg_rating, COUNT(userid) as count from ratings
GROUP BY movieid HAVING COUNT(userid)>50 ORDER BY movieid ASC, avg_rating DESC LIMIT 150) 
SELECT * FROM top_rated JOIN keywords ON top_rated.movieid=keywords.id LIMIT 50;

WITH top_rated as (SELECT movieid, AVG(rating) as avg_rating, COUNT(userid) as count from ratings 
GROUP BY movieid HAVING COUNT(userid)>50 ORDER BY movieid ASC, avg_rating DESC LIMIT 150) 
SELECT movieid, avg_rating into top_rated_tags from top_rated;

\copy (select * from top_rated_tags) to '/data/ratings_file' with CSV header delimiter as ',';
