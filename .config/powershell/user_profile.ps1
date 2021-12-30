# Prompt
Import-Module posh-git
Import-Module oh-my-posh

# Load Prompt Config
function Get-ScriptDirectory{ Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'coolpants.omp.json'
oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression

#Icons
Import-Module -Name Terminal-icons

#PSReadline
Set-PSReadLineOption  -EditMode Emacs
Set-PSReadLineOption  -BellStyle None
Set-PSReadLineKeyHandler  -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption  -PredictionSource History

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Alias
Set-Alias vim neovide
Set-Alias nvim neovide
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Utils
function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue |
	  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Startapp as admin 
function plsOpen($app){
        Start-Process $app -Verb runAs
}

# This is for chennai change to your airport code
function weather(){
        while(1){
                Invoke-RestMethod wttr.in/maa?0 
                Start-Sleep -Seconds 600
                Clear-Host
        }
}

#function removeAudio($file){
#        $name = [System.IO.Path]::GetFileNameWithoutExtension($file)
#        $ext = [System.IO.Path]::GetExtension($file)
#        ffmpeg -i $file -vcodec copy -an "$name-noAudio$ext"
#}
#
#function compressVideo($file){
#        $name = [System.IO.Path]::GetFileNameWithoutExtension($file)
#        $ext = [System.IO.Path]::GetExtension($file)
#        ffmpeg -i $file -vcodec libx265 -crf 28 "$name-compressed$ext"
#}

#tree view of dir
function lstree{
        tree . /F
}

function Update-File
{
    $file = $args[0]
    if($null -eq $file) {
        throw "No filename supplied"
    }

    if(Test-Path $file)
    {
        (Get-ChildItem $file).LastWriteTime = Get-Date
    }
    else
    {
        New-Item $file
    }
}

function Update-And-Code {
        $file = $args[0]
        Update-File $file
        nvim $file
}

function wc{
        $args[0] | Measure-Object -Word
}

# Quick access to powershell and wezterm config files

function wezc{
        nvim $env:USERPROFILE\dotfiles\wezterm\wezterm.lua
}

function powc{
        nvim $env:USERPROFILE\dotfiles\.config\powershell\user_profile.ps1
}

Set-Alias touch Update-File
Set-Alias tc Update-And-Code
