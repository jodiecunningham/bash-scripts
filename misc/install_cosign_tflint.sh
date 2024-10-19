#!/usr/bin/env bash

# Check if the system is Debian-based
if ! grep -q "Debian" /etc/os-release; then
  echo "This script is only for Debian-based systems."
  exit 1
fi

# Set TARGETOS and TARGETARCH
TARGETOS=$(uname -s | tr '[:upper:]' '[:lower:]')
TARGETARCH=$(uname -m)
if [ "$TARGETARCH" == "x86_64" ]; then
  TARGETARCH="amd64"
fi

# Install the latest version of cosign
COSIGN_LATEST=$(curl -s https://api.github.com/repos/sigstore/cosign/releases/latest | grep "browser_download_url.*cosign-${TARGETOS}_${TARGETARCH}" | cut -d '"' -f 4)
curl -LO $COSIGN_LATEST
dpkg -i cosign-${TARGETOS}_${TARGETARCH}

# Retrieve the latest version of tflint
TFLINT_LATEST=$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep "tag_name" | cut -d '"' -f 4)
TFLINT_URL="https://github.com/terraform-linters/tflint/releases/download/$TFLINT_LATEST/tflint_${TARGETOS}_${TARGETARCH}.zip"
CHECKSUMS_URL="https://github.com/terraform-linters/tflint/releases/download/$TFLINT_LATEST/tflint_checksums.txt"
SIG_URL="https://github.com/terraform-linters/tflint/releases/download/$TFLINT_LATEST/tflint_checksums.txt.keyless.sig"
CERT_URL="https://github.com/terraform-linters/tflint/releases/download/$TFLINT_LATEST/tflint_checksums.txt.pem"

# Download tflint release, checksums, and signature files
curl -LO $TFLINT_URL
curl -LO $CHECKSUMS_URL
curl -LO $SIG_URL
curl -LO $CERT_URL

# Verify the tflint download using cosign
cosign verify-blob --cert $CERT_URL --signature $SIG_URL --cert-identity "https://github.com/terraform-linters/tflint/.github/workflows/release.yml@refs/tags/$TFLINT_LATEST" --cert-oidc-issuer "https://token.actions.githubusercontent.com" $CHECKSUMS_URL

# Verify the tflint download using sha256sum
grep "tflint_${TARGETOS}_${TARGETARCH}.zip" tflint_checksums.txt | sha256sum -c -

# Unzip the tflint zip file into /usr/bin and set the appropriate permissions
unzip tflint_${TARGETOS}_${TARGETARCH}.zip -d /usr/bin
chmod +x /usr/bin/tflint
