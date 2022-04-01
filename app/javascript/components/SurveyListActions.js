
import React, { useState, useEffect} from 'react';
import { FormControl } from '@mui/material';
import { Select, MenuItem } from '@mui/material';
import { useNavigate } from 'react-router-dom'
import Modal from './Modal';


export default function SurveyListActions({key, surveyId, isLive}) {
    const [baseUrl, setBaseUrl] = useState('');
    const [openFailure, setOpenFailure] = useState(false);
    const [error, setError] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
      setBaseUrl(window.location.origin.replace(/\/#.*/, ""));
    }, [])

    const checkRequest = (res) => {
      if (res.status === 200) {
          return res.json();
      } else {
          throw res;
      }
    }

    const handleOpenFailure = () => {
        setOpenFailure(true);
    }

    const handleCloseFailure = () => {
        setOpenFailure(false);
    }

    const handleChange = (e) => {
      let action = e.target.value
      if (action == "respond") {
        navigate("/survey/" + surveyId)
      } else if (action == "close") {
        const survey = {
          survey: {
            isLive: false
          }
        }
        fetch(`${baseUrl}/api/v1/surveys/${surveyId}`, {
          method: 'PATCH',
          body: JSON.stringify(survey),
          headers: {
              'Content-Type': 'application/json'
          },
        })
        .then(checkRequest)
        .then(data => {
          if (!data.error && !data.notice) {
            navigate("/surveyResponses/" + surveyId)
          } else {
            console.log("\n Error: " + (data.error || data.notice));
            setError(data.error || data.notice);
            handleOpenFailure();
          }
        })
        .catch(console.log);
      } else if (action == "view") {
        navigate("/surveyResponses/" + surveyId)
      } else {
        console.log("Error");
      }
    }

    return (
      <div>
        <FormControl fullWidth>
            { isLive ? 
              (
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  value={""}
                  label="Actions"
                  onChange={handleChange}
                >
                  <MenuItem value={"respond"}>Respond to</MenuItem>
                  <MenuItem value={"close"}>Close survey</MenuItem>
                  <MenuItem value={"view"} disabled>View Metrics</MenuItem>
                </Select>
              ) : (
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  value={""}
                  label="Actions"
                  onChange={handleChange}
                >
                  <MenuItem value={"respond"} disabled>Respond to</MenuItem>
                  <MenuItem value={"close"} disabled>Close survey</MenuItem>
                  <MenuItem value={"view"}>View Metrics</MenuItem>
                  </Select>
              )
            }
        </FormControl>
        <Modal open={openFailure} handleClose={handleCloseFailure} title={"Failure"} message={`Error: ${error}`}/>
      </div>
    )
}