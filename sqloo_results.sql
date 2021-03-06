-- 0 SELECT basics
-- 1.
SELECT population FROM world
  WHERE name = 'Germany'

-- 2.
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');
-- 3.
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000
-- 1 SELECT name

-- 1.
SELECT name FROM world
  WHERE name LIKE 'Y%'
-- 2.
SELECT name FROM world
  WHERE name LIKE '%y'
-- 3.
SELECT name FROM world
  WHERE name LIKE '%x%'
-- 4.
SELECT name FROM world
  WHERE name LIKE '%land'
-- 5.
SELECT name FROM world
  WHERE name LIKE 'C%ia'
-- 6.
SELECT name FROM world
  WHERE name LIKE '%oo%'
-- 7.
SELECT name FROM world
  WHERE name LIKE '%a%a%a%'
-- 8.
SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name
-- 9.
SELECT name FROM world
 WHERE name LIKE '%o__o%'
-- 10.
SELECT name FROM world
 WHERE name LIKE '____'
-- 11.
SELECT name
  FROM world
 WHERE capital = name;

-- 12.
SELECT name
FROM world
WHERE capital LIKE CONCAT(name, '%city');
-- 13, 14, and 15 have a bug, please skip them


-- 2 SELECT from World
-- 1.
SELECT name, continent, population FROM world
-- 2.
SELECT name FROM world
WHERE population > 200000000
-- 3.
SELECT name, gdp / population
FROM world
WHERE population > 200000000;
-- 4.
SELECT name, population/1000000 FROM world
  WHERE continent = 'South America'
-- 5.
SELECT name,population FROM world
  WHERE name IN ('France','Germany','Italy')
-- 6.
SELECT name FROM world
Where name Like '%United%' 
-- 7.
SELECT name, population, area FROM world
WHERE population > 250000000 or area > 3000000
-- 8.
SELECT name, population, area FROM world
WHERE area > 3000000 XOR population > 250000000
-- 9.
select name, ROUND(population/1000000,2), ROUND(gdp/1000000000,2) from world
  where continent = 'South America'
-- 10.
SELECT name, ROUND(gdp/ population, -3) FROM world
WHERE gdp > 1000000000000
-- 11.
SELECT name, capital FROM world
WHERE LENGTH(capital) = Length(name)
-- 12.
SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital;
-- 13.

SELECT name FROM world
WHERE name LIKE '%a%'
AND name LIKE '%e%' 
AND name LIKE '%i%' 
AND name LIKE '%o%' 
AND name LIKE '%u%' 
AND NAME NOT LIKE '% %'

-- 3 SELECT from Nobel
-- 1.
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

-- 2.
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'
-- 3.
SELECT yr, subject FROM nobel
WHERE winner = 'Albert Einstein'
-- 4.
SELECT winner FROM nobel
WHERE subject = 'Peace' AND yr >= 2000
-- 5.
SELECT yr, subject, winner
  FROM nobel
WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989
-- 6.
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')
-- 7.
SELECT winner FROM nobel
WHERE winner LIKE 'John%'
-- 8.
SELECT yr, subject, winner FROM nobel
WHERE subject = 'Physics' AND yr = '1980'
OR subject = 'Chemistry' AND yr = '1984'
-- 9.
SELECT * FROM nobel
WHERE yr = '1980' AND subject NOT IN ('Chemistry', 'Medicine')
-- 10.
SELECT yr, subject, winner FROM nobel
WHERE subject = 'Medicine' AND yr < 1910
OR subject = 'Literature' AND yr >= 2004
-- 11.
SELECT * FROM nobel
WHERE winner = 'PETER GRÜNBERG'
-- 12.
SELECT * FROM nobel
WHERE winner = 'EUGENE O''NEILL'
-- 13.
SELECT winner, yr, subject FROM nobel
  WHERE winner LIKE 'Sir %'
  ORDER BY yr DESC, winner
-- 14.

SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject in ('Chemistry','Physics'), subject, winner

-- 4 SELECT within SELECT
-- 1.SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- 2.
SELECT name FROM world
WHERE continent = 'Europe'
AND gdp/population > (SELECT gdp/population
                            FROM world
                           WHERE name = 'United Kingdom')
-- 3.
SELECT name, continent FROM world
WHERE continent IN (SELECT continent FROM world 
WHERE name IN ('Argentina','Australia'))
ORDER BY name
-- 4.
SELECT name, population FROM world
WHERE population > 
(SELECT population FROM world 
WHERE name = 'CANADA') 
AND population < 
(SELECT population FROM world 
WHERE name = 'Poland')
-- 5.
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world
WHERE name = 'Germany')*100,0),'%')
FROM world WHERE continent = 'Europe'
-- As noted in the tutorial, questions 6 - 10 in this unit are considered bonuses, just like units 6 - 8+
-- 6.
SELECT name FROM world
WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe' AND gdp > 0)
-- 7.
SELECT continent, name, area FROM world x
WHERE area >= ALL
(SELECT area FROM world y
WHERE y.continent=x.continent
AND area>0)
-- 8.
SELECT continent, name FROM world x
  WHERE name <= ALL
    (SELECT name FROM world y
        WHERE y.continent=x.continent)
-- 9.
SELECT name, continent, population FROM world x
  WHERE 25000000 >= ALL(SELECT population
	                FROM world y
		        WHERE x.continent = y.continent
                        AND y.population>0);
-- 10.

SELECT name, continent FROM world x
  WHERE population >= ALL(SELECT population*3
                         FROM world y
                         WHERE x.continent = y.continent
                         and y.name != x.name)

-- 5 SUM and COUNT
-- 1.
SELECT SUM(population)
FROM world
-- 2.
SELECT DISTINCT continent FROM world
-- 3.
SELECT SUM(gdp) FROM world
WHERE continent =  'Africa'
-- 4.
SELECT COUNT(name) FROM world 
WHERE area > 1000000
-- 5.
SELECT SUM(population) FROM world
WHERE name = 'Estonia'
OR name = 'Latvia'
OR name = 'Lithuania'
-- 6.
SELECT continent, COUNT(name) FROM world
GROUP BY continent
-- 7.
SELECT continent, COUNT(name) FROM world
WHERE population > 10000000
GROUP BY continent
-- 8.
SELECT continent FROM world
GROUP BY continent
HAVING SUM(population) > 100000000
-- Note: the units below this are bonus for this weekend, and they will be required in a future assignment. If you do them now you will be ahead of the game!
-- 6 JOIN
-- 1.
SELECT matchid, player FROM goal
  WHERE teamid = 'GER'
-- 2.
SELECT id,stadium,team1,team2
  FROM game
  WHERE id = 1012
-- 3.
SELECT player,teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER'
-- 4.

SELECT team1, team2, player FROM game 
JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%'
-- 5.
SELECT player, teamid, coach, gtime
FROM goal 
JOIN eteam on (teamid=Id)
WHERE gtime<=10
-- 6.
SELECT mdate,teamname FROM game
JOIN eteam ON (team1 = eteam.id)
WHERE coach = 'Fernando Santos'
-- 7.
SELECT player FROM goal
  JOIN game ON (matchid = id)
  WHERE stadium = 'National Stadium, Warsaw'
-- 8.
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id
    WHERE (team1= 'GER' OR team2='GER')
    AND teamid != 'GER'
-- 9.
SELECT teamname, COUNT(*)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname
-- 10.
SELECT stadium, COUNT(*) FROM goal
  JOIN game ON (matchid = id)
  GROUP BY stadium
-- 11.
SELECT matchid, mdate, COUNT(*)
  FROM game JOIN goal ON matchid = id
  WHERE (team1 = 'POL' OR team2 = 'POL')
  GROUP BY matchid, mdate
-- 12.
SELECT matchid, mdate, COUNT(*) FROM goal
  JOIN game ON (matchid=id)
  WHERE teamid = 'GER'
  GROUP BY matchid, mdate
-- 13.

SELECT DISTINCT mdate, team1,
	SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
    team2,
    SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game
LEFT JOIN goal ON game.id = goal.matchid
GROUP BY id, mdate, team1, team2
ORDER BY mdate, matchid, team1, team2

-- 7 More JOIN operations
-- 1.
SELECT id, title
 FROM movie
 WHERE yr=1962
-- 2.
SELECT yr FROM movie
WHERE title = 'citizen kane'
-- 3.
SELECT id, title, yr FROM movie
  WHERE title LIKE '%Star Trek%'
  ORDER BY yr
-- 4.
Select id FROM actor
WHERE name = 'Glenn Close'
-- 5.
SELECT id FROM movie
WHERE title = 'casablanca'
-- 6.
SELECT name FROM casting JOIN actor ON (id=actorid)
  WHERE movieid=11768
-- 7.
SELECT name FROM casting
  JOIN actor ON (actor.id=actorid)
  JOIN movie ON (movie.id=movieid)
  WHERE title = 'Alien'
-- 8.
SELECT title FROM casting
  JOIN movie ON (movie.id = movieid)
  JOIN actor ON (actor.id = actorid)
  WHERE name = 'Harrison Ford'
-- 9.
SELECT title FROM casting
  JOIN movie ON (movie.id = movieid)
  JOIN actor ON (actor.id = actorid)
  WHERE name = 'Harrison Ford'  AND ord > 1
-- 10.
SELECT title, name FROM casting
  JOIN movie ON (movie.id = movieid)
  JOIN actor ON (actor.id = actorid)
  WHERE yr = 1962 and ord = 1
-- 11.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 WHERE name='Rock Hudson'
 GROUP BY yr) as t)
-- 12.
SELECT title, name FROM casting
  JOIN movie ON movie.id = movieid
  JOIN actor ON actor.id = actorid
WHERE ord = 1
	AND movie.id IN
	(SELECT movie.id FROM movie
	   JOIN casting ON movie.id = movieid
	   JOIN actor ON actor.id = actorid
           WHERE actor.name = 'Julie Andrews')
-- 13.
SELECT DISTINCT name FROM casting
  JOIN movie ON movie.id = movieid
  JOIN actor ON actor.id = actorid
  WHERE actorid IN (
	SELECT actorid FROM casting
	  WHERE ord = 1
	  GROUP BY actorid
	  HAVING COUNT(actorid) >= 15)
ORDER BY name

-- 14.
SELECT title, COUNT(actorid) FROM casting
  JOIN movie ON movieid = movie.id
  WHERE yr = 1978
ORDER BY COUNT(actorid) DESC  
GROUP BY movieid, title
-- 15.

 JOIN actor ON actorid = actor.id
  WHERE name != 'Art Garfunkel'
	AND movieid IN (
		SELECT movieid
		FROM movie
		JOIN casting ON movieid = movie.id
		JOIN actor ON actorid = actor.id
		WHERE actor.name = 'Art Garfunkel'
)
-- 8 Using Null
-- 1.
SELECT name FROM teacher
WHERE dept IS NULL
-- 2.
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
-- 3.
SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)
-- 4.
SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id)
-- 5.
SELECT teacher.name, COALESCE(teacher.mobile,'07986 444 2266')  FROM teacher
-- 6.
SELECT teacher.name, COALESCE(dept.name,'None') FROM teacher
  LEFT JOIN dept ON teacher.dept = dept.id
-- 7.
SELECT COUNT(name), COUNT(mobile) FROM teacher
-- 8.
SELECT dept.name, COUNT(teacher.dept) FROM teacher
  RIGHT JOIN dept ON dept.id = teacher.dept
  GROUP BY dept.name
-- 9.
SELECT name, CASE WHEN dept IN (1,2) THEN 'Sci'
                  ELSE 'Art'
                  END
                  FROM teacher
-- 10.

SELECT name, CASE WHEN dept IN (1,2) THEN 'Sci'
                  WHEN dept = 3 THEN 'Art'
                  ELSE 'None'
                  END
                  FROM teacher

-- 8+ Numeric Examples
-- 1.
SELECT A_STRONGLY_AGREE FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science';
-- 2.
SELECT institution, subject FROM nss
WHERE question='Q15' AND score >=100;
-- 3.
SELECT institution, score FROM nss
WHERE question='Q15'
AND subject='(8) Computer Science'
AND score < 50;
-- 4.
SELECT subject, SUM(response) FROM nss 
WHERE question = 'Q22'
GROUP BY subject HAVING subject 
IN('(8) Computer Science', '(H) Creative Arts and Design');

-- 5.
SELECT subject, SUM((response*A_STRONGLY_AGREE) / 100) FROM nss
WHERE question='Q22'
GROUP BY subject HAVING subject IN('(8) Computer Science', 
'(H) Creative Arts and Design');
-- 6.
SELECT subject,
ROUND(SUM(A_STRONGLY_AGREE * response) / SUM(response))
FROM nss
WHERE question='Q22'
GROUP BY subject
HAVING subject IN('(8) Computer Science',
'(H) Creative Arts and Design');
-- 7.
SELECT institution, ROUND(SUM(score * response) / SUM(response))
FROM nss
WHERE question='Q22' AND (institution LIKE '%Manchester%')
GROUP BY institution;
-- 8.
SELECT institution, SUM(sample) AS sample_n,
SUM(CASE WHEN subject = '(8) Computer Science' THEN sample
ELSE 0 END) AS computing_n
FROM nss
WHERE question='Q01' AND (institution LIKE '%Manchester%')
GROUP BY institution;
