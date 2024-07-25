SELECT 
CASE WHEN id%10=0 THEN NULL ELSE id END AS id, 
CASE WHEN id%10=0 THEN NULL ELSE (random() * 10000)::int END AS randint, 
CASE WHEN id%10=0 THEN NULL ELSE CASE WHEN random()>0.5 THEN md5(random()::text) ELSE regexp_replace(md5(random()::text), '[0-9]+', '', 'g') END END AS randtext, 
CASE WHEN id%10=0 THEN NULL ELSE ('2012-01-01'::timestamp + (random() * 366 * 10)::int * INTERVAL '1 day' + (random() * 100000) * INTERVAL '1 second')::timestamp(0) END AS randdatetime 
FROM generate_series(0,80000000) AS id;

INSERT INTO gen_data SELECT * FROM gen_data LIMIT 20000000;

COPY gen_data TO 'A:\PostgreSQL15\data\randdata.csv' DELIMITER ',' CSV HEADER NULL AS 'null';