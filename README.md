## Commands:
- terraform init
- terraform plan
- terraform apply
- terraform destroy
- terraform apply --auto-approve
- terraform state list | show 
- terraform output
- terraform refresh

## Project1:
1. create vpc
1. Create internal gateway
1. Create custom route table
1. create a subnet
1. associate subnet with route table
1. create security group to allow port 22, 80, 443
1. create a network interface with an ip in the subnet that was created in step 4
1. assign an elastic ip to the network interface created in step 7
1. create ubuntu server and install/enable apache2

## Project2:
1. Create compute with miniconda
1. Execute user_data, download d2l
1. log userdata: tail -f /var/log/cloud-init-output.log

## Links:
https://www.youtube.com/watch?v=SLB_c_ayRMo

https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180
