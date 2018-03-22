import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore } from 'redux'
import rootReducer from '../reducers'
import App from './App'
 
const store = createStore(rootReducer)

const HelloWorld = () => {
    return (
        <Provider store={store}>
            <App />
        </Provider>
    );
}

export default HelloWorld