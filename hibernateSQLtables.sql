SET foreign_key_checks = 0;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS  Instructor;
DROP TABLE IF EXISTS  Student;
DROP TABLE IF EXISTS  Course;
DROP TABLE IF EXISTS  Offering;
DROP TABLE IF EXISTS  Enrollment;
Set foreign_key_checks = 1;
/* --- END TABLE DROPS --- */

create table Person
(
	Name char(20),
	ID char(9) not null,
	Address char(30),
	DOB date,
	primary key(ID)
);
 create table Instructor
(
	InstructorID char(9) not null,
	Rank char(12),
	Salary integer,
	primary key(InstructorID),
    foreign key(InstructorID) references person(ID)
);
create table Student
(
	StudentID char(9) not null,
	Classification char(10),
	GPA double,
	MentorID char(9),
	CreditHours integer,
	primary key(StudentID),
    foreign key(MentorID) references Instructor(InstructorID)
);
create table Course
(
	CourseCode char(6) not null,
	CourseName char(50),
	PreReq char(6),
	primary key (CourseCode, CourseName)
);

create table Offering
(
	CourseCode char(6) not null,
	SectionNo integer not null,
	InstructorID char(9) not null,
	primary key(CourseCode, SectionNo),
    foreign key(InstructorID) references instructor(InstructorID)
);
create table Enrollment
(
	CourseCode char(6) not null,
	SectionNo int not null,
	StudentID char(9) not null references Student,
	Grade char(4) not null,
	primary key(CourseCode, StudentID),
	foreign key(CourseCode, SectionNo) references Offering(CourseCode, SectionNo)
);
LOAD XML LOCAL INFILE '/Users/zac/cs363/UniversityXML/Person.xml' INTO TABLE person ROWS IDENTIFIED BY '<Person>';
LOAD XML LOCAL INFILE '/Users/zac/cs363/UniversityXML/Instructor.xml' INTO TABLE instructor ROWS IDENTIFIED BY '<Instructor>';
LOAD XML LOCAL INFILE '/Users/zac/cs363/UniversityXML/Student.xml' INTO TABLE student ROWS IDENTIFIED BY '<Student>';
LOAD XML LOCAL INFILE '/Users/zac/cs363/UniversityXML/Course.xml' INTO TABLE course ROWS IDENTIFIED BY '<Course>';
LOAD XML LOCAL INFILE '/Users/zac/cs363/UniversityXML/Offering.xml' INTO TABLE offering ROWS IDENTIFIED BY '<Offering>';
LOAD XML LOCAL INFILE '/Users/zac/cs363/UniversityXML/Enrollment.xml' INTO TABLE enrollment ROWS IDENTIFIED BY '<Enrollment>';