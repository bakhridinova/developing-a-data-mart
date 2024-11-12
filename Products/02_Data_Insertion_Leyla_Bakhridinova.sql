-- Populate FactProductSales
insert into star.factproductsales (dateid, productid, quantitysold, totalsales)
select d.dateid,
       p.productid,
       sod.quantity,
       (sod.quantity * sod.unitprice) as totalsales
from staging.stagingorderdetails sod
         join staging.stagingorders so on sod.orderid = so.orderid
         join staging.stagingproducts p on sod.productid = p.productid
         join star.dimdate d on so.orderdate = d.date;
