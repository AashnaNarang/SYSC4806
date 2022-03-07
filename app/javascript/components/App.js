import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Home from './Home'
import CreatSurvey from './CreateSurvey'

function App () {
    return(   
    <div>
        <Routes>
            <Route path='/home' element={<Home />} />
            <Route path='/createSurvey' element={<CreatSurvey />} />
        </Routes>
    </div>
    )
}

export default App;