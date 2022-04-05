
import * as React from 'react';
import TextField from '@mui/material/TextField';
import {Typography } from '@mui/material';
import 'chart.js/auto';
import {Pie} from 'react-chartjs-2';

class McMetrics extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        const {
            response,
        } = this.props;

        return ( 
            <div>
                <Typography variant="h5">{response.question}</Typography>
                <Pie
                    options = {{
                        width: "400",
                        height: "400"
                    }}
                    data={{
                        labels: Object.keys(response.mc_responses),
                        datasets: [{
                            data: Object.values(response.mc_responses)
                        }]
                    }}
                    >
                </Pie>
                <br/>
            </div>
        );
    }

}

export default McMetrics