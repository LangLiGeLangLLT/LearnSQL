-- 1. 新建一个名为 bonus 的数据库进行以下的练习
CREATE DATABASE bonus;

-- 2. 指向新建的数据库
USE bonus;

-- 3. 创建一个表格来记录篮球队
CREATE TABLE teams (
    team_id         INTEGER(2)      NOT NULL,
    name            VARCHAR(20)     NOT NULL
);

-- 4. 创建一个表格记录队员
CREATE TABLE players (
    player_id       INTEGER(2)      NOT NULL,
    last            VARCHAR(20)     NOT NULL,
    first           VARCHAR(20)     NOT NULL,
    team_id         INTEGER(2)      NULL,
    number          INTEGER(2)      NOT NULL
);

-- 5. 创建一个表格记录队员的个人信息
CREATE TABLE player_data (
    player_id       INTEGER(2)      NOT NULL,
    height          DECIMAL(4, 2)   NOT NULL,
    WEIGHT          DECIMAL(5, 2)   NOT NULL
);

-- 6. 创建一个表格记录比赛
CREATE TABLE games (
    game_id         INTEGER(2)      NOT NULL,
    game_dt         DATETIME        NOT NULL,
    home_team_id    INTEGER(2)      NOT NULL,
    guest_team_id   INTEGER(3)      NOT NULL
);

-- 7. 创建一个表格记录每支球队在每场比赛里的成绩
CREATE TABLE scores (
    game_id         INTEGER(2)      NOT NULL,
    team_id         INTEGER(2)      NOT NULL,
    score           INTEGER(3)      NOT NULL,
    win_lose        VARCHAR(4)      NOT NULL
);

-- 8. 查看这些表
SHOW TABLES;

-- 9. 生成篮球队的记录 (team_id, name)
INSERT INTO teams VALUES ('1', 'STRING MUSIC');
INSERT INTO teams VALUES ('2', 'HACKERS');
INSERT INTO teams VALUES ('3', 'SHARP SHOOTERS');
INSERT INTO teams VALUES ('4', 'HAMMER TIME');

-- 10. 生成队员的记录 (player_id, last, first, team_id, number)
INSERT INTO players VALUES ('1', 'SMITH', 'JOHN', '1', '12');
INSERT INTO players VALUES ('2', 'BOBBIT', 'BILLY', '1', '2');
INSERT INTO players VALUES ('3', 'HURTA', 'WIL', '2', '32');
INSERT INTO players VALUES ('4', 'OUCHY', 'TIM', '2', '22');
INSERT INTO players VALUES ('5', 'BYRD', 'ERIC', '3', '6');
INSERT INTO players VALUES ('6', 'JORDAN', 'RYAN', '3', '23');
INSERT INTO players VALUES ('7', 'HAMMER', 'WALLY', '4', '21');
INSERT INTO players VALUES ('8', 'HAMMER', 'RON', '4', '44');
INSERT INTO players VALUES ('11', 'KNOTGOOD', 'AL', NULL, '0');

-- 11. 生成队员的个人信息 (player_id, height, weight)
INSERT INTO player_data VALUES ('1', '71', '180');
INSERT INTO player_data VALUES ('2', '58', '195');
INSERT INTO player_data VALUES ('3', '72', '200');
INSERT INTO player_data VALUES ('4', '74', '170');
INSERT INTO player_data VALUES ('5', '71', '182');
INSERT INTO player_data VALUES ('6', '72', '289');
INSERT INTO player_data VALUES ('7', '79', '250');
INSERT INTO player_data VALUES ('8', '73', '193');
INSERT INTO player_data VALUES ('11', '85', '310');

-- 12. 基于已经安排的比赛生成 games 表里的记录 (game_id, game_dt, home_team_id, guest_team_id)
INSERT INTO games VALUES ('1', '2002-05-01', '1', '2');
INSERT INTO games VALUES ('2', '2002-05-02', '3', '4');
INSERT INTO games VALUES ('3', '2002-05-03', '1', '3');
INSERT INTO games VALUES ('4', '2002-05-05', '2', '4');
INSERT INTO games VALUES ('5', '2002-05-05', '1', '2');
INSERT INTO games VALUES ('6', '2002-05-09', '3', '4');
INSERT INTO games VALUES ('7', '2002-05-10', '2', '3');
INSERT INTO games VALUES ('8', '2002-05-11', '1', '4');
INSERT INTO games VALUES ('9', '2002-05-12', '2', '3');
INSERT INTO games VALUES ('10', '2002-05-15', '1', '4');

-- 13. 基于已经进行的比赛生成 scores 表里的记录 (game_id, team_id, score, win_lose)
INSERT INTO scores VALUES ('1', '1', '66', 'LOSE');
INSERT INTO scores VALUES ('2', '3', '78', 'WIN');
INSERT INTO scores VALUES ('3', '1', '45', 'LOSE');
INSERT INTO scores VALUES ('4', '2', '56', 'LOSE');
INSERT INTO scores VALUES ('5', '1', '100', 'WIN');
INSERT INTO scores VALUES ('6', '3', '67', 'LOSE');
INSERT INTO scores VALUES ('7', '2', '57', 'LOSE');
INSERT INTO scores VALUES ('8', '1', '98', 'WIN');
INSERT INTO scores VALUES ('9', '2', '56', 'LOSE');
INSERT INTO scores VALUES ('10', '1', '46', 'LOSE');

INSERT INTO scores VALUES ('1', '2', '75', 'WIN');
INSERT INTO scores VALUES ('2', '4', '46', 'LOSE');
INSERT INTO scores VALUES ('3', '3', '87', 'WIN');
INSERT INTO scores VALUES ('4', '4', '99', 'WIN');
INSERT INTO scores VALUES ('5', '2', '88', 'LOSE');
INSERT INTO scores VALUES ('6', '4', '77', 'WIN');
INSERT INTO scores VALUES ('7', '3', '87', 'WIN');
INSERT INTO scores VALUES ('8', '4', '56', 'LOSE');
INSERT INTO scores VALUES ('9', '3', '87', 'WIN');
INSERT INTO scores VALUES ('10', '4', '78', 'WIN');

-- 14. 球员的平均身高是多少？
SELECT AVG(height) FROM player_data;

-- 15. 球员的平均体重是多少？
SELECT AVG(weight) FROM player_data;

-- 16. 像下面这样查看球员信息：name=last number=n height=n weight=n
SELECT CONCAT('name=', P1.last, ' number=', P1.number, ' height=', P2.height, ' weight=', P2.weight)
FROM players P1, player_data P2
WHERE P1.player_id = P2.player_id;

-- 17. 像下面这样创建一个球队的人名单：team name    last, first     number
SELECT T.name, CONCAT(P.last, ', ', P.first), P.number
FROM teams T, players P
WHERE T.team_id = P.team_id;

-- 18. 哪支球队在全部比赛中获得了最多的分数？
SELECT T.name, SUM(S.score)
FROM teams T, scores S
WHERE T.team_id = S.team_id
GROUP BY T.name
ORDER BY 2 DESC;

-- 19. 哪支球队在一场比赛里获得了最高的分数？
SELECT team_id, MAX(score) FROM scores;

-- 20. 在一场比赛里，两队分数之和最高是多少？
SELECT game_id, SUM(score)
FROM scores
GROUP BY game_id
ORDER BY 2 DESC;

-- 21. 哪个球员不属于任何球队？
SELECT last, first, team_id
FROM players
WHERE team_id IS NULL;

-- 22. 一共有多少只球队？
SELECT COUNT(*) FROM teams;

-- 23. 一共有多少球员？
SELECT COUNT(*) FROM players;

-- 24. 2002年5月5日多少场比赛？
SELECT COUNT(*)
FROM games
WHERE game_dt = '2002-05-05';

-- 25. 谁是最高的球员？
SELECT P.last, P.first, PD.height
FROM players P, player_data PD
WHERE P.player_id = PD.player_id
ORDER BY 3 DESC;

-- 26. 把 Ron Hammer 的记录从数据库里删除，用 Al Knotgood 替换他
SELECT player_id
FROM players
WHERE last = 'HAMMER'
AND first = 'RON';

DELETE FROM players WHERE player_id = '8';

DELETE FROM player_data WHERE player_id = '8';

SELECT player_id
FROM players
WHERE last = 'KNOTGOOD'
AND first = 'AL';

UPDATE players
SET team_id = '4'
WHERE player_id = '11';

-- 27. 谁是 Al Knotgood 的新队友
SELECT teammate.last, teammate.first
FROM players teammate, players P
WHERE P.team_id = teammate.team_id
AND P.last = 'KNOTGOOD'
AND P.first = 'AL';

-- 28. 生成一个列表，列出全部比赛和比赛日期，以及每场比赛的主队和客队
SELECT G.game_id, G.game_dt, HT.name, GT.name
FROM games G, teams HT, teams GT
WHERE HT.team_id = G.home_team_id
AND GT.team_id = G.guest_team_id;

-- 29. 为数据库里的全部姓名设置索引。我们经常会根据姓名进行搜索，所以一般会被设置索引
CREATE INDEX team_idx
ON teams (name);

CREATE INDEX players_idx
ON players (last, first);

-- 30. 哪支球队赢的比赛最多？
SELECT T.name, COUNT(S.win_lose)
FROM teams T, scores S
WHERE T.team_id = S.team_id
AND S.win_lose = 'WIN'
GROUP BY T.name
ORDER BY 2 DESC;

-- 31. 哪支球队输的比赛最多？
SELECT T.name, COUNT(S.win_lose)
FROM teams T, scores S
WHERE T.team_id = S.team_id
AND S.win_lose = 'LOSE'
GROUP BY T.name
ORDER BY 2 DESC;

-- 32. 哪支球队的场均得分最高？
SELECT T.name, AVG(S.score)
FROM teams T, scores S
WHERE T.team_id = S.team_id
GROUP BY T.name
ORDER BY 2 DESC;

-- 33. 生成一个报告来展示每支球队的记录。输出结果首先按赢的场次多排序，再按输的场次少排序
SELECT T.name, SUM(REPLACE(S.win_lose, 'WIN', 1)) wins, SUM(REPLACE(S.win_lose, 'LOSE', 1)) losses
FROM teams T, scores S
WHERE T.team_id = S.team_id
GROUP BY T.name
ORDER BY 2 DESC, 3;

-- 34. 每场比赛的最终比分是多少？
SELECT G.game_id, HOME_TEAMS.name "home team", HOME_SCORES.score, GUEST_TEAMS.name "GUEST TEAM", GUEST_SCORES.score
FROM games G, teams HOME_TEAMS, teams GUEST_teams, scores HOME_SCORES, scores GUEST_SCORES
WHERE G.home_team_id = HOME_TEAMS.team_id
AND G.guest_team_id = GUEST_TEAMS.team_id
AND HOME_SCORES.game_id = G.game_id
AND GUEST_SCORES.game_id = G.game_id
AND HOME_SCORES.team_id = G.home_team_id
AND GUEST_SCORES.team_id = G.guest_team_id
ORDER BY G.game_id;