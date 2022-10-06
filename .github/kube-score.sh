#!/bin/bash
set -euox pipefail
export PS4='+ $0:$LINENO '

CHART_DIRS="charts"
KUBESCORE_VERSION="1.14.0"

# install kube-score
curl --silent --show-error --fail --location --output /tmp/kube-score.tar.gz https://github.com/zegl/kube-score/releases/download/v${KUBESCORE_VERSION}/kube-score_${KUBESCORE_VERSION}_linux_amd64.tar.gz
tar -xf /tmp/kube-score.tar.gz kube-score

# validate charts
helm template "${CHART_DIR}" -f "${CHART_DIR}"/values.yaml | ./kube-score score -

