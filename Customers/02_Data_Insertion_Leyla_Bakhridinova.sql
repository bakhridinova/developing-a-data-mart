insert into star.factcustomersales (dateid, customerid, totalamount, totalquantity, numberoftransactions)
select d.dateid,
       c.customerid,
       sum((od.unitprice * od.quantity) - (od.unitprice * od.quantity * od.discount)) as totalamount,
       sum(od.quantity)                                                               as totalquantity,
       count(distinct o.orderid)                                                      as numberoftransactions
from staging.stagingorders o
         join
     staging.stagingorderdetails od on o.orderid = od.orderid
         join
     star.dimdate d on d.date = o.orderdate
         join
     star.dimcustomer c on c.customerid = o.customerid
group by d.dateid,
         c.customerid;
