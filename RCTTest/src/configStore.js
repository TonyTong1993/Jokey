import { createStore,applyMiddleware  } from 'redux'
import movies from './reducer/LoginReducer'

import thunk from 'redux-thunk';
import promise from 'redux-promise';
import {createLogger} from 'redux-logger';

const logger = createLogger();

const store = createStore(movies,applyMiddleware(thunk,logger,promise))

module.exports = store
