import './App.css';
import Home from './Components/Home/Home'; 
import Login from './Components/Login/Login'; 
import Navbar from './Components/Navbar/Navbar';
import Reservation from './Components/Reservation/Resarvation'; 

function App() {
  return (
    <div>
      <Navbar/>
      <Home/>
      <Login/>
      <Reservation/>
    </div>
  );
}

export default App;
