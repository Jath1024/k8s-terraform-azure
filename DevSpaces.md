Quickstart: Create a Kubernetes dev space with Azure Dev Spaces (Node.js)
In this guide, you will learn how to:

Set up Azure Dev Spaces with a managed Kubernetes cluster in Azure.
Iteratively develop code in containers using VS Code and the command line.
Debug code running in your cluster.
[!Note] If you get stuck at any time, see the Troubleshooting section, or post a comment on this page. You can also try the more detailed tutorial.

Prerequisites
An Azure subscription. If you don't have an Azure subscription, you can create a free account.

A Kubernetes cluster running Kubernetes 1.10.3, in the EastUS, CentralUS, WestUS2, WestEurope, CanadaCentral, or CanadaEast region, with Http Application Routing enabled.

Be sure to enable Http Application Routing.

Visual Studio Code, which you can download here.

Set up Azure Dev Spaces
Install the Azure CLI (version 2.0.38 or higher).
Set up Dev Spaces on your AKS cluster: az aks use-dev-spaces -g MyResourceGroup -n MyAKS
Download the Azure Dev Spaces extension for VS Code. Click Install once on the extension's Marketplace page, and again in VS Code.
Build and run code in Kubernetes
Download sample code from GitHub: https://github.com/Azure/dev-spaces

Change directory to the webfrontend folder: cd dev-spaces/samples/nodejs/getting-started/webfrontend

Generate Docker and Helm chart assets: azds prep --public

Build and run your code in AKS. In the terminal window from the webfrontend folder, run this command: azds up

Scan the console output for information about the URL that was created by the up command. It will be in the form:

Service 'webfrontend' port 'http' is available at <url>

Open this URL in a browser window, and you should see the web app load. As the container executes, stdout and stderr output is streamed to the terminal window.

[!Note] On first run, it can take several minutes for public DNS to be ready. If the public URL does not resolve, you can use the alternative http://localhost: URL that is displayed in the console output. If you use the localhost URL, it may seem like the container is running locally, but actually it is running in AKS. For your convenience, and to facilitate interacting with the service from your local machine, Azure Dev Spaces creates a temporary SSH tunnel to the container running in Azure. You can come back and try the public URL later when the DNS record is ready.

Update a content file
Azure Dev Spaces isn't just about getting code running in Kubernetes - it's about enabling you to quickly and iteratively see your code changes take effect in a Kubernetes environment in the cloud.

Locate the file ./public/index.html and make an edit to the HTML. For example, change the page's background color to a shade of blue:

<body style="background-color: #95B9C7; margin-left:10px; margin-right:10px;">
Save the file. Moments later, in the Terminal window you'll see a message saying a file in the running container was updated.

Go to your browser and refresh the page. You should see your color update.

What happened? Edits to content files, like HTML and CSS, don't require the Node.js process to restart, so an active azds up command will automatically sync any modified content files directly into the running container in Azure, thereby providing a fast way to see your content edits.

Test from a mobile device
Open the web app on a mobile device using the public URL for webfrontend. You may want to copy and send the URL from your desktop to your device to save you from entering the long address. When the web app loads in your mobile device, you will notice that the UI does not display properly on a small device.

To fix this, you'll add a viewport meta tag:

Open the file ./public/index.html

Add a viewport meta tag in the existing head element:

<head>
    <!-- Add this line -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
Save the file.

Refresh your device's browser. You should now see the web app rendered correctly.

This is an example of how some problems just aren't found until you test on the devices where an app is meant to be used. With Azure Dev Spaces, you can rapidly iterate on your code and validate any changes on target devices.

Update a code file
Updating server-side code files requires a little more work, because a Node.js app needs to restart.

In the terminal window, press Ctrl+C (to stop azds up).

Open the code file named server.js, and edit service's hello message:

res.send('Hello from webfrontend running in Azure!');
Save the file.

Run azds up in the terminal window.

This rebuilds the container image and redeploys the Helm chart. Reload the browser page to see your code changes take effect.

But there is an even faster method for developing code, which you'll explore in the next section.

Debug a container in Kubernetes
In this section, you'll use VS Code to directly debug our container running in Azure. You'll also learn how to get a faster edit-run-test loop.



Initialize debug assets with the VS Code extension
You first need to configure your code project so VS Code will communicate with our dev space in Azure. The VS Code extension for Azure Dev Spaces provides a helper command to set up debug configuration.

Open the Command Palette (using the View | Command Palette menu), and use auto-complete to type and select this command: Azure Dev Spaces: Prepare configuration files for Azure Dev Spaces.

This adds debug configuration for Azure Dev Spaces under the .vscode folder.



Select the AZDS debug configuration
To open the Debug view, click on the Debug icon in the Activity Bar on the side of VS Code.
Select Launch Program (AZDS) as the active debug configuration.


[!Note] If you don't see any Azure Dev Spaces commands in the Command Palette, ensure you have installed the VS Code extension for Azure Dev Spaces.

Debug the container in Kubernetes
Hit F5 to debug your code in Kubernetes!

Similar to the up command, code is synced to the dev space when you start debugging, and a container is built and deployed to Kubernetes. This time, the debugger is attached to the remote container.

[!Tip] The VS Code status bar will display a clickable URL.

Set a breakpoint in a server-side code file, for example within the app.get('/api'... in server.js. Refresh the browser page, or press the 'Say It Again' button, and you should hit the breakpoint and be able to step through code.

You have full access to debug information just like you would if the code was executing locally, such as the call stack, local variables, exception information, etc.

Edit code and refresh the debug session
With the debugger active, make a code edit; for example, modify the hello message again:

app.get('/api', function (req, res) {
    res.send('**** Hello from webfrontend running in Azure! ****');
});
Save the file, and in the Debug actions pane, click the Refresh button.



Instead of rebuilding and redeploying a new container image each time code edits are made, which will often take considerable time, Azure Dev Spaces will restart the Node.js process in between debug sessions to provide a faster edit/debug loop.

Refresh the web app in the browser, or press the Say It Again button. You should see your custom message appear in the UI.

Use NodeMon to develop even faster
The sample webfrontend project was configured to use nodemon, a popular tool for speeding up Node.js development that is fully compatible with Azure Dev Spaces.

Try the following steps:

Stop the VS Code debugger.
Click on the Debug icon in the Activity Bar on the side of VS Code.
Select Attach (AZDS) as the active debug configuration.
Hit F5.
In this configuration, the container is configured to start nodemon. When server code edits are made, nodemon automatically restarts the Node process, just like it does when you develop locally.

Edit the hello message again in server.js, and save the file.
Refresh the browser, or click the Say It Again button, to see your changes take effect!
Now you have a method for rapidly iterating on code and debugging directly in Kubernetes!
