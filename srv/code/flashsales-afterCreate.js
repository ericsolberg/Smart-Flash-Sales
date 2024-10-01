/**
 * 
 * @After(event = { "CREATE" }, entity = "flashsalesSrv.FlashSales")
 * @param {(Object|Object[])} results - For the After phase only: the results of the event processing
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = async function (results, request) {
	// Ensure results is an array for consistent processing
	const createdEntities = Array.isArray(results) ? results : [results];

	console.log("Triggering flash sale approval workflow")
	// Iterate over each created entity
	for (const entity of createdEntities) {
		if (entity && entity.ID) {
			// Get the ID of the newly created entity
			const flashSaleID = entity.ID;

			// Trigger a workflow (this is a placeholder for your actual workflow logic)
			await triggerWorkflow(flashSaleID);
		}
		else {
			console.log('No new entity identified')
		}
	}
};

/**
 * Placeholder function to trigger a workflow
 * @param {string} flashSaleID - The ID of the newly created FlashSales entity
 */
async function triggerWorkflow(flashSaleID) {
	const workflowContent = {
		"definitionId": "eu10.build-demos.smartflashprocesses.approveFlashSale",
		"context": {
			"flashSaleId": flashSaleID,
			"isActiveEntity": true,
			"appUrl": `https://build-demos.launchpad.cfapps.eu10.hana.ondemand.com/lcapsmartflashsales.smartflashsalesLaunchpad-1.0.0/launchpadPage.html#flashsalemanagement-open&/FlashSales(ID=${flashSaleID},IsActiveEntity=true)`
		}
	};
	const SPA_API = await cds.connect.to('spa_api');
	const result = await SPA_API.send(
		'POST',
		'/workflow/rest/v1/workflow-instances',
		JSON.stringify(workflowContent),
		{ "Content-Type": "application/json" }
	);
	console.log(`Workflow triggered for FlashSales ID: ${flashSaleID} result ${result}`);
	return result;
}