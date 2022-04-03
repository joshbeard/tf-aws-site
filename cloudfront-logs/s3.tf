resource "aws_s3_bucket_notification" "this" {
  bucket = var.log_bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.this.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.s3_bucket_invoke_function]
}
