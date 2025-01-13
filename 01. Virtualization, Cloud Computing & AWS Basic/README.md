# Virtualization, Cloud Computing & AWS Basic Tasks


1. Deploy a VM and get the memory & disk usage of the VM and host machine.
2. Get the memory & disk usage of the host machine before & after running the `hello-world` Docker container.
3. Draw the virtualization stack. 


## Task 1
> Disclaimer: instead of VirtualBox, I used QEMU with  Virtual Machine Manager, as it's what I already had installed & typically use.

For this task, I quickly set up an Ubuntu Server VM & this was the memory & disk size that could be seen via the GUI:

![Image](./Task%20Screenshots/VM_Mem.png)
![Image](./Task%20Screenshots/VM_Storage.png)

Here's the terminal information for the host:

![Image](./Task%20Screenshots/VM_Host_Mem_Storage_Before.png)

In this case it's important to note that the main OS and boot partition are separate, so the bulk of the data is hosted on `/dev/mapper/otter--vg-root`, as opposed to the usual `sda1`.

When checking the VM data from inside the VM itself, this is what can be seen:

![Image](./Task%20Screenshots/VM_CLI_Mem_Storage.png)

Here, same as with the host, the bulk of the data is not held in `/dev/sda1`.

And here is the host data whilst the VM is running:

![Image](./Task%20Screenshots/VM_Host_Mem_Storage_After.png)

### Results
- Host:
	* Free memory: 3.1 GB -> 2.3 GB
	* Free disk space: 204 GB -> 204 GB
- VM:
 	* Free memory: 3.5 GB
	* Free disk space: 24 GB
	
Overall, when the VM is running, we can see that it has no impact on the host's disk space due to the fact that there wasn't a significant amount of data created when starting the VM. Furthermore, the host system experienced a memory reduction of 0.8 GB after starting the VM, which aligns closely with the VM's memory usage (~ 0.5 GB).

## Task 2

Here's the system information before running the Docker container:

![Image](./Task%20Screenshots/Docker_Before.png)

And this is after:

![Image](./Task%20Screenshots/Docker_After.png)

### Results
In this case, we can see that there weren't any significant changes in the disk space, nor memory usage. This would likely be due to the fact that this container is one that does not persistently run & the end result is that it just prints information for the user.

## Task 3
![Image](./Task%20Screenshots/Individual_Task.png)