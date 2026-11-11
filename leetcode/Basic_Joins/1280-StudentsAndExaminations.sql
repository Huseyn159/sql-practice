SELECT s.student_id,s.student_name,sb.subject_name,COUNT(e.student_id) as attended_exams
FROM students s
CROSS JOIN subjects sb
LEFT JOIN examinations e ON e.student_id = s.student_id AND e.subject_name = sb.subject_name
GROUP BY s.student_id,s.student_name,sb.subject_name
ORDER BY s.student_id,sb.subject_name