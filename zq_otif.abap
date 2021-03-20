@AbapCatalog.sqlViewName: 'ZQOTIF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@Analytics.query: true
@OData.publish: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Calculo de OTIF Query - Final'
define view ZQ_OTIF
  as select from ZC_OTIF 
{
    //ZC_OTIF3 
    SalesOrder as OrdemVenda, 
    CreationDate as DataOrdem, 
    RequestedDeliveryDate as DataEntrega, 
    OrderQuantity as QuantidadeOrdem, 
    CreationDate_Fat as DataFaturada, 
    FatQuantity as QuantidadeFaturada
    }
