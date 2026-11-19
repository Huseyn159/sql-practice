SELECT user_id,name,mail
FROM users
WHERE  mail ~ '^[A-Za-z][A-Za-z0-9._-]*@leetcode\.com$'