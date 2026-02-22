document.getElementById('start-btn').addEventListener('click', function() {
    // 1. Switch Screens
    document.getElementById('landing-page').classList.add('hidden');
    document.getElementById('celebration-zone').classList.remove('hidden');

    // 2. Play Music (You must add the audio file for this to work)
    const music = document.getElementById('bday-music');
    music.play().catch(e => console.log("Audio requires user interaction first."));

    // 3. Start Balloon Rain
    setInterval(createBalloon, 500);
});

function createBalloon() {
    const container = document.getElementById('balloon-container');
    const balloon = document.createElement('div');
    balloon.className = 'balloon';
    
    // Randomize balloon properties
    const colors = ['#ff007a', '#00f2ff', '#ffd700', '#00ff44'];
    const randomColor = colors[Math.floor(Math.random() * colors.length)];
    const randomLeft = Math.floor(Math.random() * 100);
    
    balloon.style.left = randomLeft + 'vw';
    balloon.style.backgroundColor = randomColor;
    balloon.style.boxShadow = `0 0 10px ${randomColor}`;
    
    container.appendChild(balloon);

    // Remove balloon from DOM after animation
    setTimeout(() => {
        balloon.remove();
    }, 6000);
}