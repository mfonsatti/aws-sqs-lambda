resource "aws_lambda_event_source_mapping" "sqs_reader_mapping" {
  event_source_arn = "${aws_sqs_queue.terraform_queue.arn}"
  enabled          = true
  function_name    = "${aws_lambda_function.sqs_reader.arn}"
  batch_size       = 1
}