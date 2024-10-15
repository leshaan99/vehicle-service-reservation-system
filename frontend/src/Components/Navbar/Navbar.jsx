import React from 'react';
import './Navbar.css'; 
import Home from '../Home/Home';

const Navbar = () => {
  return (
    <nav className="navbar">
      <div className="navbar-logo">
        <a href="/">FixMyRide</a> {Home}
      </div>
      <div className="navbar-links">
        <a href="/login" className="btn-login">Login</a>
        <a href="/signup" className="btn-signup">Sign Up</a>
      </div>
    </nav>
  );
};

export default Navbar;
