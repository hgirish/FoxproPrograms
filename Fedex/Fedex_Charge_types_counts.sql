select chargetype, count(chargetype) as counts, sum(amount)/count(chargetype) as Amount from fedex.chargedetails
where InvoiceNumber in (select InvoiceNumber from Fedex.Invoices where InvoiceDate > '20200101')
group by ChargeType order by Counts desc

