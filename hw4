SELECT ('ФИО: Зайонц Григорий');

-- спользуя функцию определения размера таблицы, вывести top-5 самых больших таблиц базы

SELECT table_name from information_schema.tables order by pg_relation_size('' || table_schema || '.' || table_name || '') DESC limit 5;

-- array_agg: собрать в массив все фильмы, просмотренные пользователем (без повторов)
SELECT userID, array_agg(movieId) as user_views FROM ratings group by userID;

-- таблица user_movies_agg, в которую сохраните результат предыдущего запроса
SELECT userID, user_views INTO public.user_movies_agg FROM (SELECT userID, array_agg(movieId) as user_views FROM ratings group by userID) as userr;


-- Используя следующий синтаксис, создайте функцию cross_arr оторая принимает на вход два массива arr1 и arr2.
-- Функциия возвращает массив, который представляет собой пересечение контента из обоих списков.
-- Примечание - по именам к аргументам обращаться не получится, придётся делать через $1 и $2.

CREATE OR REPLACE FUNCTION cross_arr (int[], int[]) RETURNS int[] language sql as $FUNCTION$ select array((SELECT UNNEST($1)) INTERSECT (SELECT UNNEST($2))); ; $FUNCTION$;

-- Сформируйте запрос следующего вида: достать из таблицы всевозможные наборы u1, r1, u2, r2.
-- u1 и u2 - это id пользователей, r1 и r2 - соответствующие массивы рейтингов
-- ПОДСКАЗКА: используйте CROSS JOIN
SELECT w1.userid as u1, w2.userid as u2, w1.user_views as ar1, w2.user_views as ar2 from public.user_movies_agg w1 cross join public.user_movies_agg w2 where w1.userid<>w2.userid;

-- Оберните запрос в CTE и примените к парам <ar1, ar2> функцию CROSS_ARR, которую вы создали
-- вы получите триплеты u1, u2, crossed_arr
-- созхраните результат в таблицу common_user_views
DROP TABLE IF EXISTS common_user_views;
WITH user_pairs as (SELECT w1.userid as u1, w2.userid as u2, w1.user_views as ar1, w2.user_views as ar2 from public.user_movies_agg w1 cross join public.user_movies_agg w2 where w1.userid<>w2.userid) SELECT u1, u2, cross_arr(ar1, ar2) INTO common_user_views FROM user_pairs order by array_length(cross_arr(ar1, ar2),1) limit 10 ;



-- Создайте по аналогии с cross_arr функцию diff_arr, которая вычитает один массив из другого.
-- Подсказка: используйте оператор SQL EXCEPT.
WITH user_pairs as (SELECT w1.userid as u1, w2.userid as u2, w1.user_views as ar1, w2.user_views as ar2 from public.user_movies_agg w1 cross join public.user_movies_agg w2 where w1.userid<>w2.userid) SELECT u1, u2, cross_arr(ar1, ar2), diff_arr(ar1,ar2) INTO common_user_views FROM user_pairs order by array_length(cross_arr(ar1, ar2),1) limit 10 ;

-- в последнем запросе немного зачитерил, но получилось даже интереснее рекомендации от пользователей у которых больше всего совпадений
