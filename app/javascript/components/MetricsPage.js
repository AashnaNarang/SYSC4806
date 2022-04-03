import React from 'react'
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography'
import Card from '@mui/material/Card'
import { createTheme, ThemeProvider, styled } from '@mui/material/styles';
import SurveyList from './SurveyList';
import SurveyListActions from './SurveyListActions'


const darkTheme = createTheme({ palette: { mode: 'dark' } });
const lightTheme = createTheme({ palette: { mode: 'light' } });

const MetricsPage = () => {
    const { surveyId } = useParams();
    const [baseUrl, setBaseUrl] = useState('');
    const [title, setTitle] = useState('');

    const checkRequest = (res) => {
        if (res.status === 200) {
            return res.json();
        } else {
            throw res;
        }
    }

    useEffect(async () => {
        setBaseUrl(window.location.origin.replace(/\/#.*/, ""));
        await fetch(`${baseUrl}/api/v1/surveyResponses/${surveyId}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
        })
        .then(checkRequest)
        .then(data => {
            setTitle(data.survey.title);
        })
        .catch(console.log);
    }, []);

    return(
        <Card>
            <ThemeProvider theme={darkTheme}>
                <Typography variant="h4" component="h3">
                    Hello surveyor, Welcome to the Metrics Page!
                </Typography> 
                <Paper variant="outlined" />
            </ThemeProvider>
            <br/>
            <br/>
            {/* <SurveyList></SurveyList> */}
        </Card>
    )
}

export default MetricsPage