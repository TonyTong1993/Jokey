
jest.dontMock('../../actions/test/sum');

describe('sum', function() {
 it('adds 1 + 2 to equal 3', function() {
   var sum = require('../../actions/test/sum');
   expect(sum(1, 2)).toBe(3);
 });
});
//expect 期望，matchers 匹配集
describe('object assigenment',()=> {
	let data = {one:1};
	data['two'] = 2;
	expect(data).isEqual({one:1,two:2})
});
//使用not可以测试一个matchers的反向规则
describe('ading positive numbers is not zero',() => {
	for (let a = 1; a < 10; i++) {
		 for (let b = 1; b < 10; b++) {
            expect(a + b).not.toBe(0);
        }
	};
})
/*
Truthiness -在测试的时候，有时候我们需要在undefined，null和false进行区别，
但是我们又不想去了解他们的不同点，Jest也会帮助我们得到我们想要的结.
toBeNull 检查是否为null
toBeUndefined 检查是否为undefined
toBeDefined 与toBeUndefined的相反
toBeTruthy 检查任何通过if显示转换是否为true
toBeFalsy 检查任何通过if显示转换是否为false
*/
test('null', () => {
    let n = null;
      expect(n).toBeNull();
      expect(n).toBeDefined();
      expect(n).not.toBeUndefined();
      expect(n).not.toBeTruthy();
      expect(n).toBeFalsy();
});

test('zero', () => {
      let z = 0;
      expect(z).not.toBeNull();
      expect(z).toBeDefined();
      expect(z).not.toBeUndefined();
      expect(z).not.toBeTruthy();
      expect(z).toBeFalsy();
});

/*
Numbers
比较数字的大多数方法都有其对应的matchers

toBeGreaterThan 大于
toBeGreaterThanOrEqual 大于等于
toBeLessThan 小于
toBeLessThanOrEqual 小于等于
*/
test('two plus two', () => {
    let value = 2 + 2;
    expect(value).toBeGreaterThan(3);
    expect(value).toBeGreaterThanOrEqual(3.5);
    expect(value).toBeLessThan(5);
    expect(value).toBeLessThanOrEqual(4.5);

    // toBe and toEqual 对于number类型作用是一样的
    expect(value).toBe(4);
    expect(value).toEqual(4);
});
//对于浮点数的测试，使用toBeCloseTo来替代toEqual，因为我们不会让一个测试依赖于一个微小的舍入型错误。
test('adding floating point numbers', () => {
    let value = 0.1 + 0.2;
    expect(value).not.toBe(0.3);    // It isn't! Because rounding error
    expect(value).toBeCloseTo(0.3); // This works.
});
//Strings:使用toMatch对字符串进行正则表达式匹配
test('there is no I in team', () => {
    expect('team').not.toMatch(/I/);
});

test('but there is a "stop" in Christoph', () => {
    expect('Christoph').toMatch(/stop/);
})
//Arrays:使用toContain对数组内的特定项进行匹配测试
let shoppingList = ['diapers', 'kleenex', 'trash bags', 'paper towels', 'beer'];

test('the shopping list has beer on it', () => {
    expect(shoppingList).toContain('beer');
});
//Exceptions:使用toThrow对一个特定函数调用时候抛出的错误进行测试
function compileAndroidCode() {
    throw new ConfigError('you are using the wrong JDK');
}

test('compiling android goes as expected', () => {
    expect(compileAndroidCode).toThrow();
    expect(compileAndroidCode).toThrow(ConfigError);

    // You can also use the exact error message or a regexp
    expect(compileAndroidCode).toThrow('you are using the wrong JDK');
    expect(compileAndroidCode).toThrow(/JDK/);
});
