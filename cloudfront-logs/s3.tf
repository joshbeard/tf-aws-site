#data "aws_iam_policy_document" "s3_bucket_readonly" {
#  statement {
#    actions = [
#      "s3:Get*",
#      "s3:List*",
#    ]
#
#    resources = [
#      data.aws_s3_bucket.this.arn,
#      "${data.aws_s3_bucket.this.arn}/*",
#    ]
#  }
#}

resource "aws_s3_bucket_notification" "this" {
  bucket = var.log_bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.this.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.s3_bucket_invoke_function]
}
