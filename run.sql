-- =======[FUNCTION]=======

-- function to find all the films with IMDB or Meta score higher, than given

DROP FUNCTION IF EXISTS films_over_specified_score(int);

CREATE OR REPLACE FUNCTION films_over_specified_score(min_score int)
    RETURNS TABLE (film_title varchar, imdb_score int, meta_score int)
    LANGUAGE 'plpgsql'
AS $$
BEGIN
    RETURN QUERY
        SELECT movies.Series_title::varchar, movies.IMDB_Rating::int, movies.Meta_Score::int
		FROM movies
		WHERE movies.IMDB_Rating > min_score OR movies.Meta_Score > min_score;
END;
$$;

SELECT * FROM films_over_specified_score(99);

-- =======[PROCEDURE]=======

-- Procedure to show all the director name of the specified film

DROP PROCEDURE IF EXISTS get_movie_director(varchar);

CREATE OR REPLACE PROCEDURE get_movie_director(mov_name varchar)
LANGUAGE 'plpgsql'
AS $$
DECLARE movie_title movies.Series_title%TYPE;
DECLARE director_name Director.Director_name%TYPE;


BEGIN
    SELECT
		movies.Series_title, Director.Director_name
		INTO movie_title, director_name
		FROM Director
		JOIN movies
		ON movies.Director_ID = Director.Director_ID
		WHERE TRIM(movies.Series_title) = TRIM(mov_name);
	RAISE INFO 'Title: %, Director: %', TRIM(movie_title), TRIM(director_name);
END;
$$;

CALL get_movie_director('The Shawshank Redemption');

-- =======[TRIGGER]=======

-- trigger to write all new certifications in upper case

CREATE OR REPLACE FUNCTION certificate_upper() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS
$$
     BEGIN
	 	UPDATE movies
		SET Certificate = UPPER(NEW.Certificate)
		WHERE movies.Movie_ID = NEW.Movie_ID;
		RETURN NULL;
	END;
$$;

-- uncomment this if trigger was NOT created before, expect errors otherwise
-- CREATE TRIGGER movies_insert
-- AFTER INSERT ON movies
-- FOR EACH ROW
-- 	EXECUTE FUNCTION certificate_upper();

INSERT INTO Movies (movie_id, director_id, series_title, release_yea, certificate, runtime, imdb_rating, meta_score)
	VALUES('10', '5','Fight Club 2','2024','fkids','150min', '99','100');

SELECT * FROM Movies
	WHERE movie_id = 10;