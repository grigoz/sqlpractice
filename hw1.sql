SELECT ('Григорий Зайонц');
-- первый запрос
SELECT * FROM ratings LIMIT 10;

-- второй запрос
SELECT * FROM (SELECT * FROM (SELECT * FROM links WHERE links.movieid<1000) links WHERE 100<links.movieid) links WHERE links.imdbid like'%42%' LIMIT 10;

-- третий запрос
SELECT * FROM public.links INNER JOIN public.ratings ON links.movieid=ratings.movieid WHERE ratings.rating = 5 LIMIT 10;

--четвертый запрос
select COUNT(movieid) FROM ratings  WHERE ratings.movieid IS NULL;

--пятый запрос
SELECT DISTINCT userid, AVG(rating) as avg_rating FROM ratings GROUP BY userid HAVING AVG(rating) > 3.5 LIMIT 10;

--шестой запрос
SELECT imdbid, AVG(rating) as avg_rating FROM public.links INNER JOIN public.ratings ON links.movieid=ratings.movieid GROUP BY imdbid HAVING AVG(rating)>3.5  LIMIT 10;

--седьмой запрос
Select userId, AVG(rating) as avg_rating, COUNT(userId) as count from ratings GROUP BY userid HAVING COUNT(userId)>10 LIMIT 10;
