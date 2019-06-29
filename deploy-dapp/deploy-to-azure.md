In the previous [tutorials](https://kauri.io/collection/5b8e401ee727370001c942e3) we have seen how to develop a full stack blockchain dapp. Now we will deploy a dapp using Microsoft Workbench Blockchain. This article illustrates the complete steps to deploy a blockchain instance and deploy a blockchain dapp.

# Deploy Blockchain Workbench

Blockchain Workbench allows the user to deploy a blockchain ledger along with a set of Azure services used to build a blockchain dapp. Once deployed, Blockchain Workbench provides access to client apps to create and manage users and blockchain applications.

The following steps highlight on how to deploy blockchain workbench:
1.  Sign in to the  [Azure portal](https://portal.azure.com/). If you don't have an account, create one and select a suitable service/subscription plan. You can try the "free plan" for 30 days to test the waters.
2.  In the left pane, select  **Create a resource**. Search for  `Azure Blockchain Workbench`  in the  **Search the Marketplace**  search bar.  Select  **Azure Blockchain Workbench** and then **Create**
3. Complete the basic settings and click  **OK** .
4.  In  **Advanced Settings**, choose if you want to create a new blockchain network or use an existing blockchain network and select  **OK**  to finish Advanced Settings. To create new blockchain network, select **Create New** option under *Blockchain Network* and then choose the *Azure Blockchain Service Pricing Tier* and *Azure Active Directory Settings*. For using existing blockchain network, select **Use Existing** under *Blockchain Network* and set the *Ethereum RPC Endpoint*. Then choose *Azure Active Directory Settings* and *VM Selection*.
5.  Verify whelther your parameters are accurate and click **Create** to deploy your Azure Blockchain Workbench.

Once the deployment of the Blockchain Workbench has completed which takes around 90 minutes, a new *resource group* is created contains your Blockchain Workbench resources. Blockchain Workbench services are accessed through a web URL. The following steps show you how to retrieve the web URL of the deployed framework:

1. In the left-hand navigation pane, select **Resource groups**
2.   Choose the resource group name you specified when deploying Blockchain Workbench.
3.  Select the  **TYPE**  column heading to sort the list alphabetically by type.
4.  There are two resources with type  **App Service**. Select the resource of type  **App Service**  _without_  the "-api" suffix.
5. In the App Service **Essentials** section, copy the **URL** value, which represents the web URL to your deployed Blockchain Workbench.

### Azure AD configuration
Azure Blockchain Workbench requires Azure AD configuration and application registrations. You can choose to do the Azure AD  [configurations manually](https://docs.microsoft.com/en-gb/azure/blockchain/workbench/deploy#azure-ad-configuration)  before deployment or run a script post deployment. If you are redeploying Blockchain Workbench, see  [Azure AD configuration](https://docs.microsoft.com/en-gb/azure/blockchain/workbench/deploy#azure-ad-configuration)  to verify your Azure AD configuration.

# Deploy Blockchain applications

To create a blockchain dapp refer to previous [tutorials](https://kauri.io/collection/5b8e401ee727370001c942e3) on how to create a full stack blockchain dapp. Create a configuration file with ``*json`` extension to represent the workflow, application roles and interaction with the blockchain application. View a sample configuration file [here](https://docs.microsoft.com/en-gb/azure/blockchain/workbench/create-app#configuration-file).

To add a blockchain application to Blockchain Workbench, you upload the configuration and smart contract files to define the application.

1.  In a web browser, navigate to the Blockchain Workbench web address which is in the format  `https://{workbench URL}.azurewebsites.net/`.
2. Sign in as a  [Blockchain Workbench administrator](https://docs.microsoft.com/en-gb/azure/blockchain/workbench/manage-users#manage-blockchain-workbench-administrators) to assign roles to users.
3.  Select  **Applications**  >  **New**. The  **New application**  pane is displayed.
4.  Select  **Upload the contract configuration**  >  **Browse**  to locate the configuration file you created. The configuration file is automatically validated. Select the  **Show**  link to display validation errors. Fix validation errors before you deploy the application. Repeat the same for smart contract code file by selecting **Upload the contract code**  >  **Browse**  to locate the smart contract code file.
5.  Click  **Deploy**  to create the blockchain application based on the configuration and smart contract files.

Deployment of the blockchain application takes a few minutes. When deployment is finished, the new application is displayed in  **Applications**.

To create a new contract, you need to be a member specified as a contract  **initiator**. For information defining application roles and initiators for the contract, see  [workflows in the configuration overview](https://docs.microsoft.com/en-gb/azure/blockchain/workbench/configuration#workflows). For information on assigning members to application roles, see  [add a member to application](https://docs.microsoft.com/en-gb/azure/blockchain/workbench/manage-users#add-member-to-application).

1.  In Blockchain Workbench application section, select the application tile that contains the contract you want to create. A list of active contracts is displayed.
2.  To create a new contract, select  **New contract**.
3. The **New contract** pane is displayed. Specify the initial parameters values. Select **Create**.

### Modifying smart contract

Depending on the state the contract is in, members can take actions to transition to the next state of the contract. Actions are defined as [transitions](https://docs.microsoft.com/en-gb/azure/blockchain/workbench/configuration#transitions) within a [state](https://docs.microsoft.com/en-gb/azure/blockchain/workbench/configuration#states). Members belonging to an allowed application or instance role for the transition can take the action.

1.  In Blockchain Workbench application section, select the application tile that contains the contract to take the action.
2.  Select the contract in the list. Details about the contract are displayed in different sections
3.  In the  **Action**  section, select  **Take action**.
4.  The details about the current state of the contract are displayed in a pane. Choose the action you want to take in the drop-down.
5.  Select  **Take action**  to initiate the action.  
6. If parameters are required for the action, specify the values for the action.
7. Select **Take action** to execute the action.

# Conclusion

Now that the blockchain dapp is deployed to the workbench, the users can now interact with it. The developer(s) can modify the existing deployment and make timely releases.
