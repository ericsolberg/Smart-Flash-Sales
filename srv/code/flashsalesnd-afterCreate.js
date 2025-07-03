import redir from './flashsales-afterCreate.js';

/**
 * 
 * @After(event = { "CREATE" }, entity = "flashsalesSrv.FlashSales")
 * @param {(Object|Object[])} results - For the After phase only: the results of the event processing
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = redir;