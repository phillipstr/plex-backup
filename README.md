# Plex Backup

This is a simple script that backs up Plex Media Server data to AWS S3,
following [Plex documentation](https://support.plex.tv/articles/201539237-backing-up-plex-media-server-data/).
The `Cache` directory is excluded as recommended.

## Usage

1) Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
1) Configure profile with `aws configure`

```shell
sudo ./backup.sh --bucketName BUCKET-NAME --profile aws-profile
```

### Environment

The script assumes that you're running Plex on Linux (I'm using Raspbian) and that it using the default directory.

## AWS Stuff

You'll need:

- S3 bucket
- IAM user
- IAM policy

### Minimum IAM policy 

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::BUCKET-NAME",
                "arn:aws:s3:::BUCKET-NAME/*"
            ]
        }
    ]
}
```
