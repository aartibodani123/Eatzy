// src/components/signup/RightPanel.jsx

import Footer from "../../common/Footer";

function RightPanel() {
  return (
    <div className="right-panel">
      
      {/* Top badge */}
      <div className="rating-box">
        <div className="time">
          <h2>30</h2>
          <span>min</span>
        </div>

        <div className="rating">
          <h3>4.8</h3>
          <div className="stars">⭐⭐⭐⭐⭐</div>
        </div>
      </div>

      {/* Main Heading */}
      <div className="hero-text">
        <h1>
          Fast • Fresh <br />
          <span>Delivered</span>
        </h1>
      </div>

      {/* Features */}
      <div className="features">
        <div className="feature">
          ⚡ <span>30 min or it's free</span>
        </div>
        <div className="feature">
          🍃 <span>100% fresh</span>
        </div>
      </div>

      {/* Footer */}
      <Footer />
    </div>
  );
}

export default RightPanel;