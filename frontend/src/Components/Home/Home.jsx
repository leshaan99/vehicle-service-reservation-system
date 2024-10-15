import React from 'react';
import './Home.css'; 

const Home = () => {
  return (
    <div className="home-container">
      <div className="content">
        <h1>Vehicle Service Reservation</h1>
        <a href="/login" className="btn">Login</a>
      </div>
    </div>
  );
};

export default Home;

