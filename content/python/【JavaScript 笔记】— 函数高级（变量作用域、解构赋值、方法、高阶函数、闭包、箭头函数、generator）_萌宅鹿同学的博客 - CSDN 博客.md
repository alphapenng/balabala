> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_43734095/article/details/106173591)

### [JavaScript](https://so.csdn.net/so/search?q=JavaScript&spm=1001.2101.3001.7020) 个人笔记

*   [变量作用域](#_5)
*   *   [变量提升](#_6)
    *   [全局对象 windows](#_windows_47)
    *   [命名空间](#_76)
    *   [局部作用域](#_98)
    *   [常量](#_141)
*   [解构赋值](#_156)
*   *   [使用场景](#_261)
*   [方法](#_301)
*   *   [apply](#apply_409)
    *   [装饰器](#_445)
*   [高阶函数（Array）](#Array_468)
*   *   [map](#map_498)
    *   [reduce](#reduce_520)
    *   [map、reduce 练习](#mapreduce_539)
    *   [filter](#filter_626)
    *   [sort](#sort_686)
    *   [every、find、findIndex、forEach](#everyfindfindIndexforEach_742)
*   [闭包](#_807)
*   *   [函数作为返回值](#_808)
    *   [闭包的细节](#_837)
*   [箭头函数](#_1018)
*   *   [箭头函数对 this 的修复](#_this__1071)
*   [generator](#generator_1121)

> 学习自[廖雪峰的博客](https://www.liaoxuefeng.com/wiki/1022910821149312)，记录一些个人笔记。

变量作用域
=====

变量提升
----

变量提升：函数体中**申明的变量**会被提升到函数顶部，但**不会提升变量的赋值**。

```
function foo() {
    var x = 'Hello, ' + y;
    console.log(x);
    var y = 'Bob';
}

foo(); // Hello, undefined
```

对于上述 `foo()` 函数，JavaScript 引擎看到的代码相当于：

```
function foo() {
    var y; // 提升变量y的申明，此时y为undefined
    var x = 'Hello, ' + y;
    console.log(x);
    y = 'Bob';
}
```

建议采用 “**在函数内部首先申明所有变量**” 这一规则。

最常见的做法是用一个 `var` 申明函数内部用到的所有变量：

```
function foo() {
    var
        x = 1, // x初始化为1
        y = x + 1, // y初始化为2
        z, i; // z和i为undefined
    // 其他语句:
    for (i = 0; i < 100; i++) {
        ...
    }
}
```

全局对象 windows
------------

**不在任何函数内定义的变量就具有全局作用域**。

JavaScript 默认有一个全局对象 `window`，全局作用域的变量被绑定到 `window` 的一个属性。

```
var course = 'Learn JavaScript';
alert(course); // 'Learn JavaScript'
alert(window.course); // 'Learn JavaScript' // 通过全局对象 window 调用
```

以变量方式 `var foo = function () {}` 定义的函数实际上也是一个全局变量。

顶层函数的定义也被视为一个全局变量，并绑定到 `window` 对象：

```
window.alert('调用window.alert()');
// 把alert保存到另一个变量:
var old_alert = window.alert;
// 给alert赋一个新函数:
window.alert = function () {}

alert('无法用alert()显示了!');

// 恢复alert:
window.alert = old_alert;
alert('又可以用alert()了!');
```

命名空间
----

全局变量会绑定到 `window` 上，不同的 JavaScript 文件如果使用了相同的全局变量，或者定义了相同名字的顶层函数，都会造成命名冲突，并且很难被发现。

减少冲突的一个方法是把自己的所有变量和函数全部绑定到一个全局变量中。例如：

```
// 唯一的全局变量MYAPP:
var MYAPP = {};

// 其他变量:
MYAPP.name = 'myapp';
MYAPP.version = 1.0;

// 其他函数:
MYAPP.foo = function () {
    return 'foo';
};
```

把自己的代码全部放入唯一的命名空间 `MYAPP` 中，会大大减少全局变量冲突的可能。

许多著名的 JavaScript 库都是这么干的：jQuery，YUI，underscore 等等。

局部作用域
-----

JavaScript 的**变量作用域**实际上是**函数内部**，很多语言都是 `{ }`。

```
var foo= function () {
    {
        var i = 99;
    }
    i = i + 1; // 仍然可以访问i
    console.log(i);
}

console.log(i); // Uncaught ReferenceError: i is not defined
```

我们在 `for` 循环等语句块中是无法定义具有局部作用域的变量的：

```
function foo() {
    for (var i = 0; i < 100; i++) {
        //
    }
    i += 100; // i是个全局变量, 仍然可以引用变量i
}
```

为了**解决块级作用域**，ES6 引入了新的关键字 `let`，用 `let` 替代 `var` 可以申明一个块级作用域的变量：

```
var foo = function () {
    {
        let i = 99;
    }
    console.log(i); // Uncaught ReferenceError: i is not defined
}
```

```
function foo() {
    var sum = 0;
    for (let i=0; i<100; i++) {
        sum += i;
    }
    i += 1; // Uncaught ReferenceError: i is not defined
}
```

常量
--

`var` 和 `let` 申明的是**变量**；

ES6 之前，语法上无法声明常量，通常用大写字母命名来表示 **常量**：

```
var PI = 3.14;
```

ES6 标准引入了新的关键字 `const` 来定义常量，`const` 与 `let` 都 **具有块级作用域**：

```
const PI = 3.14;
PI = 3; // 某些浏览器不报错，但是无效果！
PI; // 3.14
```

解构赋值
====

从 ES6 开始，JavaScript 引入了**解构赋值**，可以**同时对一组变量进行赋值**。

我们先看看传统的做法，如何把一个数组的元素分别赋值给几个变量：`[]`

```
var array = ['hello', 'JavaScript', 'ES6'];
var x = array[0];
var y = array[1];
var z = array[2];
```

在 ES6 中使用 解构赋值 对多个变量同时赋值：

```
var [x, y, z] = ['hello', 'JavaScript', 'ES6'];
```

如果**数组本身有嵌套**，也可以进行解构赋值，注意嵌套层次和位置要保持一致：

```
let [x, [y, z]] = ['hello', ['JavaScript', 'ES6']];
x; // 'hello'
y; // 'JavaScript'
z; // 'ES6'
```

解构赋值可以忽略某些元素：

```
let [, , z] = ['hello', 'JavaScript', 'ES6']; // 忽略前两个元素，只对z赋值第三个元素
z; // 'ES6'
```

从一个对象中取出若干属性，也可以使用解构赋值，便于快速获取对象的指定属性：`{}`

**对象的属性有嵌套**，也可以进行解构赋值，只要保证对应的层次是一致的。

**变量名** 必须与 **属性名** 相同，否则会被赋值 `undefined`。

```
var person = {
    name: '小明',
    age: 20,
    gender: 'male',
    passport: 'G-12345678',
    school: 'No.4 middle school',
    address: {
        city: 'Beijing',
        street: 'No.1 Road',
        zipcode: '100001'
    }
};
var {name, age, passport} = person;
// name, age, passport分别被赋值为对应属性:

// 对象的属性有嵌套, 使用解构赋值
var {name, address: {city, zip}} = person;
```

如果要使用的**变量名和属性名不一致**，可以用下面的语法获取：先获取，再用 `:` 取别名。

```
var person = {
    name: '小明',
    age: 20,
    gender: 'male',
    passport: 'G-12345678',
    school: 'No.4 middle school'
};

// 把passport属性赋值给变量id:
let {name, passport:id} = person;
name; // '小明'
id; // 'G-12345678'
// 注意: passport不是变量，而是为了让变量id获得passport属性:
passport; // Uncaught ReferenceError: passport is not defined
```

解构赋值还可以**使用默认值**，这样就避免了不存在的属性返回 `undefined` 的问题：

```
var person = {
    name: '小明',
    age: 20,
    gender: 'male',
    passport: 'G-12345678'
};

// 如果person对象没有single属性，默认赋值为true:
var {name, single=true} = person;
name; // '小明'
single; // true
```

有些时候，如果变量已经被声明了，再次赋值的时候，正确的写法也会报语法错误：

```
// 声明变量:
var x, y;
// 解构赋值:
{x, y} = { name: '小明', x: 100, y: 200};
// 语法错误: Uncaught SyntaxError: Unexpected token =
```

这是因为 JavaScript 引擎把 `{` 开头的语句当作了块处理，于是 `=` 不再合法。  
解决方法是用小括号括起来：

```
({x, y} = { name: '小明', x: 100, y: 200});
```

使用场景
----

解构赋值在很多时候可以 **大大简化代码**。

交换两个变量 `x` 和 `y` 的值：

```
var x = 1, y = 2;
[x, y] = [y, x];
```

快速获取当前页面的域名和路径：

```
var {hostname:domain, pathname:path} = location;
```

**如果一个函数接收一个对象作为参数**，那么，可以使用解构直接把对象的属性绑定到变量中。  
例如，下面的函数可以快速创建一个 `Date` 对象：

```
function buildDate({year, month, day, hour=0, minute=0, second=0}) {
    return new Date(year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second);
}
```

它的方便之处在于传入的对象只需要 `year`、`month` 和 `day` 这三个属性：

```
buildDate({ year: 2017, month: 1, day: 1 });
// Sun Jan 01 2017 00:00:00 GMT+0800 (CST)
```

也可以传入 `hour`、`minute` 和 `second` 属性：

```
buildDate({ year: 2017, month: 1, day: 1, hour: 20, minute: 15 });
// Sun Jan 01 2017 20:15:00 GMT+0800 (CST)
```

使用解构赋值可以减少代码量，但是，需要在支持 ES6 解构赋值特性的现代浏览器中才能正常运行。

方法
==

在一个对象中绑定函数，称为这个对象的方法。

```
var xiaoming = {
    name: '小明',
    birth: 1990,
    age: function () { // age()方法, 返回xiaoming的年龄
        var y = new Date().getFullYear();
        return y - this.birth;
    }
};

xiaoming.age; // function xiaoming.age()
xiaoming.age(); // 今年调用是25,明年调用就变成26了
```

在一个方法内部，`this` 是一个特殊变量，它始终指向当前对象。  
上例中，也就是 `xiaoming` 这个变量。所以，`this.birth` 可以拿到 `xiaoming` 的 `birth` 属性。

**这里有很大的坑**，要保证 `this` 指向正确，必须用 `obj.xxx()` 的形式调用：

```
function getAge() {
    var y = new Date().getFullYear();
    return y - this.birth;
}

var xiaoming = {
    name: '小明',
    birth: 1990,
    age: getAge
};

xiaoming.age(); // 25, 正常结果

getAge(); // NaN

var fn = xiaoming.age; // 先拿到xiaoming的age函数
fn(); // NaN
```

这是一个巨大的设计错误，并且难以纠正。

ECMA 决定，在 strict 模式下让函数的 `this` 指向 `undefined`，因此，在 strict 模式下，会报错。

```
'use strict';

var xiaoming = {
    name: '小明',
    birth: 1990,
    age: function () {
        var y = new Date().getFullYear();
        return y - this.birth;
    }
};

var fn = xiaoming.age;
fn(); // Uncaught TypeError: Cannot read property 'birth' of undefined
```

这个决定只是让错误及时暴露出来，并没有解决 `this` 应该指向的正确位置。

注意：**函数内部的 this 和 外部的 this 指向是不同的**。

```
'use strict';

var xiaoming = {
    name: '小明',
    birth: 1990,
    age: function () {
        function getAgeFromBirth() { // 函数内部定义的函数
            var y = new Date().getFullYear();
            return y - this.birth; // 函数内部的this和外部的this不同
        }
        return getAgeFromBirth();
    }
};

xiaoming.age(); // Uncaught TypeError: Cannot read property 'birth' of undefined
```

当然也有修复的办法：用 `var _this = this;` 记录外部的 `this`，再在函数内部调用 `_this`。

```
'use strict';

var xiaoming = {
    name: '小明',
    birth: 1990,
    age: function () {
        var _this = this; // 在方法内部一开始就捕获this
        function getAgeFromBirth() {
            var y = new Date().getFullYear();
            return y - _this.birth; // 用_this而不是this
        }
        return getAgeFromBirth();
    }
};

xiaoming.age(); // 25
```

用 `var _this = this;`，你就可以放心地在方法内部定义其他函数，而不是把所有语句都堆到一个方法中。

apply
-----

虽然在一个独立的函数调用中，根据是否是 strict 模式，`this` 指向 `undefined` 或 `window`，不过，我们还是可以控制 `this` 的指向的！

要指定函数的 `this` 指向哪个对象，可以用**函数本身**的 `apply` 方法，它接收两个参数，第一个参数就是需要绑定的 `this` 变量，第二个参数是 `Array`，表示函数本身的参数。

用 `apply` 修复 `getAge()` 调用：

```
function getAge() {
    var y = new Date().getFullYear();
    return y - this.birth;
}

var xiaoming = {
    name: '小明',
    birth: 1990,
    age: getAge
};

xiaoming.age(); // 25
getAge.apply(xiaoming, []); // 25, this指向xiaoming, 参数为空
```

另一个与 `apply()` 类似的方法是 `call()`，唯一区别是：

*   `apply()` 把参数打包成 `Array` 再传入；
*   `call()` 把参数按顺序传入。

比如调用 `Math.max(3, 5, 4)`，分别用 `apply()` 和 `call()` 实现如下：

```
Math.max.apply(null, [3, 5, 4]);
Math.max.call(null, 3, 5, 4);
```

对普通函数调用，我们通常把 `this` 绑定为 `null`。

装饰器
---

利用 `apply()`，我们还可以**动态改变函数的行为**。

JavaScript 的所有对象都是动态的，即使内置的函数，我们也可以重新指向新的函数。

现在假定我们想统计一下代码一共调用了多少次 `parseInt()`。可以把所有的调用都找出来，然后手动加上 `count += 1`，不过这样做太傻了。最佳方案是用我们自己的函数替换掉默认的 `parseInt()`：

```
'use strict'
var count = 0;
var oldParseInt = parseInt; // 	保存原函数
window.parseInt = function() {
    count += 1;
 	return oldParseInt.apply(null, arguments); // 调用原函数
};

// 测试:
parseInt('10');
parseInt('20');
parseInt('30');

console.log('count = ' + count); // 3
```

高阶函数（Array）
===========

高阶函数英文叫 Higher-order function。那么什么是高阶函数？

*   **一个函数接收另一个函数作为参数**，这种函数就称之为高阶函数。

一个最简单的高阶函数：

```
function add(x, y, f) {
    return f(x) + f(y);
}
```

当我们调用 `add(-5, 6, Math.abs)` 时，参数 x，y 和 f 分别接收 -5，6 和 函数 `Math.abs`，根据函数定义，我们可以推导计算过程为：

```
x = -5;
y = 6;
f = Math.abs;
f(x) + f(y) ==> Math.abs(-5) + Math.abs(6) ==> 11;
return 11;
```

用代码验证一下：

```
function add(x, y, f) {
    return f(x) + f(y);
}

var x = add(-5, 6, Math.abs); // 11
console.log(x); // 11
```

编写高阶函数，就是让函数的参数能够接收别的函数。

map
---

比如我们有一个函数 f (x) = x2，要把这个函数作用在一个数组 `[1, 2, 3, 4, 5, 6, 7, 8, 9]` 上，就可以用 `map` 实现如下：  
![](https://img-blog.csdnimg.cn/20200518005429738.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
`map()` 方法定义在 JavaScript 的 `Array` 中，我们调用 `Array` 的 `map()` 方法，传入我们自己的函数，就得到了一个新的 `Array` 作为结果：

```
function pow(x) {
    return x * x;
}

var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];	
var results = arr.map(pow); // [1, 4, 9, 16, 25, 36, 49, 64, 81]
```

注意：`map()` 传入的参数是 `pow`，即**函数对象本身**。

`map()` 作为高阶函数，事实上它把运算规则抽象了，因此，我们不但可以计算简单的 f (x) = x2，还可以计算任意复杂的函数，比如，把 `Array` 的所有数字转为字符串只需要一行代码。

```
var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
arr.map(String);
```

reduce
------

`Array` 的 `reduce()` 把一个**函数**作用在这个 `Array` 的 `[x1, x2, x3...]` 上，**这个函数必须接收两个参数**，`reduce()` 把结果继续和序列的下一个元素做累积计算，其效果就是：

比方说对一个 `Array` 求和，就可以用 `reduce` 实现：

```
var arr = [1, 3, 5, 7, 9];
arr.reduce(function(x, y) {
    return x + y;
}); // 25
```

要把 `[1, 3, 5, 7, 9]` 变换成整数 13579，`reduce()` 也能派上用场：

```
var arr = [1, 3, 5, 7, 9];
arr.reduce(function (x, y) {
    return x * 10 + y;
}); // 13579
```

map、reduce 练习
-------------

（1）不使用 `parseInt()` 函数，利用 `map` 和 `reduce` 操作实现一个 `string2int()` 函数。  
思路：把字符串 `13579` 先变成 `Array` —— `[1, 3, 5, 7, 9]`，再利用 `reduce()` 。

```
function string2int (s) {
    s = s.split('');
    s = s.map(function (x) {
        return +x;
    });
    s = s.reduce(function (x, y) {
        return x * 10 + y;
    });
    return s;
}
/
function string2int(s) {
    s = s.split('');
    s = s.map((x) => {
        return +x;
    });
    s = s.reduce((x, y) => {
        return x * 10 + y;
    });
    return s;
}
/
function string2int(s) {
    return s.split('').map(x => x * 1).reduce((x, y) => x * 10 + y);
}
/
function string2int(s) {
    return s * 1;
}
/
function string2int(s) {
    return +s;
}
```

（2）请把用户输入的不规范的英文名字，变为首字母大写，其他小写的规范名字。  
输入：`['adam', 'LISA', 'barT']`，输出：`['Adam', 'Lisa', 'Bart']`。

```
function normalize(arr) {
    arr = arr.map(function(x) {
    	return x.charAt(0).toUpperCase() + x.substring(1).toLowerCase();
   	})
	return arr;
}
/
function normalize(arr) {
    arr = arr.map((x) => {
    	return x.charAt(0).toUpperCase() + x.substring(1).toLowerCase();
   	})
	return arr;
}
/
function normalize(arr) {
    arr = arr.map((x) => x.charAt(0).toUpperCase() + x.substring(1).toLowerCase());
    return arr;
}
```

（3）小明希望利用 `map()` 把字符串变成整数，他写的代码很简洁：

```
var arr = ['1', '2', '3'];
var r;
r = arr.map(parseInt);
console.log(r);
```

```
1, NaN, NaN
```

结果竟然是 `1, NaN, NaN`，小明百思不得其解，请帮他找到原因并修正代码。

错误原因：[https://www.cnblogs.com/liuyfl/p/4476179.html](https://www.cnblogs.com/liuyfl/p/4476179.html)

```
var arr = ['1', '2', '3'];
var r;
r = arr.map(x => parseInt(x));
console.log(r);
```

filter
------

`filter` 也是一个常用的操作，它用于把 `Array` 的某些元素过滤掉，然后返回剩下的元素。

`filter()` 接收一个**函数**，把传入的函数依次作用于每个元素，函数返回值为 `true` 则保留元素，为 `false` 则删除元素。

例如，在一个 `Array` 中，删掉偶数，只保留奇数，可以这么写：

```
var arr = [1, 2, 4, 5, 6, 9, 10, 15];
var r = arr.filter(function (x) {
    return x % 2 !== 0;
});
r; // [1, 5, 9, 15]
```

把一个 `Array` 中的空字符串删掉，可以这么写：

```
var arr = ['A', '', 'B', null, undefined, 'C', '  '];
var r = arr.filter(function (s) {
    return s && s.trim(); // 注意：IE9以下的版本没有trim()方法
});
r; // ['A', 'B', 'C']
```

`filter()` 接收的 **回调函数**，其实可以有多个参数。通常我们仅使用第一个参数，表示 `Array` 的某个元素。回调函数还可以接收另外两个参数，表示元素的位置和数组本身：

```
var arr = ['A', 'B', 'C'];
var r = arr.filter(function (element, index, self) {
    console.log(element); // 依次打印'A', 'B', 'C'
    console.log(index); // 依次打印0, 1, 2
    console.log(self); // self就是变量arr
    return true;
});
```

利用 `filter`，可以巧妙地去除 `Array` 的重复元素：

```
var 
	r,
    arr = ['apple', 'strawberry', 'banana', 'pear', 'apple', 'orange', 'orange', 'strawberry'];

r = arr.filter(function (element, index, self) {
    return self.indexOf(element) === index; // 保留
});
```

练习：请尝试用 `filter()` 筛选出素数：

```
function get_primes(arr) {
        return arr.filter(function(ele) {
        if (ele === 1) return false; // 1是特殊情况
        let count = 0;
        for (let i = 1; i < ele; i++) {
            if (ele % i == 0) count++;
            if (count >= 2) return false;
        }
        return true;
    });
}
```

sort
----

`Array` 的 `sort()` 方法就是用于排序的，但是默认排序结果**令人震惊**：

```
// 理想中的结果:
['Google', 'Apple', 'Microsoft'].sort(); // ['Apple', 'Google', 'Microsoft'];

// 实际结果: apple排在了最后
['Google', 'apple', 'Microsoft'].sort(); // ['Google', 'Microsoft", 'apple']

// 无法理解的结果:
[10, 20, 1, 2].sort(); // [1, 10, 2, 20]
```

第二个排序把 `apple` 排在了最后，是因为字符串根据 ASCII 码进行排序，而小写字母 `a` 的 ASCII 码在大写字母 `A` 之后。

第三个排序结果是因为 `Array` 的 `sort()` 方法 **默认把所有元素先转换为 String 再排序**，结果 `'10'` 排在了 `'2'` 的前面，因为字符 `'1'` 比字符 `'2'` 的 ASCII 码小。

`sort()` 方法的默认排序规则十分反人类，好在 `sort()` 方法也是一个高阶函数，它还可以接收一个**比较函数**来实现自定义的排序。

要按数字大小排序，我们可以这么写：

```
var arr = [10, 20, 1, 2];
arr.sort(function(x, y) {
    if (x < y) {
        return -1;
    }
    if (x > y) {
        return 1;
    }
    return 0;
});
console.log(arr); // [1, 2,10, 20]
```

如果要**倒序排序**，我们可以把大的数放前面：

```
var arr = [10, 20, 1, 2];
arr.sort(function (x, y) {
    if (x < y) {
        return 1;
    }
    if (x > y) {
        return -1;
    }
    return 0;
}); // [20, 10, 2, 1]
```

要注意，`sort()` 方法会直接对 `Array` 进行修改，它返回的结果仍是当前 `Array`：

```
var a1 = ['B', 'A', 'C'];
var a2 = a1.sort();
a1; // ['A', 'B', 'C']
a2; // ['A', 'B', 'C']
a1 === a2; // true, a1和a2是同一对象
```

every、find、findIndex、forEach
----------------------------

对于数组，除了 `map()`、`reduce`、`filter()`、`sort()` 这些方法可以传入一个函数外，`Array` 对象还提供了很多非常实用的高阶函数。

`every()` **用于判断数组的所有元素是否满足测试条件**。

例如，给定一个包含若干字符串的数组，判断所有字符串是否满足指定的测试条件：

```
var arr = ['Apple', 'pear', 'orange'];
arr.every(function (s) {
    return s.length > 0;
}); // true, 因为每个元素都满足s.length>0

arr.every(function (s) {
    return s.toLowerCase() === s;
}); // false, 因为不是每个元素都全部是小写
```

`find()` **用于查找符合条件的第一个元素**，找到则返回该元素，否则返回 `undefined`：

```
var arr = ['Apple', 'pear', 'orange'];
arr.find(function (s) {
    return s.toLowerCase() === s;
}); // 'pear', 因为pear全部是小写

arr.find(function (s) {
    return s.toUpperCase() === s;
}); // undefined, 因为没有全部是大写的元素
```

`findIndex()` **用于查找符合条件的第一个元素**，找到则返回该**元素的索引**，否则返回 `-1`：

```
var arr = ['Apple', 'pear', 'orange'];
console.log(arr.findIndex(function (s) {
    return s.toLowerCase() === s;
})); // 1, 因为'pear'的索引是1

console.log(arr.findIndex(function (s) {
    return s.toUpperCase() === s;
})); // -1
```

`forEach()` 和 `map()` 类似，也把每个元素依次作用于传入的函数，**但不会返回新的数组**。  
`forEach()` 常用于遍历数组，因此，传入的函数不需要返回值：

```
var arr = ['Apple', 'pear', 'orange'];

// 依次打印每个元素
arr.forEach(function (x) {
    console.log(x);
});

arr.forEach(console.log);
```

[闭包](https://so.csdn.net/so/search?q=%E9%97%AD%E5%8C%85&spm=1001.2101.3001.7020)
================================================================================

函数作为返回值
-------

高阶函数除了可以接受函数作为参数外，还可以把函数作为**结果值**返回。

```
function lazy_sum(arr) {
    var sum = function () {
        return arr.reduce(function (x, y) {
            return x + y;
        });
    }
    return sum;
}
```

调用 `lazy_sum()` 时，返回求和函数；调用 `f()` 时返回计算结果。

```
var f = lazy_sum([1, 2, 3, 4, 5]); // function sum()

f(); // 15
```

这个例子中，函数 `lazy_sum` 中又定义了函数 `sum`，并且，内部函数 `sum` 可以引用外部函数 `lazy_sum` 的参数和局部变量，当 `lazy_sum` 返回函数 `sum` 时，相关参数和变量都保存在返回的函数中，这种称为 **闭包（Closure）** 的程序结构拥有极大的威力。

再注意一点，当我们调用 `lazy_sum()` 时，每次调用都会返回一个新的函数，即使传入相同的参数：

```
var f1 = lazy_sum([1, 2, 3, 4, 5]);
var f2 = lazy_sum([1, 2, 3, 4, 5]);
f1 === f2; // false
```

`f1()` 和 `f2()` 的调用结果互不影响。

闭包的细节
-----

下面这个例子结果可能有点令人震惊：

```
function count() {
    var arr = [];
    for (var i = 1; i <= 3; i++) {
        arr.push(function () {
            return i * i;
        });
    }
    return arr;
}

var results = count();
var f1 = results[0];
var f2 = results[1];
var f3 = results[2];

f1(); // 16
f2(); // 16
f3(); // 16
```

返回值全部都是 `16`，原因就在于返回的函数引用了变量 `i`，但它**并非立刻执行**。等到 3 个函数都返回时，它们所引用的变量 `i` 已经变成了 `4`，因此最终结果为 `16`。

返回闭包时牢记一点：**返回函数不要引用任何循环变量，或者后续会发生变化的变量**。

如果一定要引用循环变量怎么办？方法是再创建一个函数，用该函数的参数绑定循环变量当前的值，无论该循环变量后续如何更改，已绑定到函数参数的值不变：

```
function count () {
    var arr = [];
    for (var i = 1; i <= 3; i++) {
        arr.push((function (n) {
            return function() {
                return n * n;
            }
        })(i));
    }
    return arr;
}

var results = count();
var f1 = results[0];
var f2 = results[1];
var f3 = results[2];

f1(); // 1
f2(); // 4
f3(); // 9
```

这里用了一个 **创建一个匿名函数并立刻执行** 的语法：

```
// 创建匿名函数需要用括号括起函数定义
(function (x) {
    return x * x;
})(3); // 9

// 创建匿名函数【不能】这么写:
function (x) { return x * x } (3) // SyntaxError
```

说了这么多，难道闭包就是为了返回一个函数然后延迟执行吗？

当然不是！闭包有非常强大的功能。举个栗子：

在面向对象的程序设计语言里，比如 Java 和 C++，要在对象内部封装一个**私有变量**，可以用 `private` 修饰一个成员变量。

在没有 `class` 机制，只有函数的语言里，借助闭包，同样可以封装一个私有变量。

我们用 JavaScript 创建一个计数器：

```
function create_counter(initial) {
    var x = initial || 0;
    return { // 返回一个对象
        inc: function () {
            x += 1;
            return x;
        }
    }
}
```

它用起来像这样：

```
var c1 = create_counter();
c1.inc(); // 1
c1.inc(); // 2
c1.inc(); // 3

var c2 = create_counter(10);
c2.inc(); // 11
c2.inc(); // 12
c2.inc(); // 13
```

在返回的对象中，实现了一个闭包，该闭包携带了局部变量 `x`，并且，从外部代码根本无法访问到变量 `x`。换句话说，**闭包就是携带状态的函数，并且它的状态可以完全对外隐藏起来**。

**闭包还可以把多参数的函数变成单参数的函数。**

例如，要计算 x^y 可以用 `Math.pow(x, y)` 函数，不过考虑到经常计算 x2 或 x3，我们可以利用闭包创建新的函数 `pow2` 和 `pow3`：

```
function make_pow (n) {
    return function(x) {
		return Math.pow(x, n);
	}
}

// 创建两个新函数:
var pow2 = make_pow(2);
var pow3 = make_pow(3);

console.log(pow2(5)); // 25
console.log(pow3(7)); // 343
```

**脑洞大开**

很久很久以前，有个叫阿隆佐・邱奇的帅哥，发现只需要用函数，就可以用计算机实现运算，而不需要 `0`、`1`、`2`、`3` 这些数字和 `+`、`-`、`*`、`/` 这些符号。

JavaScript 支持函数，所以可以用 JavaScript 用函数来写这些计算。来试试：

```
// 定义数字0:
var zero = function (f) {
    return function (x) {
        return x;
    }
};

// 定义数字1:
var one = function (f) {
    return function (x) {
        return f(x);
    }
};

// 定义加法:
function add(n, m) {
    return function (f) {
        return function (x) {
            return m(f)(n(f)(x)); // 先执行n(x)，然后执行m(n(x))
        }
    }
}

// 计算数字2 = 1 + 1:
var two = add(one, one);

// 计算数字3 = 1 + 2:
var three = add(one, two);

// 计算数字5 = 2 + 3:
var five = add(two, three);

// 你说它是3就是3，你说它是5就是5，你怎么证明？

// 呵呵，看这里:

// 给3传一个函数,会打印3次:
(three(function () {
    console.log('print 3 times');
}))();

// 给5传一个函数,会打印5次:
(five(function () {
    console.log('print 5 times');
}))();

// 继续接着玩一会...
```

箭头函数
====

ES6 标准新增了一种新的函数：Arrow Function（箭头函数）。

箭头函数有两种表达方式，第一种**只包含一个表达式**，连 `{ ... }` 和 `return` 都省略掉了

```
x => x * x

// 等价于下面
function (x) {
    return x * x;
}
```

还有一种**可以包含多条语句**，这时候就不能省略 `{ ... }` 和 `return`：

```
x => {
    if (x > 0) {
        return x * x;
    }
    else {
        return - x * x;
    }
}
```

如果参数不是一个，就需要用括号 `()` 括起来：

```
// 两个参数:
(x, y) => x * x + y * y

// 无参数:
() => 3.14

// 可变参数:
(x, y, ...rest) => {
    var i, sum = x + y;
    for (i = 0; i < rest.length; i++) {
        sum += rest[i];
    }
    return sum;
}
```

如果**要返回一个对象**，就要注意，如果是单表达式，这么写的话会报错：

```
// SyntaxError:
x => { foo: x }
```

因为和函数体的 `{ ... }` 有语法冲突，所以要改为：

```
// ok:
x => ({ foo: x })
```

箭头函数对 this 的修复
--------------

箭头函数看上去是匿名函数的一种简写，但实际上，箭头函数和匿名函数有个明显的区别：

*   箭头函数内部的 `this` 是词法作用域，由上下文确定。

回顾前面的例子，由于 JavaScript 函数对 `this` 绑定的错误处理，下面的例子无法得到预期结果：

```
var obj = {
    birth: 1990,
    getAge: function () {
        var b = this.birth; // 1990
        var fn = function () {
            return new Date().getFullYear() - this.birth; // this指向window或undefined
        };
        return fn();
    }
};
```

现在，箭头函数完全修复了 `this` 的指向，`this` 总是指向词法作用域，也就是外层调用者 `obj`：

```
var obj = {
    birth: 1990,
    getAge: function () {
        var b = this.birth; // 1990
        var fn = () => new Date().getFullYear() - this.birth; // this指向obj对象
        return fn();
    }
};
obj.getAge(); // 25
```

如果使用箭头函数，以下的写法就不需要了。

```
var _this = this;
```

由于 `this` 在箭头函数中已经按照词法作用域绑定了，所以，用 `call()` 或者 `apply()` 调用箭头函数时，无法对 `this` 进行绑定，**即传入的第一个参数被忽略**：

```
var obj = {
    birth: 1990,
    getAge: function (year) {
        var b = this.birth; // 1990
        var fn = (y) => y - this.birth; // this.birth仍是1990
        return fn.call({birth:2000}, year);
    }
};
obj.getAge(2015); // 25
```

generator
=========

**generator（生成器）** 是 ES6 标准引入的新的数据类型。

generator 跟函数很像，定义如下：

```
function* foo(x) {
    yield x + 1;
    yield x + 2;
    return x + 3;
}
```

和函数不同的是：generator 由 `function*` 定义，并且除了 `return` ，还可以用 `yield` 返回多次。

generator 就是能够返回多次的 “函数”？返回多次有啥用？

以一个著名的斐波那契数列为例，它由 0，1 开头：

```
function fib(max) {
    var
        t,
        a = 0,
        b = 1,
        arr = [0, 1];
    while (arr.length < max) {
        [a, b] = [b, a + b];
        arr.push(b);
    }
    return arr;
}

// 测试:
fib(5); // [0, 1, 1, 2, 3]
fib(10); // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
```

函数只能返回一次，所以必须返回一个 `Array`。

如果换成 generator，就可以一次返回一个数，不断返回多次。用 generator 改写如下：

```
function* fib(max) {
 var
	t,
	a = 0,
	b = 1,
	n = 0;
	while (n < max) {
		yield a;
		[a, b] = [b, a + b];
		n ++;
	}
	return;
```

直接调用试试：

```
fib(5); // fib {[[GeneratorStatus]]: "suspended", [[GeneratorReceiver]]: Window}
```

直接调用一个 generator 和调用函数不一样，`fib(5)` 仅仅是创建了一个 generator 对象，还没有去执行它。

调用 generator 对象有两个方法，一是不断地调用 generator 对象的 `next()` 方法：

```
var f = fib(5);
f.next(); // {value: 0, done: false}
f.next(); // {value: 1, done: false}
f.next(); // {value: 1, done: false}
f.next(); // {value: 2, done: false}
f.next(); // {value: 3, done: false}
f.next(); // {value: undefined, done: true}
```

`next()` 方法会执行 generator 的代码，然后，每次遇到 `yield x;` 就返回一个对象 `{value: x, done: true/false}`，然后 “暂停”。返回的 `value` 就是 `yield` 的返回值，`done` 表示这个 `generator` 是否已经执行结束了。如果 `done` 为 `true`，则 `value` 就是 `return` 的返回值。

当执行到 `done` 为 `true` 时，这个 generator 对象就已经全部执行完毕，不要再继续调用 `next()` 了。

第二个方法是直接用 `for ... of` 循环迭代 generator 对象，这种方式不需要我们自己判断 `done`：

```
function* fib(max) {
    var
        t,
        a = 0,
        b = 1,
        n = 0;
    while (n < max) {
        yield a;
        [a, b] = [b, a + b];
        n ++;
    }
    return;
}

for (var x of fib(10)) {
    console.log(x); // 依次输出0, 1, 1, 2, 3, ...
}
```

generator 和普通函数相比，有什么用？  
因为 generato r 可以在执行过程中多次返回，所以它看上去就像一个**可以记住执行状态的函数**，利用这一点，写一个 generator 就可以实现需要用面向对象才能实现的功能。

例如，用一个对象来保存状态，得这么写：

```
var fib = {
    a: 0,
    b: 1,
    n: 0,
    max: 5,
    next: function () {
        var
            r = this.a,
            t = this.a + this.b;
        this.a = this.b;
        this.b = t;
        if (this.n < this.max) {
            this.n ++;
            return r;
        } else {
            return undefined;
        }
    }
};
```

用对象的属性来保存状态，相当繁琐。

generator 还有另一个巨大的好处，就是把异步回调代码变成 “同步” 代码。这个好处要等到后面学了 AJAX 以后才能体会到。

没有 generator 之前用 AJAX 时需要这么写代码：回调越多，代码越难看。

```
ajax('http://url-1', data1, function (err, result) {
    if (err) {
        return handle(err);
    }
    ajax('http://url-2', data2, function (err, result) {
        if (err) {
            return handle(err);
        }
        ajax('http://url-3', data3, function (err, result) {
            if (err) {
                return handle(err);
            }
            return success(result);
        });
    });
});
```

有了 generator 后用 AJAX 时可以这么写：看上去是同步的代码，实际执行是异步的。

```
try {
    r1 = yield ajax('http://url-1', data1);
    r2 = yield ajax('http://url-2', data2);
    r3 = yield ajax('http://url-3', data3);
    success(r3);
}
catch (err) {
    handle(err);
}
```

**练习**

要生成一个自增的 ID，可以编写一个 `next_id()` 函数：

```
var current_id = 0;

function next_id() {
    current_id ++;
    return current_id;
}
```

由于函数无法保存状态，故需要一个全局变量 `current_id` 来保存数字。

不用闭包，试用 generator 改写：

```
var current_id = 1;
while(true) {
    current_id++
    yield current_id;
}
return;
```