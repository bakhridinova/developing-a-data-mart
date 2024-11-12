-- Top-Selling Products
select p.productname,
       sum(fps.quantitysold) as totalquantitysold,
       sum(fps.totalsales)   as totalrevenue
from star.factproductsales fps
         join star.dimproduct p on fps.productid = p.productid
group by p.productname
order by totalrevenue desc
limit 5;

-- Products With Low Stock Levels
select productid,
       productname,
       unitsinstock
from star.dimproduct
where unitsinstock < 10;
-- Assumes a critical low stock level threshold of 10 units

-- Sales Trends by Product Category
select c.categoryname,
       extract(year from d.date)  as year,
       extract(month from d.date) as month,
       sum(fps.quantitysold)      as totalquantitysold,
       sum(fps.totalsales)        as totalrevenue
from star.factproductsales fps
         join star.dimproduct p on fps.productid = p.productid
         join star.dimcategory c on p.categoryid = c.categoryid
         join star.dimdate d on fps.dateid = d.dateid
group by d.date, c.categoryname, year, month
order by year, month, totalrevenue desc;

-- Inventory Valuation
select p.productname,
       p.unitsinstock,
       p.unitprice,
       (p.unitsinstock * p.unitprice) as inventoryvalue
from star.dimproduct p
order by inventoryvalue desc;

-- Supplier Performance Based on Product Sales
select s.companyname,
       count(distinct fps.factsalesid) as numberofsalestransactions,
       sum(fps.quantitysold)           as totalproductssold,
       sum(fps.totalsales)             as totalrevenuegenerated
from star.factproductsales fps
         join star.dimproduct p on fps.productid = p.productid
         join star.dimsupplier s on p.supplierid = s.supplierid
group by s.companyname
order by totalrevenuegenerated desc;

