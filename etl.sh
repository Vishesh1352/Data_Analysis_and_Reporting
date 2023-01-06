#!/bin/bash
set -a; source .env; set +a
mysql --defaults-extra-file=config.cnf --local-infile=1 $DATABASE << 'EOF'

LOAD DATA LOCAL INFILE 'Movie_data.csv'
IGNORE INTO TABLE `movie_info`
CHARACTER SET ascii
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(movie_name,movie_genre,movie_length,@release_date)
SET release_date = STR_TO_DATE(@release_date, '%d-%c-%Y');

LOAD DATA LOCAL INFILE 'Movie_data.csv'
IGNORE INTO TABLE `movie_finance`
CHARACTER SET ascii
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@a,@b,@c,@mid,`dist_compney`,`prod_compney`,`prod_prize`,`movie_collect`)
SET `mid` = (SELECT `mid` From `movie_info` WHERE `movie_name` = @a);

LOAD DATA LOCAL INFILE 'Movie_data.csv'
IGNORE INTO TABLE `movie_stars`
CHARACTER SET ascii
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@a,@b,@c,@d,@e,@f,@g,@mid,`male_lead`,`female_lead`,`director`)
SET `mid` = (SELECT `mid` FROM `movie_info` WHERE `movie_name` = @a);

LOAD DATA LOCAL INFILE 'Movie_data.csv'
IGNORE INTO TABLE `movie_react`
CHARACTER SET ascii
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@a,@b,@c,@d,@f,@g,@h,@i,@j,@k,@mid,`rating`,`review`)
SET `mid` = (SELECT `mid` FROM `movie_info` WHERE `movie_name` = @a);

EOF
echo "The values are stored in the databse."