#!/bin/bash
set -euox pipefail
export PS4='+ $0:$LINENO '

CHART_DIRS="charts"
KUBECONFORM_VERSION="0.4.14"

# install kube-score
curl --silent --show-error --fail --location --output /tmp/kubeconform.tar.gz https://github.com/yannh/kubeconform/releases/download/v${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz
tar -xf /tmp/kubeconform.tar.gz kubeconform

# validate charts
for CHART_DIR in ${CHART_DIRS}; do
  helm template "${CHART_DIR}" -f "${CHART_DIR}"/values.yaml | ./kubeconform -strict -kubernetes-version "${KUBERNETES_VERSION#v}" -exit-on-error
done
