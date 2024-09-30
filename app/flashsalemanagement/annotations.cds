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
            $Type : 'UI.DataFieldForAction',
            Action : 'flashsalesSrv.startSale',
            Label : 'Start Sale',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'flashsalesSrv.endSale',
            Label : 'End Sale',
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
        },
        {
            $Type : 'UI.DataField',
            Value : description,
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
);

annotate service.FlashSales with {
    status @Common.FieldControl: #ReadOnly
};
annotate service.FlashSales with {
    startDate @Common.Label : 'Start Date'
};

