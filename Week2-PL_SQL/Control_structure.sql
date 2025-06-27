---Scenario 1: Apply Discount for Senior Customers
BEGIN
  FOR cust_rec IN (SELECT customer_id FROM customers WHERE age > 60) LOOP
    UPDATE loans
    SET interest_rate = interest_rate - 1
    WHERE customer_id = cust_rec.customer_id;
  END LOOP;
  COMMIT;
END;


---Scenario 2: Promote to VIP Based on Balance
BEGIN
  FOR cust_rec IN (SELECT customer_id FROM customers WHERE balance > 10000) LOOP
    UPDATE customers
    SET IsVIP = 'TRUE'
    WHERE customer_id = cust_rec.customer_id;
  END LOOP;
  COMMIT;
END;

---Scenario 3: Send Reminders for Loans Due Soon

DECLARE
  v_due_date loans.due_date%TYPE;
  v_customer_id loans.customer_id%TYPE;
  v_name customers.name%TYPE;
BEGIN
  FOR loan_rec IN (
    SELECT l.customer_id, l.due_date, c.name
    FROM loans l
    JOIN customers c ON l.customer_id = c.customer_id
    WHERE l.due_date BETWEEN SYSDATE AND SYSDATE + 30
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Loan for customer ' || loan_rec.name || 
                         ' (ID: ' || loan_rec.customer_id || 
                         ') is due on ' || TO_CHAR(loan_rec.due_date, 'DD-MON-YYYY'));
  END LOOP;
END;