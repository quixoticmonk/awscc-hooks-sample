# Create compliant S3 bucket
resource "awscc_s3_bucket" "compliant_bucket" {
  versioning_configuration = {
    status = "Enabled"
  }
  public_access_block_configuration = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}
