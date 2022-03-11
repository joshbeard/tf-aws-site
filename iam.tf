data "aws_iam_policy_document" "site_deploy" {
  statement {
    sid = "DeployWebsite"
    actions = [
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectVersionAcl"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.site.bucket}/*",
      "arn:aws:s3:::${aws_s3_bucket.site.bucket}"
    ]
  }

  statement {
    sid = "DeployWebsiteCloudfront"
    actions = [
      "cloudfront:CreateInvalidation"
    ]
    resources = [aws_cloudfront_distribution.site_distribution.arn]
  }
}

resource "aws_iam_policy" "site_deploy" {
  name   = local.iam_name
  path   = "/"
  policy = data.aws_iam_policy_document.site_deploy.json
  tags   = local.tags
}

resource "aws_iam_user" "site_deployer" {
  name = local.iam_name
  path = "/"
  tags = local.tags
}

resource "aws_iam_user_policy_attachment" "site_deploy" {
  user       = aws_iam_user.site_deployer.name
  policy_arn = aws_iam_policy.site_deploy.arn
}