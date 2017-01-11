resource "aws_iam_policy" "state_read" {
  name        = "${var.prefix}-terraform-state-read"
  description = "Read ${var.prefix} Terraform state bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "S3:GetObject",
        "S3:GetObjectVersion"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.state.arn}/*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "state_write" {
  name        = "terraform-state-write"
  description = "Write ${var.prefix} Terraform state bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "S3:GetObject",
        "S3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.state.arn}/*"
    },
    {
      "Action": [
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:ListTables",
        "dynamodb:DescribeTable",
        "dynamodb:PutItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:UpdateItem"
      ],
      "Effect": "Allow",
      "Resource": "${aws_dynamodb_table.state_lock.arn}"
    }
  ]
}
EOF
}
