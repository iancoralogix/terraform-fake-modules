# Terraform Fake Modules

### Quickly get started

For a fake AWS VPC:
```
source = "git@github.com:iangrunt/terraform-fake-modules.git//modules/aws/vpc?ref=main"

```

For a fake EKS cluster:
```
source = "git@github.com:iangrunt/terraform-fake-modules.git//modules/aws/eks?ref=main"

```

For a fake GCP VPC:
```
source = "git@github.com:iangrunt/terraform-fake-modules.git//modules/gcp/vpc?ref=main"

```

A collection of fake Terraform modules for example purposes when you need to demonstrate module behavior with tools like Terragrunt. Don't use these modules for testing, stubbing, or production. See [Terratest](https://terratest.gruntwork.io/) for how to effectively test Terraform.

## Non-semantic-versioning
Pre-v1 tags used are used for fake module changes. `v1.0.0` and `v2.0.0` are reserved for testing patterns around updating module versions, not updating the modules themselves.


<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->
