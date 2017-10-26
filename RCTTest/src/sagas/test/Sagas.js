import { takeEvery,takeLatest } from 'redux-saga';
import { call,put } from 'redux-saga/effects';


export function *helloSaga() {
	console.log('hello saga')
}