create or replace function calculate_tax --urunun vergisi hesaplamak icin
(p_invoice_id number)
return number
is
v_billed_tax number;
begin
  select billed_amt into v_billed_tax from product_invoice
  where invoice_id = p_invoice_id;
  return ((v_billed_tax*18)/100);
  
 exception
 when others then 
     dbms_output.put_line(SQLCODE||' -ERROR- '||SQLERRM);
     dbms_output.put_line('calculate_tax has error');
end;

declare 
begin 
    for i in 1..100 loop
        update product_invoice 
        set billed_tax = nvl(calculate_tax(i), 0)
        where invoice_id = i;
    end loop;
   exception
   when others then 
     dbms_output.put_line(SQLCODE||' -ERROR- '||SQLERRM);
end; 

select *from product_invoice;
