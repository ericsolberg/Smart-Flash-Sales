/**
 * 
 * @On(event = { "ResetDevices" })
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
*/
module.exports = async function (request) {

	const LOG = cds.log('eslSimulator');

	const { ESLSim } = cds.entities;

	LOG.info("Resetting ESLSim");

	await DELETE.from(ESLSim);
}