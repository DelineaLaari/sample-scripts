
# Delinea Platform API Access Token Powershell Script - Work-In-Progress!!!!!!

This repository contains a PowerShell script designed to manage OAuth tokens and test API connectivity for the Delinea Platform.

## Overview

The script performs the following tasks:
1. Obtains initial OAuth tokens (access and refresh tokens).
2. Refreshes the access token when it is expired.
3. Calls a test API endpoint to verify token validity and connectivity.

## Files

- `config.ps1`: Contains configuration variables required for token management and API calls.
- `main.ps1`: The main PowerShell script that performs token management and API calls.

## Configuration

Update the `config.ps1` file with your specific configuration details:

```powershell
# Configuration variables
$TOKEN_URL = "https://your-hostname.delinea.app/identity/api/oauth2/token/xpmplatform"
$CLIENT_ID = "your-client-id"
$CLIENT_SECRET = "your-client-secret"
$SCOPE = "xpmheadless"  
$GRANT_TYPE = "client_credentials"  # Default grant type
$REFRESH_GRANT_TYPE = "refresh_token"  # Grant type for refreshing the token
$TEST_API_URL = "https://your-hostname.delinea.app/identity/entities/xpmusers?detail=true"  # Test API endpoint
```

## Usage


### Prerequisites
- PowerShell 5.1 or later

### Running the Script

- Clone this repository or download the config.ps1 and main.ps1 files.
- Open a PowerShell prompt and navigate to the directory where the scripts are saved.
- Run the main.ps1 script:

```powershell
.\main.ps1 --mimic-expired
```

Script Parameters

--mimic-expired: Optional switch to mimic an expired token scenario for testing purposes.


## Notes
This script is provided as-is without any warranties. Please review the code and test it in a controlled environment before deploying it in a production setting. Use it at your own risk.
Ensure you have appropriate permissions and access to the Delinea Platform API.
