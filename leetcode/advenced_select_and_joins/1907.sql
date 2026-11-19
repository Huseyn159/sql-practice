SELECT 'Low Salary' as category,COUNT(CASE WHEN income < 20000 THEN 1
    END) as accounts_count FROM accounts
UNION SELECT 'Average Salary',COUNT(CASE WHEN income >= 20000  AND income <= 50000 THEN 1  END) FROM accounts
UNION SELECT 'High Salary',COUNT(CASE WHEN income > 50000 THEN 1  END) FROM accounts