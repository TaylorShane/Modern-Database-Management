/*
* Shane Taylor
* Modern Database Management, Section 1, Summer 2016
* Taylor_Create_Objects.sql
* Script to create a user, the tables, sequences, index, view, procedure
* function, and package.
*/


-- 1 What employees are selling which vendor's products?
SELECT (e.first_name || ' ' || e.last_name) AS "Employee", 
  v.vendor_name AS "Vendor"
FROM employees_jj e
JOIN sales_invoices_jj si ON si.employee_id = e.employee_id
JOIN product_sales_jj ps ON PS.invoice_id = si.invoice_id
JOIN products_jj p ON p.product_id = ps.product_id
JOIN vendors_jj v ON P.vendor_id = v.vendor_id
ORDER BY e.last_name;
/*  Results
Billy Crystal	Tico Beans
Billy Crystal	Sumatra Growers
Fran Drescher	Kenya Beans
Fran Drescher	Vietnam Growers Guild
Cristopher Guest	Aloha Coffees
Cristopher Guest	Indonesian Indobeans
Cristopher Guest	Brazilian Beans
*/

-- 2 Which customers bought beans supplied by the vendor 'Tico Beans'?  
--   Let's email them about the Cool Beans sale we are having.
SELECT DISTINCT(c.email) AS "Customer Email", (c.first_name || ' ' || c.last_name) AS "Customer Name"
FROM customers_jj c JOIN sales_invoices_jj si ON c.customer_id = si.customer_id
JOIN product_sales_jj ps ON ps.invoice_id = si.invoice_id
JOIN products_jj p ON p.product_id = ps.invoice_id
JOIN vendors_jj v ON v.vendor_id = p.vendor_id
WHERE UPPER(v.vendor_name) = 'TICO BEANS';
/*  Results
WhatsUpPussycat@aol.com	Tom Jones
*/

-- 3 What customer spends the most?  We should call and thank them.
SELECT c.customer_id AS "Customer ID", (c.first_name || ' ' || c.last_name) AS 
  "Customer Name", TO_CHAR(SI.invoice_total, '$99,999.99') AS "Invoice Total", 
  to_char(c.phone,'000G000G0000', 'nls_numeric_characters=''.-''') AS "Customer Phone"
FROM customers_jj c JOIN sales_invoices_jj si ON c.customer_id = si.customer_id
WHERE c.customer_id IN
  (SELECT * FROM 
    (SELECT customer_id
      FROM sales_invoices_jj 
      ORDER BY invoice_total DESC)
    WHERE ROWNUM = 1);
/* Results
101	Tom Yorke	 $89,003.00	 654-258-7987
101	Tom Yorke	  $6,528.63	 654-258-7987
*/

-- 4 Which vendor's product constitutes most of our sales?
SELECT vendor_name AS "Vendor", TO_CHAR(invoice_total, '$99,999.99') 
  AS "Invoice Amount"
FROM vendors_jj v 
JOIN products_jj p ON v.vendor_id = p.vendor_id
JOIN product_sales_jj ps ON p.product_id = ps.product_id
JOIN sales_invoices_jj si ON si.invoice_id = ps.invoice_id
WHERE invoice_total IN
  (SELECT * FROM 
    (SELECT invoice_total
      FROM sales_invoices_jj 
      ORDER BY invoice_total DESC)
    WHERE ROWNUM <= 1); 
/*  Results
Sumatra Growers	 $89,003.00
*/

-- 5 How many customers with an area code of 659 buy coffee from India
Select si.customer_id AS "Customer ID", (c.first_name || c.last_name) AS "Customer Name", 
  p.origin AS "Origin", to_char(c.phone,'000G000G0000', 'nls_numeric_characters=''.-''') 
  AS "Customer Phone"
FROM sales_invoices_jj si
JOIN customers_jj c ON si.customer_id = c.customer_id
JOIN product_sales_jj ps ON ps.invoice_id = si.invoice_id
JOIN products_jj p ON p.product_id = ps.product_id
WHERE UPPER(c.PHONE) LIKE '659%'
AND UPPER(p.origin) LIKE '%INDIA%';
/* Results
106	TomPetty	India	 659-852-4714
*/

-- 6 We want to notify our customers of a sale.  We need their email addresses, 
--   unless they have an aol email address, in which case we want their phone number.
SET SERVEROUTPUT ON;
DECLARE 
  cus_first   customers_jj.first_name%TYPE;
  cus_last    customers_jj.last_name%TYPE;
  cus_phone   customers_jj.phone%TYPE;
  cus_email   customers_jj.email%TYPE;
  CURSOR CUSTS IS SELECT first_name, last_name, phone, email
                    INTO cus_first, cus_last, cus_phone, cus_email
                    FROM customers_jj;
  i NUMBER:= 0;
BEGIN 
  
  FOR e_rec IN CUSTS LOOP
  i:= i+1;
    IF UPPER(e_rec.email) LIKE '%AOL%' THEN
      DBMS_OUTPUT.PUT_LINE('This crusty old AOL user '|| e_rec.first_name ||' '
      || e_rec.last_name || ' should be called at ' || 
      to_char(e_rec.phone,'000G000G0000', 'nls_numeric_characters=''.-'''));
    ELSE
      DBMS_OUTPUT.PUT_LINE('Please email '|| e_rec.first_name || ' ' ||
      e_rec.last_name || ' at ' || e_rec.email);
    END IF;
  END LOOP;
END;
/
/*  Results
This crusty old AOL user Tom Jones should be called at 987-816-8945
Please email Tom Yorke at koComputer@gmail.com
Please email Thomas Dolby at blindedMeWithScience@yahoo.com
Please email Tom Waits at DrunkPiano@mail.net
Please email Tommy Tutone at HeyJennyJenny@netscape.net
Please email Tom Verlaine at Tvtunes@mail.music
Please email Tom Petty at Americano@gmail.com
*/

-- 7 Which sales employees have sold the largest sized bags of beans?
SELECT (e.first_name || e.last_name) AS "Sales Employee", size_lbs AS "Largest Bag Sold"
FROM employees_jj e
JOIN sales_invoices_jj si ON e.employee_id = si.employee_id
JOIN product_sales_jj ps ON ps.invoice_id = si.invoice_id
JOIN products_jj p ON p.product_id = ps.product_id
WHERE SIZE_LBS IN
  (SELECT * FROM 
    (SELECT size_lbs
      FROM products_jj 
      ORDER BY size_lbs DESC)
    WHERE ROWNUM <= 1); 
/*  Results
CristopherGuest	15
*/