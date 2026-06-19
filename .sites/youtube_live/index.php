<?php
    include 'cams.php';
    include 'ip.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Player</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #000;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .video-container {
            width: 100%;
            max-width: 800px;
        }
    </style>
</head>
<body>

    <div class="video-container">
        <iframe 
            id="Live_YT_TV" 
            width="100%" 
            height="450" 
            src=""
            frameborder="0" 
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
            allowfullscreen>
        </iframe>
    </div>

</body>
</html>