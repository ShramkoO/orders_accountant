CREATE OR REPLACE FUNCTION update_product_column(ids int[], column_name text, increment_values int[])
RETURNS VOID AS
$func$
DECLARE
    i int;
    row_id int;
BEGIN
    FOR i IN 1..array_length(ids, 1) LOOP
        row_id := ids[i];
        EXECUTE format('UPDATE products SET %I = %I + $1 WHERE id = $2', column_name, column_name)
        USING increment_values[i], row_id;
    END LOOP;
    RETURN;
END;
$func$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_product_column(ids int[], column_name text, increment_values int[])
RETURNS VOID AS
$func$
DECLARE
    i int;
    row_id int;
BEGIN
    FOR i IN 1..array_length(ids, 1) LOOP
        row_id := ids[i];
        EXECUTE format('UPDATE products SET %I = %I + $1 WHERE id = $2', column_name, column_name)
        USING increment_values[i], row_id;
    END LOOP;
    RETURN;
END;
$func$ LANGUAGE plpgsql;

