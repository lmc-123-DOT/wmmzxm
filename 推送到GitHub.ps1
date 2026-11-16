# 推送到 GitHub —— 在「D:\大肥鱼\我的相册」目录下运行
# 用法：右键这个文件 -> 使用 PowerShell 运行
#      或者打开 PowerShell，cd 到该目录后执行 .\推送到GitHub.ps1

$user = Read-Host "输入你的 GitHub 用户名"
if ([string]::IsNullOrWhiteSpace($user)) { Write-Host "没输入用户名，退出"; exit }
$repo = "album"

Set-Location "D:\大肥鱼\我的相册"

Write-Host ""
Write-Host "== 1/3 配置 Git 身份 ==" -ForegroundColor Cyan
git config user.name "$user"
git config user.email "$user@users.noreply.github.com"
Write-Host "  作者：$user <$user@users.noreply.github.com>"

Write-Host ""
Write-Host "== 2/3 关联远程仓库 ==" -ForegroundColor Cyan
git remote remove origin 2>$null
git remote add origin "https://github.com/$user/$repo.git"
Write-Host "  origin -> https://github.com/$user/$repo.git"

Write-Host ""
Write-Host "== 3/3 推送 ==" -ForegroundColor Cyan
Write-Host "  弹窗时：用户名填 $user" -ForegroundColor Yellow
Write-Host "         密码粘贴你的 token（ghp_ 开头那串）" -ForegroundColor Yellow
Write-Host ""
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "推送成功！" -ForegroundColor Green
    Write-Host ""
    Write-Host "下一步：去开 Pages" -ForegroundColor Cyan
    Write-Host "  https://github.com/$user/$repo/settings/pages" -ForegroundColor White
    Write-Host "  Source 选 Deploy from a branch，Branch 选 main / (root)，点 Save"
    Write-Host ""
    Write-Host "等 1~2 分钟，你的链接就是：" -ForegroundColor Cyan
    Write-Host "  https://$user.github.io/$repo/" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "推送失败。常见原因：" -ForegroundColor Red
    Write-Host "  1. 仓库还没建 —— 先去 https://github.com/new 建一个叫 album 的公开仓库"
    Write-Host "  2. token 没勾 repo 权限 —— 重新生成一个"
    Write-Host "  3. 用户名或仓库名写错"
}

Write-Host ""
Read-Host "按回车关闭"
