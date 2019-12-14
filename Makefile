deploy:
	terraform init aws/base
	terraform apply -auto-approve aws/base

deploy-nat:
	terraform init aws/igw
	terraform apply -auto-approve aws/igw


clean:
	terraform destroy aws/base