resource "aws_cloudwatch_metric_alarm" "billing" {
  alarm_name          = "awsbilling-AWS-Service-Charges-total"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 21600
  statistic           = "Maximum"
  threshold           = 5
  alarm_actions       = ["arn:aws:sns:us-east-1:098453759506:NotifyMe"]
  alarm_description   = "Created from CloudWatch console" # TODO
  datapoints_to_alarm = 1

  dimensions = {
    Currency = "USD"
  }

  provider = "aws.us-east-1"
}
