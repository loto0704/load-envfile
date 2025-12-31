function Get-Env {
    param(
        [Parameter(Position = 0)]
        [string]$FilePath = ".env"
    )

    if (-not (Test-Path $FilePath)) {
        Write-Error "ファイルが見つかりません: $FilePath"
        return $null
    }

    $envData = @{}

    foreach ($line in Get-Content $FilePath) {
        # 空行とコメント行（#）をスキップ
        if ($line -match '^\s*$' -and $line -match '^\s*#') { continue }

        # Key=Value の形式を解析
        if ($line -match '^([^=]+)=(.*)$') {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim()

            # 前後の引用符（' または "）を除去
            $value = $value -replace '^["'']|["'']$', ''

            # 連想配列に追加
            $envData[$key] = $value
        }
    }

    return $envData
}
