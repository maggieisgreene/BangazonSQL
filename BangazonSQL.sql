--List each employee first name, last name and supervisor status along with their department name.
--Order by department name, then by employee last name, and finally by employee first name.

SELECT e.FirstName, e.LastName, e.IsSupervisor, d.[Name] FROM Employee e
LEFT JOIN Department d ON d.Id = e.DepartmentId
ORDER BY d.[Name], e.FirstName, e.LastName

--List each department ordered by budget amount with the highest first.

SELECT [Name], Budget FROM Department
ORDER BY Budget DESC

--List each department name along with any employees (full name) in that department who are supervisors.

SELECT e.FirstName, e.LastName, d.Name FROM Employee e
INNER JOIN Department d ON e.DepartmentId = d.Id
WHERE e.IsSupervisor = 1

--List each department name along with a count of employees in each department.

SELECT d.[Name], COUNT(e.DepartmentId) FROM Department d
LEFT JOIN Employee e ON d.Id = e.DepartmentId
GROUP BY d.[Name]

--Write a single update statement to increase each department's budget by 20%.

UPDATE Department SET Budget = (Budget * 1.2)

--List the employee full names for employees who are not signed up for any training programs.

SELECT e.FirstName + ' ' + e.LastName AS "Employees Not Training"
FROM Employee e
LEFT JOIN EmployeeTraining et ON et.EmployeeId = e.Id
WHERE et.EmployeeId IS NULL

--List the employee full names for employees who are signed up for at least one training program
--and include the number of training programs they are signed up for.

SELECT e.FirstName + ' ' + e.LastName AS "Employees Training", COUNT(et.EmployeeId) AS "Training Program Count"
FROM Employee e
LEFT JOIN EmployeeTraining et ON et.EmployeeId = e.Id
WHERE et.EmployeeId IS NOT NULL
GROUP BY e.FirstName, e.LastName

--List all training programs along with the count employees who have signed up for each.

SELECT tp.[Name], COUNT(et.EmployeeId) AS "Attending Count"
FROM TrainingProgram tp
LEFT JOIN EmployeeTraining et ON tp.Id = et.TrainingProgramId
GROUP BY tp.[Name]

--List all training programs who have no more seats available.

SELECT tp.[Name] AS "Programs At Max Capacity" FROM TrainingProgram tp
LEFT JOIN EmployeeTraining et ON et.TrainingProgramId = tp.Id
GROUP BY tp.[Name], tp.MaxAttendees
HAVING tp.MaxAttendees <= COUNT(et.EmployeeId)

--List all future training programs ordered by start date with the earliest date first.

SELECT [Name], StartDate FROM TrainingProgram
WHERE StartDate >= GetDate()
ORDER BY StartDate ASC

--Assign a few employees to training programs of your choice.

INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES(33, 16)
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES(23, 15)
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES(39, 7)

