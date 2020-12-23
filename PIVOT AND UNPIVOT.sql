CREATE TABLE pivot_test (
  id            NUMBER,
  customer_id   NUMBER,
  product_code  VARCHAR2(5),
  quantity      NUMBER
);

INSERT INTO pivot_test VALUES (1, 1, 'A', 10);
INSERT INTO pivot_test VALUES (2, 1, 'B', 20);
INSERT INTO pivot_test VALUES (3, 1, 'C', 30);
INSERT INTO pivot_test VALUES (4, 2, 'A', 40);
INSERT INTO pivot_test VALUES (5, 2, 'C', 50);
INSERT INTO pivot_test VALUES (6, 3, 'A', 60);
INSERT INTO pivot_test VALUES (7, 3, 'B', 70);
INSERT INTO pivot_test VALUES (8, 3, 'C', 80);
INSERT INTO pivot_test VALUES (9, 3, 'D', 90);
INSERT INTO pivot_test VALUES (10, 4, 'A', 100);
COMMIT;

SELECT SUM(DECODE(product_code, 'A', quantity, 0)) AS a_sum_quantity,
       SUM(DECODE(product_code, 'B', quantity, 0)) AS b_sum_quantity,
       SUM(DECODE(product_code, 'C', quantity, 0)) AS c_sum_quantity
FROM   pivot_test
ORDER BY customer_id;


SELECT customer_id,
       SUM(DECODE(product_code, 'A', quantity, 0)) AS a_sum_quantity,
       SUM(DECODE(product_code, 'B', quantity, 0)) AS b_sum_quantity,
       SUM(DECODE(product_code, 'C', quantity, 0)) AS c_sum_quantity
FROM   pivot_test
GROUP BY customer_id
ORDER BY customer_id;

----------------------------------


SELECT * FROM --PIVOT DENEMESI AMA YENISI VAR ASAGIDA
(
SELECT ACCOUNT_NO, PRODUCT_NAME, SUM(BILLED_TAX) + SUM(BILLED_AMT) TOPLAM3, MONTH_DATE FROM DATA_ACCOUNT_PRODUCT
GROUP BY MONTH_DATE, ACCOUNT_NO, PRODUCT_NAME, MONTH_DATE
ORDER BY ACCOUNT_NO
)
PIVOT
(
MAX(PRODUCT_NAME) FOR (PRODUCT_NAME) IN ('product_1' , 'product_2', 'product_3', 'product_5', 'product_7')
)ORDER BY ACCOUNT_NO
FETCH FIRST 15 ROWS ONLY;

 SELECT *FROM DATA_ACCOUNT_PRODUCT;

 
---------------------------------------------------------
CREATE TABLE DATA_ACCOUNT_PRODUCT_COPY AS( --COLUMN SAYISI AZALTMAK ICIN
    SELECT ACCOUNT_NO, PRODUCT_NAME, YEAR_DATE , TOPLAM FROM DATA_ACCOUNT_PRODUCT
    );

 SELECT * FROM(--pivot denemessi
 SELECT ACCOUNT_NO, TOPLAM, PRODUCT_NAME, YEAR_DATE
 FROM DATA_ACCOUNT_PRODUCT)
 PIVOT
 ( 
    MIN(PRODUCT_NAME) FOR PRODUCT_NAME IN ('product_1', 'product_2', 'product_3', 'product_4')
 )
ORDER BY ACCOUNT_NO
FETCH FIRST 20 ROWS ONLY;


SELECT *FROM DATA_ACCOUNT_PRODUCT_COPY;
 SELECT ACCOUNT_NO, PRODUCT_NAME, YEAR_DATE, 
 MAX(DECODE(PRODUCT_NAME, 'product_1', toplam, 0)) as product_1_toplam,
 MAX(DECODE(PRODUCT_NAME, 'product_2', toplam, 0)) as product_2_toplam,
 MAX(DECODE(PRODUCT_NAME, 'product_3', toplam, 0)) as product_3_toplam
 FROM DATA_ACCOUNT_PRODUCT_COPY
 GROUP BY ACCOUNT_NO, PRODUCT_NAME, YEAR_DATE, TOPLAM
 ORDER BY ACCOUNT_NO;
 
 
