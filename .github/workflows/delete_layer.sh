#! /bin/bash

LAYER_NAME=$1

get_versions () {
  echo $(aws lambda list-layer-versions --layer-name "$LAYER_NAME" --output text --query LayerVersions[].Version | tr '[:blank:]' '\n')
}

versions=$(get_versions)
for version in $versions;
  do
    echo "deleting arn:aws:lambda:ap-northeast-1:*:layer:$LAYER_NAME:$version"
    aws lambda delete-layer-version --layer-name "$LAYER_NAME" --version "$version" > /dev/null
  done
done

echo "All versions of $LAYER_NAME have been deleted!"
