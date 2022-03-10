data "aws_iam_policy_document" "site_deploy" {
  statement {
    sid     = "DeployWebsite"
    actions = [
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:PutObjectAcl"
      "s3:PutObjectVersionAcl",
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*",
      "arn:aws:s3:::${var.bucket_name}",
    ]
  }

  statement {
    sid     = "DeployWebsiteCloudfront"
    actions = [
      "cloudfront:CreateInvalidation",
    ]
    resources = [aws_cloudfront_distribution.site_distribution.arn]
  }
}

resource "aws_iam_policy" "site_deploy" {
  name   = var.iam_name
  path   = "/"
  policy = data.aws_iam_policy_document.site_deploy.json
}

resource "aws_iam_user" "site_deployer" {
  name = var.iam_name
  path = "/"
}