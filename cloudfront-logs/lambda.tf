resource "aws_lambda_function" "this" {
  function_name = "${var.name_prefix}-${var.name}"

  runtime                        = "nodejs16.x"
  handler                        = "index.handler"
  timeout                        = 5
  reserved_concurrent_executions = 3

  environment {
    variables = {
      CLOUDWATCH_LOGS_GROUP_ARN = aws_cloudwatch_log_group.logs.arn
    }
  }

  role = aws_iam_role.lambda.arn

  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256

  tags = var.tags

  depends_on = [aws_cloudwatch_log_group.lambda]
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/src"
  output_path = ".terraform/tmp/lambda/${var.name}.zip"
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name = "${var.name_prefix}-lambda-${var.name}"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  tags = var.tags
}

resource "aws_iam_role_policy" "lambda_cloudwatch_log_group" {
  name   = "${var.name_prefix}-cloudwatch-log-group"
  role   = aws_iam_role.lambda.name
  policy = data.aws_iam_policy_document.lambda_cloudwatch_log_group.json
}

resource "aws_iam_role_policy" "lambda_cloudwatch_log_group_logs" {
  name   = "${var.name_prefix}-cloudwatch-log-group-logs"
  role   = aws_iam_role.lambda.name
  policy = data.aws_iam_policy_document.logs_cloudwatch_log_group.json
}

data "aws_iam_policy_document" "s3_bucket_readonly" {
  statement {
    actions = [
      "s3:Get*",
      "s3:List*",
    ]

    resources = [
      data.aws_s3_bucket.logging.arn,
      "${data.aws_s3_bucket.logging.arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "lambda_s3_bucket_readonly" {
  name   = "${var.name_prefix}-s3-bucket-readonly"
  role   = aws_iam_role.lambda.name
  policy = data.aws_iam_policy_document.s3_bucket_readonly.json
}

resource "aws_lambda_permission" "s3_bucket_invoke_function" {
  function_name = aws_lambda_function.this.arn
  statement_id  = "S3Logging"
  action        = "lambda:InvokeFunction"

  principal  = "s3.amazonaws.com"
  source_arn = data.aws_s3_bucket.logging.arn
}
