
jest.dontMock('../src/actions/test/sum');

describe('sum', function() {
 it('adds 1 + 2 to equal 3', function() {
   var sum = require('../src/actions/test/sum');
   expect(sum(1, 2)).toBe(3);
 });
})