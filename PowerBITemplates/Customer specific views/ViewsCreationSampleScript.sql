-- To ensure customer specific data is Access controlled, 
-- we recommend creating seperate views per customer.
-- The query and report shared in this folder provides 
-- a sample on how this can be done for a specific customer "demotenant3".
-- FOR EACH TENANT, INDIVIDUAL VIEWS MUST BE CREATED.


-- Before running the SQL query: 
--	*	Ensure you change the name of the tenant in the sql script, instead of 'demotenant3' provide the name of the tenant.
--	*	Ensure you change the view names the use in the sql script reflect the customer name. For example, vCustomerCurrentUsage
--		should be named v<customername>CurrentUsage. e.g. vDemoTenant3CurrentUsage. Similar changes for other views in the file.

-- Before publishing PBIX files:
--	*	Once the following views have been created, the sample power BI template file "CSPCustomerReport.pbix" must also be published
--		seperately for EACH tenant.
--	*	Ensure that the names of the customer specific views have been updated in the pbix file:
--		*	Open the pbix file (CSPCustomerReport.pbix) and go to �Edit queries� on the ribbon.
--		*	In the query editor window that opens up, first select the appropriate view on the left panel (under �queries�) and then click on �Advanced editor�.
--		*	In the advanced editor window, change the Item=�<value>� to the desired view in SQL. 
--			E.g. if the sql view name is �vdemotenant3BillingSummary� in SQL Server, 
--			that exact value should be updated as Item=�vdemotenant3BillingSummary�


CREATE VIEW vCustomerCurrentUsage AS
SELECT [Id]
      ,[Category]
      ,[QuantityUsed]
      ,[ResourceId]
      ,[ResourceName]
      ,[SubCategory]
      ,[TotalCost] * 1.15 as [EstimatedTotalCost]
      ,[Unit]
      ,[CustomerDomain]
      ,[SubscriptionName]
      ,[SubscriptionId]
      ,[SubscriptionStatus]
      ,[BillingStartDate]
      ,[BillingEndDate]
  FROM [dbo].[CspUsageData]
  WHERE
  [CustomerName] = 'demotenant3'

GO

CREATE VIEW vCustomerHistoricUsage AS
SELECT [Id]
      ,[UsageDate]
      ,[SubscriptionId]
      ,[SubscriptionName]
      ,[SubscriptionDescription]
      ,[ServiceName]
      ,[ServiceType]
      ,[ResourceGuid]
      ,[ResourceName]
      ,[Region]
      ,[ConsumedQuantity]
      ,[ChargeStartDate]
      ,[ChargeEndDate]
  FROM [dbo].[CspBillingData]
WHERE [CustomerCompanyName] = 'demotenant3'

GO

CREATE VIEW vCustomerBillingSummary AS
SELECT [Id]
      ,[ChargeEndDate]
      ,[ChargeStartDate]
      ,[ConsumedQuantity]
      ,[Currency]
      ,[PostTaxTotal] * 1.15 as [EstimatedCost]
      ,[Region]
      ,[ResourceGuid]
      ,[ResourceName]
      ,[ServiceName]
      ,[ServiceType]
      ,[Sku]
      ,[SubscriptionDescription]
      ,[SubscriptionId]
      ,[SubscriptionName]
  FROM [dbo].[CspSummaryData]
WHERE 
[CustomerCompanyName] = 'demotenant3'

GO