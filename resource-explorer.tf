resource "aws_resourceexplorer2_index" "ap_southeast_1" {
  type = "AGGREGATOR"
}

resource "aws_resourceexplorer2_index" "us_east_1" {
  provider = aws.us_east_1

  type = "LOCAL"
}

resource "aws_resourceexplorer2_view" "main" {
  depends_on = [
    aws_resourceexplorer2_index.ap_southeast_1,
  ]

  default_view = true
  name         = "all-regions-all-resources"

  included_property {
    name = "tags"
  }
}
