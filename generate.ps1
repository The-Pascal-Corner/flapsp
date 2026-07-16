param(
  [string]$RomsDir = "roms",
  [string]$OutputHtml = "menu.html"
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RomsPath = Join-Path $ScriptDir $RomsDir
$HtmlPath = Join-Path $ScriptDir $OutputHtml

if (-not (Test-Path $RomsPath)) {
  Write-Host "ERROR: roms dir not found at $RomsPath" -ForegroundColor Red
  exit 1
}

$swfFiles = Get-ChildItem -LiteralPath $RomsPath -Filter "*.swf" -File | Sort-Object Name
Write-Host "Found $($swfFiles.Count) .swf files"

$names = @()
$swfFiles | ForEach-Object { $names += $_.BaseName }

$gameCount = $names.Count

# Build games array in lines of 8 names
$jsLines = @()
$line = @()
$i = 0
foreach ($n in $names) {
  $line += "`"$n`""
  $i++
  if ($i % 8 -eq 0) {
    $jsLines += $line -join ","
    $line = @()
  }
}
if ($line.Count -gt 0) { $jsLines += $line -join "," }

$jsGames = ($jsLines | ForEach-Object { "  $_" }) -join ",`n"

$html = @"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FLAPSP - $gameCount PSP Flash Games</title>
<style type="text/css">
* { margin:0; padding:0; }
body { background:#0a0a0a; color:#ccc; font-family:Arial,Helvetica,sans-serif; font-size:14px; padding:6px; }
a { text-decoration:none; }
.header { text-align:center; padding:10px 0 8px 0; border-bottom:2px solid #4FC3F7; margin-bottom:6px; }
.header h1 { color:#fff; font-size:20px; letter-spacing:3px; }
.header p { color:#888; font-size:11px; margin-top:2px; }
.header p a { color:#4FC3F7; }
.footer { text-align:center; font-size:10px; color:#555; padding:8px 0; border-top:1px solid #333; margin-top:8px; }
.footer a { color:#555; }
.controls { padding:6px; background:#0a0a0a; border-bottom:1px solid #333; margin-bottom:6px; }
.controls input { width:100%; background:#1a1a1a; color:#ccc; border:1px solid #444; padding:3px 0; font-size:12px; }
.card { border:1px solid #333; margin-bottom:4px; padding:6px 10px; }
.card a { color:#fff; }
.none { padding:20px; text-align:center; color:#666; font-size:14px; }
</style>
</head>
<body>

<div class="header">
  <h1>FLAPSP</h1>
  <p>PSP Flash Games &mdash; <span id="gameCount"></span> games</p>
</div>

<div class="controls">
  <input type="text" id="searchBox" onkeyup="renderGames()" placeholder="Tim game...">
</div>

<div id="gameList"></div>

<div class="footer">
  FLAPSP by <a href="https://github.com/The-Pascal-Corner">The Pascal Corner</a>
</div>

<script type="text/javascript" language="JavaScript">
var games = [
$jsGames
];
var searchBox, gameList, countSpan;

function init() {
  searchBox = document.getElementById('searchBox');
  gameList = document.getElementById('gameList');
  countSpan = document.getElementById('gameCount');
  renderGames();
}

function renderGames() {
  var q = searchBox.value;
  q = q.toLowerCase();
  var html = '';
  var count = 0;
  var i;
  for (i = 0; i < games.length; i++) {
    if (q != '' && games[i].toLowerCase().indexOf(q) < 0) continue;
    html += '<div class="card"><a href="roms/' + games[i] + '.swf">' + games[i] + '</a></div>';
    count++;
  }
  if (count == 0 && q != '') {
    html = '<div class="none">No games found</div>';
  } else if (count == 0) {
    html = '<div class="none">No games</div>';
  }
  gameList.innerHTML = html;
  countSpan.innerHTML = '' + count;
}

init();
</script>

</body>
</html>
"@

$html | Set-Content -LiteralPath $HtmlPath -Encoding ASCII

Write-Host "Generated $OutputHtml - $gameCount games" -ForegroundColor Green
