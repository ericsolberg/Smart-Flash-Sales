sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'flashsalemanagement/test/integration/FirstJourney',
		'flashsalemanagement/test/integration/pages/FlashSalesList',
		'flashsalemanagement/test/integration/pages/FlashSalesObjectPage'
    ],
    function(JourneyRunner, opaJourney, FlashSalesList, FlashSalesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('flashsalemanagement') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheFlashSalesList: FlashSalesList,
					onTheFlashSalesObjectPage: FlashSalesObjectPage
                }
            },
            opaJourney.run
        );
    }
);