SELECT t.id,COUNT(t.id) as num
FROM (
         SELECT requester_id as id
         FROM requestaccepted
         UNION ALL
         SELECT accepter_id
         FROM requestaccepted
     ) as t
GROUP BY t.id
ORDER BY num desc
    LIMIT 1

--Birden cox insanin dost sayi en cox olarsa


SELECT t.id,COUNT(t.id) as num
FROM (
         SELECT requester_id as id
         FROM requestaccepted
         UNION ALL
         SELECT accepter_id
         FROM requestaccepted
     ) as t
GROUP BY t.id
HAVING COUNT(t.id) = (
    SELECT MAX(num)
    FROM(
            SELECT t.id,COUNT(t.id) as num
            FROM (
                     SELECT requester_id as id
                     FROM requestaccepted
                     UNION ALL
                     SELECT accepter_id
                     FROM requestaccepted
                 ) as t
            GROUP BY t.id
        ) as c
)
