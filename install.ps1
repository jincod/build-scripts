$baseUrl = "https://raw.githubusercontent.com/jincod/build-scripts/master/"

function downloadWithConfirm ($url, $out) {
    if (Test-Path $out) {
        Write-Host "$out exists. Override: Y/N?"

        if ((read-host) -like "*y*") {
            Invoke-WebRequest $url -OutFile $out
        } else {
            Write-Host "Skip $out"
        }
    } else {
        Invoke-WebRequest $url -OutFile $out
    }
}

downloadWithConfirm "${baseUrl}/build-scripts/build.cake" build.cake
downloadWithConfirm "${baseUrl}/build-scripts/build.cmd" build.cmd
