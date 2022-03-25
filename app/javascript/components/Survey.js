import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom'
import TextResponse from './responseTypes/TextResponse'
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

    useEffect(async () => {
        setBaseUrl(window.location.origin.replace(/\/#.*/, ""));
        await createResponder();
        await fetch(`${baseUrl}/api/v1/surveys/${surveyId}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
        })
        .then(checkRequest)
        .then(data => {
            setTitle(data.survey.title);
            addResponses(data.questions);
        })
        .catch(console.log);
    }, []);

    const createResponder = async() => {
        const responder = {
            survey_responder: {
                survey_id: surveyId
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
                survey_responder_id: surveyResponder
            }
            switch(q.question_type) {
                case questionType.OPEN_ENDED:
                    response.text_question_id = q.id;
                    break;
                case questionType.MULTIPLE_CHOICE:
                    break;
            }
            q.resp = response;
            resps.push(q);
        });
        setResponses(resps);

    }

    // Update the array of current questions upon a change
    const updateResponse = (i, newValue) => {
        responses[i].resp = newValue;
        setResponses([...responses])
    }

    const handleSubmitSurvey = async () => {
        await responses.forEach(async (r) => {
            switch(r.question_type) {
                case questionType.OPEN_ENDED:
                    await submitTextResponse(r.resp);
                    break;
                case questionType.MULTIPLE_CHOICE:
                    break;
            }
        });

    }

    const submitTextResponse = async (resp) => {
        let text_response = {
            text_response: {
                response: resp.response || "null",
                text_question_id: resp.text_question_id, 
                survey_responder_id: surveyResponder
            }
        }
        await fetch(`${baseUrl}/api/v1/text_responses/create`, {
            method: 'POST',
            body: JSON.stringify(text_response),
            headers: {
                'Content-Type': 'application/json'
            },
        })
        .then(checkRequest)
        .then(data => {
            console.log("Submitted response for question with text_question_id=" + resp.text_question_id);
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
                                    return
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