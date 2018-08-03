resource "azurerm_resource_group" "k8s" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name                = "${var.cluster_name}"
    location            = "${azurerm_resource_group.k8s.location}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    dns_prefix          = "${var.dns_prefix}"
    kubernetes_version = "${var.kube_version}"

    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
        key_data = "${file("${var.ssh_public_key}")}"
        }
    }

    agent_pool_profile {
        name            = "default"
        count           = "${var.agent_count}"
        vm_size         = "Standard_D3_V2"
        os_type         = "Linux"
        os_disk_size_gb = 30
        #vnet_subnet_id  = ""
    }

    network_profile {
        network_plugin      = "azure"
        service_cidr        = "10.0.0.0/16"
        dns_service_ip      = "10.0.0.10"
        docker_bridge_cidr  = "172.17.0.1/16"
        #pod_cidr            = ""
    }

    service_principal {
        client_id     = "${var.client_id}"
        client_secret = "${var.client_secret}"
    }

    tags {
        Environment = "Development"
    }
}