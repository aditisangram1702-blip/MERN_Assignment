use sunbeam_learning;

INSERT INTO users (email, password, role) VALUES
('admin@sunbeam.com', 'admin123', 'admin'),
('john.doe@sunbeam.com', 'john123', 'instructor'),
('jane.smith@sunbeam.com', 'jane123', 'instructor'),
('alice.w@sunbeam.com', 'alice123', 'student'),
('bob.m@sunbeam.com', 'bob123', 'student');

INSERT INTO courses (course_name, description, fees, start_date, end_date, video_expire_days) VALUES
('Python Basics', 'Learn Python from scratch', 5000, '2025-12-10', '2026-01-10', 30),
('Web Development', 'HTML, CSS, JS & React', 7000, '2025-12-10', '2026-01-10', 30),
('Data Science', 'Python, Pandas, ML', 10000, '2025-12-10', '2026-01-10', 30),
('Java Programming', 'Core Java & OOP concepts', 6000, '2025-12-10', '2026-01-10', 30),
('SQL & Databases', 'MySQL, SQL Workbench, Queries', 4000, '2025-12-10', '2026-01-10', 30);


INSERT INTO users (email, password, role) VALUES
('shradha.j@sunbeam.com', 'shradha123', 'student'),
('rohit.n@sunbeam.com', 'rohit123', 'student'),
('priya.p@sunbeam.com', 'priya123', 'student');

INSERT INTO students (name, email, course_id, mobile_no, profile_pic) VALUES
('Aditi Mane', 'aditi@sunbeam.com', 1, 9876543210, NULL),
('Kedar Malkar ', 'kedar@sunbeam.com', 2, 9123456780, NULL),
('Shradha Jadhav', 'shradha.j@sunbeam.com', 3, 9988776655, NULL),
('Rohit Nalawade', 'rohit.n@sunbeam.com', 1, 9871122334, NULL),
('Priya Patil', 'priya.p@sunbeam.com', 4, 9765432109, NULL);

INSERT INTO videos (course_id, title, description, youtube_url, added_at) VALUES
(1, 'Python Introduction', 'Overview of Python', 'https://youtu.be/python_intro', '2025-01-11'),
(1, 'Python Variables', 'Understanding variables', 'https://youtu.be/python_variables', '2025-01-12'),
(2, 'HTML Basics', 'Learn HTML structure', 'https://youtu.be/html_basics', '2025-02-02'),
(2, 'CSS Styling', 'Styling web pages', 'https://youtu.be/css_styling', '2025-02-05'),
(3, 'Data Analysis with Pandas', 'Using Pandas for data analysis', 'https://youtu.be/pandas_analysis', '2025-03-02');


INSERT INTO courses (course_name, description, fees, start_date, end_date, video_expire_days) VALUES
('Angular', 'Complete Angular Guide', 6000, '2025-12-22', '2026-01-22', 30),
('DevOps', 'Master in DevOps', 7000, '2025-12-28', '2026-01-28', 30);


--  q.1 sql query that will fetch upcoming couses

SELECT *
FROM courses
WHERE start_date > CURDATE();


-- q.2 sql query that will fetch all register students  along with course name


SELECT 
    s.reg_no,
    s.name AS student_name,
    s.email,
    s.mobile_no,
    s.course_id,
    c.course_name
FROM students s
JOIN courses c 
    ON s.course_id = c.course_id;


-- q.3 SQL query to fetch the complete details of a student (based on their email) along with the details
-- of the course they are enrolled in. having col  regno, name, email,mobile no, couse-id, couse_name, description,fess, start_date, end_date,video_exp_date

SELECT 
    s.reg_no,
    s.name AS student_name,
    s.email,
    s.mobile_no,
    c.course_id,
    c.course_name,
    c.description,
    c.fees,
    c.start_date,
    c.end_date,
    c.video_expire_days
FROM students s
JOIN courses c 
    ON s.course_id = c.course_id
WHERE s.email = 'aditi@sunbeam.com';  


-- SQL query to retrieve the course details and the list of non-expired videos for a specific student
-- using their email address. A video is considered active (not expired) if its added_at date plus the course’s
-- video_expire_days has not yet passed compared to the current date


SELECT 
    s.name AS student_name,
    s.email AS student_email,
    c.course_id,
    c.course_name,
    c.description,
    c.fees,
    c.start_date,
    c.end_date,
    c.video_expire_days,

    v.video_id,
    v.title AS video_title,
    v.description AS video_description,
    v.youtube_url,
    v.added_at

FROM students s
JOIN courses c 
    ON s.course_id = c.course_id
JOIN videos v
    ON c.course_id = v.course_id

-- Only active (non-expired) videos:
WHERE s.email = 'aditi@sunbeam.com'   -- change email here
  AND DATE_ADD(v.added_at, INTERVAL c.video_expire_days DAY) >= CURDATE()

ORDER BY v.added_at ASC;

