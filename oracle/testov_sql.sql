﻿/* selecting 3 column in case if phone number like 515% - replace it with 'not working anymore'
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

/* added more salary checking ranges
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, 
    (CASE 
    when PHONE_NUMBER like '515%' then PHONE_NUMBER else 'not working anymore' 
     END)                                                               phone_number,
                                                                        SALARY      ,
    CASE 
        when SALARY <  1000                   then 'low salary'
        when SALARY >= 1000 and SALARY < 3000 then 'medium salary'
        when SALARY >= 3000 and SALARY < 6000 then 'big salary'
        when SALARY >= 6000 and SALARY < 8000 then 'huge salary'
        else 'top salary' 
    END
																		salary_level
    FROM employees
    */
	
/*  Added case check for department number returning string into new column departments
	And decode option (Oracle only available)
	Code is formatted

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME,
    (CASE 
    when PHONE_NUMBER like '515%' then PHONE_NUMBER else 'not working anymore' 
     END)                                                               phone_number,
                                                                        SALARY      ,
    CASE 
        when SALARY <  1000                   then 'low salary'
        when SALARY >= 1000 and SALARY < 3000 then 'medium salary'
        when SALARY >= 3000 and SALARY < 6000 then 'big salary'
        when SALARY >= 6000 and SALARY < 8000 then 'huge salary'
        else                                       'top salary' 
    END                                                                 salary_level,
           
    CASE 
        when DEPARTMENT_ID <  60                            then 'dep1'
        when DEPARTMENT_ID >= 80  and DEPARTMENT_ID < 90    then 'dep2'
        when DEPARTMENT_ID >= 90  and DEPARTMENT_ID < 100   then CASE
                                                                    when SALARY < 5000 then 'smile'
                                                                    else                    'slile x2'
                                                                 END
        else ':)'

        
    END                                                                 departments123,
    DECODE (JOB_ID, 'AD_PRES', 		'blue', 
				    'AD_VP',  		'red',
				    'IT_PROG', 		'green', 
				    'FI_ACCOUNT',	'white',
									'other_color')  "COLORS" 
    FROM employees
    */