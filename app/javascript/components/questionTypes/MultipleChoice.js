import React from "react";
import { Button, TextField, Stack } from '@mui/material'
import DeleteIcon from '@mui/icons-material/Delete'

export default function MultipleChoice({q, i, deleteQuestion, update}) {
  return (
    <>
    <Stack spacing={2} direction="row">
      <TextField
          placeholder="Enter question here"
          variant="outlined"
          label="Question"
          size="small"
          color="secondary"
          onChange={e => update(i, {...q, question: e.target.value})}         
          value={q.question}
      />
      <TextField
        value={q.options}
        variant="outlined"
        label="Options seperated by commas ','"
        size="small"
        color="secondary"
        fullWidth
        onChange={e => update(i, {...q, options: e.target.value.split(',')})}
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
