/* selecting 3 column in case if phone number like 515% - replace it with 'not working anymore'
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME,
    (case 
    when PHONE_NUMBER like '515%' then  PHONE_NUMBER else 'not working anymore' END) phone_number
    FROM employees
*/

