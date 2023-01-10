## Project Overview

Amazon Virtual Private Cloud (Amazon VPC) enables you to launch AWS resources into a virtual network that you’ve defined. A subnet is a range of IP addresses within the VPC. Subnets can be either public with a gateway to the internet or private.

Instances launched in a public subnet can send outbound traffic to the internet while instances launched in the private subnet can only do so via a network address translation (NAT) gateway in a public subnet.

Naturally private subnets are more secure, as the management ports aren’t exposed to the internet. Typically in a modular web application, the front end web server will reside within the public subnet while the backend database is in the private subnet.

Instances within the same VPC can connect to one another via their private IP addresses, as such it is possible to connect to an instance in a private subnet from an instance in a public subnet; otherwise known as a bastion host.

In this project, the use of an instance as a bastion host will be used to access two private instances in two private subnets and configure nginx web server in them using ansible configuration tool. It will be attached to a NAT gateway in a public subnet in order to access internet and a load balancer will be attached to direct traffic accross the private instances.

## TASKS

- Set up 2 EC2 instances on AWS(use the free tier instances)
- Deploy an Nginx web server on these instances(you are free to use Ansible)
- Set up an ALB(Application Load balancer) to route requests to your EC2 instances
- Make sure that each server displays its own Hostname or IP address. You can use any programming language of your choice to display this.

### Important points to note:

- The web servers can not be accessed through their respective IP addresses. Access must be only via the load balancer
- A logical network should be defined on the cloud for the servers.
- EC2 instances must be launched in a private network.
- Instances should not be assigned public IP addresses.
- A custom domain name(from a domain provider e.g. Route53) or the ALB’s domain name must be submitted.

## STEPS

### 1. Create a VPC with two public and private subnets

- Click on AWS Services and go to Networking and Content Delivery
- Then click on VPC where the arrow is pointing at

![a1](./snaps/a1.jpg)

Click on create VPC to setup the environment

![a2](./snaps/a2.jpg)

Click on VPC and more to automatically setup a VPC and its subnets

![a3](./snaps/a3.jpg)

- Mark the auto-generate botton.
- Provide a VPC name.
- Put the number of AZs to be two. This is to ensure high availability of your servers incase there is a downtime in one Availability Zone.
- You can see on the right, the subnets are been setup automatically.

![a4](./snaps/a4.jpg)

- Number of public subnet should be two.
- Number of private subnet should be two.
- Choose NAT gateways in 1 AZ.

![a5](./snaps/a5.jpg)

The other settings should be left in default and create VPC.

![a6](./snaps/a6.jpg)

It is setting up the environment and will take 30secs to 1mins to finish up.

![a7](./snaps/a7.jpg)

### 2. Lanuch EC2 instances in both public and private subnet

- Go to AWS services
- Click on compute
- Click on EC2

![a8](./snaps/a8.jpg)
