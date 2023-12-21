data "aws_iam_policy_document" "s3" {
  statement {
    actions = [
      "s3:GetAccelerateConfiguration",
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:ListBucketMultipartUploads",
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}",
    ]

    effect = "Allow"
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}/*",
    ]

    effect = "Allow"
  }

}

data "aws_iam_policy_document" "assume_role_sgw" {
  statement {
    effect = "Allow"

    principals {
      identifiers = [
        "storagegateway.amazonaws.com",
      ]

      type = "Service"
    }

    actions = [
      "sts:AssumeRole",
      ]
    
  }
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      "arn:aws:iam::215354123741:role/d2l-ear-partition-info-reader-dev"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:*",
    ]
    resources = [
     "arn:aws:kms:us-east-1:215354123741:key/*"
    ]
  }
}

resource "aws_iam_role" "gateway" {
  name               = "${var.gateway_name}-sgw-instance-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_sgw.json
  description        = "IAM role for file gateway" 
}

resource "aws_iam_instance_profile" "gateway" {
  role = aws_iam_role.gateway.name
  name = "${var.gateway_name}-sgw-instance-profile"
}

resource "aws_iam_policy" "s3" {
  name   = "${var.gateway_name}-sgw-bucket-access"
  policy = data.aws_iam_policy_document.s3.json
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = aws_iam_role.gateway.id
  policy_arn = aws_iam_policy.s3.arn
}