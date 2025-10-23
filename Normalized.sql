CREATE TABLE Students (
StudentID INTEGER PRIMARY KEY,
StudentName VARCHAR2(30),
Major VARCHAR2(30)
);

CREATE TABLE Courses (
CourseID INTEGER PRIMARY KEY,
CourseName VARCHAR2(30),
Credits INTEGER
);

CREATE TABLE Enrollments (
StudentID INTEGER, CourseID
INTEGER, EnrollmentDate
DATE,
PRIMARY KEY (StudentID, CourseID),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Instructors (
InstructorID INTEGER PRIMARY KEY,
InstructorName VARCHAR2(30),
Phone INTEGER
);

CREATE TABLE Course_Instructors ( CourseID
INTEGER,
InstructorID INTEGER,
PRIMARY KEY (CourseID, InstructorID),
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

INSERT INTO Students VALUES (1, 'Alice Smith', 'Computer Science'); INSERT INTO Students VALUES (2, 'Bob Johnson', 'Mathematics');
INSERT INTO Students VALUES (3, 'Charlie Brown', 'Physics');
Query:
INSERT INTO Courses VALUES (101, 'Introduction to Programming', 3);
INSERT INTO Courses VALUES (102, 'Calculus I', 4);
INSERT INTO Courses VALUES (103, 'Classical Mechanics', 3);
Query:
INSERT INTO Enrollments VALUES (1, 101, '01 SEP 24');
INSERT INTO Enrollments VALUES (1, 102, '01 SEP 24');
INSERT INTO Enrollments VALUES (2, 102, '01 SEP 24'); INSERT INTO Enrollments VALUES (3, 103, '01 SEP 24'); Query:
INSERT INTO Instructors VALUES (1001, 'Dr. Emily White', 7225148456);
INSERT INTO Instructors VALUES (1002, 'Prof. David Green', 9822663346);
Query:
INSERT INTO Course_Instructors VALUES (101, 1001);
INSERT INTO Course_Instructors VALUES (102, 1002);
INSERT INTO Course_Instructors VALUES (103, 1002);

Retrieve all students and their majors
select StudentName,Major from Students;

List all courses along with the number of credits.
select CourseName, Credits from Courses;

Find all students enrolled in a specific course (e.g., 'Introduction to Programming').
SELECT s.* FROM students s
JOIN enrollments e ON s.studentID = e.studentID
JOIN courses c ON e.courseID = c.courseID
WHERE c.coursename = 'Introduction to Programming';

Get the list of instructors teaching a specific course(e.g., 'Introduction to Programming')
SELECT i.* FROM Instructors i, Course_Instructors ci, Courses c
WHERE i.InstructorID = ci.InstructorID
AND ci.CourseID = c.CourseID
AND c.CourseName = 'Introduction to Programming';

Count the number of students enrolled in each course.
SELECT c.CourseName, COUNT(e.StudentID) FROM
Courses c, Enrollments e
WHERE c.CourseID = e.CourseID
GROUP BY c.CourseName;

List courses along with their instructor names
SELECT c.CourseName, i.Instructorname
FROM Courses c, Course_Instructors ci, Instructors i WHERE c.CourseID = ci.CourseID
AND ci.InstructorID = i.InstructorID;

Get the number of courses taught by each instructor
SELECT i.Instructorname, COUNT(ci.CourseID) AS NumberOfCourses FROM
Instructors i, Course_Instructors ci
WHERE i.InstructorID = ci.InstructorID GROUP BY i.Instructorname;

Find students enrolled after a certain date (e.g., '2024 01 01')
SELECT s.StudentName, e.EnrollmentDate
FROM Students s, Enrollments e
WHERE s.StudentID = e.StudentID
AND e.EnrollmentDate > TO_DATE('2024 01 01','YYYY MM DD');
Show each student with the total number of credits they are taking


SELECT s.StudentName, SUM(c.credits) AS TotalCredits FROM
Students s, Enrollments e, Courses c
WHERE s.StudentID = e.StudentID
AND e.CourseID = c.CourseID
GROUP BY s.StudentName;
Show courses

Show courses that have more than 3 credits.
SELECT c.CourseName, c.credits FROM Courses c WHERE
c.credits > 3;



