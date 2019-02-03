# Fibonacci API

## Deploy
You will require following components and tools :

1. Terraform (v0.11.11)
2. Ansible (2.7.6)

Steps :

1. Create credential file for AWS in following format :
```
[Profile_Name]
aws_access_key_id = <your_id>
aws_secret_access_key = <your_access_key>
```
2. Put credential file path and Profile name into variables.tf or pass them later with terraform command.
3. Create Key-Pair in AWS console or you should have some already. Also put them into variables.
4. Clone repo somewhere.
5. Run terraform apply and wait. 

It will create ec2 t2.micro instance under default VPC and network with custom SG where 80 and 22 ports will be open.
Ansible will be invoked with local-exec at the end of the provisioning process, it will apply all neccasary configuration to machine.
In the output of terraform you'll find a "test link" to check if it's working.

You also can apply ansible playbook to any other CentOS instance :
```
ansible-playbook -u '<user>' -i <instance-ip>, --private-key <private-key> playbook.yml
```

## Using Api
Usage is pretty simple just pass any integer with n param to /api/fib, like that: ```<ip-adress>/api/fib?n=10``` and you will get 10th fibonacci number in this example :)