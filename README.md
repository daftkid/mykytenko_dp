Bachelor Diploma Project
by Oleksandr Mykytenko (daft_kiD)

Source tree:
```
.
├── app
├── puppet
└── tf
    ├── manual_resources.tf
    ├── modules
    │   ├── bastion
    │   │   ├── elb.tf
    │   │   ├── iam.tf
    │   │   ├── outputs.tf
    │   │   ├── scaling.tf
    │   │   ├── security.tf
    │   │   ├── templates
    │   │   │   └── userdata.tpl
    │   │   ├── templates.tf
    │   │   └── variables.tf
    │   ├── jenkins
    │   │   ├── elb.tf
    │   │   ├── iam.tf
    │   │   ├── outputs.tf
    │   │   ├── route53.tf
    │   │   ├── s3.tf
    │   │   ├── scaling.tf
    │   │   ├── security.tf
    │   │   ├── templates
    │   │   │   └── userdata.tpl
    │   │   ├── templates.tf
    │   │   └── variables.tf
    │   ├── vpc
    │   │   ├── dns.tf
    │   │   ├── internet_gateway.tf
    │   │   ├── nat.tf
    │   │   ├── network_acl.tf
    │   │   ├── outputs.tf
    │   │   ├── route_table.tf
    │   │   ├── subnet.tf
    │   │   ├── variables.tf
    │   │   └── vpc.tf
    │   └── webapp
    │       ├── efs.tf
    │       ├── elb.tf
    │       ├── iam.tf
    │       ├── outputs.tf
    │       ├── rds.tf
    │       ├── route53.tf
    │       ├── s3.tf
    │       ├── scaling.tf
    │       ├── security.tf
    │       ├── templates
    │       │   └── userdata.tpl
    │       ├── templates.tf
    │       └── variables.tf
    ├── mykytenko-dp.tf
    ├── terraform.tfvars
    └── variables.tf
```

For Kharkiv National Aerospace University 'HAI', spring-summer 2017
