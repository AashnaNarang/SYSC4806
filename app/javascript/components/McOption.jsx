import { Construction } from "@mui/icons-material";
import React from "react";

class McOption extends React.Component{
    constructor(props) {
        super(props);

        this.state = {option: props.option};

        this.handleChange = this.handleChange.bind(this);
    }

    handleChange(event) {
        this.setState({option: event.target.question});
      }
}