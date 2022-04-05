
import React, { useState, useEffect} from 'react';
import Paper from '@mui/material/Paper';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import moment from "moment";
import SurveyListActions from './SurveyListActions';


export default function SurveyList() {
    const [baseUrl, setBaseUrl] = useState('');
    const [surveys, setSurveys] = useState([]);

    useEffect(() => {
      setBaseUrl(window.location.origin.replace(/\/#.*/, ""));
      fetch(`${baseUrl}/api/v1/surveys/index`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        },
      })
      .then(checkRequest)
      .then(data => {
          setSurveys(data);
      })
    .catch(console.log);
    }, [])

    const columns = [
      { id: 'title', label: 'Title', minWidth: 170 },
      { id: 'live', label: 'Live', minWidth: 50 },
      {
        id: 'liveDate',
        label: 'Live\u00a0Date',
        minWidth: 100,
        align: 'right',
      },
      {
        id: 'closedOnDate',
        label: 'Closed\u00a0On\u00a0Date',
        minWidth: 100,
        align: 'right',
      },
      {
        id: 'actions',
        label: 'Actions',
        minWidth: 100,
        align: 'right',
      },
    ];
    
    const checkRequest = (res) => {
      if (res.status === 200) {
          return res.json();
      } else {
          throw res;
      }
    }

    return (
      <div>
        <Paper sx={{ width: '100%', overflow: 'hidden' }}>
        <TableContainer sx={{ maxHeight: 640 }}>
          <Table stickyHeader aria-label="sticky table">
            <TableHead>
              <TableRow>
                {columns.map((column) => (
                  <TableCell
                    key={column.id}
                    align={column.align}
                    style={{ minWidth: column.minWidth }}
                  >
                    {column.label}
                  </TableCell>
                ))}
              </TableRow>
            </TableHead>
            <TableBody>
              {surveys.map((survey) => (
                <TableRow
                key={survey.id}
                sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
                >
                  <TableCell component="th" scope="row">
                    {survey.title}
                  </TableCell>
                  <TableCell align="right">{survey.isLive ? "True": "False"}</TableCell>
                  <TableCell align="right">{survey.wentLiveAt ? moment(survey.wentLiveAt).format("MMM D, YYYY HH:mm:ss") : "-"}</TableCell>
                  <TableCell align="right">{survey.wentLiveAt ? moment(survey.wentLiveAt).format("MMM D, YYYY HH:mm:ss") : "-"}</TableCell>
                  <TableCell align="right"><SurveyListActions surveyId={survey.id} isLive={survey.isLive}/></TableCell>
              </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
        </Paper>
      </div>
    )
}