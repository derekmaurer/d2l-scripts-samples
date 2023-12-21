data "aws_kms_key" "shared_key" {
    provider = aws.partitions

  # use the appropriate shared key for the region and stage
  # Dev:
  #   arn:aws:kms:ca-central-1:215354123741:alias/d2l/shared/mixedpb
  #   arn:aws:kms:us-east-1:215354123741:alias/d2l/shared/mixedpb
  # Prd:
  #   arn:aws:kms:ap-southeast-1:572755843338:alias/d2l/shared/mixedpb
  #   arn:aws:kms:ap-southeast-2:572755843338:alias/d2l/shared/mixedpb
  #   arn:aws:kms:ca-central-1:572755843338:alias/d2l/shared/mixedpb
  #   arn:aws:kms:eu-west-1:572755843338:alias/d2l/shared/mixedpb
  #   arn:aws:kms:us-east-1:572755843338:alias/d2l/shared/mixedpb
  key_id = "arn:aws:kms:us-east-1:215354123741:alias/d2l/shared/mixedpb"
}