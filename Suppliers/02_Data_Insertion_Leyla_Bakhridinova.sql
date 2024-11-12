insert into star.factsupplierpurchases (supplierid, totalpurchaseamount, purchasedate, numberofproducts)
select p.supplierid,
       sum(od.unitprice * od.quantity) as totalpurchaseamount,
       current_date                    as purchasedate, -- Simplified for demonstration purposes
       count(distinct od.productid)    as numberofproducts
from staging.stagingorderdetails od
         join staging.stagingproducts p on od.productid = p.productid
group by p.supplierid;
