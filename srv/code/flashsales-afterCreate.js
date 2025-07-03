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
 * Triggers a workflow for approving a flash sale.
 *
 * @param {string} flashSaleID - The ID of the flash sale for which the workflow is triggered.
 * @returns {Promise<Object>} - The result of the workflow trigger operation.
 */
async function triggerWorkflow(flashSaleID) {
	// Define the content for the workflow, including the definition ID and context
	const workflowContent = {
		"definitionId": "eu10.build-demos.smartflashprocesses.approveFlashSale",
		"context": {
			"flashSaleId": flashSaleID,
			"isActiveEntity": true,
			"flashSaleId": flashSaleID, // Pass the flash sale ID to the workflow context
			"isActiveEntity": true, // Indicate that this is an active entity
			// Construct the application URL for the flash sale management page
			"appUrl": `https://build-demos.launchpad.cfapps.eu10.hana.ondemand.com/lcapsmartflashsales.smartflashsalesLaunchpad-1.0.0/launchpadPage.html#flashsalemanagement-open&/FlashSales(ID=${flashSaleID},IsActiveEntity=true)`
		}
	};

	// Connect to the SPA API service
	const SPA_API = await cds.connect.to('spa_api');

	// Send a POST request to trigger the workflow instance with the defined content
	const result = await SPA_API.send(
		'POST',
		'/workflow/rest/v1/workflow-instances',
		JSON.stringify(workflowContent),
		{ "Content-Type": "application/json" }
		'/workflow/rest/v1/workflow-instances', // Endpoint for creating workflow instances
		JSON.stringify(workflowContent), // Convert the workflow content to a JSON string
		{ "Content-Type": "application/json" } // Set the content type to application/json
	);

	// Log the result of the workflow trigger operation
	console.log(`Workflow triggered for FlashSales ID: ${flashSaleID} result ${result}`);

	// Return the result of the workflow trigger operation
	return result;
}