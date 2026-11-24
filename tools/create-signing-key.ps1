$ErrorActionPreference = 'Stop'
$path = Join-Path $PWD 'offlinetv.jks'
if (Test-Path $path) { throw 'Key already exists. Back it up; do not overwrite.' }
& keytool -genkeypair -v -keystore $path -storetype JKS -alias offlinetv -keyalg RSA -keysize 2048 -validity 10000
if ($LASTEXITCODE -ne 0) { throw 'keytool failed' }
[Convert]::ToBase64String([IO.File]::ReadAllBytes($path)) | Set-Clipboard
Write-Host 'Base64 key copied to clipboard. Paste into ANDROID_KEYSTORE_BASE64 GitHub secret. Keep the JKS and passwords private.'
