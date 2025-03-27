
INSERT INTO authors (author_id, name, nationality) VALUES
(1, 'J.K. Rowling', 'British'),
(2, 'George Orwell', 'British'),
(3, 'Haruki Murakami', 'Japanese');


INSERT INTO books (book_id, title, author_id, isbn) VALUES
(101, 'Harry Potter', 1, '978-0747532743'),
(102, '1984', 2, '978-0451524935'),
(103, 'Norwegian Wood', 3, '978-0375704024');


INSERT INTO members (member_id, name, email) VALUES
(201, 'Alice Johnson', 'alice@example.com'),
(202, 'Bob Smith', 'bob@example.com'),
(203, 'Charlie Brown', 'charlie@example.com');


INSERT INTO loans (loan_id, book_id, member_id, loan_date, due_date) VALUES
(301, 101, 201, '2023-10-01', '2023-10-15'),
(302, 102, 202, '2023-10-02', '2023-10-16'),
(303, 103, 203, '2023-10-03', '2023-10-17');
