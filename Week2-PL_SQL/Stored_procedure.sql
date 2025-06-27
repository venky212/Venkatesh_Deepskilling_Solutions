
---Scenario 1: Process Monthly Interest for Savings Accounts
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
BEGIN
  UPDATE Accounts
  SET Balance = Balance + (Balance * 0.01),
      LastModified = SYSDATE
  WHERE AccountType = 'SAVINGS';

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    INSERT INTO LOG_ERRORS (error_message, procedure_name)
    VALUES (SQLERRM, 'ProcessMonthlyInterest');
    COMMIT;
END;

---Scenario 2: Update Employee Bonus by Department
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
  p_department IN VARCHAR2,
  p_bonus_pct  IN NUMBER
)
IS
BEGIN
  UPDATE Employees
  SET Salary = Salary + (Salary * p_bonus_pct / 100)
  WHERE Department = p_department;

  IF SQL%ROWCOUNT = 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'No employees found in the specified department.');
  END IF;

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    INSERT INTO LOG_ERRORS (error_message, procedure_name)
    VALUES (SQLERRM, 'UpdateEmployeeBonus');
    COMMIT;
END;

---Scenario 3: Transfer Funds Between Customer Accounts
CREATE OR REPLACE PROCEDURE TransferFunds(
  p_from_account_id IN NUMBER,
  p_to_account_id   IN NUMBER,
  p_amount          IN NUMBER
)
IS
  v_balance NUMBER;
BEGIN
  SELECT Balance INTO v_balance
  FROM Accounts
  WHERE AccountID = p_from_account_id
  FOR UPDATE;

  IF v_balance < p_amount THEN
    RAISE_APPLICATION_ERROR(-20004, 'Insufficient balance in source account');
  END IF;

  
  UPDATE Accounts
  SET Balance = Balance - p_amount,
      LastModified = SYSDATE
  WHERE AccountID = p_from_account_id;

  UPDATE Accounts
  SET Balance = Balance + p_amount,
      LastModified = SYSDATE
  WHERE AccountID = p_to_account_id;

  
  INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
  VALUES (Transactions_seq.NEXTVAL, p_from_account_id, SYSDATE, p_amount, 'DEBIT');

  INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
  VALUES (Transactions_seq.NEXTVAL, p_to_account_id, SYSDATE, p_amount, 'CREDIT');

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    INSERT INTO LOG_ERRORS (error_message, procedure_name)
    VALUES (SQLERRM, 'TransferFunds');
    COMMIT;
END;