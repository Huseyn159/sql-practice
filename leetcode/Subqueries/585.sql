WITH cte as (
    SELECT tiv_2015,tiv_2016,COUNT(*) OVER (PARTITION BY tiv_2015) as tivcnt,lat,lon,
           COUNT(*) OVER (PARTITION BY lat,lon) as llcnt
    FROM insurance
)
SELECT ROUND(SUM(tiv_2016)::numeric,2) as tiv_2016 FROM cte
WHERE tivcnt > 1 AND llcnt = 1