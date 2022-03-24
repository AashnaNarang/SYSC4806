import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Home from './Home'
import CreateSurvey from './CreateSurvey'
import Survey from './Survey'

const App = () => {
    return(   
    <div>
        <link
                    rel="stylesheet"
                    href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
        />
        <Routes>
            <Route path='/' element={<Home />} />
            <Route path='/createSurvey' element={<CreateSurvey />} />
            <Route path='/survey/:surveyId' element={<Survey />} />
        </Routes>
    </div>
    )
}

export default App;
