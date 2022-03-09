import React from 'react'
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography'
import Card from '@mui/material/Card'
import { createTheme, ThemeProvider, styled } from '@mui/material/styles';

const darkTheme = createTheme({ palette: { mode: 'dark' } });
const lightTheme = createTheme({ palette: { mode: 'light' } });

const Home = () => {
    return(
        <Card className="sl-app sl-app_home t">
            <ThemeProvider theme={darkTheme}>
                <Typography className ="t" variant="h4" component="h3">
                    Hey surveyors, Welcome to SurveyLab!
                </Typography>  
                <Paper variant="outlined" />
            </ThemeProvider>
        </Card>
    )
}
export default Home