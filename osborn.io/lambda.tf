locals {
  log_group_retention_in_days    = 7
  security_headers_function_name = "io-osborn-security-headers"
}

resource "aws_lambda_function" "security_headers" {
  filename         = "${data.archive_file.security_headers.output_path}"
  function_name    = "${local.security_headers_function_name}"
  handler          = "security_headers.handler"
  role             = "${aws_iam_role.lambda_exec.arn}"
  runtime          = "nodejs8.10"
  source_code_hash = "${data.archive_file.security_headers.output_base64sha256}"

  tags {
    Project = "${var.project_tag}"
  }

  depends_on = ["aws_cloudwatch_log_group.security_headers"]
  provider   = "aws.us-east-1"

  lifecycle {
    ignore_changes = [
      "filename",
      "last_modified",
    ]
  }
}

resource "aws_cloudwatch_log_group" "security_headers" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.us-east-1" # US East (N. Virginia) - Price Class 100
}

resource "aws_cloudwatch_log_group" "security_headers_APN1" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.ap-northeast-1" # Asia Pacific (???) - Price Class 200
}

resource "aws_cloudwatch_log_group" "security_headers_APN2" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.ap-northeast-2" # Asia Pacific (???) - Price Class 200
}

resource "aws_cloudwatch_log_group" "security_headers_APS1" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.ap-southeast-1" # Asia Pacific (Singapore) - Price Class 200
}

resource "aws_cloudwatch_log_group" "security_headers_APS3" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.ap-south-1" # Asia Pacific (Mumbai) - Price Class 200
}

resource "aws_cloudwatch_log_group" "security_headers_CAN1" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.ca-central-1" # Canada (Central) - Price Class 100
}

resource "aws_cloudwatch_log_group" "security_headers_EU" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.eu-west-1" # EU (Ireland) - Price Class 100
}

resource "aws_cloudwatch_log_group" "security_headers_EUC1" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.eu-central-1" # EU (Frankfurt) - Price Class 100
}

resource "aws_cloudwatch_log_group" "security_headers_EUN1" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.eu-north-1" # EU (Stockholm) - Price Class 100
}

resource "aws_cloudwatch_log_group" "security_headers_EUW2" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.eu-west-2" # EU (London) - Price Class 100
}

resource "aws_cloudwatch_log_group" "security_headers_EUW3" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.eu-west-3" # EU (Paris) - Price Class 100
}

resource "aws_cloudwatch_log_group" "security_headers_USE2" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.us-east-2" # US East (Ohio) - Price Class 100
}

resource "aws_cloudwatch_log_group" "security_headers_USW1" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.us-west-1" # US West (N. California) - Price Class 100
}

resource "aws_cloudwatch_log_group" "security_headers_USW2" {
  name              = "/aws/lambda/us-east-1.${local.security_headers_function_name}"
  retention_in_days = "${local.log_group_retention_in_days}"

  tags {
    Project = "${var.project_tag}"
  }

  provider = "aws.us-west-2" # US West (Oregon) - Price Class 100
}

resource "aws_iam_role" "lambda_exec" {
  name_prefix        = "lambda-exec-"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "lambda_exec" {
  role       = "${aws_iam_role.lambda_exec.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "security_headers" {
  type        = "zip"
  source_file = "${path.module}/security_headers.js"
  output_path = "${path.module}/security_headers.zip"
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "edgelambda.amazonaws.com",
        "lambda.amazonaws.com",
      ]
    }
  }
}
