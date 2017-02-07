resource "aws_cloudformation_stack" "certificate" {
  name          = "Cannoli"
  template_body = "${file("${path.module}/certificate.yaml")}"

  parameters {
    DomainName = "${var.domain_name}"
    ProjectTag = "${var.project_tag}"
  }

  tags = {
    Project = "${var.project_tag}"
  }

  depends_on = ["aws_route53_record.MX"]
  provider   = "aws.us-east-1"
}
