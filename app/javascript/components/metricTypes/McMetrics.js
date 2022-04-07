
import * as React from 'react';
import TextField from '@mui/material/TextField';
import {colors, Typography } from '@mui/material';
import 'chart.js/auto';
import {Pie} from 'react-chartjs-2';

class McMetrics extends React.Component {
    constructor(props) {
        super(props);
    }

    getRandomColors(length){
        var colour_list = []
            var letters = '0123456789ABCDEF'.split('');
            for (var y = 0; y < length; y++){
                var color = '#';
                for (var i = 0; i < 6; i++ ) {
                    color += letters[Math.floor(Math.random() * 16)];
                }
                colour_list.push(color);
            }
        return colour_list
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
                            data: Object.values(response.mc_responses),
                            backgroundColor: this.getRandomColors(Object.keys(response.mc_responses).length)
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