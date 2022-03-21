import React from "react";
import Button from '@mui/material/Button'
import TextField from '@mui/material/TextField';
import Stack from '@mui/material/Stack';
import DeleteIcon from '@mui/icons-material/Delete';

class McQuestion extends React.Component {
  constructor(props) {
      super(props);
      this.state = {
        question: '', 
        options: [], 
        survey_id: 
        props.survey_id, 
        position: props.position};
    }

  handleCreateMcQuestion(){
    //Hardcoded the value for now, Base url causing a weird URL
    var base_url = window.location.origin
		fetch(`${base_url}/api/v1/mc_questions/create`, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify({mc_question: {question: this.state.question, 
                                          survey_id: this.state.survey_id}, 
                           mc_options: {options: this.state.options}}),
		})
			.then((data) => {
				if (data.ok) {
					return data.json();
				}
				throw new Error("Network error.");
			})
			.catch(console.log);
  }

  handleOptionChange(i, event) {
    let options = [...this.state.options]
    options[i] = event.target.value
    this.setState({options: options})
  }

  handleQuestionChange(event){
    let question = this.state.question
    question = event.target.value
    this.setState({question: question})
  }

  addOption(){
    this.setState(prevState => ({options: [...prevState.options, '']}));
  }

  removeOption(i){
    let options = [...this.state.options];
    options.splice(i, 1);
    this.setState({options: options});
  }

  renderQuestion(){
    return(
      <div>
        <TextField
              value={this.state.question}
              variant="outlined"
              label="Question"
              size="small"
              color="secondary"
              onChange={this.handleQuestionChange.bind(this)}
          />
      </div>
    )
  }

  renderOptions() {
    return(
      <div>
        {this.optionsList()}
        <Button 
            variant="outlined"
            color="secondary"
            size="small"
            onClick={this.addOption.bind(this)}
            >Add
        </Button>
      </div>
    );
  }

  optionsList() {
    return this.state.options.map((element, i) =>
      <div key={i}>
        <Stack spacing={2} direction="row">
          <TextField
              value={element||''}
              variant="outlined"
              label="Option"
              size="small"
              color="secondary"
              onChange={this.handleOptionChange.bind(this,i)}
          />
          <Button 
              variant="outlined"
              color="secondary"
              onClick={this.removeOption.bind(this, i)}
              size="small"
          >
          <DeleteIcon/></Button>
        </Stack>
      </div>
    )
  }

  render() {
    return (
      <Stack spacing={2} direction="column">
        <div>
          {this.renderQuestion()}
        </div>
        <div>
          {this.renderOptions()}
        </div>
        <div>
        Temp, for debugging
        <Button 
            variant="outlined"
            color="secondary"
            size="small"
            onClick={this.handleCreateMcQuestion.bind(this)}
            >Submit
        </Button>
        </div>
      </Stack>
    );
  }
}
export default McQuestion