resource "aws_ecs_cluster" "app_cluster" {
    name = "node-app-ecs"
}

resource "aws_ecs_task_definition" "nclouds_app_server" {
    family = "nclouds-app-server"
    container_definitions = "${file("task-definitions/node-app.json")}"
}

resource "aws_elb" "app_cluster_elb" {
    name = "app-cluster-elb"
    subnets = ["${split(",", module.vpc.public_subnets)}"]
    connection_draining = true
    cross_zone_load_balancing = true
    security_groups = [
        "${aws_security_group.allow_inbound_ports.id}",
        "${aws_security_group.allow_all_outbound.id}"
    ]

    listener {
        instance_port = 4000
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold = 1
        unhealthy_threshold = 10
        target = "HTTP:4000/"
        interval = 5
        timeout = 4
    }
}

resource "aws_ecs_service" "nclouds_app" {
    name = "nclouds-app"
    cluster = "${aws_ecs_cluster.app_cluster.id}"
    task_definition = "${aws_ecs_task_definition.nclouds_app_server.arn}"
    desired_count = 1
    iam_role = "${aws_iam_role.ecs.arn}"
    depends_on = ["aws_iam_policy_attachment.ecs_elb"]

    load_balancer {
        elb_name = "${aws_elb.app_cluster_elb.id}"
        container_name = "nclouds-app-server"
        container_port = 4000
    }
}
