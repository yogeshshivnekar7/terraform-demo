resource "aws_launch_configuration" "elb-launchconfig" {
  name_prefix     = "elb-launchconfig"
  image_id        = var.AMI_ID
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.instance-sg.id]
  user_data       = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\necho 'webserver' > /var/www/html/index.html"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "elb-autoscaling" {
  name                      = "elb-autoscaling"
  vpc_zone_identifier       = [aws_subnet.Public_SN_1.id, aws_subnet.Public_SN_2.id]
  launch_configuration      = aws_launch_configuration.elb-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.my-elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}

