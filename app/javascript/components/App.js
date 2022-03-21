import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Home from './Home'
import CreateSurvey from './CreateSurvey'

const App = () => {
    return(   
    <div>
        <Routes>
            <Route path='/' element={<Home />} />
            <Route path='/createSurvey' element={<CreateSurvey />} />
        </Routes>
    </div>
    )
}

export default App;