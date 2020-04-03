-- EXERCISES WITH NOBEL TABLE

-- Show the total number of prizes awarded.

SELECT COUNT(winner) FROM nobel

-- List each subject - just once

SELECT DISTINCT subject FROM nobel

-- Show the total number of prizes awarded for Physics.

SELECT COUNT(subject) FROM nobel
WHERE subject='Physics'

-- For each subject show the subject and the number of prizes.

SELECT subject, COUNT(subject) FROM nobel
GROUP BY subject

-- For each subject show the first year that the prize was awarded.

SELECT subject, MIN(yr) FROM nobel
GROUP BY subject


-- For each subject show the number of prizes awarded in the year 2000.

SELECT subject, COUNT(yr) FROM nobel
WHERE yr=2000
GROUP BY subject

-- Show the number of different winners for each subject.

SELECT subject, COUNT(DISTINCT winner) FROM nobel
GROUP BY subject

-- For each subject show how many years have had prizes awarded.

SELECT subject, COUNT(DISTINCT yr) FROM nobel
GROUP BY subject

-- Show the years in which three prizes were given for Physics.

SELECT yr FROM nobel
WHERE subject='Physics'
GROUP BY yr
HAVING COUNT(yr)=3

-- Show winners who have won more than once.

SELECT winner FROM nobel
GROUP BY winner
HAVING COUNT(winner) > 1

-- Show winners who have won more than one subject.

SELECT winner FROM nobel
GROUP BY winner
HAVING COUNT(DISTINCT subject)>1

-- Show the year and subject where 3 prizes were given. Show only years 2000 onwards.

SELECT yr, subject FROM nobel
WHERE yr>1999
GROUP BY yr, subject
HAVING COUNT(subject)= 3

-- World Country Profile
-- Using GROUP BY and HAVING

-- For each continent show the number of countries:

SELECT continent, COUNT(name)
  FROM world
 GROUP BY continent

-- For each continent show the total population:

SELECT continent, SUM(population)
  FROM world
 GROUP BY continent

-- For each relevant continent show the number of countries that has a population of at least 200000000.

SELECT continent, COUNT(name)
  FROM world
 WHERE population>200000000
 GROUP BY continent

-- Show the total population of those continents with a total population of at least half a billion.

SELECT continent, SUM(population)
  FROM world
 GROUP BY continent
HAVING SUM(population)>500000000

-- Old JOIN Tutorial

-- Show the athelete (who) and the country name for medal winners in 2000.

SELECT who, country.name
  FROM ttms JOIN country
         ON (ttms.country=country.id)
 WHERE games = 2000

-- Show the who and the color of the medal for the medal winners from 'Sweden'.

SELECT who, color FROM ttms JOIN country ON ttms.country=country.id
WHERE country.name='Sweden'

-- Show the years in which 'China' won a 'gold' medal.

SELECT games FROM country JOIN ttms ON country.id=ttms.country
WHERE name='China' AND color='gold'

-- Show who won medals in the 'Barcelona' games.

SELECT who
  FROM ttws JOIN games
            ON (ttws.games=games.yr)
  WHERE city = 'Barcelona'

-- Show which city 'Jing Chen' won medals. Show the city and the medal color.

SELECT games.city, color FROM ttws JOIN games ON games=yr
WHERE who='Jing Chen'

-- Show who won the gold medal and the city.

SELECT who, games.city FROM ttws JOIN games ON ttws.games=yr
WHERE color='gold'

-- Show the games and color of the medal won by the team that includes 'Yan Sen'.

SELECT games, color FROM ttmd JOIN team ON ttmd.team=team.id
WHERE team.name='Yan Sen'

-- Show the 'gold' medal winners in 2004.

SELECT name FROM ttmd JOIN team ON ttmd.team=team.id
WHERE games=2004 AND color='gold'

-- Show the name of each medal winner country 'FRA'.

SELECT name FROM team JOIN ttmd ON ttmd.team=team.id
WHERE country='FRA'
