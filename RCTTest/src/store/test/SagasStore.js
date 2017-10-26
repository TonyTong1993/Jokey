import { createStore,applyMiddleware } from 'redux';
import { createLogger } from 'redux-logger';
import createSagaMiddleware  from 'redux-saga';

import { helloSaga } from '../../sagas/test/Sagas.js'
import MoviesReducer from '../../reducer/test/MoviesReducer';
const logger = createLogger();
const saga = createSagaMiddleware(helloSaga);

const store = createStore(MoviesReducer,applyMiddleware(saga,logger));
module.exports = store;