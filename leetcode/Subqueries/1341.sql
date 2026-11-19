
SELECT a.name as results
FROM(
        SELECT u.name,COUNT(mr.user_id) as rate_count
        FROM users u
                 JOIN movierating mr ON mr.user_id = u.user_id
        GROUP BY u.name
        ORDER BY rate_count desc,u.name asc
            LIMIT 1 ) as a
UNION ALL
SELECT b.title
FROM(
        SELECT m.title,AVG(mr.rating)
        FROM movies m
                 JOIN movierating mr ON mr.movie_id = m.movie_id
        WHERE created_at >= '2020-02-01' AND created_at <'2020-03-01'
        GROUP BY m.title
        ORDER BY avg desc,m.title asc
            LIMIT 1
    ) as b

