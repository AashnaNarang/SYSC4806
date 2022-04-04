import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom'
import Typography from '@mui/material/Typography'

const MetricsPage = () => {
    const { surveyId } = useParams();
    const [baseUrl, setBaseUrl] = useState('');
    const [title, setTitle] = useState('');
    
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
        })
        .catch(console.log);
    }, []);

    return(
        <div className="surveyResponses">
            <Typography variant="h2">{title}</Typography>
        </div>
    )
}

export default MetricsPage