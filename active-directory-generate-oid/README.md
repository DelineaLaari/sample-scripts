# OID Generator Script

This repository contains a PowerShell script for generating an Object Identifier (OID) based on a GUID. The script creates a root OID, formats it according to specific rules, and writes detailed information about the OID to a text file.

## Overview

The script performs the following tasks:
1. Generates a new GUID.
2. Converts the GUID into a formatted OID.
3. Writes the OID and additional information to a text file.

## Files

- `generate_oid.ps1`: The main PowerShell script that generates the OID and writes it to a file.

## Usage

### Prerequisites

- PowerShell 5.1 or later

### Running the Script

1. Clone this repository or download the `generate_oid.ps1` file.
2. Open a PowerShell prompt and navigate to the directory where the script is saved.
3. Run the `generate_oid.ps1` script:

```powershell
   .\generate_oid.ps1
```

### Output
The script generates an OID and saves it to a text file located at C:\Users\Administrator\Desktop\oidInfo.txt. The file includes:

- The generated OID.
- Instructions on how to use the OID for naming schema attributes and classes.
- Links to additional resources for Active Directory (AD) schema.


### Notes
- Ensure that the directory C:\Users\Administrator\Desktop\ exists or update the $outFile path to a valid location on your system.
- The script uses a fixed OID prefix for Microsoft. Modify the prefix as needed for different use cases.
