import React from 'react';
import './Navbar.css'; 
import { Link, useLocation } from 'react-router-dom';

const Navbar = () => {
  const location = useLocation();

  return (
    <nav className="navbar">
      <div className="navbar-logo">
        <Link to="/">FixMyRide</Link>
      </div>
      {location.pathname !== '/login' && location.pathname !== '/signup' && (
        <div className="navbar-links">
          <Link to="/signup" className="btn-signup">Sign Up</Link>
        </div>
      )}
    </nav>
  );
};

export default Navbar;
