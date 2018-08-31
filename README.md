# Azure Kubernetes Service 
In this walkthrough you will use Terraform through the Azure Bash Cloud Shell to deploy an Azure Kubernetes Service, deploy and use Dev Spaces with VS Code and configure container health monitoring.

## Prerequisites
* Azure Subscription
* VS Code

## Azure Container Service (AKS)

### [STEP 1:](./K8S_setup_guide.md)

Azure Kubernetes Service (AKS) makes it simple to deploy a managed Kubernetes cluster in Azure. AKS reduces the complexity and operational overhead of managing Kubernetes by offloading much of that responsibility to Azure. As a hosted Kubernetes service, Azure handles critical tasks like health monitoring and maintenance for you. In addition, the service is free, you only pay for the agent nodes within your clusters, not for the masters.

[Source AKS Overview](https://docs.microsoft.com/en-gb/azure/aks/intro-kubernetes)

## Dev Spaces

### [STEP 2:](./DevSpaces_guide.md)

Azure Dev Spaces provides a rapid, iterative Kubernetes development experience for teams. With minimal dev machine setup, you can iteratively run and debug containers directly in Azure Kubernetes Service (AKS). Develop on Windows, Mac, or Linux using familiar tools like Visual Studio, Visual Studio Code, or the command line.

Azure Dev Spaces helps development teams be more productive on Kubernetes in the following ways:

Minimize local dev machine setup for each team member and work directly in AKS, a managed Kubernetes cluster in Azure.
Rapidly iterate and debug code directly in Kubernetes using Visual Studio 2017 or Visual Studio Code.
Generate Docker and Kubernetes configuration-as-code assets for you to use from development through to production.
Share a managed Kubernetes cluster with your team and collaboratively work together. Develop your code in isolation, and do end-to-end testing with other components without replicating or mocking up dependencies.

[Source Dev Spaces Overview](https://docs.microsoft.com/en-us/azure/dev-spaces/azure-dev-spaces)

## AKS Health

### STEP 3: 

Container health gives you performance monitoring ability by collecting memory and processor metrics from controllers, nodes, and containers that are available in Kubernetes through the Metrics API. After you enable container health, these metrics are automatically collected for you through a containerized version of the Log Analytics agent for Linux and stored in your Log Analytics workspace. The included pre-defined views display the residing container workloads and what affects the performance health of the Kubernetes cluster so that you can:

* Identify containers that are running on the node and their average processor and memory utilization. This knowledge can help you identify resource bottlenecks.
* Identify where the container resides in a controller or a pod. This knowledge can help you view the controller's or pod's overall performance.
* Review the resource utilization of workloads running on the host that are unrelated to the standard processes that support the pod.
* Understand the behavior of the cluster under average and heaviest loads. This knowledge can help you identify capacity needs and determine the maximum load that the cluster can sustain.

[Source AKS Health Overview](https://docs.microsoft.com/en-us/azure/monitoring/monitoring-container-health)
