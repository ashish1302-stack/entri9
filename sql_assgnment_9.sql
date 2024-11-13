CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT,
    JoiningDate DATETIME,
    Department CHAR(25)
);
INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department) VALUES 
(1, 'Ashly', 'Thomas', 50000, '2024-01-15', 'HR'),
(2, 'Jibin', 'Jpy', 60000, '2024-03-23', 'Finance'),
(3, 'Goshal', 'Jay', 55000, '2023-06-10', 'IT'),
(4, 'Richu', 'Zach', 62000, '2023-12-05', 'Marketing'),
(5, 'Mebin', 'Joby', 58000, '2024-05-20', 'HR'),
(6, 'Jonhy', 'John', 63000, '2023-04-18', 'Finance'),
(7, 'Gopika', 'Anil', 48000, '2024-11-25', 'IT'),
(8, 'George', 'Mamen', 67000, '2023-07-14', 'Marketing'),
(9, 'Justin', 'Jose', 54000, '2024-02-10', 'HR'),
(10, 'Mariya', 'Sam', 62000, '2023-09-29', 'Finance');

select*from worker;

DELIMITER //
CREATE PROCEDURE add_worker(
    IN p_worker_id INT,
    IN p_firstname CHAR(25),
    IN p_lastname CHAR(25),
    IN p_salary INT,
    IN p_joiningdate DATETIME,
    IN p_department CHAR(25)
)
BEGIN
    INSERT INTO worker (worker_id, firstname, lastname, salary, joiningdate, department)
    VALUES (p_worker_id, p_firstname, p_lastname, p_salary, p_joiningdate, p_department);
END //
DELIMITER ;


CALL add_worker(11, 'Alex', 'Khan', 65000, '2024-10-01', 'Marketing');

SELECT*FROM worker;

DELIMITER //
CREATE PROCEDURE update_department(
    IN p_worker_id INT,
    IN p_department CHAR(25)
)
BEGIN
    UPDATE worker
    SET department = p_department
    WHERE worker_id = p_worker_id;
END //
DELIMITER ;

CALL update_department(2, 'Legal');

SELECT*FROM worker;


DELIMITER //

CREATE PROCEDURE get_worker_count_by_department(
    IN p_department CHAR(25),
    OUT p_workerCount INT)
BEGIN
    SELECT COUNT(*) INTO p_workerCount
    FROM worker
    WHERE Department = p_department;
END //
DELIMITER ;

SET @worker_count = 0;
CALL get_worker_count_by_department('Legal', @worker_count);

SELECT @worker_count AS WorkerCountInLegal;

DELIMITER //

CREATE PROCEDURE get_avg_salary_by_department(
    IN p_department CHAR(25),
    OUT p_avgSalary DECIMAL(10, 2))
BEGIN
    SELECT AVG(Salary) INTO p_avgSalary
    FROM worker
    WHERE Department = p_department;
END //

DELIMITER ;

SET @avg_salary = 0.00;

CALL get_avg_salary_by_department('Legal', @avg_salary);

SELECT @avg_salary AS AverageSalaryInLegal;

