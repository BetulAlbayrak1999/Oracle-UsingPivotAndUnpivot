declare --product_invoice tablosu doldurmak icin
counter number := 1;
rowcount number :=1;
begin 
 loop
  insert into product_invoice (invoice_id, account_no, billed_amt, invo_date_year)
  values                      (rowcount, rowcount+3, trunc(DBMS_RANDOM.VALUE(50, 400)),sysdate);
  rowcount := rowcount+1;
  counter := counter+1;
  exit when counter > 100;
  end loop;
end;

select *from product_information;
select *from product_invoice;

declare--product_information tablosu doldurmak icin
counter number := 1;
rowcount number :=1;
begin 
 loop
   insert into product_information(product_id,invoice_id, product_name)
   values                         (rowcount, rowcount, 'product_'|| rowcount);
  rowcount := rowcount+1;
  counter := counter+1;
  exit when counter > 100;
  end loop;
end;

 




