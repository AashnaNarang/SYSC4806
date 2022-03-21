import React from 'react'
import { Stack, TextField, Button } from '@mui/material'
import DeleteIcon from '@mui/icons-material/Delete'

export default function TextQuestion({q, i, deleteQuestion, update}) {
  return (
    <>
         <Stack spacing={2} direction="row">
            <TextField
                placeholder="Enter question here"
                variant="outlined"
                label="Title"
                size="small"
                color="secondary"
                onChange={e => update(i, {...q, question: e.target.value})}
                value={q.question}
            />
            <Button 
                variant="text"
                color="secondary"
                onClick={e => deleteQuestion(i)}
                size="small"
            >
            <DeleteIcon/></Button>
        </Stack>
    </>
  )
}