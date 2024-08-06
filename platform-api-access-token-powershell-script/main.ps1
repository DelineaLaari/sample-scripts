# DISCLAIMER: This script is provided as-is without any warranties.
# Please thoroughly review the code and test it in a controlled
# environment before deploying it in a production setting.
# Use it at your own risk.

# Description: PowerShell script to manage and refresh OAuth tokens and test API connectivity

Import-Module .\config.ps1

$ACCESS_TOKEN = $null
$REFRESH_TOKEN = $null
$TOKEN_EXPIRES_AT = 0

function Print-Heading {
    param (
        [string]$heading
    )
    Write-Host ""
    Write-Host $heading -ForegroundColor Cyan -BackgroundColor Black
    Write-Host ""
}

function Get-Initial-Tokens {
    param ()

    $payload = @{
        grant_type    = $GRANT_TYPE
        client_id     = $CLIENT_ID
        client_secret = $CLIENT_SECRET
        scope         = $SCOPE
    }

    $response = Invoke-RestMethod -Uri $TOKEN_URL -Method Post -Body $payload

    if ($response -ne $null) {
        $global:ACCESS_TOKEN = $response.access_token
        $global:REFRESH_TOKEN = $response.refresh_token
        $expires_in = $response.expires_in
        $global:TOKEN_EXPIRES_AT = (Get-Date).AddSeconds($expires_in - 60).ToUniversalTime()

        Print-Heading "Initial Access Token Obtained"
        Write-Host "Access Token: $ACCESS_TOKEN" -ForegroundColor Green
        if ($REFRESH_TOKEN) {
            Write-Host "Refresh Token: $REFRESH_TOKEN" -ForegroundColor Green
        }
    } else {
        Print-Heading "Failed to Obtain Initial Tokens"
        Write-Host (ConvertTo-Json $response -Depth 4) -ForegroundColor Red
    }
}

function Get-New-Access-Token {
    param ()

    $headers = @{
        Authorization = "Bearer $ACCESS_TOKEN"
    }
    $payload = @{
        grant_type    = $REFRESH_GRANT_TYPE
        refresh_token = $REFRESH_TOKEN
    }

    $response = Invoke-RestMethod -Uri $TOKEN_URL -Method Post -Headers $headers -Body $payload

    if ($response -ne $null) {
        $global:ACCESS_TOKEN = $response.access_token
        $expires_in = $response.expires_in
        $global:TOKEN_EXPIRES_AT = (Get-Date).AddSeconds($expires_in - 60).ToUniversalTime()

        Print-Heading "New Access Token Obtained"
        Write-Host "Access Token: $ACCESS_TOKEN" -ForegroundColor Green
        if ($response.refresh_token) {
            $global:REFRESH_TOKEN = $response.refresh_token
            Write-Host "Refresh Token: $REFRESH_TOKEN" -ForegroundColor Green
        }
        # Call the test API after refreshing the token
        Call-Test-API
    } else {
        Print-Heading "Failed to Refresh Token"
        Write-Host (ConvertTo-Json $response -Depth 4) -ForegroundColor Red
    }
}

function Ensure-Valid-Token {
    param (
        [bool]$mimic_expired
    )

    if ($mimic_expired -or ((Get-Date).ToUniversalTime() -gt $TOKEN_EXPIRES_AT)) {
        Print-Heading "Access Token Expired"
        Write-Host "Refreshing..."
        Get-New-Access-Token
    } else {
        Print-Heading "Access Token is Still Valid"
        # Call the test API if the token is still valid
        Call-Test-API
    }
}

function Call-Test-API {
    param ()

    $headers = @{
        Authorization = "Bearer $ACCESS_TOKEN"
    }

    $response = Invoke-RestMethod -Uri $TEST_API_URL -Method Get -Headers $headers
    
    if ($response -ne $null) {
        Print-Heading "Test API Call Successful"
        Write-Host (ConvertTo-Json $response -Depth 4) -ForegroundColor Green
    } else {
        Print-Heading "Test API Call Failed"
        Write-Host "Status Code: $($response.StatusCode)" -ForegroundColor Red
        Write-Host (ConvertTo-Json $response -Depth 4) -ForegroundColor Red
    }
}

function Main {
    param (
        [switch]$mimic_expired
    )

    Print-Heading "Starting Token Acquisition"
    Get-Initial-Tokens
    Ensure-Valid-Token -mimic_expired:$mimic_expired
}

Main @args
