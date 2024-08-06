# Delinea Platform Token Management and Test API Script

This repository contains a Python script designed to manage OAuth tokens and test API connectivity for the Delinea Platform.

## Overview

The script performs the following tasks:
1. Obtains initial OAuth tokens (access and refresh tokens).
2. Refreshes the access token when it is expired.
3. Calls a test API endpoint to verify token validity and connectivity.

## Files

- `config.py`: Contains configuration variables required for token management and API calls.
- `main.py`: The main Python script that performs token management and API calls.

## Configuration

Update the `config.py` file with your specific configuration details:

```python
# Configuration variables
TOKEN_URL = "https://your-hostname.delinea.app/identity/api/oauth2/token/xpmplatform"
CLIENT_ID = "your-client-id"
CLIENT_SECRET = "your-client-secret"
SCOPE = "xpmheadless"  
GRANT_TYPE = "client_credentials"  # Default grant type
REFRESH_GRANT_TYPE = "refresh_token"  # Grant type for refreshing the token
TEST_API_URL = "https://your-hostname.delinea.app/identity/entities/xpmusers?detail=true"  # Test API endpoint
```

## Usage
### Prerequisites
- Python 3.6 or later
- requests, colorama, and argparse libraries

You can install the required libraries using pip:

``` bash
pip install requests colorama argparse
```

Running the Script
1. Clone this repository or download the config.py and main.py files.
2. Open a terminal and navigate to the directory where the scripts are saved.
3. Run the main.py script:
``` bash

python main.py --mimic-expired
```

Script Parameters

--mimic-expired: Optional switch to mimic an expired token scenario for testing purposes.
