import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Home from './Home'
import CreatSurvey from './CreateSurvey'

const App = () => {
    return(   
    <div>
        <Routes>
            <Route path='/' element={<Home />} />
            <Route path='/createSurvey' element={<CreatSurvey />} />
        </Routes>
    </div>
    )
}

export default App;