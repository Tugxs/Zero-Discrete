$ErrorActionPreference = 'Stop'
$env:OLLAMA_MODELS = Join-Path $PSScriptRoot 'models'
& (Join-Path $PSScriptRoot 'runtime/ollama/ollama.exe') pull qwen3-coder:30b
if ($LASTEXITCODE -ne 0) { throw 'Model download failed. Re-run to resume.' }
Write-Host 'Ready: select Local Coder 30B in OpenCode. This model can be slow with an 8GB GPU.'
