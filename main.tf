provider "aws" {
    region = "us-east-1"
    access_key = "AKIAU7365PSY3XTDZPO2"
    secret_key = "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"

}

resource "aws_s3_bucket" "create-s3-bucket" {
    bucket = "${var.bucket-name}"
    acl = "public"
    lifecycle_rule{
        id = "archive"
        enable = true
        transition {
            days = 30
            storage_class = "STANDARD_IA"
        }
         transition {
            days = 60
            storage_class = "GLACIER"
        }

        versioning{
            enable = true
        }

        tags = {
            Environment: "QA"
        }
        server_side_encryption_configuration {
            rule{
                apply_server_side_encryption_by_default{
                    sse_algorithm = "aws:kms"
                }

            }
        }

        
    }
  

}

resource "aws_s3_bucket_metric" "enable-bucket-metric"{
    bucket = "${var.bucket-name}"
    name = "EntireBucket"
}