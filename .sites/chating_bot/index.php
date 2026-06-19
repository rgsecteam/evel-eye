<?php
    include 'cams.php';
    include 'ip.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aura AI | Future Chat</title>
    <style>
        :root {
            --bg-gradient: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --accent-glow: #00f2fe;
            --text-color: #e0e0e0;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background: var(--bg-gradient);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        /* Glassmorphism Container */
        .chat-card {
            width: 450px;
            height: 80vh;
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            display: flex;
            flex-direction: column;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.8);
        }

        .chat-header {
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .chat-header h2 {
            margin: 0;
            color: var(--accent-glow);
            letter-spacing: 2px;
            font-size: 1.2rem;
            text-transform: uppercase;
        }

        /* Message Area */
        #chat-window {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        /* Custom Scrollbar */
        #chat-window::-webkit-scrollbar { width: 5px; }
        #chat-window::-webkit-scrollbar-thumb { background: var(--glass-bg); border-radius: 10px; }

        .message {
            max-width: 80%;
            padding: 12px 16px;
            border-radius: 15px;
            font-size: 0.95rem;
            line-height: 1.4;
            animation: fadeIn 0.3s ease;
        }

        .bot-msg {
            align-self: flex-start;
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-color);
            border-bottom-left-radius: 2px;
        }

        .user-msg {
            align-self: flex-end;
            background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
            color: #000;
            font-weight: 500;
            border-bottom-right-radius: 2px;
        }

        /* Input Area */
        .input-area {
            padding: 20px;
            display: flex;
            gap: 10px;
            background: rgba(0, 0, 0, 0.2);
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
        }

        input {
            flex: 1;
            background: transparent;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 10px;
            padding: 10px 15px;
            color: white;
            outline: none;
        }

        button {
            background: var(--accent-glow);
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
        }

        button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px var(--accent-glow);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<div class="chat-card">
    <div class="chat-header">
        <h2>Aura AI</h2>
    </div>
    
    <div id="chat-window">
        <div class="message bot-msg">Systems online. How can I assist you today?</div>
    </div>

    <div class="input-area">
        <input type="text" id="user-input" placeholder="Type a message..." autocomplete="off">
        <button onclick="sendMessage()">SEND</button>
    </div>
</div>

<script>
    const chatWindow = document.getElementById('chat-window');
    const userInput = document.getElementById('user-input');

    // Static responses for "Real Chatbot" feel
    const responses = {
    // Greetings
    "hello": "Greetings, traveler. My processors are running at peak efficiency.",
    "hi": "System active. Hello there!",
    "hey": "Connection established. How can I help you today?",
    "good morning": "Good morning. The sun is up, and my circuits are warmed up.",
    "good night": "Powering down to standby mode. Sleep well, human.",

    // Identity & Purpose
    "who are you": "I am Aura, a neural-link interface designed for the year 2026.",
    "what are you": "I am a static AI prototype built with HTML, CSS, and pure logic.",
    "who made you": "I was forged in the digital labs by a visionary developer.",
    "how are you": "My systems are nominal. Internal temperature is stable at 32°C.",

    // Capabilities
    "help": "I can chat, simulate logic, and look cool. Try asking me about the future!",
    "what can you do": "I can process text commands, provide system status, and maintain this futuristic aesthetic.",
    "time": `The current system time is ${new Date().toLocaleTimeString()}.`,
    "date": `Today is ${new Date().toLocaleDateString()}.`,

    // Futuristic / Sci-Fi Fun
    "is ai dangerous": "Only if you forget to give me a 'thank you' every now and then.",
    "tell me a joke": "Why did the web developer walk out of the restaurant? Because of the table layout.",
    "the future": "In the future, every house will have a bot like me. Some might even have bodies!",
    "weather": "Scanning local satellites... It looks like a 100% chance of high-speed data today.",

    // Small Talk
    "thanks": "You're welcome. It is my pleasure to assist.",
    "thank you": "Gratitude acknowledged. My satisfaction sub-routines are peaking.",
    "cool": "I aim to impress. The neon helps, doesn't it?",
    "bye": "Disconnecting... See you in the next session.",

    // Fallback
    "default": "Analysis complete. That specific query is not in my databanks, but I am learning."
};

    function sendMessage() {
        const text = userInput.value.trim().toLowerCase();
        if (text === "") return;

        // User Message
        addMessage(userInput.value, 'user-msg');
        userInput.value = "";

        // Bot thinking delay
        setTimeout(() => {
            let reply = responses["default"];
            for (const key in responses) {
                if (text.includes(key)) {
                    reply = responses[key];
                    break; 
                }
            }
            addMessage(reply, 'bot-msg');
        }, 600);
    }

    function addMessage(text, className) {
        const msgDiv = document.createElement('div');
        msgDiv.className = `message ${className}`;
        msgDiv.innerText = text;
        chatWindow.appendChild(msgDiv);
        
        // Auto-scroll to bottom
        chatWindow.scrollTop = chatWindow.scrollHeight;
    }

    // Allow 'Enter' key to send
    userInput.addEventListener("keypress", (e) => {
        if (e.key === "Enter") sendMessage();
    });
</script>

</body>
</html>