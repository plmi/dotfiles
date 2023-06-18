Set-Alias ll ls

if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineKeyHandler -Chord "Ctrl+j" -Function NextHistory
    Set-PSReadLineKeyHandler -Chord "Ctrl+k" -Function PreviousHistory
}

function sha256sum() {
  param(
    [string] $filename
  )

  certUtil -hashfile $filename SHA256 | Select -Index 1
}

function md5sum() {
  param(
    [string] $filename
  )

  certUtil -hashfile $filename MD5 | Select -Index 1
}

function sha1sum() {
  param(
    [string] $filename
  )

  certUtil -hashfile $filename SHA1 | Select -Index 1
}

