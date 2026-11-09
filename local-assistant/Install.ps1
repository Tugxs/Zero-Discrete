$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
New-Item -ItemType Directory -Force (Join-Path $root 'runtime'),(Join-Path $root 'models') | Out-Null
$packages = @(
  @{Repo='anomalyco/opencode';Tag='v1.19.5';File='opencode-windows-x64.zip';Folder='opencode'},
  @{Repo='ollama/ollama';Tag='v0.40.15';File='ollama-windows-amd64.zip';Folder='ollama'}
)
foreach ($pkg in $packages) {
  $zip = Join-Path $root ('runtime/' + $pkg.File)
  $url = 'https://github.com/' + $pkg.Repo + '/releases/download/' + $pkg.Tag + '/' + $pkg.File
  & curl.exe -L --fail --show-error $url -o $zip
  if ($LASTEXITCODE -ne 0) { throw "Download failed: $url" }
  Expand-Archive -LiteralPath $zip -DestinationPath (Join-Path $root ('runtime/' + $pkg.Folder)) -Force
}
$env:OLLAMA_MODELS = Join-Path $root 'models'
try { Invoke-RestMethod 'http://127.0.0.1:11434/api/version' | Out-Null } catch {
  Start-Process -FilePath (Join-Path $root 'runtime/ollama/ollama.exe') -ArgumentList 'serve' -WindowStyle Hidden
  Start-Sleep -Seconds 3
}
& (Join-Path $root 'runtime/ollama/ollama.exe') pull qwen3.5:4b
if ($LASTEXITCODE -ne 0) { throw 'Model download failed. Run installer again to resume.' }
$body = @{model='zero-discrete';from='qwen3.5:4b';parameters=@{num_ctx=65536;num_gpu=20;temperature=0.4};stream=$false} | ConvertTo-Json -Depth 5
Invoke-RestMethod 'http://127.0.0.1:11434/api/create' -Method Post -ContentType 'application/json' -Body $body -TimeoutSec 60 | Out-Null
