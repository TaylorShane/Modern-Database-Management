/*
* Shane Taylor
* Modern Database Management, Section 1, Summer 2016
* Taylor_Create_Objects.sql
* Script to create a user, the tables, sequences, index, view, procedure
* function, and package.
*/
-- Create user
CREATE USER shanet IDENTIFIED BY shanet
DEFAULT TABLESPACE users;
GRANT ALL PRIVILEGES TO shanet;

-- Create tables
CREATE TABLE customers_jj
(
  customer_id   NUMBER(6),
  first_name    VARCHAR2(25)    NOT NULL,
  last_name     VARCHAR2(50)    NOT NULL,
  email         VARCHAR2(50),
  phone         NUMBER(15),
  CONSTRAINT customers_jj_pk PRIMARY KEY (customer_id),
  CONSTRAINT customer_id_ck CHECK (customer_id BETWEEN 100 AND 999999)
);

CREATE TABLE vendors_jj
(
  vendor_id           NUMBER(6),
  vendor_name         VARCHAR2(50)    NOT NULL,
  payment_terms       NUMBER(2)       DEFAULT 30,
  contact_first_name  VARCHAR2(25),
  contact_last_name   VARCHAR2(50),
  CONSTRAINT vendors_jj_pk PRIMARY KEY (vendor_id),
  CONSTRAINT vendor_id_ck CHECK (vendor_id BETWEEN 100 AND 999999)
);

CREATE TABLE employees_jj
(
  employee_id   NUMBER(6),
  first_name    VARCHAR2(25)    NOT NULL,
  last_name     VARCHAR2(50)    NOT NULL,
  phone         NUMBER(15)      NOT NULL,
  department    VARCHAR2(75)    NOT NULL,
  CONSTRAINT employees_jj_pk PRIMARY KEY (employee_id),
  CONSTRAINT employee_id_ck CHECK (employee_id BETWEEN 100 AND 999999)
);

CREATE TABLE products_jj
(
  product_id    NUMBER(6),
  vendor_id     NUMBER(6),
  origin        VARCHAR2(50)    NOT NULL,
  size_lbs      NUMBER(3)       NOT NULL,
  price         NUMBER(4,2)     NOT NULL,
  CONSTRAINT products_jj_products_jj_pk PRIMARY KEY (product_id),
  CONSTRAINT products_fk_vendors FOREIGN KEY (vendor_id) REFERENCES vendors_jj(vendor_id),
  CONSTRAINT product_id_ck CHECK (product_id BETWEEN 100 AND 999999),
  CONSTRAINT size_lbs_ck CHECK (size_lbs BETWEEN 1 AND 20),
  CONSTRAINT price_ck CHECK (price BETWEEN 5 AND 30)
);

CREATE TABLE sales_invoices_jj
(
  invoice_id    NUMBER(6),
  customer_id   NUMBER(6)       NOT NULL,
  product_id    NUMBER(6)       NOT NULL,
  invoice_total NUMBER(8,2)     NOT NULL,
  employee_id   NUMBER(6)       NOT NULL,
  CONSTRAINT sales_invoices_pk PRIMARY KEY (invoice_id),
  CONSTRAINT sales_invoices_fk_customers FOREIGN KEY (customer_id) REFERENCES  customers_jj(customer_id),
  CONSTRAINT sales_invoices_fk_products FOREIGN KEY (product_id) REFERENCES  products_jj(product_id),
  CONSTRAINT sales_invoices_fk_employees FOREIGN KEY (employee_id) REFERENCES  employees_jj(employee_id),
  CONSTRAINT sales_invoice_jj_ck CHECK (invoice_id BETWEEN 100 AND 999999)
);

CREATE TABLE product_sales_jj
(
  product_id    NUMBER(6),
  invoice_id    NUMBER(6),
  CONSTRAINT product_sales_fk_products FOREIGN KEY (product_id) REFERENCES  products_jj(product_id),
  CONSTRAINT product_sales_fk_invoices FOREIGN KEY (invoice_id) REFERENCES  sales_invoices_jj(invoice_id)
);

-- Create sequences for all the primary keys to use.
CREATE SEQUENCE customers_jj_seq
  START WITH 100;
CREATE SEQUENCE employees_jj_seq
  START WITH 100;
CREATE SEQUENCE products_jj_seq
  START WITH 100;
CREATE SEQUENCE sales_invoices_jj_seq
  START WITH 100;
CREATE SEQUENCE vendors_jj_seq
  START WITH 100;

-- Create Index of the top salespeople.  The top salesperson gets a 
-- free cup of coffee.
CREATE INDEX sales_invoices_jj_top_sales 
  ON  sales_invoices_jj (employee_id, invoice_total DESC);
  
-- Create View to find out which salesperson isn't doing their job.
CREATE OR REPLACE VIEW youre_fired_view AS
  SELECT e.first_name, e.last_name
  FROM employees_jj e LEFT JOIN  sales_invoices_jj s 
  ON e.employee_id = s.employee_id
  WHERE UPPER(e.department) = 'SALES' AND e.employee_id NOT IN
    (SELECT employee_id FROM
    sales_invoices_jj);

-- Create Stored Procedure that inserts a new vendor into the vendors table.
CREATE OR REPLACE PROCEDURE new_vendor_insert_sproc
(
  vendor_id_param             vendors_jj.vendor_id%TYPE,
  vendor_name_param           vendors_jj.vendor_name%TYPE,
  payment_terms_param         vendors_jj.payment_terms%TYPE,
  contact_first_name_param    vendors_jj.contact_first_name%TYPE,
  contact_last_name_param     vendors_jj.contact_first_name%TYPE
)
AS
BEGIN
  INSERT INTO vendors_jj(vendor_id, vendor_name, payment_terms, contact_first_name, contact_last_name)
  VALUES(vendor_id_param, vendor_name_param, payment_terms_param, contact_first_name_param, contact_last_name_param);
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;
/
commit;

/* new_vendor_insert_sproc Procedure call
I've placed this at the end of the Taylor_populate_tables.sql file because if it is here,
this new vendor_id is 100 and it throws off the relation between vendor_name and product.origin
BEGIN
  new_vendor_insert_sproc(vendors_jj_seq.NEXTVAL,'Cool Beans',30,'Paully','Shore');
END;
/
*/
  
-- Create a function to get the vendor id using the vendor name.
CREATE OR REPLACE FUNCTION get_vendor_id
(
  vendor_name_param     vendors_jj.vendor_name%TYPE
)
RETURN NUMBER
AS
  vendor_id_var    NUMBER;
BEGIN
  SELECT vendor_id
  INTO vendor_id_var
  FROM vendors_jj
  WHERE vendor_name = vendor_name_param;
  
  RETURN vendor_id_var;
END;
/

-- Call the get_vendor_id function to get the payment terms of a vendor that you 
-- know the name of but not the vendor id.
SELECT payment_terms
FROM vendors_jj
WHERE vendor_id = get_vendor_id('Tico Beans');

-- Create Package
CREATE OR REPLACE PACKAGE jj_package AS
  PROCEDURE new_vendor_insert_sproc(
    vendor_id_param vendors_jj.vendor_id%TYPE,
    vendor_name_param           vendors_jj.vendor_name%TYPE,
    payment_terms_param         vendors_jj.payment_terms%TYPE,
    contact_first_name_param    vendors_jj.contact_first_name%TYPE,
    contact_last_name_param     vendors_jj.contact_first_name%TYPE);
  
  FUNCTION get_vendor_id
  (vendor_name_param     vendors_jj.vendor_name%TYPE)
  RETURN NUMBER;
END jj_package;
/

COMMIT;