Create Table employees (
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(30) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(20) NOT NULL,
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title_id) references titles(title_id)
);

CREATE TABLE titles (
	title_id VARCHAR(30) PRIMARY KEY NOT NULL,
	title VARCHAR(30) NOT NULL
);

CREATE TABLE Departments (
    dept_no VARCHAR PRIMARY KEY NOT NULL,
	dept_name VARCHAR NOT NULL
);

CREATE TABLE Department_manager (
    dept_no VARCHAR NOT NULL,
    emp_no INTEGER NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES Departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no)
);

CREATE TABLE Department_employees (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments (dept_no)
);

CREATE TABLE Salaries (
	emp_no INT,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no)
);



SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, s.salary
FROM employees
INNER JOIN salaries AS s ON employees.emp_no = s.emp_no;

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM "hire_date") = 1986;

SELECT departments.dept_no, departments.dept_name, department_manager.emp_no, employees.last_name, employees.first_name
FROM departments
INNER JOIN department_manager ON departments.dept_no = department_manager.dept_no
INNER JOIN employees ON employees.emp_no = department_manager.emp_no;

SELECT employees.emp_no, employees.last_name, employees.last_name, departments.dept_name
FROM employees
JOIN department_employees ON department_employees.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = department_employees.dept_no;

SELECT first_name, last_name, sex
FROM employees
WHERE first_name LIKE 'Hercules%' and last_name LIKE 'B%';

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees  
INNER JOIN department_employees ON department_employees.emp_no = employees.emp_no
INNER JOIN departments ON department_employees.dept_no = departments.dept_no
WHERE dept_name LIKE 'Sales%';

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN department_employees ON department_employees.emp_no = employees.emp_no
INNER JOIN departments ON department_employees.dept_no = departments.dept_no
WHERE dept_name IN ('Sales','Development');

SELECT last_name,
COUNT(last_name) AS Total
FROM employees
GROUP BY last_name
ORDER BY Total DESC;