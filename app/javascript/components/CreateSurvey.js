import React, { useState, useEffect } from 'react';
import Card from '@mui/material/Card'
import Button from '@mui/material/Button'
import TextField from '@mui/material/TextField';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';
import MenuItem from '@mui/material/MenuItem';
import InputLabel from '@mui/material/InputLabel';
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';

const questionType = {
    "MULTIPLE_CHOICE": "multipleChoice",
    "OPEN_ENDED": "openEnded",
    "Numericale": "number",
}

const CreatSurvey = () => {
    const [baseUrl, setBaseUrl] = useState('');
    const [surveyName, setSurveyName] = useState('');
    const [questions, setQuestions] = useState([]);
    const [currentType, setCurrentType] = useState('');
    const [link, setLink] = useState('');

    useEffect(() => {
       setBaseUrl(window.location.href.replace(/\/#.*/, ""));
    }, [])

    const handleCreateSurvey = () => {
        const survey = {
            name: surveyName,
            questions: questions,
        }
    }

    const handleAddQuestion = () => {
        addQuestionAtIndex(questions.length)
    }

    const checkRequest = (res) => {
        if (res.status === 200) {
            return res.json();
        } else {
            throw res;
        }
    }

    const addQuestionAtIndex = (i) => {
        switch(currentType) {
            case questionType.OPEN_ENDED:
                setQuestions([
                    ...questions.slice(0, i),
                    {
                        type: currentType,
                        question: '',
                    },
                    ...questions.slice(i, questions.length)
                ]);
                break;
            case questionType.NUMERICAL:
                setQuestions([
                    ...questions.slice(0, i),
                    {
                        type: currentType,
                        min: 0,
                        max: 0,
                        question: '',
                    },
                    ...questions.slice(i, questions.length)
                ]);
                break;
            case questionType.DROPDOWN:
                setQuestions([
                    ...questions.slice(0, i),
                    {
                        type: currentType,
                        options: [],
                        question: '',
                    },
                    ...questions.slice(i, questions.length)
                ]);
                break;
            default:
                console.log(`[WARNING] Unknown question type "${currentType}"`);
        }
    }

    const deleteQuestion = (i) => {

    }
    // Update the array of current questions upon a change
    const updateQuestion = (i, value) => {

    }
    return(
        <div className="createSurvey">
            <Box
                component="form"
                sx={{
                 '& .MuiTextField-root': { m: 1, width: '25ch' },
                }}
                noValidate
                autoComplete="off"
            >
                <div>
                    <Stack spacing={2} direction="row">
                        <TextField
                            required
                            id="survey-name"
                            label="Survey Name"
                            margin="dense"                          
                            variant="standard"
                            size="small"
                            color="secondary" 
                            focused
                            onChange={e => setSurveyName(e.target.value)}
                        />
                        <Button
                            variant="outlined"                              
                            color="secondary"
                            size="small"
                            onClick={handleCreateSurvey}
                        >Create Survey</Button>
                    </Stack> 
                </div>
            </Box>
        </div>
    );
}
export default CreatSurvey
