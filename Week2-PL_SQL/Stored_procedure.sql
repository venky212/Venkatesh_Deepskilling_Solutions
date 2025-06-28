
---Scenario 1: Process Monthly Interest for Savings Accounts
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
  FOR acc IN (
    SELECT AccountID, Balance 
    FROM Accounts 
    WHERE AccountType = 'Savings'
  ) LOOP
    UPDATE Accounts
    SET Balance = Balance + (acc.Balance * 0.01),
        LastModified = SYSDATE
    WHERE AccountID = acc.AccountID;

    DBMS_OUTPUT.PUT_LINE('Interest applied to Account ' || acc.AccountID || 
                         ', New Balance: ' || (acc.Balance * 1.01));
  END LOOP;
END;
/


---Scenario 2: Update Employee Bonus by Department
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
  dept_name IN VARCHAR2,
  bonus_percent IN NUMBER
) IS
BEGIN
  FOR emp IN (
    SELECT EmployeeID, Salary 
    FROM Employees 
    WHERE Department = dept_name
  ) LOOP
    UPDATE Employees
    SET Salary = Salary + (emp.Salary * bonus_percent / 100)
    WHERE EmployeeID = emp.EmployeeID;

    DBMS_OUTPUT.PUT_LINE('Bonus applied to Employee ' || emp.EmployeeID ||
                         ', New Salary: ' || (emp.Salary + emp.Salary * bonus_percent / 100));
  END LOOP;
END;
/


---Scenario 3: Transfer Funds Between Customer Accounts
CREATE OR REPLACE PROCEDURE TransferFunds (
  from_account IN NUMBER,
  to_account IN NUMBER,
  amount IN NUMBER
) IS
  from_balance NUMBER;
BEGIN
 
  SELECT Balance INTO from_balance
  FROM Accounts
  WHERE AccountID = from_account;

  IF from_balance < amount THEN
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in source account.');
  ELSE
  
    UPDATE Accounts
    SET Balance = Balance - amount,
        LastModified = SYSDATE
    WHERE AccountID = from_account;

    
    UPDATE Accounts
    SET Balance = Balance + amount,
        LastModified = SYSDATE
    WHERE AccountID = to_account;

    DBMS_OUTPUT.PUT_LINE('Transferred ' || amount || 
                         ' from Account ' || from_account || 
                         ' to Account ' || to_account);
  END IF;
END;
/
