import React, { useState, useEffect } from 'react';
import {
    Button,
    TextField,
    FormControl,
    Select,
    MenuItem,
    InputLabel,
    Box,
    Stack,
    Paper
    }
    from '@mui/material'
    
import TextQuestion from './questionTypes/TextQuestion';
import { v4 as uuidv4 } from 'uuid';

const questionType = {
    "MULTIPLE_CHOICE": "multipleChoice",
    "OPEN_ENDED": "openEnded",
    "NUMERICAL": "numerical",
}

export default function CreateSurvey() {
    const [baseUrl, setBaseUrl] = useState('');
    const [surveyName, setSurveyName] = useState('');
    const [surveyId, setSurveyId] = useState(-1);
    const [questions, setQuestions] = useState([]);
    const [currentType, setCurrentType] = useState('');

    useEffect(() => {
       setBaseUrl(window.location.origin.replace(/\/#.*/, ""));
       const survey = {
            survey: {
                title: "New Survey",
                isLive: false
            }
        };

        fetch(`${baseUrl}/api/v1/surveys/create`, {
            method: 'POST',
            body: JSON.stringify(survey),
            headers: {
                'Content-Type': 'application/json'
            },
        })
        .then(checkRequest)
        .then(data => {
            handleSurveyAPIResponse(data, "Created")
        })
        .catch(console.log);
    }, []);

    const handleCreateSurvey = () => {
        const survey = {
            survey: {
                title: surveyName,
                isLive: true,
            }
        };
        fetch(`${baseUrl}/api/v1/surveys/${surveyId}`, {
            method: 'PATCH',
            body: JSON.stringify(survey),
            headers: {
                'Content-Type': 'application/json'
            },
        })
        .then(checkRequest)
        .then(data => {
            handleSurveyAPIResponse(data, "Submitted")
        })
        .catch(console.log);
    };
    
    const handleSurveyAPIResponse = (data, messageType) => {
        console.log(data);
        if (!data.error && !data.notice) {
            setSurveyName(data.title);
            setSurveyId(data.id);
            console.log("\nSurvey " + data.title + " " + messageType + " with ID: " + data.id);
        } else {
            console.log("\n Error: " + (data.error || data.notice));
        }
    }

    const handleAddQuestion = () => {
        const question = {
            type: currentType,
            question: ''
        }
        switch(currentType) {
            case questionType.MULTIPLE_CHOICE:
                question.options = [];
                break;           
            case questionType.NUMERICAL:
                question.max = 0;
                question.min = 0;
                break;
            case questionType.OPEN_ENDED:
                break;
            default:
                console.log(`[WARNING] Unknown question type "${currentType}"`);
        }
        setQuestions([...questions, question])
    }

    const deleteQuestion = (i) => {
        questions.splice(i, 1)
        setQuestions([...questions])
    }

    // Update the array of current questions upon a change
    const updateQuestion = (i, newValue) => {
        questions.splice(i, 1, newValue)
        setQuestions([...questions])
    }
    
    const checkRequest = (res) => {
        if (res.status === 200) {
            return res.json();
        } else {
            throw res;
        }
    }

    
    return(
        <div className="createSurvey">          
            <Paper
                sx={{ p: '2px 4px', display: 'flex', alignItems: 'center', width: 400 }}
            >
                <Box
                    sx={{
                    '& .MuiTextField-root': { m: 1, width: '25ch' },
                    }}
                >
                    <Stack spacing={2} direction="row">
                        <TextField
                            required
                            id="survey-name"
                            label="Survey Name"
                            margin="dense"                          
                            variant="outlined"
                            size="small"
                            color="secondary" 
                            focused
                            onChange={e => setSurveyName(e.target.value)}
                        />
                        <Button
                            variant="text"                              
                            color="secondary"
                            size="small"
                            onClick={handleCreateSurvey}
                        >Create Survey</Button>
                    </Stack>  
                    <Stack spacing={2} direction="row">
                        <FormControl variant="outlined" sx={{ m: 1, minWidth: 120 }}>
                            <InputLabel id="qType-label" color="secondary">Question Type</InputLabel>
                            <Select 
                                value={currentType}
                                label="Question Type" 
                                autoWidth                       
                                color="secondary" 
                                onChange={e => setCurrentType(e.target.value)}
                            >
                                <MenuItem value={questionType.OPEN_ENDED}>Open-Ended</MenuItem>                        
                                <MenuItem value={questionType.MULTIPLE_CHOICE}>Multiple Choice</MenuItem>
                                <MenuItem value={questionType.NUMERICAL}>Numerical</MenuItem>
                            </Select>
                        </FormControl>
                        <Button
                            variant="text" 
                            color="secondary" 
                            disabled={!currentType}
                            size="small" 
                            onClick={handleAddQuestion}>add</Button>
                    </Stack>

                    {questions.map((q, i) => {
                            switch(q.type) {
                                case questionType.OPEN_ENDED:
                                   return (<TextQuestion key={i} i={i} q={q} deleteQuestion={deleteQuestion} update={updateQuestion}></TextQuestion>)
                                case questionType.MULTIPLE_CHOICE:
                                    return (
                                        //Need to be replaced with survey id
                                        //<McQuestion survey_id={1}/>
                                        <></>
                                    )
                            }
                        })
                    }
                            
                </Box>
            </Paper>
        </div>
    )
}
