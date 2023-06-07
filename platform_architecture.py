#!/usr/bin/env python3
#
# Copyright (c) 2023 Murilo Ijanc' <mbsd@m0x.ru>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

from diagrams import Cluster, Diagram, Edge
# aws compute
from diagrams.aws.compute import (ECR, ECS, ElasticContainerServiceService,
                                  Fargate, LambdaFunction)
# aws database
from diagrams.aws.database import DDB, RDS, ElastiCache
# aws devtools
from diagrams.aws.devtools import XRay
# aws engagement
from diagrams.aws.engagement import SES
# general
from diagrams.aws.general import Client, User
# aws integration
from diagrams.aws.integration import SNS, SQS
# aws management
from diagrams.aws.management import Cloudwatch
# aws network
from diagrams.aws.network import (ALB, CF, AppMesh, InternetGateway,
                                  NATGateway, PrivateSubnet, PublicSubnet,
                                  Route53, VPCElasticNetworkInterface)
# aws security
from diagrams.aws.security import ACM, IAM, KMS, WAF, SecretsManager
# aws storage
from diagrams.aws.storage import S3

with Diagram("Microbio Platform Architecture", show=False):
    user = User("User1")
    client = Client("Client1")
