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


CREATE TRIGGER movies_insert
AFTER INSERT ON movies
FOR EACH ROW
	EXECUTE FUNCTION certificate_upper();