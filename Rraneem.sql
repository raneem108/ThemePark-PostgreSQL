-- tables
-- members table
CREATE TABLE members 
(member_id int generated always as identity primary key, 
first_name varchar(200) not null, 
last_name      varchar(200) not null, 
email          varchar(200) not null unique,
phone          varchar(200) not null,
city           varchar(150),
join_date      date   default current_date,
membership_status varchar(150) not null check (membership_status  in ('active','suspended')));

-- staff table 
CREATE TABLE staff (
staff_id        int   generated always as identity   PRIMARY KEY,
first_name      VARCHAR(50)  NOT NULL,
last_name       VARCHAR(50)  NOT NULL,
email       VARCHAR(100) NOT NULL UNIQUE,         
hire_date       DATE         NOT NULL DEFAULT CURRENT_DATE,   
supervisor_id   INT      REFERENCES staff(staff_id)       
);


-- categories table

CREATE TABLE categories (
category_id       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
category_name     varchar(200)  not null  unique);


-- books table
CREATE TABLE books (
book_id     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
title       varchar(200) not null ,
author_name varchar(200) not null ,
isbn        varchar(150) not null unique,
category_id  int not null REFERENCES categories(category_id),
publication_year  int,
price  numeric(6,2) default 5.50,
copies_available  int check (copies_available >= 0) 
);


-- loans table

CREATE TABLE loans (
loan_id     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
loan_date    date  default current_date ,
due_date     date  not null,
return_date  date ,
member_id  int  not null REFERENCES members(member_id),
book_id    int  not null  REFERENCES books(book_id),
staff_id    int  not null REFERENCES staff(staff_id),
fine_amount numeric(6,2)   default 0 check (fine_amount >=0)
);



-- adding columns and changing constraints 

ALTER TABLE members add column loyalty_points int default 0 ;
ALTER TABLE members alter column phone type varchar(20);

-- insert data
-- insert categories
insert into categories (category_name) values  ('science'); 
insert into categories (category_name) values ('fiction');
insert into categories (category_name) values ('history');
insert into categories (category_name) values ('biography');
insert into categories (category_name) values ('Psychology');
insert into categories (category_name) values('mystery');

-- insert staff
insert into staff( first_name, last_name , email, hire_date,supervisor_id) 
values 
(' Raneem ','Abujabal','rabujabal4@gmail.com','2018-03-01',null),
(' Dalya ','Abujabal','dalyaabujabal4@gmail.com','2020-07-01',null),
(' Eman ','Abujabal','emanabujabal4@gmail.com','2020-09-01',2),
(' Mohammad ','Abujabal','moabujabal4@gmail.com','2024-03-01',3),
(' Ethar ','Abujabal','eabujabal4@gmail.com','2025-10-01',null);

-- insert books 
INSERT INTO books (title, author_name, isbn, category_id, publication_year, price, copies_available) VALUES 
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', '9780099590088', 1, 2014, 12.50, 8), --science
('Brief Answers to the Big Questions', 'Stephen Hawking', '9781473695986', 1, 2018, 9.90, 5),
('The Selfish Gene', 'Richard Dawkins', '9780198788607', 1, 2016, 11.00, 6),
('The Bride of Amman', 'Fadi Zaghmout', '9789881219893', 2, 2012, 8.00, 12), -- fiction
('Yellowface', 'R.F. Kuang', '9780008631086', 2, 2023, 11.00, 15),
('The Alchemist', 'Paulo Coelho', '9780062315007', 2, 1993, 7.50, 22),
('The Middle East: A Brief History of the Last 2000 Years', 'Bernard Lewis', '9780140260427', 3, 1995, 13.50, 4), -- history
('A History of Jordan', 'Philip Robins', '9780521598958', 3, 2004, 15.00, 3),
('SPQR: A History of Ancient Rome', 'Mary Beard', '9781631492228', 3, 2015, 14.50, 5),
('Married to a Bedouin', 'Marguerite van Geldermalsen', '9781844082209', 4, 2006, 11.50, 20),-- biography
('Leap of Faith: Memoirs of an Unexpected Life', 'Queen Noor', '9780786867172', 4, 2003, 12.00, 6),
('Steve Jobs', 'Walter Isaacson', '9781451648539', 4, 2011, 13.00, 9),
('12 Rules for Life: An Antidote to Chaos', 'Jordan B. Peterson', '9780345816023', 5, 2018, 14.00, 9), -- psychology
('Thinking, Fast and Slow', 'Daniel Kahneman', '9780374275631', 5, 2011, 13.00, 7),
('Atomic Habits', 'James Clear', '9780735211292', 5, 2018, 12.00, 18);

-- insert members

INSERT INTO members (first_name, last_name, email, phone, city, join_date, membership_status) VALUES
('Ali',  'Al-Zubi',   'aAl-Zubi@gmail.com',   '0783467902', 'Irbid', '2023-01-05', 'active'),     
('Maria',  'Al-Khatib',    'marAl-Khatib@gmail.com',    '0799564478', 'Irbid', '2023-06-12', 'active'),
('Ahmad',    'Bdour',     'aBdour.@gmailcom',       '0775364589', 'Irbid',  '2023-09-01', 'active'),     
('Noor',   'Al-Momani',     'noor23.osei@gmail.com',      '0774567392', 'Ajloun', '2024-02-10', 'suspended'),  
('Samer',    'Obeidat',    'samerqudah.patel@gmail.com',      '0788630043', 'Irbid',  '2024-05-20', 'active'),     
('Yamen',  'Al-Qudah ',      'yamen@gmail.com',      '0775683459', 'Ajloun',   '2024-12-01', 'active'),     
('Muna',    'Al-Majali ',  'muna@gmail.com',    '0758342985', 'Al-karak', '2025-01-15', 'active'),     
('Adam',    'Al-Masri',     'adamben@gmail.com',       '0788667739', 'Irbid',   '2025-03-20', 'suspended'),  
('khawla', 'Al-Fayez',    'khawla243@gmail.com',   '0776549809', 'Amman',  '2025-04-01', 'active'),     
('Hashim',   'Abujabal',    'hashimabu@gmail.com',     '0796674569', 'Irbid', '2025-05-10', 'active');   

-- insert loans

INSERT INTO loans (member_id, book_id, staff_id, loan_date, due_date, return_date, fine_amount) VALUES
(1,  1,  1, '2026-01-05', '2026-01-19', '2026-01-18', 0),      
(2,  2,  2, '2026-01-10', '2026-01-24', '2026-02-05', 12.00),  
(3,  3,  3, '2026-02-01', '2026-02-15', NULL,          0),      
(4,  4,  1, '2026-02-03', '2026-02-17', '2026-02-25', 8.00),   
(5,  5,  2, '2026-02-10', '2026-02-24', NULL,          0),      
(6,  6,  3, '2026-02-12', '2026-02-26', '2026-02-24', 0),      
(7,  7,  4, '2026-03-01', '2026-03-15', NULL,          0),      
(8,  8,  5, '2026-03-02', '2026-03-16', '2026-03-30', 14.00),  
(9,  9,  1, '2026-03-05', '2026-03-19', NULL,          0),      
(6, 10, 2, '2026-03-10', '2026-03-24', '2026-04-02', 9.00),   
(8, 11, 3, '2026-03-12', '2026-03-26', NULL,          0),      
(1,  12, 4, '2026-03-15', '2026-03-29', '2026-03-28', 0),      
(2,  13, 5, '2026-03-20', '2026-04-03', '2026-04-10', 7.00),   
(3,  14, 1, '2026-04-01', '2026-04-15', NULL,          0),      
(4,  15, 2, '2026-04-02', '2026-04-16', '2026-04-14', 0),      
(5,  10, 3, '2026-04-05', '2026-04-19', NULL,          0);      


UPDATE staff
SET first_name = TRIM(first_name),
    last_name = TRIM(last_name);

UPDATE members
SET first_name = TRIM(first_name),
    last_name = TRIM(last_name);
-- phase 3
--1
select (first_name ||' ' || last_name) as full_name , email from members order by join_date asc;
--2
select distinct city from members ;
--3
select * from members where membership_status = 'active';
--4 
update books set copies_available = 4 where book_id = 6 returning book_id,title,copies_available;
--5
INSERT INTO loans (member_id, book_id, staff_id, loan_date, due_date, return_date, fine_amount) VALUES
(6,  1,  4, '2026-04-10', '2026-04-24', '2026-04-23', 15.50) returning loan_id;
delete from loans where loan_id = 17 returning loan_id, member_id, book_id, staff_id, return_date;


-- phase 4

--1
select l.loan_date, l.due_date, l.return_date, l.fine_amount ,
b.title, (m.first_name || ' '|| m.last_name) as full_name
from loans l inner join members m on l.member_id = m.member_id 
inner join books b on l.book_id =b.book_id
order by l.loan_date desc ;
--2
select count(l.loan_id),b.title  from loans l right join books b on l.book_id = b.book_id  group by b.title;

--3
select c.category_name ,b.title from categories c left join books b on c.category_id = b.category_id ;

--4
select (s.first_name || ' '|| s.last_name) as staff_name , 
(ss.first_name || ' '|| ss.last_name) as supervisor_name 
from staff s left join staff ss 
on s.supervisor_id=ss.staff_id ;

-- phase 5 
--1
select count(loan_id), member_id from loans group by member_id order by count(loan_id) asc;
--2
select member_id, avg(fine_amount) as average_fine_amount  from loans group by member_id order by member_id ;
--3
SELECT c.category_id, c.category_name,
       MIN(b.publication_year) AS earliest_year,
       MAX(b.publication_year) AS latest_year
FROM categories c
LEFT JOIN books b ON c.category_id = b.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_id;

--4 
select c.category_name , count(b.book_id) as books_per_category 
from categories c left join books b
on c.category_id = b.category_id 
group by category_name having count(b.book_id)>2  ;

--5 
select  (m.first_name || ' '|| m.last_name) as member_name 
from members m 
where member_id  not in (select member_id from loans );

--6
select  (first_name || ' '|| last_name) as staff_member from staff  where staff_id in
(select staff_id from loans
group by staff_id having count(loan_id)> (select avg(countl) from (select count(loan_id) as countl from loans group by staff_id)));


-- phase 6 Phase 6 — Indexing
--1. Create an index on the members table to speed up searches by email.
--2. Create an index on the loans table to speed up lookups by book_id.
--3. Drop one of the two indexes as a test, and note in a comment why you would (or wouldn't) keep it in
--production.

--1
create index idx_members_email on members(email);

--2
create index idx_loans_book_id on loans(book_id);

--3
drop index idx_loans_book_id ;
-- Both indexes are worth having, but if I need to drop one, I'm choosing idx_loans_book_id ; not because it's less important than the other, it's just that email is queried more frequently (many distinct values) -> (this is my opinion)

-- phase 7 
CREATE USER readonly_user WITH PASSWORD 'readingread22';
GRANT SELECT ON ALL TABLES IN SCHEMA public to readonly_user;

CREATE USER librarian_user WITH PASSWORD 'libraryll22';
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public to librarian_user;

REVOKE UPDATE ON TABLE  loans from librarian_user;


-- phase 8
/*
--1. Write an anonymous DO block that declares a variable using %TYPE against members.email, retrieves (with
SELECT INTO) the email and total loan count of the member with the earliest join_date, and prints both with
RAISE NOTICE.
*/
--1
DO $$
DECLARE
v_loan_count INT;
v_email members.email%TYPE;
BEGIN
SELECT m.email, COUNT(l.loan_id)
    INTO v_email, v_loan_count
    FROM members m
    LEFT JOIN loans l ON l.member_id = m.member_id
    WHERE m.join_date = (SELECT MIN(join_date) FROM members)
    GROUP BY m.email;
 RAISE NOTICE 'Earliest joined member email: % | total loans: %', v_email, v_loan_count;
END;
$$;





--2. Write a DO block that checks a specific member's membership_status and RAISE NOTICE a different message
--for 'active', 'suspended', and any other value.

DO $$
DECLARE

    v_status members.membership_status%TYPE;
BEGIN
SELECT  (membership_status)
    INTO  v_status
	from members 
	WHERE member_id = 6;

	IF v_status = 'active' THEN
        RAISE NOTICE 'Member 6 is ACTIVE and may borrow books.';
    ELSIF v_status = 'suspended' THEN
        RAISE NOTICE 'Member 6 is SUSPENDED and may not borrow books.';
    ELSE
        RAISE NOTICE 'Member 6 has an unrecognized status: %', v_status;
    
    END IF;
END;
$$;


--3. Write a FOR loop that iterates over all books in one specific category and prints each book's title.

DO $$ 
DECLARE 
         v_title books.title%TYPE;
		
BEGIN
         FOR v_title IN 
		              SELECT  title from books where category_id =4

		 LOOP
		              raise notice  'Book_title : %' , v_title ;
		 END LOOP;
END;
$$;




--4. Write a WHILE loop that increments a specific book's copies_available one unit at a time until it reaches 20
--(simulating receiving a new shipment of copies), printing a RAISE NOTICE at each step showing the updated
--count.
DO $$
DECLARE
    v_current INT;
BEGIN
    SELECT copies_available INTO v_current FROM books WHERE book_id = 4;
 
    WHILE v_current < 20 
	LOOP
        v_current := v_current + 1;
        UPDATE books SET copies_available = v_current WHERE book_id = 4;
        RAISE NOTICE 'Book 4 copies_available is now %', v_current;
	
    END LOOP;
	RAISE NOTICE 'Book 4 copies_available are >= 20';
END;
$$;





--5. Write a DO block that uses a RECORD variable inside a FOR loop to iterate through every loan of one member,
--printing the book title, loan_date, and due_date from the record.

DO $$
DECLARE
    v_loan RECORD ;
BEGIN
    FOR  v_loan IN 
	  SELECT b.title, l.loan_date, l.due_date from loans l inner join books b on l.book_id=b.book_id where member_id = 7
	
    LOOP
      RAISE NOTICE 'Book_title :% , loan_date : %, due_date :%' , 
	               v_loan.title , v_loan.loan_date , v_loan.due_date;
	
    END LOOP;
END $$;





--6. Wrap an INSERT into loans in a BEGIN / EXCEPTION block. Deliberately trigger an error (e.g. an invalid
--book_id) and show that your EXCEPTION block catches it and prints a friendly message instead of crashing.

DO $$
BEGIN
    BEGIN
        INSERT INTO loans (member_id, book_id, staff_id, due_date)
        VALUES (1,18, 1, CURRENT_DATE + 14);  -- book_id 18 does not exist
        RAISE NOTICE 'Loan inserted successfully.';
    EXCEPTION
        WHEN foreign_key_violation THEN
            RAISE NOTICE 'Could not create loan: that book does not exist. Please choose a valid book.';
    END;
END $$;














--7. Write a DO block that attempts to insert a staff member with an email that already exists and catches the error
--specifically using the unique_violation named exception, printing a friendly message.

DO $$
BEGIN
    BEGIN
        INSERT INTO staff (first_name, last_name, email, hire_date)
        VALUES ('rania', 'abujabal', 'rabujabal4@gmail.com', CURRENT_DATE);
        RAISE NOTICE 'Staff member added successfully.';
    EXCEPTION
        WHEN unique_violation THEN
            RAISE NOTICE 'Sign-up failed: a staff member with that email already exists.';
    END;
END $$;
-- NOTICE:  Sign-up failed: a staff member with that email already exists. DO







--8. Returns how many loans that member has made. Show the CREATE FUNCTION statement and a sample
--SELECT calling it.


CREATE OR REPLACE FUNCTION get_member_loan_count(p_member_id INT)
RETURNS INT AS $$
BEGIN
    RETURN (
    SELECT COUNT(*) 
    FROM loans
    WHERE member_id = p_member_id );
 
   
END;
$$ LANGUAGE plpgsql;
 
-- Usage
SELECT get_member_loan_count(4) ;


--9

CREATE OR REPLACE FUNCTION calculate_late_fine(p_due_date DATE, p_return_date DATE)
RETURNS NUMERIC(6,2)
AS $$
BEGIN
    IF p_return_date IS NULL OR p_return_date <= p_due_date THEN
        RETURN 0.00;
    END IF;
 
    RETURN ((p_return_date - p_due_date) * 1.00)::NUMERIC(6,2);
END;
$$ LANGUAGE plpgsql;
 
-- Usage
SELECT loan_id, due_date, return_date,
       calculate_late_fine(due_date, return_date) AS computed_fine
  FROM loans;

--10. Inserts a new row into loans and decrements the book's copies_available by 1, with an EXCEPTION block that
--prevents issuing a loan when copies_available is already 0 .


CREATE OR REPLACE FUNCTION issue_loan(
    p_member_id INT,
    p_book_id   INT,
    p_staff_id  INT,
    p_due_date  DATE
) RETURNS INT AS $$
DECLARE
    v_copies    INT;
    v_new_loan_id INT;
BEGIN
    SELECT copies_available INTO v_copies
    FROM books WHERE book_id = p_book_id
    FOR UPDATE;
 
    IF v_copies IS NULL THEN
        RAISE EXCEPTION 'Book % does not exist.', p_book_id;
    END IF;
 
    IF v_copies = 0 THEN
        RAISE EXCEPTION 'Cannot issue loan: book % has 0 copies available.', p_book_id;
    END IF;
 
    INSERT INTO loans (member_id, book_id, staff_id, due_date)
    VALUES (p_member_id, p_book_id, p_staff_id, p_due_date)
    RETURNING loan_id INTO v_new_loan_id;
 
    UPDATE books SET copies_available = copies_available - 1
    WHERE book_id = p_book_id;
 
    RETURN v_new_loan_id;

END;
$$ LANGUAGE plpgsql;
 
-- Usage
SELECT issue_loan(9, 11, 3, CURRENT_DATE + 14) AS new_loan_id;
 



--11. Before inserting a row into loans, prevent the insert if the book's copies_available is 0, raising a clear error
--message.



CREATE OR REPLACE FUNCTION trg_prevent_loan_when_no_copies()
RETURNS TRIGGER AS $$
DECLARE
    v_copies INT;
BEGIN
    SELECT copies_available INTO v_copies FROM books WHERE book_id = NEW.book_id;
 
    IF v_copies IS NULL THEN
        RAISE EXCEPTION 'Cannot create loan: book % does not exist.', NEW.book_id;
    END IF;
 
    IF v_copies <= 0 THEN
        RAISE EXCEPTION 'Cannot create loan: book % has no copies available.', NEW.book_id;
    END IF;
 
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER trg_check_copies_before_loan
BEFORE INSERT ON loans
FOR EACH ROW
EXECUTE FUNCTION trg_prevent_loan_when_no_copies();
 









--12. After a loan's return_date is updated from NULL to an actual date (i.e. the book is returned), automatically
--increase that book's copies_available by 1.
CREATE OR REPLACE FUNCTION trg_increase_copies_on_return()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.return_date IS NULL AND NEW.return_date IS NOT NULL THEN
        UPDATE books
        SET copies_available = copies_available + 1
        WHERE book_id = NEW.book_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS trg_return_book ON loans;

CREATE TRIGGER trg_return_book
AFTER UPDATE OF return_date ON loans
FOR EACH ROW
WHEN (OLD.return_date IS NULL AND NEW.return_date IS NOT NULL)
EXECUTE FUNCTION trg_increase_copies_on_return();