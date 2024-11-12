-- Customer Sales Overview
select c.customerid,
       c.companyname,
       sum(fcs.totalamount)          as totalspent,
       sum(fcs.totalquantity)        as totalitemspurchased,
       sum(fcs.numberoftransactions) as transactioncount
from star.factcustomersales fcs
         join
     star.dimcustomer c on fcs.customerid = c.customerid
group by c.customerid, c.companyname
order by totalspent desc;

-- Top Five Customers by Total Sales
select c.companyname,
       sum(fcs.totalamount) as totalspent
from star.factcustomersales fcs
         join
     star.dimcustomer c on fcs.customerid = c.customerid
group by c.companyname
order by totalspent desc limit 5;

-- Customers by Region
select c.region,
       count(*)             as numberofcustomers,
       sum(fcs.totalamount) as totalspentinregion
from star.factcustomersales fcs
         join
     star.dimcustomer c on fcs.customerid = c.customerid
group by c.region
order by numberofcustomers desc;

-- Customer Segmentation Analysis
select c.customerid,
       c.companyname,
       case
           when sum(fcs.totalamount) > 10000 then 'VIP'
           when sum(fcs.totalamount) between 5000 and 10000 then 'Premium'
           else 'Standard'
           end as customersegment
from star.factcustomersales fcs
         join
     star.dimcustomer c on fcs.customerid = c.customerid
group by c.customerid, c.companyname
order by sum(fcs.totalamount) desc;