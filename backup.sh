#!/bin/bash

AWS_PROFILE="default"

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --profile) AWS_PROFILE="$2"; shift ;;
        --bucketName) BUCKET_NAME="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [[ -z "$BUCKET_NAME" ]]; then
    echo "Usage: $0 --bucketName <bucket_name>"
    exit 1
fi

plex_data_tar() {
    tar --exclude='/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Cache' -czf /tmp/plexMediaServer.tar.gz -C / 'var/lib/plexmediaserver/Library/Application Support/Plex Media Server/'
}

upload_to_s3() {
    aws s3 cp /tmp/plexMediaServer.tar.gz s3://$BUCKET_NAME/$backupDate/plexMediaServer.tar.gz --storage-class STANDARD_IA --profile $AWS_PROFILE
}

remove_local_backup() {
    rm /tmp/plexMediaServer.tar.gz
}

backupDate=$(date +%Y%m%d-%H%M%S)
plexDir="/var/lib/plexmediaserver/Library/Application Support/Plex Media Server"
plex_data_tar
upload_to_s3
remove_local_backup
