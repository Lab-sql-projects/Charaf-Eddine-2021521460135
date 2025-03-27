-- View all available books
SELECT b.title, a.name AS author 
FROM books b
JOIN authors a ON b.author_id = a.author_id
WHERE b.available = TRUE;

-- Find overdue books
SELECT m.name AS member, b.title, l.due_date
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN members m ON l.member_id = m.member_id
WHERE l.due_date < CURRENT_DATE;

-- Count books by nationality
SELECT a.nationality, COUNT(*) AS book_count
FROM books b
JOIN authors a ON b.author_id = a.author_id
GROUP BY a.nationality;
