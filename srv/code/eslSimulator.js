module.exports = async function (msg) {

    const LOG = cds.log('eslSimulator')

    const { ESLSim } = cds.entities;

    const eslData = JSON.parse(msg.data);
    LOG.info("> Received: ", eslData)

    // see if the ESL record is already in the database
    const esl = await SELECT.one().from(ESLSim).where({ eslDevice: eslData.eslDevice });
    if (esl) {
        // update the existing record
        await UPDATE(ESLSim, esl.ID).with(eslData);
        LOG.info("Updated esl: ", { ID: esl.ID, ...eslData });
    }
    else {
        // insert new record
        const newEsl = { ID: cds.utils.uuid(), ...eslData };
        await INSERT.into(ESLSim).entries(newEsl);
        LOG.info("Inserted esl: ", newEsl);
    }
    const test = await SELECT.one().from(ESLSim).where({ eslDevice: eslData.eslDevice });
    LOG.info("Test: ", test);
};