DELETE FROM AdminChangesTracker;
DELETE FROM Game;
DELETE FROM TeamStadium;
DELETE FROM FanTeam;
DELETE FROM NFLAdmin;
DELETE FROM NFLFan;
DELETE FROM AppUser;
DELETE FROM Stadium;
DELETE FROM Team;
DELETE FROM ConferenceDivision;

DBCC CHECKIDENT ('ConferenceDivision', RESEED, 0);
DBCC CHECKIDENT ('Team', RESEED, 0);
DBCC CHECKIDENT ('AppUser', RESEED, 0);
DBCC CHECKIDENT ('Stadium', RESEED, 0);
DBCC CHECKIDENT ('FanTeam', RESEED, 0);
DBCC CHECKIDENT ('TeamStadium', RESEED, 0);
DBCC CHECKIDENT ('Game', RESEED, 0);
DBCC CHECKIDENT ('AdminChangesTracker', RESEED, 0);

INSERT INTO ConferenceDivision (Conference, Division)
VALUES
('AFC','North'),
('AFC','East'),
('AFC','South'),
('AFC','West'),
('NFC','North'),
('NFC','East'),
('NFC','South'),
('NFC','West');

INSERT INTO Team (Tname, TcityState, Tcolors, Tlogo, CDID)
VALUES
('Ravens','Baltimore, MD','Purple, Black, Metallic Gold','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='North')),
('Bengals','Cincinnati, OH','Black, Orange, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='North')),
('Browns','Cleveland, OH','Brown, Orange, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='North')),
('Steelers','Pittsburgh, PA','Black, Gold, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='North')),

('Bills','Buffalo, NY','Royal Blue, Red, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='East')),
('Dolphins','Miami, FL','Aqua, Orange, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='East')),
('Patriots','New England, MA','Navy Blue, Red, Silver','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='East')),
('Jets','New York, NY','Green, White, Black','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='East')),

('Texans','Houston, TX','Deep Steel Blue, Battle Red, Liberty White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='South')),
('Colts','Indianapolis, IN','Speed Blue, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='South')),
('Jaguars','Jacksonville, FL','Teal, Black, Gold, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='South')),
('Titans','Tennessee, TN','Navy Blue, Titans Blue, Red, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='South')),

('Broncos','Denver, CO','Orange, Navy Blue, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='West')),
('Chiefs','Kansas City, MO','Red, Gold, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='West')),
('Raiders','Las Vegas, NV','Silver, Black','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='West')),
('Chargers','Los Angeles, CA','Powder Blue, Gold, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='AFC' AND Division='West')),

('Bears','Chicago, IL','Navy Blue, Orange, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='North')),
('Lions','Detroit, MI','Honolulu Blue, Silver, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='North')),
('Packers','Green Bay, WI','Green, Gold, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='North')),
('Vikings','Minnesota, MN','Purple, Gold, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='North')),

('Cowboys','Dallas, TX','Navy Blue, Silver, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='East')),
('Giants','New York, NY','Royal Blue, Red, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='East')),
('Redskins','Washington, DC','Burgundy, Gold, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='East')),
('Eagles','Philadelphia, PA','Midnight Green, Silver, Black, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='East')),

('Cardinals','Arizona, AZ','Cardinal Red, Black, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='West')),
('Rams','Los Angeles, CA','Royal Blue, Yellow, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='West')),
('49ers','San Francisco, CA','Scarlet Red, Gold, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='West')),
('Seahawks','Seattle, WA','College Navy Blue, Action Green, Wolf Grey','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='West')),

('Falcons','Atlanta, GA','Red, Black, Silver, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='South')),
('Panthers','Carolina, NC','Black, Panther Blue, Silver, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='South')),
('Saints','New Orleans, LA','Old Gold, Black, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='South')),
('Buccaneers','Tampa Bay, FL','Red, Pewter, White','Logo',(SELECT CDID FROM ConferenceDivision WHERE Conference='NFC' AND Division='South'));

INSERT INTO AppUser (Firstname, Lastname, Email, Phone, PasswordHash, UserRole)
VALUES
('Tom','Brady','tom.brady@example.com','555-1234',0x01,N'NFLFan'),
('Aaron','Rodgers','aaron.rodgers@example.com','555-9012',0x01,N'NFLFan'),
('Drew','Brees','drew.brees@example.com','555-2222',0x01,N'NFLFan'),
('Patrick','Mahomes','patrick.mahomes@example.com','555-7890',0x01,N'NFLFan'),
('Bill','Belichick','bill.belichick@example.com','555-5678',0x01,N'NFLAdmin'),
('Sean','McVay','sean.mcvay@example.com','555-3456',0x01,N'NFLAdmin'),
('Mike','Tomlin','mike.tomlin@example.com','555-1111',0x01,N'NFLAdmin'),
('Andy','Reid','andy.reid@example.com','555-3333',0x01,N'NFLAdmin');

INSERT INTO NFLFan (NFLFanID)
SELECT AppUserID
FROM AppUser
WHERE UserRole = N'NFLFan';

INSERT INTO NFLAdmin (NFLAdminID)
SELECT AppUserID
FROM AppUser
WHERE UserRole = N'NFLAdmin';

INSERT INTO FanTeam (NFLFanID, TeamID, PrimaryTeam)
VALUES
((SELECT AppUserID FROM AppUser WHERE Email='tom.brady@example.com'), (SELECT TeamID FROM Team WHERE Tname='Patriots'), 1),
((SELECT AppUserID FROM AppUser WHERE Email='tom.brady@example.com'), (SELECT TeamID FROM Team WHERE Tname='Buccaneers'), 0),
((SELECT AppUserID FROM AppUser WHERE Email='aaron.rodgers@example.com'), (SELECT TeamID FROM Team WHERE Tname='Packers'), 1),
((SELECT AppUserID FROM AppUser WHERE Email='aaron.rodgers@example.com'), (SELECT TeamID FROM Team WHERE Tname='Jets'), 0),
((SELECT AppUserID FROM AppUser WHERE Email='aaron.rodgers@example.com'), (SELECT TeamID FROM Team WHERE Tname='Steelers'), 0),
((SELECT AppUserID FROM AppUser WHERE Email='drew.brees@example.com'), (SELECT TeamID FROM Team WHERE Tname='Saints'), 1),
((SELECT AppUserID FROM AppUser WHERE Email='drew.brees@example.com'), (SELECT TeamID FROM Team WHERE Tname='Chargers'), 0),
((SELECT AppUserID FROM AppUser WHERE Email='patrick.mahomes@example.com'), (SELECT TeamID FROM Team WHERE Tname='Chiefs'), 1);

INSERT INTO Stadium (StadiumName, StadiumCityState, Capacity)
VALUES
('M&T Bank Stadium','Baltimore, MD',71008),
('Paycor Stadium','Cincinnati, OH',65515),
('Huntington Bank Field','Cleveland, OH',67431),
('Acrisure Stadium','Pittsburgh, PA',68400),
('Highmark Stadium','Buffalo, NY',71608),
('Hard Rock Stadium','Miami, FL',65300),
('Gillette Stadium','New England, MA',65878),
('MetLife Stadium','New York, NY',82500),
('NRG Stadium','Houston, TX',72220),
('Lucas Oil Stadium','Indianapolis, IN',67000),
('EverBank Stadium','Jacksonville, FL',62000),
('Nissan Stadium','Tennessee, TN',69143),
('Empower Field at Mile High','Denver, CO',76125),
('GEHA Field at Arrowhead Stadium','Kansas City, MO',76416),
('Allegiant Stadium','Las Vegas, NV',65000),
('SoFi Stadium','Los Angeles, CA',70240),
('Soldier Field','Chicago, IL',61500),
('Ford Field','Detroit, MI',65000),
('Lambeau Field','Green Bay, WI',81441),
('U.S. Bank Stadium','Minnesota, MN',66860),
('AT&T Stadium','Dallas, TX',80000),
('Lincoln Financial Field','Philadelphia, PA',69796),
('Northwest Stadium','Washington, DC',67617),
('State Farm Stadium','Arizona, AZ',63400),
('Levi''s Stadium','San Francisco, CA',68500),
('Lumen Field','Seattle, WA',69000),
('Mercedes-Benz Stadium','Atlanta, GA',71000),
('Bank of America Stadium','Carolina, NC',74867),
('Caesars Superdome','New Orleans, LA',73208),
('Raymond James Stadium','Tampa Bay, FL',69218);

INSERT INTO TeamStadium (TeamID, StadiumID, StartYear, EndYear)
VALUES
((SELECT TeamID FROM Team WHERE Tname='Ravens'), (SELECT StadiumID FROM Stadium WHERE StadiumName='M&T Bank Stadium'), 1998, NULL),
((SELECT TeamID FROM Team WHERE Tname='Bengals'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Paycor Stadium'), 2000, NULL),
((SELECT TeamID FROM Team WHERE Tname='Browns'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Huntington Bank Field'), 1999, NULL),
((SELECT TeamID FROM Team WHERE Tname='Steelers'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Acrisure Stadium'), 2001, NULL),
((SELECT TeamID FROM Team WHERE Tname='Bills'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Highmark Stadium'), 1973, NULL),
((SELECT TeamID FROM Team WHERE Tname='Dolphins'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Hard Rock Stadium'), 1987, NULL),
((SELECT TeamID FROM Team WHERE Tname='Patriots'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Gillette Stadium'), 2002, NULL),
((SELECT TeamID FROM Team WHERE Tname='Jets'), (SELECT StadiumID FROM Stadium WHERE StadiumName='MetLife Stadium'), 2010, NULL),
((SELECT TeamID FROM Team WHERE Tname='Texans'), (SELECT StadiumID FROM Stadium WHERE StadiumName='NRG Stadium'), 2002, NULL),
((SELECT TeamID FROM Team WHERE Tname='Colts'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Lucas Oil Stadium'), 2008, NULL),
((SELECT TeamID FROM Team WHERE Tname='Jaguars'), (SELECT StadiumID FROM Stadium WHERE StadiumName='EverBank Stadium'), 1995, NULL),
((SELECT TeamID FROM Team WHERE Tname='Titans'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Nissan Stadium'), 1999, NULL),
((SELECT TeamID FROM Team WHERE Tname='Broncos'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Empower Field at Mile High'), 2001, NULL),
((SELECT TeamID FROM Team WHERE Tname='Chiefs'), (SELECT StadiumID FROM Stadium WHERE StadiumName='GEHA Field at Arrowhead Stadium'), 1972, NULL),
((SELECT TeamID FROM Team WHERE Tname='Raiders'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Allegiant Stadium'), 2020, NULL),
((SELECT TeamID FROM Team WHERE Tname='Chargers'), (SELECT StadiumID FROM Stadium WHERE StadiumName='SoFi Stadium'), 2020, NULL),
((SELECT TeamID FROM Team WHERE Tname='Bears'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Soldier Field'), 1971, NULL),
((SELECT TeamID FROM Team WHERE Tname='Lions'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Ford Field'), 2002, NULL),
((SELECT TeamID FROM Team WHERE Tname='Packers'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Lambeau Field'), 1957, NULL),
((SELECT TeamID FROM Team WHERE Tname='Vikings'), (SELECT StadiumID FROM Stadium WHERE StadiumName='U.S. Bank Stadium'), 2016, NULL),
((SELECT TeamID FROM Team WHERE Tname='Cowboys'), (SELECT StadiumID FROM Stadium WHERE StadiumName='AT&T Stadium'), 2009, NULL),
((SELECT TeamID FROM Team WHERE Tname='Giants'), (SELECT StadiumID FROM Stadium WHERE StadiumName='MetLife Stadium'), 2010, NULL),
((SELECT TeamID FROM Team WHERE Tname='Redskins'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Northwest Stadium'), 1997, NULL),
((SELECT TeamID FROM Team WHERE Tname='Eagles'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Lincoln Financial Field'), 2003, NULL),
((SELECT TeamID FROM Team WHERE Tname='Cardinals'), (SELECT StadiumID FROM Stadium WHERE StadiumName='State Farm Stadium'), 2006, NULL),
((SELECT TeamID FROM Team WHERE Tname='Rams'), (SELECT StadiumID FROM Stadium WHERE StadiumName='SoFi Stadium'), 2020, NULL),
((SELECT TeamID FROM Team WHERE Tname='49ers'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Levi''s Stadium'), 2014, NULL),
((SELECT TeamID FROM Team WHERE Tname='Seahawks'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Lumen Field'), 2002, NULL),
((SELECT TeamID FROM Team WHERE Tname='Falcons'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Mercedes-Benz Stadium'), 2017, NULL),
((SELECT TeamID FROM Team WHERE Tname='Panthers'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Bank of America Stadium'), 1996, NULL),
((SELECT TeamID FROM Team WHERE Tname='Saints'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Caesars Superdome'), 1975, NULL),
((SELECT TeamID FROM Team WHERE Tname='Buccaneers'), (SELECT StadiumID FROM Stadium WHERE StadiumName='Raymond James Stadium'), 1998, NULL);

SELECT * FROM ConferenceDivision;
SELECT * FROM Team;
SELECT * FROM AppUser;
SELECT * FROM NFLFan;
SELECT * FROM NFLAdmin;
SELECT * FROM FanTeam;
SELECT * FROM Stadium;
SELECT * FROM TeamStadium;