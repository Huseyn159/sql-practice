
SELECT CASE WHEN id%2 = 0 THEN id-1
            WHEN id%2 != 0 and id + 1 IN (SELECT id
                                  FROM seat) THEN id + 1
            ELSE id END as id,student
FROM seat
ORDER BY id asc

