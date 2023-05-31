.PHONY: init plan apply apply-approve destroy

init:
	terraform init -backend-config=config.aws.tfbackend

plan:
	terraform plan -var-file=terraform.tfvars

apply:
	terraform apply -var-file=terraform.tfvars

apply-approve:
	terraform apply -var-file=terraform.tfvars -auto-approve

destroy:
	terraform destroy -var-file=terraform.tfvars
