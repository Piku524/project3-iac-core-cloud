#!/bin/bash

echo "Starting Terraform drift detection..."

terraform plan -detailed-exitcode -out=drift.tfplan

code=$?

if [ $code -eq 0 ]; then
  echo "No drift detected."
elif [ $code -eq 2 ]; then
  echo "Drift detected."
  terraform show drift.tfplan
else
  echo "Terraform drift check failed."
  exit 1
fi
