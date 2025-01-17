# Networking & Binary Computing Tasks
1. Build a Star Topology Using AWS VPC
	- Task:
		- Create a Virtual Private Cloud (VPC) with a hub-and-spoke (star) topology.
		- Use a central EC2 instance as a router (hub) and multiple other instances (spokes) in different subnets.
Instructions:
	- Design a VPC with:
		- One central EC2 instance (hub) in a public subnet.
		- At least 3 EC2 instances (spokes) in separate private subnets.
		- Configure the central hub to act as a NAT instance for spoke instances.
		- Test connectivity by sending pings or transferring files from spoke instances via the hub.
		- (Optional) Use AWS Transit Gateway instead of a NAT instance for scalable hub-and-spoke architecture.
	- Objective:
		- Understand the concepts of star topology.
		- Learn about routing and NAT in AWS.
 
2. Implement a Mesh Topology Using Peering Connections 
	- Task:
		- Create a fully connected mesh network using AWS VPC peering between multiple VPCs.
	- Instructions:
		- Create 3-5 VPCs in different regions or availability zones.
		- Establish VPC Peering between each pair of VPCs to form a fully meshed network.
		- Launch EC2 instances in each VPC and configure them to communicate with each other.
		- Document the routes and changes required in the route tables.
	- Objective:
		- Explore the concept of mesh topology and inter-VPC communication.
		- Learn about VPC peering, route tables, and cross-region networking.

- Deliverables for Students:
	- Network architecture diagrams.
	- Screenshots of AWS configurations (VPCs, routing tables, security groups, etc.).
- A short report describing:
	- Topology setup process.
	- Challenges faced.
	- Key learnings and observations.
 
## Task 1

1. Created a VPC named `Room2` to be used as a central hub with the CDR block `10.0.0.0/16`
2. Created 3 associated subnets for the VPC:
	1. `Room2-Public` w/ subnet CIDR block `10.0.1.0/24`
	2. `Room2-Private1` w/ subnet CIDR block `10.0.2.0/24`
	3. `Room2-Private2` w/ subnet CIDR block `10.0.3.0/24`
	4. `Room2-Private3` w/ subnet CIDR block `10.0.4.0/24`
3. Created an EC2 instance named `Room2-Hub` w/ a Public IP
4. Created an EC2 instance on each of the private subnets
5. Created an internet gateway & attached it to the VPC.
6. Created a NAT gateway & created new route tables for each of the subnet with the appropriate NAT gateway
7. Updated the security rules for the public & private EC2 instances to allow ICMP traffic via the internal network.

Challenges faced:

- Understanding the difference between NAT and Internet Gateway.
- Configuring route tables & understanding how to connect the NAT/Internet.
- Getting used to the AWS interface & how it works.

Pings: 

![image](./Task%20Screenshots/Star_Google_Ping.png)
![image](./Task%20Screenshots/Star_Internal_Ping.png)

Configurations:

![image](./Task%20Screenshots/Star_VPC.png)
![image](./Task%20Screenshots/Star_Hub_Rules.png)
![image](./Task%20Screenshots/Star_NAT.png)
![image](./Task%20Screenshots/Star_Priv_Rules.png)
![image](./Task%20Screenshots/Star_CIDR.png)

Topology:

![image](./Task%20Screenshots/Star_Topology.png)
