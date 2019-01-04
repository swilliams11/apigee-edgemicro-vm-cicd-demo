BUCKET_NAME="$1"
#gsutil rm gs://$BUCKET_NAME/express-gateway.sh
gsutil rm -r gs://$BUCKET_NAME

gcloud deployment-manager deployments delete $1
