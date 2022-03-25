import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom'
import TextResponse from './responseTypes/TextResponse'
import McResponse from './responseTypes/McResponse'

 import {
    Button, 
    Typography,
    Box,
    Stack,
    Paper } from '@mui/material'

const questionType = {
    "MULTIPLE_CHOICE": "mc",
    "OPEN_ENDED": "text",
    "NUMERICAL": "numerical",
}

const Survey = () => {
    const { surveyId } = useParams();
    const [baseUrl, setBaseUrl] = useState('');
    const [title, setTitle] = useState('');
    const [surveyResponder, setSurveyResponder] = useState('');
    const [responses, setResponses] = useState([]);

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
            setTitle(data.survey.title);
            addResponses(data.questions);
        })
        .catch(console.log);
    }, []);

    const createResponder = async() => {
        const responder = {
            responder: {
                surveyId: surveyId,
                respondedAt: null
            }
        }
        await fetch(`${baseUrl}/api/v1/survey_responders/create`, {
            method: 'POST',
            body: JSON.stringify(responder),
            headers: {
                'Content-Type': 'application/json'
            },
        })
        .then(checkRequest)
        .then(data => {
            setSurveyResponder(data.id);
        })
        .catch(console.log);
    }

    const addResponses = (questions) => {
        let resps = [];
        questions.forEach((q) => {
            let response = {
                response: '',
                survey_responder_id: -1
            }
            switch(q.question_type) {
                case questionType.OPEN_ENDED:
                    response.text_question_id = q.id;
                    break;
                case questionType.MULTIPLE_CHOICE:
                    response.mc_question_id = q.id
                    break;
            }
            q.resp = response;
            resps.push(q);
        });
        console.log(resps)
        setResponses(resps);

    }

    // Update the array of current questions upon a change
    const updateResponse = (i, newValue) => {
        responses[i].resp = newValue;
        setResponses([...responses])
    }

    const handleSubmitSurvey = () => {
        console.log(responses);
        responses.forEach((r) => {
            switch(r.question_type) {
                case questionType.OPEN_ENDED:
                    // submitTextResponse(r.resp);
                    break;
                case questionType.MULTIPLE_CHOICE:
                    submitMcResponse(r.resp);
                    break;
            }
        });
    }

    const submitTextResponse = (resp) => {
        fetch(`${baseUrl}/api/v1/text_responses/create`, {
            method: 'POST',
            body: JSON.stringify(resp),
            headers: {
                'Content-Type': 'application/json'
            },
        })
        .then(checkRequest)
        .then(data => {
            console.log(data);
        })
        .catch(console.log);
    }

    const submitMcResponse = (resp) => {
        var mc_response = {"mc_response": {"mc_option_id": resp.response, "mc_question_id": resp.mc_question_id,
                                           "survey_responder_id": resp.survey_responder_id}}

        fetch(`${baseUrl}/api/v1/mc_responses/create`, {
            method: 'POST',
            body: JSON.stringify(mc_response),
            headers: {
                'Content-Type': 'application/json'
            },
        })
        .then(checkRequest)
        .then(data => {
            console.log(data);
        })
        .catch(console.log);
    }

    return(
        <div className="survey">
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
                    {responses.map((r, i) => {
                            switch(r.question_type) {
                                case questionType.OPEN_ENDED:
                                   return (<TextResponse i={i} response={r} update={updateResponse}></TextResponse>)
                                case questionType.MULTIPLE_CHOICE:
                                    return (<McResponse i={i} response={r} update={updateResponse}></McResponse>
                                    )
                            }
                        })
                    }
                    <br/>
                    <Button
                            variant="text"                              
                            color="secondary"
                            size="small"
                            onClick={handleSubmitSurvey}
                    >Submit</Button>
                </Box>
                
            </Paper>
            <br/>
            <br/>

        </div>
    )
}

export default Survey;