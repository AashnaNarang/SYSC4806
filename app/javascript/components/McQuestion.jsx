import React from "react";

class AddMcQuestionForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {question: props.question};
    
        this.handleChange = this.handleChange.bind(this);
      }
    
      handleChange(event) {
        this.setState({value: event.target.value});
      }

    render() {
            return (
                <label>
                    Question:
                    <input type="text" value={this.state.option} onChange={this.handleChange} />
                </label>
            );
        }
}
export default AddMcQuestionForm