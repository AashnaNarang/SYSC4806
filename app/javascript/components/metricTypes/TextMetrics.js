import React from 'react'
import { TextField, Typography } from '@mui/material'

export default function TextMetrics(response) {
  return (
    <> 
        <Typography variant="h5">{response.response.question}</Typography>
        <TextField 
            disabled
            multiline          
            label="Answer List"
            value={response.response.text_responses}
            variant="outlined"
            size="small"
        />
        <br/>
    </>
  )
}
