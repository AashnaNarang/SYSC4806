import React from 'react';
import {
    Routes, 
    Route, 
    Link 
} from 'react-router-dom';

const Home = () => <h1><Link to="/about">Click Me</Link></h1>
const About = () => <h1>About Us</h1>

const App = () => (
    <div>
        <Routes>
            <Route exact path="/" component={Home} />
            <Route path="/about" component={About} />
        </Routes>
    </div>
)

export default App;