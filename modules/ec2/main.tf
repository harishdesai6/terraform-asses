resource "aws_instance" "webserver" {
    ami  = var.ami_id
    instance_type  = var.instance_type
    subnet_id  = var.public_subnets[0]
    key_name  = var.key_name
    vpc_security_group_ids  = [var.webserver_sg_id]

    root_block_device {
        volume_size  = 10
        volume_type  = "gp3"
        encrypted  = true
    }

    ebs_block_device {
        device_name  = "/dev/sdh"
        volume_size  = 20
        volume_type  = "gp3"
        encrypted  = true
        delete_on_termination  = true
    }
}


