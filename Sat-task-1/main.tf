resource "aws_iam_user" "user-1" {
  name = var.user_name
}

resource "aws_iam_user" "user-2" {
  name = var.user2_name
}

resource "aws_iam_group" "developers" {
  name = var.group_name
}

resource "aws_iam_group_membership" "membership" {
  name  = "developers-membership"
  users = [aws_iam_user.user-2.name,
  aws_iam_user.user-1.name]
  group = aws_iam_group.developers.name
}

resource "aws_iam_policy" "s3_bucket_policy" {
  name   = "s3bucketpolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:ListBucket"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "group_attach" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.s3_bucket_policy.arn
}

resource "aws_iam_role" "ec2role" {
    name = var.role_name
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        }
      ]
    })
}

resource "aws_iam_role_policy_attachment" "role-attachment" {
  role       = aws_iam_role.ec2role.name
  policy_arn = aws_iam_policy.s3_bucket_policy.arn
}