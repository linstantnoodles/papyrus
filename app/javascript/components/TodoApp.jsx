/*
    Next
    - Learn ES6 Class syntax
    - Defining class methods
    - How do you get around the adjacent sibling error? What's recommended? Just keep wrapping divs?
    - Add todo. Bind the button to an event and then the event to a side effect.
    - https://reactjs.org/docs/reconciliation.html#recursing-on-children
    - j.s inside render function
    - https://reactjs.org/docs/thinking-in-react.html#step-4-identify-where-your-state-should-live
*/

/*
    Lets say my component initially renders with some data which gets rendered. This data gets changed over time by eithre the component itself or some sub-component and we should re-render to reflect these changes.

    Should this data be a prop? be a state? Should we set it as a state initially and pass it down as a prop?

    https://stackoverflow.com/questions/43539654/why-isnt-this-allowed-before-super

    In HTML, form elements such as <input>, <textarea>, and <select> typically maintain their own state and update it based on user input. In React, mutable state is typically kept in the state property of components, and only updated with setState().

    We can combine the two by making the React state be the “single source of truth”. Then the React component that renders a form also controls what happens in that form on subsequent user input. An input form element whose value is controlled by React in this way is called a “controlled component”.
*/

import React from 'react'

class AddButton extends React.Component {
    render() {
        return (
            <div>
                <button onClick={this.props.onAdd}>Add Item</button>
            </div>
        )
    }
}

class TodoList extends React.Component {
    render() {
        return (
            <ul>
                {
                    this.props.items.map((value, index) => {
                        return <li key={index}>{value}</li>
                    })
                }
            </ul>
        )
    }
}

class TodoApp extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            items: this.props.items,
            new_item_value: ''
        };
        this.addItem = this.addItem.bind(this);
        this.setItemValue = this.setItemValue.bind(this);
    }

    setItemValue(e) {
        this.setState({
            new_item_value: e.target.value
        });
    }

    addItem(e) {
        e.preventDefault();
        this.setState({
            items: this.state.items.concat([this.state.new_item_value]),
            new_item_value: ''
        });
    }

    render() {
        return (
            <div>
                <input type="text" value={this.state.new_item_value} onChange={this.setItemValue}/>
                <TodoList items={this.state.items}></TodoList>
                <AddButton onAdd={this.addItem}></AddButton>
            </div>
        )
    }
}

export default TodoApp