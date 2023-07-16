> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_43734095/article/details/106166823)

### [JavaScript](https://so.csdn.net/so/search?q=JavaScript&spm=1001.2101.3001.7020) 个人笔记

*   [数据类型和变量](#_5)
*   *   [浮点数的相等比较](#_31)
    *   [null 和 undefined](#null__undefined_41)
    *   [== 与 ===](#___48)
    *   [strict 模式](#strict_54)
*   [字符串](#_68)
*   *   [模板字符串](#_76)
    *   [字符串常用方法](#_91)
*   [数组](#_121)
*   *   [数组常用方法](#_144)
*   [对象](#_239)
*   [条件判断](#_302)
*   [循环](#_334)
*   [Map](#Map_389)
*   [Set](#Set_418)
*   [iterable](#iterable_448)
*   *   [for ... of 循环 和 for ... in 循环区别](#for__of___for__in__467)
    *   [forEach](#forEach_490)
*   [函数定义与使用](#_545)
*   *   [arguments](#arguments_593)
    *   [rest](#rest_639)
    *   [小心 return 语句](#_return__679)

> 学习自[廖雪峰的博客](https://www.liaoxuefeng.com/wiki/1022910821149312)，记录一些个人笔记。

数据类型和变量
=======

JavaScript 不区分整数和浮点数，统一用 Number 表示，以下都是合法的 Number 类型：

```
123; // 整数123
0.456; // 浮点数0.456
1.2345e3; // 科学计数法表示1.2345x1000，等同于1234.5
-99; // 负数
NaN; // NaN表示Not a Number，当无法计算结果时用NaN表示
Infinity; // Infinity表示无限大，当数值超过了JavaScript的Number所能表示的最大值时，就表示为Infinity

0xff00; // 十六进制
0xa5b4c3d2; // 十六进制
```

`NaN` 这个特殊的 Number 与所有其他值都不相等，包括它自己：

```
NaN === NaN; // false
```

唯一能判断 `NaN` 的方法是通过 `isNaN()` 函数：

```
isNaN(NaN); // true
```

浮点数的相等比较
--------

```
1 / 3 === (1 - 2 / 3); // false
```

浮点数在运算过程中会产生误差，因为计算机无法精确表示无限循环小数。要比较两个浮点数是否相等，只能计算它们之差的绝对值，看是否小于某个阈值：

```
Math.abs(1 / 3 - (1 - 2 / 3)) < 0.0000001; // true
```

null 和 undefined
----------------

`null` 表示一个 “**空**” 的值，`undefined`，它表示 “**未定义**”。

区分两者的意义不大。大多数情况下，我们都应该用 `null`，`undefined` 仅仅在判断函数参数是否传递的情况下有用。

== 与 ===
--------

`==` 会自动转换数据类型再比较，很多时候，会得到非常诡异的结果；  
`===` 不会自动转换数据类型，如果数据类型不一致，返回 `false`，如果一致，再比较。

建议：**不要**使用 `==` 比较，始终坚持使用 `===` 比较。

strict 模式
---------

如果一个变量没有通过 `var` 申明就被使用，那么该变量就自动被申明为全局变量。  
即使在函数体内，如果没有用 `var` 声明，它会成为一个全局变量，这是很危险的。

```
i = 10; // i现在是全局变量
```

在 strict 模式下运行的 JavaScript 代码，强制通过 `var` 申明变量，未使用 `var` 申明变量就使用的，将导致运行错误。

启用 strict 模式的方法是在 JavaScript 代码的第一行写上：

```
'use strict';
```

这是一个字符串，不支持 strict 模式的浏览器会把它当做一个字符串语句执行，支持 strict 模式的浏览器将开启 strict 模式运行 JavaScript。

字符串
===

由于多行字符串用 `\n` 写起来比较费事，所以最新的 ES6 标准新增了一种多行字符串的表示方法，用**反引号**表示：

```
`这是一个
多行
字符串`;
```

模板字符串
-----

字符串的连接使用 `+` 号：

```
var name = '小明';
var age = 20;
var message = '你好, ' + name + ', 你今年' + age + '岁了!';
alert(message);
```

如果有很多变量需要连接，用 `+` 号就比较麻烦，ES6 新增了**模板字符串**：

```
var name = '小明';
var age = 20;
var message = `你好, ${name}, 你今年${age}岁了!`;
alert(message)
```

字符串常用方法
-------

`toUpperCase()` 把一个字符串全部变为大写；

```
var s = 'Hello';
s.toUpperCase(); // 返回'HELLO'
```

`toLowerCase()` 把一个字符串全部变为小写；

```
var s = 'Hello';
var lower = s.toLowerCase(); // 返回'hello'并赋值给变量lower
lower; // 'hello'
```

`indexOf()` 会搜索指定字符串出现的位置；

```
var s = 'hello, world';
s.indexOf('world'); // 返回7
s.indexOf('World'); // 没有找到指定的子串，返回-1
```

`substring()` 返回指定索引区间的子串：

```
var s = 'hello, world'
s.substring(0, 5); // 从索引0开始到5（不包括5），返回'hello'
s.substring(7); // 从索引7开始到结束，返回'world'
```

数组
==

JavaScript 的 `Array` 可以包含**任意数据类型**，并通过索引来访问每个元素。

注意，直接给 `Array` 的 `length` 赋一个新的值会导致 `Array` 大小的变化：

```
var arr = [1, 2, 3];
arr.length; // 3
arr.length = 6;
arr; // arr变为[1, 2, 3, undefined, undefined, undefined]
arr.length = 2;
arr; // arr变为[1, 2]
```

通过索引赋值时，**索引超过了范围**，同样会引起 `Array` 大小的变化：

```
var arr = [1, 2, 3];
arr[5] = 'x';
arr; // arr变为[1, 2, 3, undefined, undefined, 'x']
```

在编写代码时，**不建议直接修改 `Array` 的大小，访问索引时要确保索引不会越界**。

数组常用方法
------

`indexOf()` 用来搜索数组中一个指定的元素的位置：

```
var arr = [10, 20, '30', 'xyz'];
arr.indexOf(10); // 元素10的索引为0
arr.indexOf(20); // 元素20的索引为1
arr.indexOf(30); // 元素30没有找到，返回-1
arr.indexOf('30'); // 元素'30'的索引为2
// 注意了，数字30和字符串'30'是不同的元素
```

`slice()` 对应 String 的 `substring()`，它截取 `Array` 的部分元素，然后返回一个新的 `Array`：

```
var arr = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
arr.slice(0, 3); // 从索引0开始，到索引3结束，但不包括索引3: ['A', 'B', 'C']
arr.slice(3); // 从索引3开始到结束: ['D', 'E', 'F', 'G']
```

`push()` 向 `Array` 的**尾部**添加若干元素，  
`pop()` 把 `Array` 的最后一个元素删除掉：

```
var arr = [1, 2];
arr.push('A', 'B'); // 返回Array新的长度: 4
arr; // [1, 2, 'A', 'B']
arr.pop(); // pop()返回'B'
arr; // [1, 2, 'A']
arr.pop(); arr.pop(); arr.pop(); // 连续pop 3次
arr; // []
arr.pop(); // 空数组继续pop不会报错，而是返回undefined
arr; // []
```

`unshift()` 方法往 `Array` 的**头部**添加若干元素，  
`shift()` 方法把 `Array` 的第一个元素删掉：

```
var arr = [1, 2];
arr.unshift('A', 'B'); // 返回Array新的长度: 4
arr; // ['A', 'B', 1, 2]
arr.shift(); // 'A'
arr; // ['B', 1, 2]
arr.shift(); arr.shift(); arr.shift(); // 连续shift 3次
arr; // []
arr.shift(); // 空数组继续shift不会报错，而是返回undefined
arr; // []
```

`sort()` 可以对当前 `Array` 进行排序，它会直接修改当前 `Array` 的元素位置，直接调用时，按照默认顺序排序：

```
var arr = ['one', 'two', 'three'];
arr.reverse(); 
arr; // ['three', 'two', 'one']
```

`splice()` 是修改 `Array` 的 “**万能方法**”，它可以从指定的索引开始删除若干元素，然后再从该位置添加若干元素：

```
var arr = ['Microsoft', 'Apple', 'Yahoo', 'AOL', 'Excite', 'Oracle'];
// 从索引2开始删除3个元素,然后再添加两个元素:
arr.splice(2, 3, 'Google', 'Facebook'); // 返回删除的元素 ['Yahoo', 'AOL', 'Excite']
arr; // ['Microsoft', 'Apple', 'Google', 'Facebook', 'Oracle']
// 只删除,不添加:
arr.splice(2, 2); // ['Google', 'Facebook']
arr; // ['Microsoft', 'Apple', 'Oracle']
// 只添加,不删除:
arr.splice(2, 0, 'Google', 'Facebook'); // 返回[],因为没有删除任何元素
arr; // ['Microsoft', 'Apple', 'Google', 'Facebook', 'Oracle']
```

```
var arr = ['Microsoft', 'Apple', 'Yahoo', 'AOL', 'Excite', 'Oracle'];
arr.splice(0, arr.length); // 清空数组
```

`concat()` 把当前的 `Array` 和另一个 `Array` 连接起来，并返回一个新的 `Array`：

```
var arr = ['A', 'B', 'C'];
var added = arr.concat([1, 2, 3]);
added; // ['A', 'B', 'C', 1, 2, 3]
arr; // ['A', 'B', 'C']

// 可以接收任意个元素和 Array, 自动把 Array 拆开添加到新 Array 中
var arr = ['A', 'B', 'C'];
arr.concat(1, 2, [3, 4]); // ['A', 'B', 'C', 1, 2, 3, 4]
```

`join()` 是一个非常实用的方法，将当前 `Array` 的每个元素都用指定的字符串连接起来，然后返回连接后的字符串：

```
var arr = ['A', 'B', 'C', 1, 2, 3];
arr.join('-'); // 'A-B-C-1-2-3'
arr; // ['A', 'B', 'C', 1, 2, 3]
```

对象
==

JavaScript 的对象是一种**无序的集合数据类型**，它由若干**键值对**组成。  
JavaScript 对象的所有**属性**（**键**）都是字符串，不过 **属性对应的值** 可以是任意数据类型。

```
var xiaohong = {
    name: '小红',
    'middle-school': 'No.1 Middle School'
};

// xiaoming.middle-school; 这么写是错误的, 必须像下面这么写
xiaohong['middle-school']; // 'No.1 Middle School'
xiaohong['name']; // '小红'
xiaohong.name; // '小红'
```

JavaScript 中访问不存在的属性不报错，返回 `undefined`。

由于 JavaScript 的对象是动态类型，你可以自由地给一个对象添加或删除属性：

```
var xiaoming = {
    name: '小明'
};
xiaoming.age; // undefined
xiaoming.age = 18; // 新增一个age属性
xiaoming.age; // 18
delete xiaoming.age; // 删除age属性
xiaoming.age; // undefined
delete xiaoming['name']; // 删除name属性
xiaoming.name; // undefined
delete xiaoming.school; // 删除一个不存在的school属性也不会报错
```

如果我们要检测 `xiaoming` 是否拥有某一属性，可以用 `in` 操作符：

```
var xiaoming = {
    name: '小明',
    birth: 1990,
    school: 'No.1 Middle School',
    height: 1.70,
    weight: 65,
    score: null
};
'name' in xiaoming; // true
'grade' in xiaoming; // false
```

不过要小心，如果 `in` 判断一个属性存在，这个属性不一定是 `xiaoming` 的，它可能是 `xiaoming` 继承得到的：

```
'toString' in xiaoming; // true
```

因为 `toString` 定义在 `object` 对象中，而所有对象最终都会在原型链上指向 `object`，所以 `xiaoming` 也拥有 `toString` 属性。

要判断一个属性是否是 `xiaoming` 自身拥有的，而不是继承得到的，可以用 `hasOwnProperty()` 方法：

```
var xiaoming = {
    name: '小明'
};
xiaoming.hasOwnProperty('name'); // true
xiaoming.hasOwnProperty('toString'); // false
```

条件判断
====

JavaScript 把 `null`、`undefined`、`0`、`NaN` 和 空字符串`''` 视为 `false`，其他值一概视为 `true`。

练习：  
小明身高 1.75，体重 80.5kg。请根据 BMI 公式（体重除以身高的平方）帮小明计算他的 BMI 指数，并根据 BMI 指数：

*   低于 18.5：过轻
*   18.5-25：正常
*   25-28：过重
*   28-32：肥胖
*   高于 32：严重肥胖

用 `if...else...` 判断并显示结果：

```
var height = parseFloat(prompt('请输入身高(m):'));
var weight = parseFloat(prompt('请输入体重(kg):'));
var bmi = weight / (height ** 2);
console.log(bmi);
if (bmi < 18.5) {
    console.log("过轻");
} else if (bmi >= 18.5 && bmi < 25) {
    console.log("正常");
} else if (bmi >= 25 && bmi < 28) {
    console.log("过重");
} else if (bmi >= 28 && bmi < 32) {
    console.log("肥胖");
} else {
    console.log("严重肥胖！");
}
```

循环
==

常规的 `for` 循环：

```
var arr = ['Apple', 'Google', 'Microsoft'];
var i, x;
for (i = 0; i < arr.length; i++) {
    x = arr[i];
    console.log(x);
}
```

`for ... in` 循环，可以把一个对象的所有属性依次循环出来：

```
var o = {
    name: 'Jack',
    age: 20,
    city: 'Beijing'
};
for (var key in o) {
    if (o.hasOwnProperty(key)) { // 过滤掉继承的属性
        console.log(key + " : " + o[key]); // 'name', 'age', 'city'
    }
}
```

由于 `Array` 也是对象，而它的每个元素的索引被视为对象的属性，因此，`for ... in` 循环可以直接循环出 `Array` 的索引，但是 `for ... in` 对 `Array` 的循环得到的是 `String` 而不是 `Number`。

```
var a = ['A', 'B', 'C'];
for (var i in a) {
    console.log(i); // '0', '1', '2'
    console.log(a[i]); // 'A', 'B', 'C'
}
```

用 `while` 循环实现计算 100 以内所有奇数之和：

```
var x = 0;
var n = 99;
while (n > 0) {
    x = x + n;
    n = n - 2;
}
x; // 2500
```

`do { ... } while()` 循环，它和 `while` 循环的唯一区别在于，不是在每次循环开始的时候判断条件，而是在每次循环完成的时候判断条件：

```
var n = 0;
do {
    n = n + 1;
} while (n < 100);
n; // 100
```

Map
===

JavaScript 的默认对象表示方式是一组**键值对**，但是 JavaScript 的对象有个小问题：**键必须是字符串**。但实际上 Number 或者其他数据类型作为键也是非常合理的。

为了解决这个问题，ES6 规范引入了新的数据类型 `Map`。

```
var m = new Map([['stu1', 96], ['stu2', 87], ['stu3', 76]]);
m.get("stu1"); // 96
```

初始化 `Map` 需要一个**二维数组**，或者直接初始化一个空 `Map`。

`Map` 具有以下方法：

```
var m = new Map(); // 空Map
m.set('Adam', 67); // 添加新的key-value
m.set('Bob', 59);
m.has('Adam'); // 是否存在key 'Adam': true
m.get('Adam'); // 67
m.delete('Adam'); // 删除key 'Adam'
m.get('Adam'); // undefined
```

一个 key 只能对应 一个 value，后添加的会覆盖前面的。

```
var m = new Map();
m.set('Adam', 67);
m.set('Adam', 88);
m.get('Adam'); // 88
```

Set
===

在 `Set` 中，没有重复的值。

要创建一个 `Set`，需要提供一个 `Array` 作为输入，或者直接创建一个空 `Set`：

```
var s1 = new Set(); // 空Set
var s2 = new Set([1, 2, 3]); // 含1, 2, 3

// set 自动过滤重复元素
var s = new Set([1, 2, 3, 3, '3']);
s; // Set {1, 2, 3, "3"}
// 注意数字`3`和字符串`'3'`是不同的元素。
```

`add(key)` 可以添加元素到 `Set` 中，不会添加重复元素。

```
s.add(4);
s; // Set {1, 2, 3, 4}
s.add(4);
s; // 仍然是 Set {1, 2, 3, 4}
```

`delete(key)` 可以删除元素：

```
var s = new Set([1, 2, 3]);
s; // Set {1, 2, 3}
s.delete(3);
s; // Set {1, 2}
```

`Map` 和 `Set` 是 ES6 标准新增的数据类型，请根据浏览器的支持情况决定是否要使用。

iterable
========

遍历 `Array` 可以采用下标循环，遍历 `Map` 和 `Set` 无法使用下标。为了统一集合类型，ES6 标准引入了新的 `iterable` 类型，`Array`、`Map` 和 `Set` 都属于 `iterable` 类型。

具有 `iterable` 类型的集合可以通过新的 `for ... of` 循环来遍历。

```
var a = ['A', 'B', 'C'];
var s = new Set(['A', 'B', 'C']);
var m = new Map([[1, 'x'], [2, 'y'], [3, 'z']]);

for (var x of a) { // 遍历Array
    console.log(x);
}
for (var x of s) { // 遍历Set
    console.log(x);
}
for (var x of m) { // 遍历Map
    console.log(x[0] + '=' + x[1]);
}
```

for … of 循环 和 for … in 循环区别
---------------------------

`for ... in` 循环由于历史遗留问题，它遍历的实际上是**对象的属性名称**，一个 `Array` 数组实际上也是一个对象，它的每个元素的**索引**被视为一个属性。

当我们手动给 `Array` 对象添加了额外的属性后，`for ... in` 循环将带来意想不到的意外效果：

```
var a = ['A', 'B', 'C'];
a.name = 'Hello';
for (var x in a) {
    console.log(x); // '0', '1', '2', 'name'
}
```

`for ... in` 循环将把 `name` 包括在内，但 `Array` 的 `length` 属性却不包括在内。

`for ... of` 循环则完全修复了这些问题，它**只循环集合本身的元素**：

```
var a = ['A', 'B', 'C'];
a.name = 'Hello';
for (var x of a) {
    console.log(x); // 'A', 'B', 'C'
}
```

建议使用 `for ... of`。

forEach
-------

更好的遍历方式是直接使用 `iterable` 内置的 `forEach` 方法，它接收一个函数，每次迭代就自动回调该函数。（`forEach()` 方法是 ES5.1 标准引入的，需要测试是否支持）

以 `Array` 为例：

```
var a = ['A', 'B', 'C'];
a.forEach(function (element, index, array) {
    // element: 指向当前元素的值
    // index: 指向当前索引
    // array: 指向Array对象本身
    console.log(element + ', index = ' + index);
});
```

```
A, index = 0
B, index = 1
C, index = 2
```

`Set` 与 `Array` 类似，但 `Set` 没有索引，因此回调函数的前两个参数都是元素本身：

```
var s = new Set(['A', 'B', 'C']);
s.forEach(function (element, sameElement, set) {
    console.log(element);
});
```

```
A
B
C
```

`Map` 的回调函数参数依次为 `value`、`key` 和 `map` 本身：

```
var m = new Map([[1, 'x'], [2, 'y'], [3, 'z']]);
m.forEach(function (value, key, map) {
    console.log(key + ' : ' + value);
});
```

```
x : 1
y : 2
z : 3
```

JavaScript 的函数调用不要求参数必须一致，因此可以忽略不需要的参数。

例如，只需要获得 `Array` 的 `element`：

```
var a = ['A', 'B', 'C'];
a.forEach(function (element) {
    console.log(element);
});
```

函数定义与使用
=======

两种定义函数的方式完全等价：

```
function abs(x) {
    if (x >= 0) {
        return x;
    } else {
        return -x;
    }
}
```

```
var abs = function(x) {
    if (x >= 0) {
        return x;
    } else {
        return -x;
    }
}; // 不要忘了分号
```

JavaScript **允许传入任意个参数**而不影响调用：

```
abs(10, 'blablabla'); // 返回10
abs(-9, 'haha', 'hehe', null); // 返回9
```

传入的参数比定义的少也没有问题：此时 `abs(x)` 函数的参数 `x` 将收到 `undefined`，计算结果为 `NaN`。

```
abs(); // 返回NaN
```

要避免收到 `undefined`，可以对参数进行检查：

```
function abs(x) {
    if (typeof x !== 'number') {
        throw 'Not a number';
    }
    if (x >= 0) {
        return x;
    } else {
        return -x;
    }
}
```

arguments
---------

`arguments` 只在函数内部起作用，并且永远指向**当前函数的调用者传入的所有参数**。  
`arguments` 类似 `Array` 但它不是一个 `Array`：

```
function foo(x) {
    console.log('x = ' + x); // 10
    for (var i = 0; i < arguments.length; i++) {
        console.log('arg ' + i + ' = ' + arguments[i]); // 10, 20, 30
    }
}

foo(10, 20, 30);
```

```
x = 10
arg 0 = 10
arg 1 = 20
arg 2 = 30
```

利用 `arguments` 可以获得调用者传入的所有参数。也就是说，即使函数不定义任何参数，还是可以拿到参数的值：

```
function abs() {
    if (arguments.length === 0) {
        return 0;
    }
    var x = arguments[0];
    return x > 0 ? x : -x;
}
```

`arguments` 最常用于判断传入参数的个数。  
例如：要把中间的参数 `b` 变为 “可选” 参数，就只能通过 `arguments` 判断，重新调整参数并赋值。

```
// foo(a[, b], c)
// 接收2~3个参数，b是可选参数，如果只传2个参数，b默认为null：
function foo(a, b, c) {
    if (arguments.length === 2) {
        // 实际拿到的参数是a和b，c为undefined
        c = b; // 把b赋给c
        b = null; // b变为默认值
    }
    // ...
}
```

rest
----

JavaScript 函数允许接收任意个参数，可以使用 `arguments` 来获取所有参数：

```
function foo(a, b) {
    var i, rest = [];
    if (arguments.length > 2) {
        for (i = 2; i < arguments.length; i++) {
            rest.push(arguments[i]);
        }
    }
    console.log('a = ' + a);
    console.log('b = ' + b);
    console.log(rest);
}
```

为了获取除了已定义参数 `a`、`b` 之外的参数，我们不得不用 `arguments`，并且循环要从索引 `2` 开始以便排除前两个参数，这种写法很别扭，只是为了获得额外的 `rest` 参数，有没有更好的方法？

ES6 标准引入了 rest 参数，上面的函数可以改写为：

```
function foo(a, b, ...rest) {
    console.log('a = ' + a);
    console.log('b = ' + b);
    console.log(rest);
}

foo(1, 2, 3, 4, 5);
// 结果:
// a = 1
// b = 2
// Array [ 3, 4, 5 ]

foo(1);
// 结果:
// a = 1
// b = undefined
// Array []
```

小心 return 语句
------------

JavaScript 引擎有一个**在行末自动添加分号**的机制，这是 `return` 的一个大坑：

```
function foo() {
    return { name: 'foo' };
}

foo(); // { name: 'foo' }
```

如果把 return 语句拆成两行：

```
function foo() {
    return
        { name: 'foo' };
}

foo(); // undefined
```

由于 JavaScript 引擎在行末自动添加分号的机制，上面的代码实际上变成了：

```
function foo() {
    return; // 自动添加了分号，相当于return undefined;
        { name: 'foo' }; // 这行语句已经没法执行到了
}
```

所以正确的多行写法是：

```
function foo() {
    return { // 这里不会自动加分号，因为{表示语句尚未结束
        name: 'foo'
    };
}
```

练习：  
定义一个计算圆面积的函数 `area_of_circle()`，它有两个参数：

*   r: 表示圆的半径；
*   pi: 表示 π 的值，如果不传，则默认 3.14

```
function area_of_circle(r, pi) {
    if (typeof pi === 'undefined') {
        pi = 3.14;
    }
    return pi * r * r;
}
```