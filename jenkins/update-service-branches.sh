#!/usr/bin/env bash
# Replaces the tutorial Jenkinsfile on every service branch with jenkins/service.Jenkinsfile
# and swaps the Docker Hub handle. Run from the repo root on a clean main checkout.
set -euo pipefail
DOCKERHUB_USER="${DOCKERHUB_USER:?export DOCKERHUB_USER=yourhandle}"

SERVICES=(adservice cartservice checkoutservice currencyservice emailservice frontend \
          loadgenerator paymentservice productcatalogservice recommendationservice shippingservice)

TEMPLATE="$(mktemp)"
sed "s/CHANGE_ME_DOCKERHUB_USER/${DOCKERHUB_USER}/" jenkins/service.Jenkinsfile > "$TEMPLATE"

for svc in "${SERVICES[@]}"; do
  echo "==> $svc"
  git checkout -q "$svc"
  cp "$TEMPLATE" Jenkinsfile
  # any leftover tutorial handle in the branch (compose files, scripts, k8s yaml).
  # On branches whose only mention was the Jenkinsfile we just overwrote, grep
  # matches nothing and exits 1 -- not an error here, so don't let pipefail abort.
  grep -rl 'adijaiswal' . --exclude-dir=.git | xargs -r sed -i "s/adijaiswal/${DOCKERHUB_USER}/g" || true
  git add -A
  git commit -qm "ci($svc): build, Trivy scan and push under own registry; tag by git SHA" || echo "   (no change)"
done

git checkout -q main
rm -f "$TEMPLATE"
echo "==> Done. Review with 'git log --oneline --all', then: git push --all origin"
