
import * as React from 'react';
import TextField from '@mui/material/TextField';
import { Typography } from '@mui/material';

class TextResponse extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        const {
            i,
            response,
            update
        } = this.props;

        return ( 
            <div>
                <Typography variant="h5">{response.question}</Typography>
                <TextField
                    id="outlined-multiline-flexible"
                    label="Response"
                    multiline
                    maxRows={5}
                    onChange={e => update(i, {...response.resp, response: e.target.value})}
                />
                <br/>
            </div>
        );
    }

}

export default TextResponse