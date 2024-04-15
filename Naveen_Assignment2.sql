--Task-1
--1
create database SISDB
use SISDB
--2
create table students (
StudentId int primary key,
FirstName varchar(20),
LastName varchar(20),
dateofbirth date,
Email varchar(25),
phonenumber BigInt)
create table teachers (teacherid int primary key,firstname varchar(20),lastname varchar(20),email varchar(25))
create table courses (courseid int primary key,courseName varchar(20),credits int ,teacherid int, Foreign key (teacherid) references teachers(teacherid))
create table enrollments (EnrollmentId int primary key,studentid int ,courseid int ,enrollmentdate date,foreign key (studentid) references students(studentid),foreign key (courseid) references courses(courseid))
create table payments (paymentid int primary key,studentid int,amount bigint,paymentDate date,Foreign key (studentid) references students(studentid))
--4&5
insert into students (studentid,firstname,lastname,dateofbirth,email,phonenumber) VALUES
    (1,'Naveen', 'kumar','2003-08-10', 'naveen@gmail.com', '9927465367'),
    (2,'Nathan', 'nate','2002-07-23', 'nathan@gmail.com', '8376453676'),
    (3,'Charlie', 'Brown', '2001-11-11','charlie@gmail.com','6253425345'),
    (4,'David', 'Williams','2004-10-23', 'david@gmail.com', '555223456'),
    (5,'paul', 'raj', '2001-08-12','paul@gmail.com', '55745657465'),
    (6,'Ram', 'charan', '2002-01-10','ram@gmail.com', '874635462'),
    (7,'Jack', 'king', '2003-02-22','jack@gmail.com', '9809876543'),
    (8,'Balu', 'balraj', '2000-05-30','balu@gmail.com', '9987654324'),
    (9,'Santhosh', 'kumar', '1999-03-20','santhish@gmail.com', '87465747756'),
    (10,'Oggy', 'Hernandez', '1995-02-15','oggy@gmail.com', '7364865736');
select *from students
INSERT INTO teachers (teacherid, firstname, lastname, email)
VALUES
(1, 'John', 'Doe', 'john@gmail.com'),
(2, 'Jane', 'Smith', 'jane@gmail.com'),
(3, 'Michael', 'Johnson', 'michael@gmail.com'),
(4, 'Emily', 'Williams', 'emily@gmail.com'),
(5, 'James', 'Brown', 'james@gmail.com'),
(6, 'Sarah', 'Jones', 'sarah@gmail.com'),
(7, 'David', 'Garcia', 'david@gmail.com'),
(8, 'Jessica', 'Martinez', 'jessica@gmail.com'),
(9, 'Robert', 'Robinson', 'robert@gmail.com'),
(10, 'Amanda', 'Lee', 'amanda@gmail.com');
select *from teachers
INSERT INTO courses (courseid, courseName, credits, teacherid) VALUES
    (1, 'Mathematics', 3, 1),
    (2, 'Physics', 4, 2),
    (3, 'Chemistry', 4, 3),
    (4, 'Biology', 3, 4),
    (5, 'English', 3, 5),
    (6, 'History', 3, 6),
    (7, 'Geography', 3, 7),
    (8, 'Computer Science', 4, 8),
    (9, 'Economics', 3, 9),
    (10, 'Art', 2, 10);
select *from courses
INSERT INTO enrollments (EnrollmentId, studentid, courseid, enrollmentdate) VALUES
    (101, 1, 1, '2025-05-01'),
    (102, 2, 2, '2023-04-02'),
    (103, 3, 3, '2024-06-03'),
    (104, 4, 4, '2022-02-04'),
    (105, 5, 5, '2024-10-05'),
    (106, 6, 6, '2024-04-06'),
    (107, 7, 7, '2024-11-07'),
    (108, 8, 8, '2021-06-08'),
    (109, 9, 9, '2024-08-09'),
    (110, 10, 10,'2024-07-10');

SELECT * FROM enrollments;
INSERT INTO payments (paymentid, studentid, amount, paymentDate) VALUES
    (111, 1, 1000, '2024-05-01'),
    (112, 2, 1500, '2024-02-02'),
    (113, 3, 1200, '2024-06-03'),
    (114, 4, 800, '2024-08-04'),
    (115, 5, 2000, '2024-09-05'),
    (116, 6, 1800, '2024-03-06'),
    (117, 7, 900, '2024-04-07'),
    (118, 8, 1300, '2024-10-08'),
    (119, 9, 1100, '2024-11-09'),
    (120, 10, 1400, '2024-12-10');
select *from payments 
--Task-2
--1
insert into students values(11,'john','Doe','1995-08-15','john.doe@example.com',1234567890)
---2
insert into Enrollments values((select max(enrollmentid)+1 from enrollments),1,1,getdate())
--3
update teachers set email='Doe@gmail.com' where teacherid=1

select *from teachers where teacherid=1
--4
delete from enrollments where studentid=1 and courseid=1
--5
update courses set teacherid=(select teacherid from teachers where firstname='john') where coursename='physics'
--6
Alter table payments Add constraint P_Student_Enrollment Foreign key (studentid) references students(studentid) On Delete Cascade
--query
delete from students where studentid=1
alter table enrollments add constraint E_student_Enrollment Foreign key (Studentid) references students(Studentid) on delete cascade

delete from students where studentid=2
select *from students
--7
update payments set amount=20000 where paymentid=112

--Task-3
--1
select concat(firstname,' ',lastname) as Name,p.amount from students,payments p where students.studentid=p.studentid   
--or
select concat(firstname,' ',lastname) as Name,p.amount from students inner join payments p on students.studentid=p.studentid
--2
select coursename,count(e.EnrollmentId) from courses left join enrollments e on courses.courseid=e.courseid group by coursename
--3
select firstname,lastname from students where studentid not in(select distinct studentid from enrollments)
--or
select firstname,count(e.enrollmentid) as no_of_enrollments from students left join enrollments e on students.studentid= e.studentid group by firstname having count(enrollmentid)=0
--4
select  firstname,lastname,coursename from students inner join enrollments on students.studentid=enrollments.studentid inner join courses on courses.courseid=enrollments.courseid
--5
select firstname ,lastname ,coursename from teachers inner join courses on teachers.teacherid=courses.teacherid
--6
select firstname,enrollmentdate  from students inner join enrollments on students.studentid=enrollments.studentid
--or
select firstname,enrollmentdate  from students inner join enrollments on students.studentid=enrollments.studentid inner join courses on courses.courseid=enrollments.courseid
--7
select firstname,lastname ,count(payments.studentid) as payments_done from students left join payments on students.studentid=payments.studentid group by firstname,lastname having count(payments.studentid)=0
--or
select firstname,lastname from students left join payments on students.studentid=payments.studentid where payments.studentid is null
--
insert into  courses values(11,'survival',4,4)

--8
select coursename from courses left join enrollments on courses.courseid=enrollments.courseid where enrollments.courseid is null
--9
select firstname,lastname,count(enrollments.studentid) as noOfEnrollments from students left join enrollments on students.studentid=enrollments.studentid group by firstname,lastname having count(enrollments.studentid)>1
--
INSERT INTO teachers (teacherid, firstname, lastname, email)
VALUES
(11, 'raghu', 'varan', 'john@gmail.com')
--10
--Query for 10th question 
select firstname from teachers left join courses on teachers.teacherid=courses.teacherid where courses.teacherid is null
--Task-4
--1
--using subquery
select courseid,avg(count(studentid)) over() as stud_enrolled_avg from(select courseid,studentid from enrollments ) as subquery group by courseid
--without using subquery
select coursename,e.courseid,avg(count(e.studentid)) over() as average  from courses inner join enrollments e on courses.courseid=e.courseid group by coursename,e.courseid
--2
select firstname,lastname from students where studentid=(select studentid from payments where amount=(select max(amount) from payments));
--or
select concat(firstname,' ',lastname) as Name from students s inner join payments p on s.studentid=p.studentid where p.amount=(select max(amount) from payments )
--3
select *from courses where courseid=(select courseid from(select top 1 courseid,count(courseid) as noOFEnrollments from enrollments group by courseid order by count(courseid) desc) as subquery )
--
begin transaction 
insert into enrollments values (112,10,1,'2023-04-02')
insert into enrollments values (113,10,2,'2023-04-02')
insert into enrollments values (114,10,3,'2023-04-02')
insert into enrollments values (115,10,4,'2023-04-02')
insert into enrollments values (116,10,5,'2023-04-02')
insert into enrollments values (117,10,6,'2023-04-02')
insert into enrollments values (118,10,7,'2023-04-02')
insert into enrollments values (119,10,8,'2023-04-02')
insert into enrollments values (120,10,9,'2023-04-02')
select *from enrollments
rollback;
--4
SELECT C.teacherid,T.firstname+' '+T.lastname "Teacher Name",SUM(amount) "Payment to teacher" 
FROM Payments P INNER JOIN Enrollments E ON E.studentid = P.studentid
INNER JOIN Courses C ON C.courseid = E.courseid
INNER JOIN Teachers T ON T.teacherid = C.teacherid
GROUP BY C.teacherid,T.firstname+' '+T.lastname;
--5
select *from students where studentid=(
select studentid from(
select studentid,count( distinct courseid) as NOOfEnrollments from enrollments group by studentid) as subquery
where noofenrollments=(select count(courseid) from courses ))

--6
select * from teachers where firstname in( select firstname from teachers where teacherid not in (select distinct teacherid from courses))
--7
select firstname,studentid,avg(age) from(select studentid,firstname,datediff(year,dateofbirth,getdate()) as age from students ) as subquery group by firstname,studentid

--8
select *from courses where courseid not in(select distinct courseid from enrollments)

--9
select e.studentid,e.courseid,sum(p.amount) from enrollments e inner join payments p on e.studentid=p.studentid group by e.studentid,e.courseid
--
insert into payments values(121,10,1500,'2024-12-28') 
--10
select * from students where studentid=( select studentid from(select studentid,count(studentid) as noOfPayments from payments group by studentid  )  as subquery where noOfPayments>1)
--or
select *from students where studentid=(select studentid from payments group by studentid having count(studentid)>1)
--or
select studentid, firstname from students where studentid in(select studentid from payments group by studentid having count(studentid)>1)

--11

select s.firstname,s.studentid,sum(p.amount) as totalpayments from students s inner join payments p on s.studentid=p.studentid group by firstname,s.studentid
--12

select coursename,count(studentid) as course_enrollment_count from courses inner join enrollments on courses.courseid=enrollments.courseid group by coursename
--13
SELECT P.studentid,S.firstname ,AVG(amount) "Average Payment" FROM Payments P
JOIN Students S ON S.studentid = P.studentid
GROUP BY P.studentid,S.firstname;
