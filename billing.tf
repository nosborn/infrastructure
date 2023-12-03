resource "aws_cloudwatch_metric_alarm" "billing" {
  provider = aws.us_east_1

  alarm_description   = "Created from CloudWatch console" # TODO
  alarm_name          = "awsbilling-AWS-Service-Charges-total"
  comparison_operator = "GreaterThanThreshold"
  datapoints_to_alarm = 1
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 21600
  statistic           = "Maximum"
  threshold           = 25

  alarm_actions = [
    "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.account_id}:NotifyMe",
  ]

  dimensions = {
    Currency = "USD"
  }
}

data "aws_caller_identity" "current" {}
