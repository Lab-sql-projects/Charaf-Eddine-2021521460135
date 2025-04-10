-- Drop existing tables if they exist
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS dorms;

-- Create dorms table
CREATE TABLE dorms (
    dorm_id INT PRIMARY KEY,
    dorm_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 16),
    dorm_id INT,
    FOREIGN KEY (dorm_id) REFERENCES dorms(dorm_id)
);

-- Insert into dorms (escaped apostrophe)
INSERT INTO dorms (dorm_id, dorm_name) VALUES
(1, 'Jiang''an Campus'),
(2, 'Wangjiang Campus'),
(3, 'Hua Xi Campus');

-- Insert into students
INSERT INTO students (student_id, name, age, dorm_id) VALUES
(1, 'Li Wei', 20, 1),
(2, 'Zhang Min', 22, 2),
(3, 'Wang Yu', 19, 3),
(4, 'Chen Hao', 21, 1),
(5, 'Sun Mei', 18, 2);

-- Create index
CREATE INDEX idx_students_dorm_id ON students(dorm_id);

-- Simulated transaction: insert and update without using START TRANSACTION
-- In real MySQL, you'd wrap these in START TRANSACTION / COMMIT
INSERT INTO dorms (dorm_id, dorm_name) VALUES (4, 'New Campus');
INSERT INTO students (student_id, name, age, dorm_id)
VALUES (6, 'Alice Zhang', 20, 4);
UPDATE students SET name = 'Alice Z.' WHERE student_id = 6;

-- Invalid insert to simulate rollback (will fail and stop here if CHECK is enforced)
-- Commented to keep script working
-- INSERT INTO students (student_id, name, age, dorm_id)
-- VALUES (7, 'Test User', 10, 1);

-- Complex query: JOIN + subquery + WHERE
SELECT s.name AS student_name, d.dorm_name
FROM students s
JOIN dorms d ON s.dorm_id = d.dorm_id
WHERE s.age > (
    SELECT AVG(age) FROM students
);

-- Show data
SELECT * FROM students;
SELECT * FROM dorms;
