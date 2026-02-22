let sentences = []; // Start with an empty array
let index = 0;

async function init() {
    try {
        // 1. Fetch the JSON file
        const response = await fetch('sentences.json');
        const data = await response.json();
        
        // 2. Assign the array to our variable
        sentences = data.texts;

        // 3. Start the animation only after data is loaded
        if (sentences.length > 0) {
            writeText();
        }
    } catch (error) {
        console.error("Error loading sentences:", error);
    }
}

function writeText() {
    const textSpan = document.getElementById("text");
    if (!textSpan) return;

    if (index >= sentences.length) {
        index = 0; // Loop back to the start
    }

    const text = sentences[index];
    let i = 0;

    function type() {
        if (i < text.length) {
            textSpan.textContent += text.charAt(i);
            i++;
            setTimeout(type, 80);
        } else {
            setTimeout(eraseText, 1800);
        }
    }

    function eraseText() {
        if (i >= 0) {
            textSpan.textContent = text.substring(0, i);
            i--;
            setTimeout(eraseText, 20);
        } else {
            index++;
            setTimeout(writeText, 600);
        }
    }

    type();
}

// Initialize the process
init();