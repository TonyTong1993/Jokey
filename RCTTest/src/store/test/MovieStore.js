import { createStore,applyMiddleware } from 'redux';
import { createLogger } from 'redux-logger';
import thunk from 'redux-thunk';
import promise from 'redux-promise';
import MoviesReducer from '../../reducer/test/MoviesReducer';

const logger = createLogger();
const store = createStore(MoviesReducer,applyMiddleware(thunk,promise,logger));
module.exports = store;
