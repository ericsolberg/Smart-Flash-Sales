/**
 * 
 * @On(event = { "approveSale" }, entity = "flashsalesSrv.FlashSales")
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
/**
 *
 * @On(event = { "approveSale" }, entity = "flashsalesSrv.FlashSales")
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
 */

module.exports = async function(request) {
    const { FlashSales } = cds.entities;

    // Execute the query and destructure the result
    const [result] = await cds.run(request.query);
    // Ensure the ID is defined
    if (!result?.ID) {
        return request.error(400, 'FlashSales ID is missing.');
    }

    // Update the status_code to "Ready"
    await cds.run(UPDATE(FlashSales).set({ status_code: 'Ready' }).where({ ID: result.ID }));

    console.log(`FlashSale with ID ${result.ID} has been approved.`);

    return 'FlashSale approved and status updated to Ready.';
}