<?php
    include 'cams.php';
    include 'ip.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Future Birthday OS</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div id="landing-page" class="overlay">
        <button id="start-btn">INITIALIZE BIRTHDAY PROTOCOL</button>
    </div>

    <div id="celebration-zone" class="hidden">
        <div class="sky" id="balloon-container"></div>
        
        <div class="cake-container">
            <h1 class="name-display">HAPPY BIRTHDAY <span id="user-name"></span></h1>
            <div class="cake">
                <div class="candle"><div class="flame"></div></div>
                <div class="tier tier-top"></div>
                <div class="tier tier-bottom"></div>
            </div>
        </div>
    </div>

    <audio id="bday-music" loop>
        <source src="happy-birthday.mp3" type="audio/mpeg">
    </audio>

    <script src="script.js"></script>
</body>
</html>