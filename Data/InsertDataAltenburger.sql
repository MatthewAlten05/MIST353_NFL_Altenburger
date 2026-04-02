

INSERT INTO ConferenceDivision (Conference, Division)
SELECT * FROM (VALUES
    ('AFC', 'North'),
    ('AFC', 'South'),
    ('AFC', 'East'),
    ('AFC', 'West'),
    ('NFC', 'East'),
    ('NFC', 'North'),
    ('NFC', 'South'),
    ('NFC', 'West')
) AS src(Conference, Division)
WHERE NOT EXISTS (
    SELECT 1 FROM ConferenceDivision cd
    WHERE cd.Conference = src.Conference
    AND cd.Division = src.Division
);
GO

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT * FROM (VALUES
    ('Baltimore Ravens', 'Baltimore, MD', 'Purple', 1),
    ('Cincinnati Bengals', 'Cincinnati, OH', 'Orange', 1),
    ('Cleveland Browns', 'Cleveland, OH', 'Brown,White', 1),
    ('Pittsburgh Steelers', 'Pittsburgh, PA', 'Black, Gold', 1),

    ('Houston Texans', 'Houston, TX', 'Deep Steel Blue, Battle Red, Liberty White', 2),
    ('Indianapolis Colts', 'Indianapolis, IN', 'Royal Blue, White', 2),
    ('Jacksonville Jaguars', 'Jacksonville, FL', 'Teal, Black, Gold', 2),
    ('Tennessee Titans', 'Nashville, TN', 'Navy, Light Blue, Red, Silver', 2),

    ('Buffalo Bills', 'Buffalo, NY', 'Royal Blue, Red, White', 3),
    ('Miami Dolphins', 'Miami, FL', 'Aqua, Orange, White', 3),
    ('New England Patriots', 'Foxborough, MA', 'Navy Blue, Red, Silver', 3),
    ('New York Jets', 'East Rutherford, NJ', 'Gotham Green, Spotlight White, Stealth Black', 3),

    ('Denver Broncos', 'Denver, CO', 'Orange, Navy Blue, White', 4),
    ('Kansas City Chiefs', 'Kansas City, MO', 'Red, Gold, White', 4),
    ('Las Vegas Raiders', 'Las Vegas, NV', 'Silver, Black', 4),
    ('Los Angeles Chargers', 'Los Angeles, CA', 'Powder Blue, Sunshine Gold, White', 4),

    ('Dallas Cowboys', 'Arlington, TX', 'Navy Blue, Metallic Silver, White', 5),
    ('New York Giants', 'East Rutherford, NJ', 'Royal Blue, Red, White', 5),
    ('Philadelphia Eagles', 'Philadelphia, PA', 'Midnight Green, Silver, Black, White', 5),
    ('Washington Commanders', 'Landover, MD', 'Burgundy and Gold', 5),

    ('Chicago Bears', 'Chicago, IL', 'Navy Blue, Orange, White', 6),
    ('Detroit Lions', 'Detroit, MI', 'Honolulu Blue, Silver, White', 6),
    ('Green Bay Packers', 'Green Bay, WI', 'Dark Green, Gold, White', 6),
    ('Minnesota Vikings', 'Minneapolis, MN', 'Purple, Gold, White', 6),

    ('Atlanta Falcons', 'Atlanta, GA', 'Red, Black, White', 7),
    ('Carolina Panthers', 'Charlotte, NC', 'Black, Panther Blue, Silver, White', 7),
    ('New Orleans Saints', 'New Orleans, LA', 'Old Gold and Black', 7),
    ('Tampa Bay Buccaneers', 'Tampa Bay Area, FL', 'Red, Pewter and Black', 7),

    ('Arizona Cardinals', 'Phoenix, AZ', 'Cardinal Red and White', 8),
    ('Los Angeles Rams', 'Los Angeles, CA', 'Royal Blue and Solor Gold', 8),
    ('San Francisco 49ers', 'San Francisco, CA', 'Scarlet Red and Gold', 8),
    ('Seattle Seahawks', 'Seattle, WA', 'College Navy, Action Green, Wolf Grey', 8)
) AS src(TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
WHERE NOT EXISTS (
    SELECT 1 FROM Team t
    WHERE t.TeamName = src.TeamName
);
GO

