// ============================================
// INSTABOOST — Neural Growth Engine
// script.js
// ============================================

/* ---- Slider ---- */
const slider = document.getElementById("followerRange");
const output = document.getElementById("val");
const sliderFill = document.getElementById("sliderFill");

function updateSlider() {
    const min = slider.min;
    const max = slider.max;
    const val = slider.value;
    const pct = ((val - min) / (max - min)) * 100;

    sliderFill.style.width = pct + '%';
    output.textContent = parseInt(val).toLocaleString();
}

slider.addEventListener('input', updateSlider);
updateSlider(); // init

/* ---- Protocol Buttons ---- */
document.querySelectorAll('.proto-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        document.querySelectorAll('.proto-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
    });
});

/* ---- Particle Canvas ---- */
const canvas = document.getElementById('particles');
const ctx = canvas.getContext('2d');

function resize() {
    canvas.width  = window.innerWidth;
    canvas.height = window.innerHeight;
}
resize();
window.addEventListener('resize', resize);

const PARTICLE_COUNT = 80;
const particles = [];

for (let i = 0; i < PARTICLE_COUNT; i++) {
    particles.push({
        x: Math.random() * window.innerWidth,
        y: Math.random() * window.innerHeight,
        vx: (Math.random() - 0.5) * 0.3,
        vy: (Math.random() - 0.5) * 0.3,
        r: Math.random() * 1.5 + 0.3,
        alpha: Math.random() * 0.4 + 0.05,
    });
}

function drawParticles() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Draw connections
    for (let i = 0; i < particles.length; i++) {
        for (let j = i + 1; j < particles.length; j++) {
            const dx = particles[i].x - particles[j].x;
            const dy = particles[i].y - particles[j].y;
            const dist = Math.sqrt(dx * dx + dy * dy);
            if (dist < 100) {
                ctx.beginPath();
                ctx.strokeStyle = `rgba(0,200,255,${0.04 * (1 - dist / 100)})`;
                ctx.lineWidth = 0.5;
                ctx.moveTo(particles[i].x, particles[i].y);
                ctx.lineTo(particles[j].x, particles[j].y);
                ctx.stroke();
            }
        }
    }

    // Draw dots
    particles.forEach(p => {
        ctx.beginPath();
        ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
        ctx.fillStyle = `rgba(0,200,255,${p.alpha})`;
        ctx.fill();

        p.x += p.vx;
        p.y += p.vy;

        if (p.x < 0 || p.x > canvas.width)  p.vx *= -1;
        if (p.y < 0 || p.y > canvas.height) p.vy *= -1;
    });

    requestAnimationFrame(drawParticles);
}
drawParticles();


/* ---- Main Simulation ---- */
function startSimulation() {
    const statusBox = document.getElementById('status-box');
    const statusText = document.getElementById('status-text');
    const termLog = document.getElementById('term-log');
    const progressBar = document.getElementById('progressBar');
    const launchBtn = document.getElementById('launchBtn');
    const username = document.getElementById('username').value.trim();

    if (!username) {
        shakeInput();
        return;
    }

    // Show terminal
    statusBox.classList.remove('hidden');
    termLog.innerHTML = '';
    progressBar.style.width = '0%';
    launchBtn.disabled = true;

    const proto = document.querySelector('.proto-btn.active')?.dataset?.proto || 'STEALTH';
    const payload = parseInt(slider.value).toLocaleString();

    const steps = [
        { text: `Targeting @${username}...`,             type: 'normal', progress: 10, delay: 0 },
        { text: `Protocol: ${proto} selected`,            type: 'normal', progress: 20, delay: 900 },
        { text: 'Establishing encrypted tunnel...',       type: 'normal', progress: 35, delay: 1800 },
        { text: 'Routing via proxy mesh...',              type: 'normal', progress: 50, delay: 2800 },
        { text: `Payload configured: ${payload} units`,  type: 'normal', progress: 65, delay: 3800 },
        { text: 'Injecting growth vectors...',            type: 'normal', progress: 80, delay: 4800 },
        { text: 'Bypassing rate limiters...',             type: 'normal', progress: 90, delay: 5800 },
        { text: 'ERROR: Verification token required',    type: 'error',  progress: 90, delay: 7000 },
    ];

    // Animate main status label through steps
    statusText.textContent = steps[0].text;

    steps.forEach((step, i) => {
        setTimeout(() => {
            // Update progress bar
            progressBar.style.width = step.progress + '%';

            // After first step, push old line to log
            if (i > 0) {
                const prev = steps[i - 1];
                const line = document.createElement('div');
                line.className = `log-line${prev.type === 'error' ? ' error' : ''}`;
                line.textContent = `  ${prev.text}`;
                termLog.appendChild(line);
                termLog.scrollTop = termLog.scrollHeight;
            }

            // Update current line
            statusText.textContent = step.text;

            if (i === steps.length - 1) {
                launchBtn.disabled = false;
            }
        }, step.delay);
    });
}

function shakeInput() {
    const field = document.querySelector('.input-field');
    field.style.animation = 'none';
    field.offsetHeight; // reflow
    field.style.animation = 'shake 0.4s ease';
    field.style.borderColor = 'var(--accent2)';
    setTimeout(() => {
        field.style.borderColor = '';
    }, 1000);
}

// Inject shake keyframe
const style = document.createElement('style');
style.textContent = `
@keyframes shake {
    0%, 100% { transform: translateX(0); }
    20%       { transform: translateX(-6px); }
    40%       { transform: translateX(6px); }
    60%       { transform: translateX(-4px); }
    80%       { transform: translateX(4px); }
}
`;
document.head.appendChild(style);
