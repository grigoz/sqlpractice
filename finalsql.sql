
-- 1.	Начнем с простого запроса и просто посчитаем сколько всего людей участвовало во всех официально задокументированных ОИ (кроме игр 2018 года).
select count( distinct id) from characteristics;
--Ответ: 135571 человек.

--2.	Посчитаем средний возраст участников ОИ.
select AVG(cast(age as integer)) from characteristics where age !='NA';
--Ответ:25.56 лет.

--3.	Теперь посчитаем средний возраст золотых медалистов участников ОИ.
select AVG(cast(age as integer)) from public.characteristics INNER JOIN public.medals On characteristics.id=medals.id where age!='NA'and medal='Gold'; Ответ: 26,625 лет, что говорит о том, что золотой медалист в среднем старше чем средний возраст участника ОИ.

--4.	Посчитаем так же средний рост золотых медалистов.
select AVG(cast(height as integer)) from public.characteristics INNER JOIN public.medals On characteristics.id=medals.id where height!='NA'and medal='Gold';
--Ответ: 176.31см.

--5.	Посчитаем количество медалей за всю историю у сборной России.
select COUNT(medal) from public.nationality INNER JOIN public.medals On nationality.id=medals.id where medal!='NA' and team='Russia';
--Ответ: 4816 медалей.

--6.	Сколько из них золотых?
select COUNT(medal) from public.nationality INNER JOIN public.medals On nationality.id=medals.id where medal='Gold' and team='Russia';
--Из них 1669 медалей золотые.

--7.	Найдем 5 самых высоких участников ОИ.
select DISTINCT id, name ,height from characteristics where height!='NA' ORDER BY height DESC limit 5;

--8.	Создадим оконную функцию и посчитаем для каждого спортсмена в каком количестве соревнований он принимал участие и пронумеруем их.
select id,name, ROW_NUMBER() OVER (PARTITION BY id) as events_attended from characteristics order by id limit 5;

--9.	Узнаем на каких ОИ  выступал Роджер Федерер.
select distinct games from public.games INNER JOIN public.characteristics On characteristics.id=games.id where name='Roger Federer' ;
--Ответ: 2000, 2004, 2008 и 2012.

--10.	Найдем также и результаты выступлений Роджера на этих играх, для этого соединим три таблицы.
select distinct games, medal from public.games INNER JOIN public.characteristics On characteristics.id=games.id INNER JOIN public.medals ON games.id=medals.id where name='Roger Federer' ;

--11.	Создадим представление достижений Федерера на ОИ.
CREATE VIEW Roger_Federer AS select distinct games, medal from public.games INNER JOIN public.characteristics On characteristics.id=games.id INNER JOIN public.medals ON games.id=medals.id where name='Roger Federer' ;

--12.	Создадим представление всех теннисистов завоевавших медали на ОИ.
CREATE VIEW tennis AS select * from medals where sport='Tennis' and medal='NA';
