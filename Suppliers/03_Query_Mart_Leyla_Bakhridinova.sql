-- Supplier Performance Report
select s.companyname,
       count(fsp.purchaseid)        as totalorders,
       sum(fsp.totalpurchaseamount) as totalpurchasevalue,
       avg(fsp.numberofproducts)    as averageproductsperorder
from star.factsupplierpurchases fsp
         join star.dimsupplier s on fsp.supplierid = s.supplierid
group by s.companyname
order by totalorders desc, totalpurchasevalue desc;

-- Supplier Spending Analysis
select s.companyname,
       sum(fsp.totalpurchaseamount)         as totalspend,
       extract(year from fsp.purchasedate)  as year,
       extract(month from fsp.purchasedate) as month
from star.factsupplierpurchases fsp
         join star.dimsupplier s on fsp.supplierid = s.supplierid
group by s.companyname, year, month
order by totalspend desc;

-- Product Cost Breakdown by Supplier
select s.companyname,
       p.productname,
       avg(od.unitprice)               as averageunitprice,
       sum(od.quantity)                as totalquantitypurchased,
       sum(od.unitprice * od.quantity) as totalspend
from staging.stagingorderdetails od
         join staging.stagingproducts p on od.productid = p.productid
         join star.dimsupplier s on p.supplierid = s.supplierid
group by s.companyname, p.productname
order by s.companyname, totalspend desc;

-- Supplier Reliability Evaluation Report
select s.companyname,
       count(fsp.purchaseid)        as totaltransactions,
       sum(fsp.totalpurchaseamount) as totalspent
from star.factsupplierpurchases fsp
         join star.dimsupplier s on fsp.supplierid = s.supplierid
group by s.companyname
order by totaltransactions desc, totalspent desc;

-- Top Five Products by Total Purchases per Supplier
select s.companyname,
       p.productname,
       sum(od.unitprice * od.quantity) as totalspend
from staging.stagingorderdetails od
         join staging.stagingproducts p on od.productid = p.productid
         join star.dimsupplier s on p.supplierid = s.supplierid
group by s.companyname, p.productname
order by s.companyname, totalspend desc
limit 5;