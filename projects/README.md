Prereq- entitle and provision:
- Cloud Foundry
- IAS
- HANA Database & HDI Container
- Build Code
- Build Apps
- Build Process Automation
- Build Work Zone (Advanced)
- Event Mesh - standard

To setup Smart Flash Sales in a new subaccount:

1. Import the destinations api_sandbox.json. You will need to add your credentials (used to connect to an S4 service on the API Hub).
2. Create a Build Code project from this repo
- Name: SmartFlashBackEnd
- Description: SAP Build Code Full-Stack Application to manage Flash Sales, using Event Mesh to integrate real-time update of electronic shelf label devices.
3. Edit the workflow URL for your environment ... (todo)
4. Enable discovery and deploy
5. Import, release and deploy the Action: Flash Sale Actions.mtar, Destination: smartflashsales-flashsalesSrv
6. Import the workflow: Smart Flash Approval.mtar
7. Release & Deploy the workflow, publish to library
8. Import the Build Apps project: S-Mart Flash Sale Manager.mtar
9. Import the Build Apps project: ESL Device Simulator.mtar

To demo:

1. Open both the S-Mart Flash Sale Manager and ESL Device Simulator projects
2. If you want to start with an empty device list, click Reset on the device simulator- will delete existing shelf labels (new ones will appear when a new sale is started).
3. Create some Flash Sale events, and select some products to add to the sale
4. Go to the Inbox and approve the events
5. Select "Ready events" from the filter dropdown
6. Press the Run button to run your events- devices should show up as they are received on the message bus
7. Select "Running events" from the filter dropdown
8. Press the Stop button to stop the events- shelf labels revert to the original price
