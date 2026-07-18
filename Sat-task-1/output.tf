output "user1_name" {
  value = aws_iam_user.user-1
}

output "user2_name" {
  value = aws_iam_user.user-2
}

output "group_name" {
  value = aws_iam_group.developers
}

output "role_name" {
  value = aws_iam_role.ec2role.arn
}

output "role_attachment" {
  value = aws_iam_role_policy_attachment.role-attachment
}

output "policy_attachment" {
  value = aws_iam_group_policy_attachment.group_attach
}