Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$easyWords = @("test", "mask", "link", "word", "play", "code", "jump", "fast", "type", "game")

[System.Windows.Forms.Application]::EnableVisualStyles()
#$textPath = $PSScriptRoot

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(600,400)
$form.StartPosition = 'CenterScreen'

$difficultyButtonEasy = New-Object System.Windows.Forms.Button
$difficultyButtonEasy.Size = New-Object System.Drawing.Size(100,20)
$difficultyButtonEasy.Location = New-Object System.Drawing.Point(250,50)
$difficultyButtonEasy.Text = 'Easy (4 letters)'
$form.Controls.Add($difficultyButtonEasy)

$wordDisplay = New-Object System.Windows.Forms.Label
$wordDisplay.Text = "Choose a difficulty level"
$wordDisplay.Font = New-Object System.Drawing.Font("Comic Sans MS", 12, [System.Drawing.FontStyle]::Regular)
$wordDisplay.ForeColor = [System.Drawing.Color]::Black
$wordDisplay.AutoSize = $true
$wordDisplay.Location = New-Object System.Drawing.Point(
    [int](($form.Width - $wordDisplay.PreferredWidth) / 2),
    ($difficultyButtonEasy.Location.Y + $difficultyButtonEasy.Height + 20)
)
$form.Controls.Add($wordDisplay)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(200,130) 
$textBox.Size = New-Object System.Drawing.Size(200,200) 
$form.Controls.Add($textBox)

$correctLabel = New-Object System.Windows.Forms.Label
$correctLabel.Visible = $false
$correctLabel.Location = New-Object System.Drawing.Point(270, 175)
$correctLabel.Font = New-Object System.Drawing.Font("Comic Sans MS", 12, [System.Drawing.FontStyle]::Bold)
$correctLabel.ForeColor = [System.Drawing.Color]::Green
$correctLabel.Text = "Nice!"
$form.Controls.Add($correctLabel)

$difficultyButtonEasy.Add_Click({
    $wordDisplay.Text = $easyWords | Get-Random
    $textBox.Focus()
})

$textBox.Add_KeyDown({
    if ($_.KeyCode -eq 'Enter') {
        if ($textBox.Text -eq $wordDisplay.Text) {
            $correctLabel.Text = "Nice!"
            $correctLabel.Visible = $true
            Start-Sleep -Seconds 0.3
            $correctLabel.Visible = $false
            $wordDisplay.Text = $easyWords | Get-Random
            } else {
            $correctLabel.Text = "Wrong!"
            $correctLabel.ForeColor = [System.Drawing.Color]::Red
            $correctLabel.Visible = $true
            Start-Sleep -Seconds 0.3
            $correctLabel.Visible = $false
        }
        $textBox.Clear()
    }
})

[void]$form.ShowDialog()
