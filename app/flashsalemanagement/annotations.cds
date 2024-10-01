using flashsalesSrv as service from '../../srv/service';
using from '../annotations';

annotate service.FlashSales with @(
    UI.LineItem           : [
        {
            $Type: 'UI.DataField',
            Value: title,
        },
        {
            $Type      : 'UI.DataField',
            Value      : status_code,
            Criticality: status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
        },
        {
            $Type : 'UI.DataField',
            Value : description,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'flashsalesSrv.startSale',
            Label : 'Start Sale',
            Inline : true,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'flashsalesSrv.endSale',
            Label : 'End Sale',
            Inline : true,
        },
    ],
    UI.PresentationVariant: {
        GroupBy       : [status.name],
        Visualizations: ['@UI.LineItem', ]
    },
    UI.SelectionFields : [
        status_code,
        startDate,
    ],
    UI.FieldGroup #Main : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },
            {
                $Type : 'UI.DataField',
                Value : startDate,
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'flashsalesSrv.startSale',
                Label : 'Start Sale',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'flashsalesSrv.endSale',
                Label : 'End Sale',
            },
        ],
    },
);

annotate service.FlashSales with {
    status @Common.FieldControl: #ReadOnly
};
annotate service.FlashSales with {
    startDate @Common.Label : 'Start Date'
};

annotate service.SaleProducts with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Product',
            Value : product_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : product.productName,
        },
        {
            $Type : 'UI.DataField',
            Value : product.regularPrice,
        },
        {
            $Type : 'UI.DataField',
            Value : salePrice,
        },
        {
            $Type : 'UI.DataField',
            Value : product.shelfLocation,
        },
        {
            $Type : 'UI.DataField',
            Value : product.eslDevice,
        },
    ]
);

