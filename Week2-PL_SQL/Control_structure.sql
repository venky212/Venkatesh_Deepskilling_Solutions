---Scenario 1: Apply Discount for Senior Customers
BEGIN
  FOR cust IN (
    SELECT c.CustomerID, c.DOB, l.LoanID, l.InterestRate
    FROM Customers c
    JOIN Loans l ON c.CustomerID = l.CustomerID
  )
  LOOP
    IF FLOOR(MONTHS_BETWEEN(SYSDATE, cust.DOB) / 12) > 60 THEN
      UPDATE Loans
      SET InterestRate = InterestRate - 1
      WHERE LoanID = cust.LoanID;
      
      DBMS_OUTPUT.PUT_LINE('1% discount applied to Customer ID: ' || cust.CustomerID || 
                           ', New Interest Rate: ' || (cust.InterestRate - 1));
    END IF;
  END LOOP;
END;
/



---Scenario 2: Promote to VIP Based on Balance
ALTER TABLE Customers ADD IsVIP VARCHAR2(5);
BEGIN
  FOR cust IN (SELECT CustomerID, Balance FROM Customers) LOOP
    IF cust.Balance > 10000 THEN
      UPDATE Customers
      SET IsVIP = 'TRUE'
      WHERE CustomerID = cust.CustomerID;

      DBMS_OUTPUT.PUT_LINE('Customer ' || cust.CustomerID || ' promoted to VIP.');
    ELSE
      UPDATE Customers
      SET IsVIP = 'FALSE'
      WHERE CustomerID = cust.CustomerID;
    END IF;
  END LOOP;
END;
/


---Scenario 3: Send Reminders for Loans Due Soon

BEGIN
  FOR loan_rec IN (
    SELECT l.LoanID, l.CustomerID, l.EndDate, c.Name
    FROM Loans l
    JOIN Customers c ON l.CustomerID = c.CustomerID
    WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Dear ' || loan_rec.Name ||
                         ', your loan (ID: ' || loan_rec.LoanID ||
                         ') is due on ' || TO_CHAR(loan_rec.EndDate, 'DD-Mon-YYYY') || '.');
  END LOOP;
END;
/
