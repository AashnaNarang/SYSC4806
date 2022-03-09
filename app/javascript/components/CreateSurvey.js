import React from 'react'
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography'
import Card from '@mui/material/Card'
import { createTheme, ThemeProvider, styled } from '@mui/material/styles';
import McQuestion from "./McQuestion"

const CreateSurvey = () => {
    return(
        <Card>
            <div>This is the Create Survey page.</div>
            < McQuestion question={'Default'} />
        </Card>
    )
}
export default CreateSurvey