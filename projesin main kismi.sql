select a.invoice_id, a.account_no, a.billed_amt, a.billed_tax, b.product_id, b.product_name, sum(billed_tax), c.month_date, c.year_date, d.toplam  --bilgileri bir araya getirmek
from product_invoice a , product_information b, (select year_date, month_date from(
select EXTRACT(YEAR FROM invo_date_year) year_date,EXTRACT(month FROM invo_date_year) month_date  from product_invoice))c,
(select sum(billed_amt)+ sum(billed_tax) toplam, EXTRACT(month FROM invo_date_year)  from product_invoice
group by invo_date_year) d
where a.invoice_id = b.invoice_id
group by a.invoice_id, account_no, billed_amt, billed_tax, product_id, product_name, month_date, year_date, toplam
order by invoice_id;


CREATE TABLE data_account_product AS SELECT* FROM( -- bilgileri bir table e almak
select a.invoice_id, a.account_no, a.billed_amt, a.billed_tax, b.product_id, b.product_name, sum(billed_tax), c.month_date, c.year_date, d.toplam
from product_invoice a , product_information b, (select year_date, month_date from(
select EXTRACT(YEAR FROM invo_date_year) year_date,EXTRACT(month FROM invo_date_year) month_date  from product_invoice))c,
(select sum(billed_amt)+ sum(billed_tax) toplam, EXTRACT(month FROM invo_date_year)  from product_invoice
group by invo_date_year) d
where a.invoice_id = b.invoice_id
group by a.invoice_id, account_no, billed_amt, billed_tax, product_id, product_name, month_date, year_date, toplam
order by invoice_id);

select *from product_information;
select *from product_invoice;

select *from USER_constraints 
where lower(table_name) = 'product_information';


select *from data_account_product;
	
SELECT * FROM --oldu allaha sukur
(
SELECT account_no, month_date, sum(billed_tax) + sum(billed_amt) toplam3, max(product_name)
FROM data_account_product
group by month_date, account_no
order by account_no
)
PIVOT
(
sum(toplam3) total FOR (month_date) IN (1 AS first_month, 2 AS second_month, 3 AS third_month, 4 AS fourth_month, 5 AS fifth_month, 6 AS sixth_month,
 7 AS seventh_month, 8 AS eighth_month, 9 AS ninth_month, 10 AS tenth_month, 11 AS eleventh_month, 12 AS twelfth_month)
)order by account_no;
 select *from data_account_product;

DECLARE --EN COK TEKRARLANAN
SAYAC1 NUMBER DEFAULT 1;
SAYAC2 NUMBER DEFAULT 0;
EN_COK_TEKRARLANANA VARCHAR2(100);
PROD_COUNT_NUM NUMBER;
PROD_COUNT_NAME VARCHAR2(100);
BEGIN
    LOOP 
       SELECT COUNT(PRODUCT_ID) INTO PROD_COUNT_NUM FROM data_account_product
        WHERE PRODUCT_ID = SAYAC1;
        IF PROD_COUNT_NUM > SAYAC2 THEN 
           SAYAC2 := PROD_COUNT_NUM;
           SELECT DISTINCT PRODUCT_NAME INTO PROD_COUNT_NAME FROM data_account_product WHERE PRODUCT_ID = SAYAC1;
           EN_COK_TEKRARLANANA:= PROD_COUNT_NAME;
        END IF;
        SAYAC1 := SAYAC1 + 1;
    EXIT WHEN SAYAC1 >= 101;
    END LOOP; 
    DBMS_OUTPUT.PUT_LINE('THE MOST REPEATED :  ' || EN_COK_TEKRARLANANA || ',  '||SAYAC2 || '  TIMES REPEATED');
    EXCEPTION
      WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('YOU HAVE ERROR');
END;


DECLARE  --EN AZ TEKRARLANAN
SAYAC1 NUMBER DEFAULT 2;
SAYAC2 NUMBER;
EN_AZ_TEKRARLANANA VARCHAR2(100);
PROD_COUNT_NUM NUMBER;
PROD_COUNT_NAME VARCHAR2(100);
BEGIN
SELECT COUNT(PRODUCT_ID) INTO PROD_COUNT_NUM FROM data_account_product
    WHERE PRODUCT_ID = 1;
    SAYAC2 := PROD_COUNT_NUM;
    SELECT DISTINCT PRODUCT_NAME INTO PROD_COUNT_NAME FROM data_account_product WHERE PRODUCT_ID = 1;
    EN_AZ_TEKRARLANANA := PROD_COUNT_NAME;
    LOOP 
       SELECT COUNT(PRODUCT_ID) INTO PROD_COUNT_NUM FROM data_account_product
        WHERE PRODUCT_ID = SAYAC1;
        IF PROD_COUNT_NUM < SAYAC2 THEN 
           SAYAC2 := PROD_COUNT_NUM;
           SELECT DISTINCT PRODUCT_NAME INTO PROD_COUNT_NAME FROM data_account_product WHERE PRODUCT_ID = SAYAC1;
           EN_AZ_TEKRARLANANA:= PROD_COUNT_NAME;
        END IF;
        SAYAC1 := SAYAC1 + 1;
    EXIT WHEN SAYAC1 >= 101;
    END LOOP; 
    DBMS_OUTPUT.PUT_LINE('THE LEAST REPEATED :  ' || EN_AZ_TEKRARLANANA || ',  '||SAYAC2 || '  TIMES REPEATED');
    EXCEPTION
      WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('YOU HAVE ERROR');
END;




SELECT DISTINCT PRODUCT_NAME  FROM data_account_product WHERE PRODUCT_ID = 1;
UPDATE data_account_product
SET PRODUCT_ID = 101
WHERE PRODUCT_ID = 1 AND MONTH_DATE = 8;
select *from data_account_product;
