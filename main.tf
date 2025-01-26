resource "aws_s3_bucket" "hooks" {
  bucket = "ccapihooks"
}

resource "aws_s3_bucket" "hooks_logs" {
  bucket = "ccapihooks-logs"
}

resource "aws_s3_object" "hooks" {
  bucket = aws_s3_bucket.hooks.id
  key    = "safebucket.guard"
  source = "safebucket.guard"
  etag   = filemd5("safebucket.guard")
}

resource "awscc_cloudformation_guard_hook" "example" {
  alias = "CCAPI::S3::Hooks"
  rule_location = {
    uri = "s3://${aws_s3_bucket.hooks.id}/${aws_s3_object.hooks.key}"
  }
  execution_role    = awscc_iam_role.example.arn
  failure_mode      = "FAIL"
  target_operations = ["CLOUD_CONTROL"]
  hook_status       = "ENABLED"
  log_bucket        = aws_s3_bucket.hooks_logs.id
  target_filters = {
    actions           = ["CREATE", "UPDATE"]
    invocation_points = ["PRE_PROVISION"]
    target_names      = ["AWS::S3::Bucket"]
  }
}

resource "awscc_iam_role" "example" {
  path = "/"
  assume_role_policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "hooks.cloudformation.amazonaws.com"
        }
      },
    ]
  })
  policies = [{
    policy_name = "allow_s3_access"
    policy_document = jsonencode(
      {
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "s3:GetObject",
              "s3:GetObjectVersion",
              "s3:ListBucket",
              "s3:PutObject"
            ]
            Effect = "Allow"
            Resource = [
              "arn:aws:s3:::${aws_s3_bucket.hooks.id}",
              "arn:aws:s3:::${aws_s3_bucket.hooks.id}/*",
              "arn:aws:s3:::${aws_s3_bucket.hooks_logs.id}",
              "arn:aws:s3:::${aws_s3_bucket.hooks_logs.id}/*"
            ]
          },
        ]
      }
    )
  }]
}
