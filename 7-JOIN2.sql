-- List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962

-- Give year of 'Citizen Kane'.

SELECT yr FROM movie
WHERE title='Citizen Kane'

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id, title, yr FROM movie
WHERE title LIKE '%Star trek%'
ORDER BY yr

-- What id number does the actor 'Glenn Close' have?

SELECT id FROM actor
WHERE name='Glenn Close'

-- What is the id of the film 'Casablanca'

SELECT id FROM movie
WHERE title='Casablanca'

-- Obtain the cast list for 'Casablanca'.

SELECT name FROM casting JOIN actor ON actorid=id
WHERE movieid=11768

-- Obtain the cast list for the film 'Alien'

SELECT name FROM actor JOIN casting ON actorid=id
WHERE movieid=(SELECT id FROM movie WHERE title='Alien')

-- List the films in which 'Harrison Ford' has appeared

SELECT title FROM movie JOIN casting ON id=movieid WHERE actorid=(SELECT id FROM actor WHERE name='Harrison Ford')

-- List the films where 'Harrison Ford' has appeared - but not in the starring role.

SELECT title FROM movie JOIN casting ON id=movieid WHERE actorid=(SELECT id FROM actor WHERE name='Harrison Ford') AND ord != 1

-- List the films together with the leading star for all 1962 films.

SELECT title, actor.name 
FROM movie JOIN casting ON movie.id=movieid
JOIN actor ON actor.id= actorid
WHERE yr=1962 AND ord=1 

-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in

SELECT title,name 
FROM movie JOIN casting ON (movieid=movie.id AND ord=1)
           JOIN actor ON actor.id=actorid
WHERE movie.id IN (SELECT movieid FROM casting
WHERE actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews'))

-- Obtain a list, in alphabetical order, of actors who have had at least 15 starring roles.

SELECT name FROM actor JOIN casting ON id=actorid AND ord=1
GROUP BY actorid
HAVING COUNT(movieid) >= 15
ORDER BY name

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT title,COUNT(actorid) FROM movie JOIN casting ON id=movieid
WHERE yr=1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title

-- List all the people who have worked with 'Art Garfunkel'.

SELECT DISTINCT name FROM actor JOIN casting ON id=actorid
WHERE id IN(SELECT actorid FROM casting WHERE movieid IN(SELECT movieid FROM casting WHERE actorid IN(SELECT id FROM actor WHERE name='Art Garfunkel'))) AND name!='Art Garfunkel';
