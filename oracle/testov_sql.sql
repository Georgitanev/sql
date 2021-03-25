/* selecting 3 column in case if phone number like 515% - replace it with 'not working anymore'
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME,
    (case 
    when PHONE_NUMBER like '515%' then  PHONE_NUMBER else 'not working anymore' END) phone_number
    FROM employees
*/

/* select with case -> check salary and return different strings. Formatted code
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME,
	(CASE 
		when PHONE_NUMBER like '515%' then PHONE_NUMBER else 'not working anymore' 
	 END)                                                               phone_number,
														
	CASE 
		when SALARY < 1000 					   then 'low salary'
		when SALARY >= 1000 and SALARY <= 5000 then 'medium salary'
											   else 'big salary' 
	END                                                                 salary_level
FROM employees
*/
	
	
	
	