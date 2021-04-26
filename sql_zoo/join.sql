--https://sqlzoo.net/wiki/The_JOIN_operation
--1.
SELECT 	matchid, player FROM goal 
WHERE 	teamid = 'GER'

--2.
SELECT 	id,stadium,team1,team2
FROM 	game
where 	id ='1012'
--3.
/*
"""You can combine the two steps into a single query with a JOIN.

The FROM clause says to merge data from the goal table with that from the game table.
The ON says how to figure out which rows in game go with which rows in goal - the matchid
from goal must match id from game. (If we wanted to be more clear/specific we could say
The code below shows the player (from the goal) and stadium name
(from the game table) for every goal scored.

Modify it to show the player, teamid, stadium and mdate for every German goal.
"""
*/

SELECT *
FROM game JOIN goal ON (id=matchid)


SELECT 	player, teamid, stadium, mdate 
FROM 	game JOIN goal ON (id=matchid)
where 	goal.teamid = 'GER'
-- 4.
-- """Use the same JOIN as in the previous question.

-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
-- """

SELECT 	team1,team2,player
FROM 	game JOIN goal ON (id=matchid)
where 	player LIKE 'Mario%'
-- 5.
-- """The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id

-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
-- """
SELECT 	player, teamid, coach, gtime 
FROM 	goal JOIN eteam ON (teamid=id)
where 	goal.gtime <=10

-- 6.
-- """To JOIN game with eteam you could use either
-- game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)

-- Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
-- """

-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

select 	mdate,teamname 
from 	game JOIN eteam ON (team1=eteam.id)
where 	eteam.coach= 'Fernando Santos'
-- 7.
-- """List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'"""
select 	player 
from 	goal JOIN game ON (game.id=goal.matchid)
where 	game.stadium='National Stadium, Warsaw'
-- 8.
SELECT 	distinct(player)
FROM 	game JOIN goal ON (goal.matchid=game.id)
WHERE 	(team1='GER' OR team2='GER')
AND 	goal.teamid!='GER'
-- 9. 
-- """ Show teamname and the total number of goals scored. """

SELECT 		teamname, count(teamid)
FROM 		eteam JOIN goal ON(eteam.id=goal.teamid)
GROUP BY 	teamname
-- 10.
-- Show the stadium and the number of goals scored in each stadium.

SELECT 		stadium, count(goal.matchid)
FROM 		game JOIN goal ON(game.id=goal.matchid)
GROUP BY 	game.stadium
-- 11.
-- For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT 		matchid, mdate, count(teamid)
FROM 		goal JOIN game ON(goal.matchid=game.id)
WHERE 		team1='POL' OR team2='POL'
GROUP BY 	matchid, mdate

-- 12.
-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

-- 13.


