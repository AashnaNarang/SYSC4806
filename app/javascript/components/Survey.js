import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom'
import TextResponse from './responseTypes/TextResponse'
import { Typography } from '@mui/material';

const Survey = () => {
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

    useEffect(() => {
        setBaseUrl(window.location.origin.replace(/\/#.*/, ""));
        
        fetch(`${baseUrl}/api/v1/surveys/${surveyId}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
        })
        .then(checkRequest)
        .then(data => {
            console.log(data);
            setTitle(data.title);
        })
        .catch(console.log);

        // const responder = {
        //     responder: {
        //         surveyId: surveyId,
        //         respondedAt: null
        //     }
        // }
        // fetch(`${baseUrl}/api/v1/survey_responders/create`, {
        //     method: 'POST',
        //     body: JSON.stringify(responder),
        //     headers: {
        //         'Content-Type': 'application/json'
        //     },
        // })
        // .then(checkRequest)
        // .then(data => {
        //     handleSurveyAPIResponse(data, "Created")
        // })
        // .catch(console.log);
    }, []);

    return(
        <div>
            <Typography variant="h2">{title}</Typography>
            <br/>
            <br/>
            <TextResponse question={"What is your name?"}/>
        </div>
    )
}

export default Survey;