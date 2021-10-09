resource "aws_lambda_function" "sqs_reader" {
  filename = "sqs-reader.zip"
  function_name = "sqs-reader"
  role          = "${aws_iam_role.sqs_reader_role.arn}"
  handler       = "sqs-reader.js"
  runtime = "nodejs14.x"
}