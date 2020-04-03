-- How many stops are in the database.

SELECT COUNT(id) FROM stops

-- Find the id value for the stop 'Craiglockhart'

SELECT id FROM stops
WHERE name='Craiglockhart'

-- Give the id and the name for the stops on the '4' 'LRT' service.

SELECT id, name FROM stops JOIN route ON id=stop
WHERE num='4' AND company='LRT'

-- Add a HAVING clause to restrict the output to these two routes.

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*)=2

-- Change the query so that it shows the services from Craiglockhart to London Road.

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop=149

-- Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'

-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')

SELECT a.company, a.num FROM route a JOIN route b ON (a.company=b.company AND a.num = b.num)
WHERE a.stop = 115 AND b.stop = 137
GROUP BY a.num

-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'

SELECT a.company, a.num
    FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
    JOIN stops c ON a.stop=c.id JOIN stops d ON b.stop=d.id
    WHERE c.name = 'Craiglockhart' AND d.name = 'Tollcross'

-- Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.

SELECT d.name, a.company, a.num
    FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
    JOIN stops c ON a.stop = c.id JOIN stops d ON b.stop = d.id
    WHERE c.name = 'Craiglockhart' 

-- Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus.



