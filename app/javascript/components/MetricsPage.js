import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom'
import { Typography, Box, Paper } from '@mui/material'

import McMetrics from './metricTypes/McMetrics'
import TextMetrics from './metricTypes/TextMetrics';

    const questionType = {
        "MULTIPLE_CHOICE": "mc",
        "OPEN_ENDED": "text",
        "NUMERICAL": "numerical",
    }

const MetricsPage = () => {
    const { surveyId } = useParams();
    const [baseUrl, setBaseUrl] = useState('');
    const [title, setTitle] = useState('');
    const [responses, setResponses] = useState([]);
    
    const checkRequest = (res) => {
        if (res.status === 200) {
            return res.json();
        } else {
            throw res;
        }
    }

    useEffect(async () => {
        setBaseUrl(window.location.origin.replace(/\/#.*/, ""));
        await fetch(`${baseUrl}/api/v1/surveys/${surveyId}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
        })
        .then(checkRequest)
        .then(data => {
            setTitle(data.survey.title);
            setResponses(data.questions)
        })
        .catch(console.log);
    }, []);

    return(
        <div className="surveyResponses">
            <Typography variant="h2">{title}</Typography>
            <br/>
            <br/>
            <Paper
                sx={{ p: '2px 4px', display: 'flex', alignItems: 'center', width: 600 }}
            >
                <Box
                    sx={{
                    '& .MuiTextField-root': { m: 1, width: '25ch' },
                    }}
                >
                    {responses.map((response, i) => {
                            switch(response.question_type) {
                                case questionType.OPEN_ENDED:
                                   return (<TextMetrics key={i} response={response}></TextMetrics>)
                                case questionType.MULTIPLE_CHOICE:
                                    return (<McMetrics key={i} response={response}></McMetrics>)
                            }
                        })
                    }
                    <br/>
                </Box>              
            </Paper>
            <br/>
            <br/>
        </div>
    )
}


export default MetricsPage