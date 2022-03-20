
import * as React from 'react';
import TextField from '@mui/material/TextField';
import { Typography } from '@mui/material';

class TextResponse extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        const {
            question
        } = this.props;
        return ( 
            <div>
                <Typography variant="h5">{question}</Typography>
                <TextField
                    id="outlined-multiline-flexible"
                    label="Response"
                    multiline
                    maxRows={5}
                />
                <br/>
            </div>
        );
    }

}

export default TextResponse