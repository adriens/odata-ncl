sqlite3 shark-attacks-ncl.sqlite

DROP TABLE IF EXISTS CONSERVATION_STATUS;
CREATE TABLE CONSERVATION_STATUS (
    id VARCHAR(2) PRIMARY KEY,
    id_long VARCHAR(25),
    cat VARCHAR(20),
    desc VARCHAR(100)
);

.mode csv
.import --skip 1 conservation_status.csv CONSERVATION_STATUS
.mode markdown
select * from CONSERVATION_STATUS;

DROP TABLE IF EXISTS LUNAR_PHASIS;
CREATE TABLE LUNAR_PHASIS(
    id VARCHAR2(15) PRIMARY KEY,
    phase VARCHAR2(15),
    www_phase VARCHAR2(50),
    illuminated_portion_northern VARCHAR2(60),
    illuminated_portion_south  VARCHAR2(60),
    visibility VARCHAR2(60),
    average_moonrise_time  VARCHAR2(5),
    culmination  VARCHAR2(5),
    average_moonset_time  VARCHAR2(5),
    www_illustration_north_png  VARCHAR2(100),
    www_illustration_south_png VARCHAR2(100),
    www_photo_jpg VARCHAR2(100)
);

.mode csv
.import --skip 1 lunar_phases.csv LUNAR_PHASIS
.mode markdown
select id, phase from LUNAR_PHASIS;

DROP TABLE IF EXISTS SHARKS;
CREATE TABLE SHARKS(
    id VARCHAR(20) PRIMARY KEY,
    description VARCHAR(23),
    scientific_name VARCHAR(26),
    conservation_status VARCHAR(2),
    FOREIGN KEY (conservation_status) REFERENCES CONSERVATION_STATUS(id)
);

.mode csv
.import --skip 1 sharks.csv sharks
.mode markdown
select * from sharks;



DROP TABLE IF EXISTS SHARK_ATTACKS_NCL;
create table SHARK_ATTACKS_NCL (
    case_number VARCHAR(12) PRIMARY KEY,
    date TEXT,
    moon_phase_rate INTEGER,
    moon_phase VARCHAR(15),
    year_month VARCHAR(7),
    year INTEGER,
    month INTEGER,
    dow VARCHAR(9),
    season VARCHAR(6),
    type VARCHAR(10),
    country VARCHAR(13),
    comune_nom VARCHAR(11),
    coast VARCHAR(4),
    location VARCHAR(30),
    details_plage VARCHAR(50),
    code_cog INTEGER,
    province VARCHAR(4),
    geo_point VARCHAR(30),
    activity VARCHAR(13),
    name VARCHAR(25),
    sex VARCHAR(1),
    age INTEGER,
    injury VARCHAR(15),
    is_fatal VARCHAR(1),
    time VARCHAR(5),
    day_part VARCHAR(3),
    species VARCHAR(11),
    skark_size_centimeters INTEGER,
    source VARCHAR(100),
    www_sharkattack_file VARCHAR(100),
    www_nc1 VARCHAR(100),
    sharkattack_id VARCHAR(12),
    FOREIGN KEY (moon_phase) REFERENCES LUNAR_PHASIS(id)
);

.mode csv
.import --skip 1 shark-attacks-ncl.csv SHARK_ATTACKS_NCL
.mode markdown
select 
    year as "Year",
    count(*) as nb_attacks
from shark_attacks_ncl
group by year
order by year desc limit 10;