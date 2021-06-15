variable "name" {
    description = "Name of NLB"
}

variable "nlbType" {
    description = "Type of NLB, i.e. Application, Network"
    default = "network"
}

variable "subnets" {
    description = "Subnets for LB"
    #default=0.0.0.0
}

variable "tags" {
    type = map
#	default=NLBlab
}

variable "vpcId" {
    description = "VPC ID"
}

variable "instanceIds" {
    type = list
    description = "List of EC2 instance ids to attach to target group" 
}
