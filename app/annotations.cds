using { flashsalesSrv } from '../srv/service.cds';

annotate flashsalesSrv.FlashSales with @UI.HeaderInfo: {
  TypeName: 'Flash Sale',
  TypeNamePlural: 'Flash Sales'
};
annotate flashsalesSrv.FlashSales with {
  startDate @Common.Label: 'Start Date';
  title @Common.Label: 'Title';
  description @Common.Label: 'Description';
  status @Common.Label: 'Status';
  saleProducts @Common.Label: 'Sale Products'
};
annotate flashsalesSrv.FlashSales with {
  status @Common.Text : { $value: status.name, ![@UI.TextArrangement]: #TextOnly };
};
annotate flashsalesSrv.FlashSales with {
  status @Common.ValueListWithFixedValues;
};
annotate flashsalesSrv.FlashSales with @UI.SelectionFields : [
 status_code,
 startDate
];
annotate flashsalesSrv.FlashSales with @UI.LineItem : [
    { $Type: 'UI.DataField', Value: startDate },
    { $Type: 'UI.DataField', Value: title },
    { $Type: 'UI.DataField', Value: status_code, Criticality: status.criticality },
];
annotate flashsalesSrv.FlashSales with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
    { $Type: 'UI.DataField', Value: startDate },
    { $Type: 'UI.DataField', Value: title },
    { $Type: 'UI.DataField', Value: description },
    { $Type: 'UI.DataField', Value: status_code }
]};
annotate flashsalesSrv.FlashSales with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' },
  { $Type : 'UI.ReferenceFacet', ID : 'SaleProducts', Target : 'saleProducts/@UI.LineItem' }
];
annotate flashsalesSrv.SaleProducts with {
  product @Common.ValueList: {
    CollectionPath: 'Products',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: product_ID,
        ValueListProperty: 'ID'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'productID'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'productName'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'regularPrice'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'shelfLocation'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'eslDevice'
      },
    ],
  }
};
annotate flashsalesSrv.SaleProducts with {
  flashSales @Common.ValueList: {
    CollectionPath: 'FlashSales',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: flashSales_ID,
        ValueListProperty: 'ID'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'startDate'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'title'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'description'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'status'
      },
    ],
  }
};
annotate flashsalesSrv.SaleProducts with @UI.HeaderInfo: {
  TypeName: 'Sale Product',
  TypeNamePlural: 'Sale Products',
  Title: { Value: salePrice }
};
annotate flashsalesSrv.SaleProducts with {
  ID @UI.Hidden
};
annotate flashsalesSrv.SaleProducts with @UI.Identification: [{ Value: salePrice }];
annotate flashsalesSrv.SaleProducts with {
  salePrice @Common.Label: 'Sale Price';
  product @Common.Label: 'Product';
  flashSales @Common.Label: 'Flash Sale'
};
annotate flashsalesSrv.SaleProducts with @UI.SelectionFields: [
  product_ID,
  flashSales_ID
];
annotate flashsalesSrv.SaleProducts with @UI.LineItem: [
    { $Type: 'UI.DataField', Value: ID },
    { $Type: 'UI.DataField', Value: salePrice },
    { $Type: 'UI.DataField', Label: 'Product', Value: product_ID }
];
annotate flashsalesSrv.SaleProducts with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
    { $Type: 'UI.DataField', Value: ID },
    { $Type: 'UI.DataField', Value: salePrice },
    { $Type: 'UI.DataField', Label: 'Product', Value: product_ID }
]};
annotate flashsalesSrv.SaleProducts with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];
annotate flashsalesSrv.Products with @UI.HeaderInfo: {
  TypeName: 'Product',
  TypeNamePlural: 'Products'
};
annotate flashsalesSrv.Products with {
  productID @Common.Label: 'Product ID';
  productName @Common.Label: 'Product Name';
  regularPrice @Common.Label: 'Regular Price';
  shelfLocation @Common.Label: 'Shelf Location';
  eslDevice @Common.Label: 'Esl Device'
};
annotate flashsalesSrv.Products with @UI.LineItem: [
    { $Type: 'UI.DataField', Value: productID },
    { $Type: 'UI.DataField', Value: productName },
    { $Type: 'UI.DataField', Value: regularPrice },
    { $Type: 'UI.DataField', Value: shelfLocation },
    { $Type: 'UI.DataField', Value: eslDevice }
];
annotate flashsalesSrv.Products with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
    { $Type: 'UI.DataField', Value: productID },
    { $Type: 'UI.DataField', Value: productName },
    { $Type: 'UI.DataField', Value: regularPrice },
    { $Type: 'UI.DataField', Value: shelfLocation },
    { $Type: 'UI.DataField', Value: eslDevice }
]};
annotate flashsalesSrv.Products with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];