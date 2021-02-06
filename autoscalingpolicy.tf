# scale up alarm

resource "aws_autoscaling_policy" "instance-cpu-policy" {
  name                   = "instance-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.elb-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "instance-cpu-alarm" {
  alarm_name          = "instance-cpu-alarm"
  alarm_description   = "instance-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.elb-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.instance-cpu-policy.arn]
}

# scale down alarm
resource "aws_autoscaling_policy" "instance-cpu-policy-scaledown" {
  name                   = "instance-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.elb-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "instance-cpu-alarm-scaledown" {
  alarm_name          = "instance-cpu-alarm-scaledown"
  alarm_description   = "instance-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.elb-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.instance-cpu-policy-scaledown.arn]
}
