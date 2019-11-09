deploy:
	terraform init aws/base
	terraform apply -auto-approve aws/base

clean:
	terraform destroy aws/base