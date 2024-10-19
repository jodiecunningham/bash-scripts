# bash-scripts

## Install Cosign and TFLint on Debian Systems

This repository includes a bash script to install the latest versions of Cosign and TFLint on Debian-based systems.

### Usage

1. Clone the repository:
   ```sh
   git clone https://github.com/jodiecunningham/bash-scripts.git
   cd bash-scripts
   ```

2. Run the script:
   ```sh
   ./misc/install_cosign_tflint.sh
   ```

The script will:
- Check if the system is Debian-based.
- Download and install the latest version of Cosign using `dpkg`.
- Retrieve the latest version of TFLint using `curl`.
- Download the TFLint release, checksums, and signature files.
- Verify the TFLint download using Cosign.
- Verify the TFLint download using `sha256sum`.
- Unzip the TFLint zip file into `/usr/bin` and set the appropriate permissions.

### Multi-Platform Support

The script supports multi-platform installations. It uses `${TARGETOS}` and `${TARGETARCH}` to handle different operating systems and architectures. You can set these environment variables before running the script to specify the target platform.
