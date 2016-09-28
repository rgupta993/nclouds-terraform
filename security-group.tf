resource "aws_security_group" "allow_all_outbound" {
    name = "${module.vpc.vpc_id}-outbound"
    description = "Allow all outbound traffic"
    vpc_id = "${module.vpc.vpc_id}"

    egress = {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow_inbound_ports" {
    name = "${module.vpc.vpc_id}-inbound"
    description = "Allow all inbound traffic"
    vpc_id = "${module.vpc.vpc_id}"

    ingress = {
        from_port = 0
        to_port = 4000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

