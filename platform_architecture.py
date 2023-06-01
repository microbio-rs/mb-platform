from diagrams import Cluster, Diagram
from diagrams.aws.compute import ECS, Fargate, ECR
from diagrams.aws.database import RDS
from diagrams.aws.network import Route53, PrivateSubnet, PublicSubnet, NATGateway, InternetGateway, ALB
from diagrams.aws.network import VPCElasticNetworkInterface

with Diagram("Microbio Platform Architecture", show=True):
    with Cluster("Region"):
        with Cluster("VPC", direction="LR"):


            with Cluster("Availability Zone B"):
                with Cluster("Public subnet B"):
                    nta = NATGateway()
                with Cluster("Private subnet B"):
                    ecsa = ECS() >> Fargate() >> VPCElasticNetworkInterface() >> nta


            with Cluster("Availability Zone A"):
                with Cluster("Public subnet A"):
                    ntb = NATGateway()
                with Cluster("Private subnet A"):
                    ecsb = ECS() >> Fargate() >> VPCElasticNetworkInterface() >> ntb

            ig = InternetGateway()
            alb = ALB()
            ig >> alb
            # ecsb = ECS() >> Fargate() >> VPCElasticNetworkInterface() >> ntb
            nta >> ig \
                    << ntb
            ecsa << alb >> ecsb
        # ecr = ECR()
