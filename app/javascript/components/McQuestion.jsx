import React from "react";

class AddMcQuestionForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {question: '', options: []};
      }
    
      handleChange(event) {
        this.setState({question: event.target.value});
      }

    render() {
            return (
              this.renderOptions()
            );
        }

    handleOptionChange(i, event) {
      let options = [...this.state.options]
      options[i] = event.target.value
      this.state[i] = event.target.value;
    }

    addOption(){
      this.setState(prevState => ({options: [...prevState.options, '']}));
    }

    removeOption(){
      let options = [...this.state.options];
      options.split(i, 1);
      this.setState({options: options});
    }

    renderQuestion(){
      return(
        <label>
          Question:
          <input type="text" value={this.state.option} onChange={this.handleChange} />
        </label>
      )
    }

    renderOptions() {
      return(
        <div>
          {this.optionsList()}
          <input type='button' value='add option' onClick={this.addOption.bind(this)}/>
        </div>
      );
    }

    optionsList() {
      return this.state.options.map((element, i) =>
        <div key={i}>
          <input type="text" value={element||''} onChange={this.handleOptionChange.bind(this,i )}/>
          <input type="button" value='remove' onClick={this.removeOption.bind(this, i)}/>
        </div>
      )
    }
}
export default AddMcQuestionForm