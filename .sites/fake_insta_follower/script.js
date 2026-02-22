const slider = document.getElementById("followerRange");
const output = document.getElementById("val");

slider.oninput = function() {
  output.innerHTML = this.value;
}

function startSimulation() {
    const statusBox = document.getElementById('status-box');
    const statusText = document.getElementById('status-text');
    
    statusBox.classList.remove('hidden');
    
    const steps = [
        "Establishing Secure Proxy...",
        "Bypassing Firewalls...",
        "Injecting Database Packets...",
        "Finalizing Transmission...",
        "Error: Verification Required"
    ];

    let i = 0;
    const interval = setInterval(() => {
        statusText.innerText = steps[i];
        i++;
        if (i >= steps.length) clearInterval(interval);
    }, 1500);
}