insert into star.factsales
(dateid, customerid, productid, employeeid, categoryid, shipperid, supplierid, quantitysold, unitprice, discount,
 taxamount)
select d.dateid,
       c.customerid,
       p.productid,
       e.employeeid,
       cat.categoryid,
       s.shipperid,
       sup.supplierid,
       od.quantity,
       od.unitprice,
       od.discount,
       (od.quantity * od.unitprice - od.discount) * 0.1 as taxamount
from staging.stagingorderdetails od
         join staging.stagingorders o on od.orderid = o.orderid
         join staging.stagingcustomers c on o.customerid = c.customerid
         join staging.stagingproducts p on od.productid = p.productid
         left join staging.stagingemployees e on o.employeeid = e.employeeid
         left join staging.stagingcategories cat on p.categoryid = cat.categoryid
         left join staging.stagingshippers s on o.shipvia = s.shipperid
         left join staging.stagingsuppliers sup on p.supplierid = sup.supplierid
         left join star.dimdate d on o.orderdate = d.date;
