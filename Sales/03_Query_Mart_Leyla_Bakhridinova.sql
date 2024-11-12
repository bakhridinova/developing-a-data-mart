-- Aggregate Sales by Month and Category
select d.month,
       d.year,
       c.categoryname,
       sum(fs.totalamount) as totalsales
from star.factsales fs
         join star.dimdate d on fs.dateid = d.dateid
         join star.dimcategory c on fs.categoryid = c.categoryid
group by d.month, d.year, c.categoryname
order by d.year, d.month, totalsales desc;

-- Top-Selling Products per Quarter
select d.quarter,
       d.year,
       p.productname,
       sum(fs.quantitysold) as totalquantitysold
from star.factsales fs
         join star.dimdate d on fs.dateid = d.dateid
         join star.dimproduct p on fs.productid = p.productid
group by d.quarter, d.year, p.productname
order by d.year, d.quarter, totalquantitysold desc
limit 5;

-- Sales Performance by Employee
select e.firstname,
       e.lastname,
       count(fs.salesid) as numberofsales,
       sum(fs.totalamount)   as totalsales
from star.factsales fs
         join star.dimemployee e on fs.employeeid = e.employeeid
group by e.firstname, e.lastname
order by totalsales desc;

-- Customer Sales Overview
select cu.companyname,
       sum(fs.totalamount)            as totalspent,
       count(distinct fs.salesid) as transactionscount
from star.factsales fs
         join star.dimcustomer cu on fs.customerid = cu.customerid
group by cu.companyname
order by totalspent desc;

-- Monthly Sales Growth Rate
with monthlysales as (select d.year,
                             d.month,
                             sum(fs.totalamount) as totalsales
                      from star.factsales fs
                               join star.dimdate d on fs.dateid = d.dateid
                      group by d.year, d.month),
     monthlygrowth as (select year,
                              month,
                              totalsales,
                              lag(totalsales) over (order by year, month) as previousmonthsales,
                              (totalsales - lag(totalsales) over (order by year, month)) /
                              lag(totalsales) over (order by year, month) as growthrate
                       from monthlysales)
select *
from monthlygrowth;