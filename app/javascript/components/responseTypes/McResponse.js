
import * as React from 'react';
import TextField from '@mui/material/TextField';
import { RadioGroup, Typography } from '@mui/material';
import { Radio } from '@mui/material';
import { FormControl, FormLabel, FormControlLabel } from '@mui/material';

class McResponse extends React.Component {
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
                <FormControl>
                    <RadioGroup
                        name="mc_options"
                        onChange={e => update(i, {...response.resp, response: e.target.value})}
                    >
                        {response.mc_options.map((option, i) => {
                                return(
                                    <FormControlLabel key={i} value={option.id} control={<Radio />} label={option.option} />
                                )
                            })
                        }
                    </RadioGroup>
                </FormControl>
                <br/>
            </div>
        );
    }

}

export default McResponse