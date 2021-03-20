@AbapCatalog.sqlViewName: 'ZCOTIF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@Analytics.dataCategory: #CUBE
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Calculo de OTIF CUBO - Final'
define view ZC_OTIF
  as select from ZI_BillingDocumentItemCube (P_ExchangeRateType: 'M', P_DisplayCurrency: 'BRL') as Fat
    inner join   I_SalesOrderItemCube( P_ExchangeRateType: 'M' , P_DisplayCurrency: 'BRL' )     as Ordem on  Ordem.SalesOrder               = Fat.SalesDocument
                                                                                                         and Ordem.SalesOrderItem           = Fat.BillingDocumentItem
                                                                                                         and Ordem.SalesOrderType           = 'YBMO'
                                                                                                         and Fat.BillingDocumentType        = 'YBMO'
                                                                                                         and Fat.BillingDocumentIsCancelled = ''
                                                                                                         and Fat.CancelledBillingDocument   = ''
{
  Ordem.SalesOrder                   as SalesOrder,
  max( Ordem.CreationDate )          as CreationDate,
  max( Ordem.RequestedDeliveryDate ) as RequestedDeliveryDate,
  @DefaultAggregation: #SUM
  sum( Ordem.OrderQuantity )         as OrderQuantity,
  max( Fat.CreationDate )            as CreationDate_Fat,
  @DefaultAggregation: #SUM
  sum( Fat.BillingQuantity )         as FatQuantity

}
group by
  Ordem.SalesOrder
