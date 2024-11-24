document.addEventListener("DOMContentLoaded", () => {
  const grid = document.getElementById("grid");
  const popup = document.getElementById("popup");
  const form = document.getElementById("pixelForm");
  const togglePurchaseModeButton = document.getElementById("togglePurchaseMode");

  let purchaseModeEnabled = false;
  let selectedPixel = null;

  // Toggle purchase mode
  togglePurchaseModeButton.addEventListener("click", () => {
    purchaseModeEnabled = !purchaseModeEnabled;
    togglePurchaseModeButton.textContent = purchaseModeEnabled
      ? "Viewing Mode"
      : "Purchase Pixels";

    alert(
      purchaseModeEnabled
        ? "Purchase mode enabled. You can now select a pixel to buy."
        : "Viewing mode enabled. You can only view purchased pixels."
    );
  });

  // Create the grid
  for (let y = 0; y < 100; y++) {
    for (let x = 0; x < 100; x++) {
      const pixel = document.createElement("div");
      pixel.classList.add("pixel");
      pixel.dataset.x = x;
      pixel.dataset.y = y;
      pixel.addEventListener("click", () => handlePixelClick(x, y, pixel));
      grid.appendChild(pixel);
    }
  }

  function handlePixelClick(x, y, pixel) {
    if (pixel.classList.contains("purchased")) {
      if (purchaseModeEnabled) {
        alert("This pixel has already been purchased.");
      } else {
        const targetUrl = pixel.getAttribute("data-target-url");
        if (targetUrl) {
          window.open(targetUrl, "_blank");
        }
      }
      return;
    }

    if (!purchaseModeEnabled) {
      return; // Do nothing in viewing mode for unpurchased pixels
    }

    selectedPixel = { x, y };
    popup.style.display = "block";
  }

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const ownerName = document.getElementById("ownerName").value;
    const imageUrl = document.getElementById("imageUrl").value;
    const targetUrl = document.getElementById("targetUrl").value;
    const altText = document.getElementById("altText").value;

    const pixelData = {
      x: selectedPixel.x,
      y: selectedPixel.y,
      owner_name: ownerName,
      image_url: imageUrl,
      target_url: targetUrl,
      alt_text: altText,
    };

    fetch("http://127.0.0.1:5000/api/buy_pixel", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(pixelData),
    })
      .then((res) => res.json())
      .then((data) => {
        if (data.status === "success") {
          alert("Pixel purchased successfully!");
          hidePopup();
          loadPurchasedPixels(); // Refresh the grid
        } else {
          alert(data.message || "Error purchasing pixel.");
        }
      })
      .catch((error) => {
        console.error("Error:", error);
        alert("Server error. Please try again later.");
      });
  });

  // Hide popup
  function hidePopup() {
    popup.style.display = "none";
  }

  document.getElementById("closePopup").addEventListener("click", hidePopup);

  // Load purchased pixels
  function loadPurchasedPixels() {
    fetch("http://127.0.0.1:5000/api/get_pixels")
      .then((res) => res.json())
      .then((pixels) => {
        pixels.forEach(({ x, y, image_url, target_url, alt_text }) => {
          const pixelDiv = document.querySelector(
            `.pixel[data-x='${x}'][data-y='${y}']`
          );
          if (pixelDiv) {
            pixelDiv.style.backgroundImage = `url(${image_url})`;
            pixelDiv.style.backgroundSize = "cover";
            pixelDiv.title = alt_text;
            pixelDiv.classList.add("purchased");
            pixelDiv.setAttribute("data-target-url", target_url);
          }
        });
      })
      .catch((error) => console.error("Error loading pixels:", error));
  }

  loadPurchasedPixels(); // Initialize grid with purchased pixels
});
