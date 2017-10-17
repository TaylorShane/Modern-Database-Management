/* 
* Shane Taylor
* Modern Database Management, Section 1, Summer 2016
* Taylor_Populate_tables.sql
* Script to populate the JavaJim tables with data.
*/

-- Insert into customers_jj
INSERT INTO customers_jj(customer_id,first_name,last_name,email,phone) 
VALUES (customers_jj_seq.NEXTVAL,'Tom','Jones','WhatsUpPussycat@aol.com',9878168945);
INSERT INTO customers_jj(customer_id,first_name,last_name,email,phone) 
VALUES (customers_jj_seq.NEXTVAL,'Tom','Yorke','koComputer@gmail.com',6542587987);
INSERT INTO customers_jj(customer_id,first_name,last_name,email,phone) 
VALUES (customers_jj_seq.NEXTVAL,'Thomas','Dolby','blindedMeWithScience@yahoo.com',6394587452);
INSERT INTO customers_jj(customer_id,first_name,last_name,email,phone) 
VALUES (customers_jj_seq.NEXTVAL,'Tom','Waits','DrunkPiano@mail.net',1233213221);
INSERT INTO customers_jj(customer_id,first_name,last_name,email,phone) 
VALUES (customers_jj_seq.NEXTVAL,'Tommy','Tutone','HeyJennyJenny@netscape.net',5558675309);
INSERT INTO customers_jj(customer_id,first_name,last_name,email,phone) 
VALUES (customers_jj_seq.NEXTVAL,'Tom','Verlaine','Tvtunes@mail.music',9877899887);
INSERT INTO customers_jj(customer_id,first_name,last_name,email,phone) 
VALUES (customers_jj_seq.NEXTVAL,'Tom','Petty','Americano@gmail.com',6598524714);

INSERT INTO Employees_jj(employee_id,first_name,last_name,phone,department)
VALUES(employees_jj_seq.NEXTVAL,'Cristopher','Guest',8522589696,'sales');
INSERT INTO Employees_jj(employee_id,first_name,last_name,phone,department)
VALUES(employees_jj_seq.NEXTVAL,'Harry','Shearer',8521474747,'roaster');
INSERT INTO Employees_jj(employee_id,first_name,last_name,phone,department)
VALUES(employees_jj_seq.NEXTVAL,'Michael','McKean',9633693636,'roaster');
INSERT INTO Employees_jj(employee_id,first_name,last_name,phone,department)
VALUES(employees_jj_seq.NEXTVAL,'Rob','Reiner',9877897413,'CEO');
INSERT INTO Employees_jj(employee_id,first_name,last_name,phone,department)
VALUES(employees_jj_seq.NEXTVAL,'Tony','Hendra',9871239173,'Janitorial');
INSERT INTO Employees_jj(employee_id,first_name,last_name,phone,department)
VALUES(employees_jj_seq.NEXTVAL,'Billy','Crystal',1239871973,'sales');
INSERT INTO Employees_jj(employee_id,first_name,last_name,phone,department)
VALUES(employees_jj_seq.NEXTVAL,'Fran','Drescher',3219871973,'sales');
INSERT INTO employees_jj(employee_id,first_name,last_name,phone,department)
VALUES(employees_jj_seq.NEXTVAL,'Ed','Begley Jr.',3211111973,'sales');

INSERT INTO vendors_jj(vendor_id,vendor_name,payment_terms,contact_first_name,contact_last_name)
VALUES(vendors_jj_seq.NEXTVAL,'Kenya Beans',30,'Gene','Wilder');
INSERT INTO vendors_jj(vendor_id,vendor_name,payment_terms,contact_first_name,contact_last_name)
VALUES(vendors_jj_seq.NEXTVAL,'Tico Beans',45,'Marty','Feldman');
INSERT INTO vendors_jj(vendor_id,vendor_name,payment_terms,contact_first_name,contact_last_name)
VALUES(vendors_jj_seq.NEXTVAL,'Aloha Coffees',30,'Teri','Gar');
INSERT INTO vendors_jj(vendor_id,vendor_name,payment_terms,contact_first_name,contact_last_name)
VALUES(vendors_jj_seq.NEXTVAL,'Sumatra Growers',30,'Maddeline','Kahn');
INSERT INTO vendors_jj(vendor_id,vendor_name,payment_terms,contact_first_name,contact_last_name)
VALUES(vendors_jj_seq.NEXTVAL,'Brazilian Beans',30,'Peter','Boyle');
INSERT INTO vendors_jj(vendor_id,vendor_name,payment_terms,contact_first_name,contact_last_name)
VALUES(vendors_jj_seq.NEXTVAL,'Vietnam Growers Guild',30,'Mel','Brooks');
INSERT INTO vendors_jj(vendor_id,vendor_name,payment_terms,contact_first_name,contact_last_name)
VALUES(vendors_jj_seq.NEXTVAL,'Indonesian Indobeans',45,'Gene','Hackman');

INSERT INTO products_jj(product_id,vendor_id,origin,size_lbs,price)
VALUES(products_jj_seq.NEXTVAL,100, 'Kenya',5,10);
INSERT INTO products_jj(product_id,vendor_id,origin,size_lbs,price)
VALUES(products_jj_seq.NEXTVAL,101, 'Costa Rica',5,30);
INSERT INTO products_jj(product_id,vendor_id,origin,size_lbs,price)
VALUES(products_jj_seq.NEXTVAL,102, 'India',10,7);
INSERT INTO products_jj(product_id,vendor_id,origin,size_lbs,price)
VALUES(products_jj_seq.NEXTVAL,103, 'Brazil',5,12);
INSERT INTO products_jj(product_id,vendor_id,origin,size_lbs,price)
VALUES(products_jj_seq.NEXTVAL,104, 'Vietnam',15,10);
INSERT INTO products_jj(product_id,vendor_id,origin,size_lbs,price)
VALUES(products_jj_seq.NEXTVAL,105, 'Hawaii',5,25);
INSERT INTO products_jj(product_id,vendor_id,origin,size_lbs,price)
VALUES(products_jj_seq.NEXTVAL,106, 'Indonesia',10,15);

INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,105,103,65,100);
INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,100,106,291,105);
INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,102,104,5,106);
INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,103,100,487,100);
INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,101,102,89003,105);
INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,104,101,6989,106);
INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,106,100,521,100);
INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,103,106,6528.55,100);
INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,100,104,6524.32,105);
INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,101,105,6528.63,106);
INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,102,106,321.01,106);
INSERT INTO sales_invoices_jj(invoice_id,customer_id,product_id,invoice_total,employee_id)
VALUES(sales_invoices_jj_seq.NEXTVAL,106,101,63.99, 100);

INSERT INTO Product_Sales_jj(product_id,invoice_id)
VALUES(100,105);
INSERT INTO Product_Sales_jj(product_id,invoice_id)
VALUES(105,102);
INSERT INTO Product_Sales_jj(product_id,invoice_id)
VALUES(102,106);
INSERT INTO Product_Sales_jj(product_id,invoice_id)
VALUES(106,103);
INSERT INTO Product_Sales_jj(product_id,invoice_id)
VALUES(104,100);
INSERT INTO Product_Sales_jj(product_id,invoice_id)
VALUES(101,101);
INSERT INTO Product_Sales_jj(product_id,invoice_id)
VALUES(103,104);

/* new_vendor_insert_sproc Procedure call (please see my notes on the 
Tayor_Create_objects.sql file*/
BEGIN
  new_vendor_insert_sproc(vendors_jj_seq.NEXTVAL,'Cool Beans',30,'Paully','Shore');
END;
/
COMMIT;