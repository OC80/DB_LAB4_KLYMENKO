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