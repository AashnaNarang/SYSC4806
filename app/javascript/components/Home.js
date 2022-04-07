import React from 'react'
import SurveyList from './SurveyList';
import SurveyListActions from './SurveyListActions'
import {
    Button,
    Paper,
    Typography,
    Card} from '@mui/material'
import AddIcon from '@mui/icons-material/Add';
import { createTheme, ThemeProvider, styled } from '@mui/material/styles';


const darkTheme = createTheme({ palette: { mode: 'dark' } });
const lightTheme = createTheme({ palette: { mode: 'light' } });

const Home = () => {
    return(
        <Card>
            <ThemeProvider theme={darkTheme}>
                <Typography variant="h4" component="h3">
                    Welcome to SurveyLab!
                </Typography> 
                <Paper variant="outlined" />
            </ThemeProvider>
            <br/>
            <Button  
                color="secondary"
                startIcon={<AddIcon/>}
                variant="outlined"
                onClick={() => {
                    location.href='/createSurvey';
                }}
            >
                create survey
            </Button>
            <br/>
            <br/>
            <ThemeProvider theme={darkTheme}>
                <Typography variant="h6" component="h5">
                    Your Surveys:
                </Typography> 
                <Paper variant="outlined" />
            </ThemeProvider>
            <SurveyList></SurveyList>
        </Card>
    )
}
export default Home