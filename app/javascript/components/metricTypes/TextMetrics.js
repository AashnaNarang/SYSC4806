import React from 'react'
import { TextField, Typography } from '@mui/material'

export default function TextMetrics(response) {
  return (
    <>
        <Typography variant="h5">Summary of Open Ended Questions:</Typography>
        <TextField>
            disabled
            value=Object.keys(response.question)
            variant="outlined"
            label="Question"
            size="small"
        </TextField>
        <TextField> 
            disabled
            multiline          
            label="Answer List"
            value=Object.keys(response.text_responses)
            variant="outlined"
            size="small"
        </TextField>
    </>
  )
}
