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