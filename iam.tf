data "aws_iam_policy_document" "sqs_reader_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "sqs_reader_policy_document" {
  statement {
    actions = [
      "sqs:*"
    ]

    resources = [
      aws_sqs_queue.terraform_queue.arn
    ]
  }
}

resource "aws_iam_policy" "sqs_reader_policy" {
  policy = data.aws_iam_policy_document.sqs_reader_policy_document.json
}

resource "aws_iam_role_policy_attachment" "sqs_reader_role_policy_attachment" {
  role       = aws_iam_role.sqs_reader_role.name
  policy_arn = aws_iam_policy.sqs_reader_policy.arn
}

resource "aws_iam_role" "sqs_reader_role" {
  assume_role_policy = data.aws_iam_policy_document.sqs_reader_assume_role_policy.json
}
