SELECT MAX(num) as num
FROM mynumbers
WHERE (num,1) IN (SELECT num,COUNT(num)
                  FROM mynumbers
                  GROUP BY num)
