
insert into ConferenceDivision
VALUES
('AFC','North'),
('AFC','East'),
('AFC','South'),
('AFC','West'),
('NFC','North'),
('NFC','East'),
('NFC','South'),
('NFC','West');



insert into Team
values
('Ravens','Baltimore, MD','Purple, Black, Metallic Gold','Logo',1),
('Bengals','Cincinnati, OH','Black, Orange, White','Logo',1),
('Browns','Cleveland, OH','Brown, Orange, White','Logo',1),
('Steelers','Pittsburgh, PA','Black, Gold, White','Logo',1),

('Bills','Buffalo, NY','Royal Blue, Red, White','Logo',2),
('Dolphins','Miami, FL','Aqua, Orange, White','Logo',2),
('Patriots','New England, MA','Navy Blue, Red, Silver','Logo',2),
('Jets','New York, NY','Green, White, Black','Logo',2),

('Texans','Houston, TX','Deep Steel Blue, Battle Red, Liberty White','Logo',3),
('Colts','Indianapolis, IN','Speed Blue, White','Logo',3),
('Jaguars','Jacksonville, FL','Teal, Black, Gold, White','Logo',3),
('Titans','Tennessee, TN','Navy Blue, Titans Blue, Red, White','Logo',3),

('Broncos','Denver, CO','Orange, Navy Blue, White','Logo',4),
('Chiefs','Kansas City, MO','Red, Gold, White','Logo',4),
('Raiders','Las Vegas, NV','Silver, Black','Logo',4),
('Chargers','Los Angeles, CA','Powder Blue, Gold, White','Logo',4),

('Bears','Chicago, IL','Navy Blue, Orange, White','Logo',5),
('Lions','Detroit, MI','Honolulu Blue, Silver, White','Logo',5),
('Packers','Green Bay, WI','Green, Gold, White','Logo',5),
('Vikings','Minnesota, MN','Purple, Gold, White','Logo',5),

('Cowboys','Dallas, TX','Navy Blue, Silver, White','Logo',6),
('Giants','New York, NY','Royal Blue, Red, White','Logo',6),
('Redskins','Washington, DC','Burgundy, Gold, White','Logo',6),
('Eagles','Philadelphia, PA','Midnight Green, Silver, Black, White','Logo',6),

('Cardinals','Arizona, AZ','Cardinal Red, Black, White','Logo',7),
('Rams','Los Angeles, CA','Royal Blue, Yellow, White','Logo',7),
('49ers','San Francisco, CA','Scarlet Red, Gold, White','Logo',7),
('Seahawks','Seattle, WA','College Navy Blue, Action Green, Wolf Grey','Logo',7),

('Falcons','Atlanta, GA','Red, Black, Silver, White','Logo',8),
('Panthers','Carolina, NC','Black, Panther Blue, Silver, White','Logo',8),
('Saints','New Orleans, LA','Old Gold, Black, White','Logo',8),
('Buccaneers','Tampa Bay, FL','Red Pepper Red, Pewter Gray, Orange Red Accent and White Accent Colors ','Logo',8);

-- second phase inserting

-- AppUser insertion

insert into AppUser (Firstname, Lastname, Email, Phone, PasswordHash, UserRole)
VALUES
('Tom', 'Brady', 'tom.brady@example.com', '555-1234', 0x01, N'NFLFan'),
('Aaron', 'Rodgers', 'aaron.rodgers@example.com', '555-9012', 0x01, N'NFLFan'),
('Drew', 'Brees', 'drew.brees@example.com', '555-2222', 0x01, N'NFLFan'),
('Patrick', 'Mahomes', 'patrick.mahomes@example.com', '555-7890', 0x01, N'NFLFan'),
('Bill', 'Belichick', 'bill.belichick@example.com', '555-5678', 0x01, N'NFLAdmin'),
('Sean', 'McVay', 'sean.mcay@example.com', '555-3456', 0x01, N'NFLAdmin'),
('Mike', 'Tomlin', 'mike.tomlin@example.com', '555-1111', 0x01, N'NFLAdmin'),
('Andy', 'Reid', 'andy.reid@example.com', '555-3333', 0x01, N'NFLAdmin');

-- NFLFan insertion

GO
insert into NFLFan (NFLFanID)
VALUES
(1),
(2),
(3),
(4);

-- NFLAdmin insertion

GO
insert into NFLAdmin (NFLAdminID)
VALUES
(5),
(6),
(7),
(8);

-- FanTeam insertion

GO

insert into FanTeam (NFLFanID, TeamID, PrimaryTeam)
VALUES
(1, 11, 1),
(1, 24, 0), -- Tom Brady is a fan of New England Patriots and Tampa Bay Buccaneers, but Patriots is his primary team
(2, 19, 1),
(2, 12, 0),
(2, 4, 0),-- Aaron Rodgers is a fan of Green Bay Packers, New York Jets, and Pittsburgh Steelers, but Packers is his primary team
(3, 3, 1), -- Drew Brees is a fan New Orleans Saints (primary) and Los Angeles Chargers
(3, 16, 0),
(4, 14, 1); -- Patrick Mahomes is a fan of Kansas City Chiefs (primary)

-- Insert Test Data

select * from FanTeam;
select * from NFLFan;
select * from NFLAdmin;
select * from AppUser;