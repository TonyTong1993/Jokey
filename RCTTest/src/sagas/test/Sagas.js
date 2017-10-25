import { takeEvery,takeLatest } from 'redux-saga';
import { call,put } from 'redux-saga/effects';


export const helloSagas = ()=>{
	console.log('hello sagas')
}