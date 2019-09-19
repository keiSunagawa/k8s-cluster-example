resource "aws_iam_role" "eks_log_role" {
  name = "${var.prefix}_eks_log_role"

  assume_role_policy = <<EOS
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOS
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  role = "${aws_iam_role.eks_log_role.name}"
}
