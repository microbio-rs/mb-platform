# Chapter 1

> "Melhorar o fluxo de valor tecnológico é essencial para atingir os resultados DevOps"

## Recursos da AWS

1. Compute
    - [ ] ECR
    - [ ] ECS
        - [ ] Fargate
        - [ ] Service
        - [ ] Task
        - [ ] Task Definition
    - [ ] Lambda
2. Database
    - [ ] DynamoDB
    - [ ] ElasticCache
    - [ ] RDS
3. Devtools
    - [ ] XRay
4. Integration
    - [ ] SNS
    - [ ] SQS
5. Engagement
    - [ ] App Mesh
    - [ ] Cloudwatch
        - [ ] Alarm
        - [ ] Event
        - [ ] Log
    - [ ] SES
6. Network
    - [ ] ALB
    - [ ] Internet Gateway
    - [ ] NAT ?
    - [ ] RouteTable
    - [ ] Subnet Public/Private/DB/Intra
    - [ ] VPC
    - [ ] VPC Endpoint
7. Security
    - [ ] ACM
    - [ ] KMS
    - [ ] Secrets Manager
    - [ ] WAF
8. Storage
    - [ ] S3

## Aws Free

Lista de recursos que são Free por 12 meses ou Free até ultrapassar o limite.

|Service|Always Free|Limits|
|-------|-----------|------|


## How do we do it

1. making work visible
2. limit WIP
3. reducing batch sizes and number of transfers
4. identifying and continually evaluating our constraints
5. eliminating adversities in our daily work


## Architecture

1. VPC
2. Subnet
    * Public
    * Private
3. IG
4. Route Table
5. NAT / VPC Endpoints / NAT EC2
6. Cloudfront
7. ALB
8. ECS -> Fargate (ARM Ondemand / Spot x86)
9. DynamoDB
10. S3
11. Bastion
12. IAM
    * Users
    * Group
    * Roles
13. Blue/Green
14. Vault
15. Monitoring
16. SonarCube

## ToDo
1. Terragrunt

* [ ] Team Flowchart create
* [ ] Invite Slack (https://api.slack.com/methods/admin.users.invite) existe event when user accept invite?
    * [ ] Add user to channels
* [ ] AWS Add Team
* [ ] Add user to group of email

