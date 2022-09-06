Set-Alias ll ls
if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineKeyHandler -Chord "Ctrl+j" -Function NextHistory
    Set-PSReadLineKeyHandler -Chord "Ctrl+k" -Function PreviousHistory
}