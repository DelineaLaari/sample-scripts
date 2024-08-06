# Define a function to generate OID
function Generate-OID {
    # Generate a new GUID
    $guid = [guid]::NewGuid()

    # Convert GUID to string and remove hyphens
    $guidString = $guid.ToString('N')

    # Split GUID into parts and convert each part to decimal
    $oidParts = @()
    $oidParts += [convert]::ToInt32($guidString.Substring(0, 4), 16)
    $oidParts += [convert]::ToInt32($guidString.Substring(4, 4), 16)
    $oidParts += [convert]::ToInt32($guidString.Substring(8, 4), 16)
    $oidParts += [convert]::ToInt32($guidString.Substring(12, 4), 16)
    $oidParts += [convert]::ToInt32($guidString.Substring(16, 4), 16)
    $oidParts += [convert]::ToInt32($guidString.Substring(20, 6), 16)
    $oidParts += [convert]::ToInt32($guidString.Substring(26, 6), 16)

    # The Microsoft OID Prefix used for the automated OID Generator
    $oidPrefix = "1.2.840.113556.1.8000.2554"

    # Combine OID parts with the prefix
    $oid = $oidPrefix + "." + ($oidParts -join ".")

    return $oid
}

# Generate OID and output it
$oid = Generate-OID
Write-Output "Your root OID is: $oid"

# Define the output file path
$outFile = "C:\Users\Administrator\Desktop\oidInfo.txt"

# Ensure the directory exists
$outDir = [System.IO.Path]::GetDirectoryName($outFile)
if (-not (Test-Path -Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force
}

# Define the content to write to the file
$oidText = @"
Your root OID is: $oid

This prefix should be used to name your schema attributes and classes. For example:
if your prefix is "Microsoft", you should name schema elements like "microsoft-Employee-ShoeSize".
For more information on the prefix, view the Schema Naming Rules in the server
Application Specification (http://www.microsoft.com/windowsserver2003/partners/isvs/appspec.mspx).

You can create subsequent OIDs for new schema classes and attributes by appending a .X to the OID where X may
be any number that you choose. A common schema extension scheme generally uses the following structure:
If your assigned OID was: 1.2.840.113556.1.8000.2554.999999

then classes could be under: 1.2.840.113556.1.8000.2554.999999.1
which makes the first class OID: 1.2.840.113556.1.8000.2554.999999.1.1
the second class OID: 1.2.840.113556.1.8000.2554.999999.1.2     etc...

Using this example attributes could be under: 1.2.840.113556.1.8000.2554.999999.2
which makes the first attribute OID: 1.2.840.113556.1.8000.2554.999999.2.1
the second attribute OID: 1.2.840.113556.1.8000.2554.999999.2.2     etc...

Here are some other useful links regarding AD schema:
Understanding AD Schema
http://technet2.microsoft.com/WindowsServer/en/Library/b7b5b74f-e6df-42f6-a928-e52979a512011033.mspx

Developer documentation on AD Schema:
http://msdn2.microsoft.com/en-us/library/ms675085.aspx

Extending the Schema
http://msdn2.microsoft.com/en-us/library/ms676900.aspx

Step-by-Step Guide to Using Active Directory Schema and Display Specifiers
http://www.microsoft.com/technet/prodtechnol/windows2000serv/technologies/activedirectory/howto/adschema.mspx

Troubleshooting AD Schema
http://technet2.microsoft.com/WindowsServer/en/Library/6008f7bf-80de-4fc0-ae3e-51eda0d7ab651033.mspx
"@

# Write the content to the file
[System.IO.File]::WriteAllText($outFile, $oidText)
