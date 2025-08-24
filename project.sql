use t20
...players table...
create table players(player_name varchar(20) primary key,team varchar(20))
select * from players
....batting table.....
create table batting(player_name varchar(20),foreign key(player_name)references players(player_name),
team varchar(10),matches int,innings int,notout int,runs int,height_score varchar(20),
average float,strike_rate float,centuries int,half_centuries int,duck_outs int)
select * from batting
....bowling table.....
create table bowling(player_name varchar(20),foreign key(player_name)references players(player_name),
team varchar(10),matches int,innings int,balls int,maidan_over int,runs int,wickect int,
average float,bowling_economy float ,strike_rate float,five_wickect  int,ten_wickect int,catches int)
select * from bowling 
....wicketkeeping table.....
create table wicketkeeping(player_name varchar(20),foreign key(player_name)references players(player_name),team varchar(20),
matches int,innings int,dismissals int,catches int,stumpings int )
select * from wicketkeeping
.....fielding table.....
create table fielding(player_name varchar(20),foreign key(player_name)references players(player_name)
,matches int,innings int,catches int)
select * from fielding
.....match_result table......
create table match_result(team1 varchar(20),team2 varchar(20),winner varchar(20)
,margine varchar(20),ground varchar(50),match_date date )
insert into match_result(team1,team2,winner,margine,ground,match_date) values
("Bangladesh","Netherlands","Bangladesh","25 runs","Kingstown","2024-6-13"),
("England","Oman","England","8 wickets","North Sound","202-6-12"),
("Afghanistan","Papua New Guinea","Afghanistan","7 wickets","Tarouba","2024-6-14"),
("Nepal","South Africa","South Africa","1 run","Kingstown","2024-6-15"),
("New Zealand","Uganda","New Zealand","9 wickets","Tarouba","2024-6-18"),
("England","Namibia","England","41 runs","North Sound","2024-6-19"),
("Australia","Scotland","Australia","5 wickets","Gros Islet","2024-6-20"),
("Ireland","Pakistan","Pakistan","3 wickets","Lauderhill","2024-6-22"),
("Bangladesh","Nepal","Bangladesh","21 runs","Kingstown","2024-6-23"),
("Netherlands","Sri Lanka","Sri Lanka","83 runs","Gros Islet","2024-6-24")
select * from match_result
drop table match_result

--1.RETRIEVE THE NAMES OF ALL PLAYERS.
select  player_name from players

--2.FIND ALL PLAYERS WHO BELONG TO  TEAM "SL"
select player_name from players where team="sl"

--3.FIND A AVERAGE RUNS SCORED BY PLAYERS IN DESCENDING ORDER .
select avg(runs),player_name from batting group by player_name order by avg(runs) desc

--4.GROUP PLAYERS BY TEAM AND COUNT THE NUMBER OF PLAYERS IN EACH TEAM.
select count(player_name),team from players group by team

--5.FIND TEAMS WITH MORE THAN 13 PLAYERS.
select count(player_name),team from players group by team having count(player_name)>13

--6.RETRIEVE THE NAMES OF PLAYERS AND ODER THEM BY THERI HEIGHTEST  SCORE IN DESCENDING ORDER .
select a.player_name,b.height_score from players as a inner join batting as b on a.player_name =b.player_name  order by  height_score desc

--7. FIND THE  PLAYERS WITH THE HEIGHTEST BATTING AVERAGE .
select player_name,average from batting order by average desc limit 1

--8.UPDATE THE MATCH_RESULT TABLE TO SET TEAM1 AS INDIA AND WINNER AS INDIA ..
update match_result set team1="india",winner="india" where match_date="0202-06-12"
--9.REMOVE A PLAYER FROM THE PLAYERS TABLE ..
 delete from match_result where match_date="2024-06-13"
 
 --10.ADD A NEW PLAYER TO THE PLAYERS TABLE..
 insert into match_result values("india","pak","india","10 wicket","chepack","2025-07-7") 
 
 --11.FIND THE MATCHES ENGLAND WON..
 select * from match_result where winner="england"
 
 --12.LIST PLAYERS USING RIGHT JIONS BATTING AND BOWLING  STATISTICS..
 select b.player_name ,b.team ,a.matches as batting_matches,a.innings as batting_innings,
 a.notout,a.runs as bat_run ,a.height_score,a.average as bat_avg ,a.strike_rate as bat_strike
 ,a.centuries,a.half_centuries,a.duck_outs, 
 c.matches as bowl_matches,c.innings as bowl_innings,c.balls,c.maidan_over,c.bowling_economy,
c.runs as bowl_runs,c.wickect as bowl_wicket,c.average as bowl_avg,c.strike_rate as bowl_strike,
c.five_wickect,c.ten_wickect,c.catches 
from players as b
  right join batting as a on b.player_name=a.player_name
  right join bowling as c on c.player_name=b.player_name
 13.LIST PLAYERS USING left JIONS BATTING AND BOWLING  STATISTICS..
 select a.player_name ,a.team ,a.matches as batting_matches,a.innings as batting_innings,
 a.notout,a.runs as bat_run ,a.height_score,a.average as bat_avg ,a.strike_rate as bat_strike
 ,a.centuries,a.half_centuries,a.duck_outs, 
 c.matches as bowl_matches,c.innings as bowl_innings,c.balls,c.maidan_over,c.bowling_economy,
c.runs as bowl_runs,c.wickect as bowl_wicket,c.average as bowl_avg,c.strike_rate as bowl_strike,
c.five_wickect,c.ten_wickect,c.catches from batting as a left join bowling as c on c.player_name=a.player_name

 --14 FIND THE TOP 3 PLAYERS WITH THE HEIGHEST AVERAGE BTATING SCORE ALONG WITH THEIR TEAM NAMES AND THE NUMBER OF MATCHES PLAYED
 select player_name,average,team,matches from batting order by average desc limit 3
 
 --15 LIST ALL PLAYERS WHO HAVE MORE THAN 15 WICKECTS IN THEIR BOWLING CARRER..
 select * from bowling where wickect>15
 
 --16 FIND THE TEAM WITH THE HEIGHTEST NUMBER OF TOTAL WICKECT TAKEN IN ALL MATCHES..
 select team,sum(wickect)from bowling  group by team order by sum(wickect) desc limit 1
 
 --17 LIST THE PLAYERS WHO HAVE THE HEIGHEST STRIKE RATE IN EACH TEAM
 select player_name,team,strike_rate from batting where (team,strike_rate)in
 (select team ,max(strike_rate) from batting group by team )
 
 --18 DISPLAY THE TEAM AND PLAYER NAMES "RA Jadeja" PATTERS.
  select team,player_name from players where player_name like "r%j%a%" limit 1
  --19DISPLAY THE TEAMS AND SHOWS INDIA WONS "SUPER" OTHER WISE SHOW "SAD" TABLE MATCH RESULT.
  select team1,team2,if(winner="india","super","sad")from match_result
  --20 CREATE A VIEW NAMED RESULT USING ALL THE COLUMNS THE  MATCH RESULT TABLE AND DISPLAY THE CONTENTS OF THAT VIEW.
  create view result as (select * from match_result)
  select * from result