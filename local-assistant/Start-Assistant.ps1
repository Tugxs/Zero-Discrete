$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$env:OLLAMA_MODELS = Join-Path $root 'models'
$env:OLLAMA_HOST = '127.0.0.1:11434'
$env:OLLAMA_CONTEXT_LENGTH = '65536'
$env:OLLAMA_NUM_PARALLEL = '1'
$env:OLLAMA_MAX_LOADED_MODELS = '1'
try { Invoke-RestMethod 'http://127.0.0.1:11434/api/version' | Out-Null } catch {
  Start-Process -FilePath (Join-Path $root 'runtime/ollama/ollama.exe') -ArgumentList 'serve' -WindowStyle Hidden
  Start-Sleep -Seconds 3
}
Set-Location -LiteralPath $root
try {
  $web = Invoke-RestMethod 'http://127.0.0.1:4096/global/health' -TimeoutSec 2
  if ($web.healthy) { Start-Process 'http://127.0.0.1:4096'; exit }
} catch {}
& (Join-Path $root 'runtime/opencode/opencode.exe') web --hostname 127.0.0.1 --port 4096
