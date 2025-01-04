# TypeScript 开发实战

- [TypeScript 开发实战](#typescript-开发实战)
  - [类型带来的问题](#类型带来的问题)
  - [TypeScript 的编译环境](#typescript-的编译环境)
  - [TypeScript 的运行环境](#typescript-的运行环境)
  - [JavaScript 和 TypeScript 的数据类型](#javascript-和-typescript-的数据类型)
    - [JavaScript 类型 - number 类型](#javascript-类型---number-类型)
    - [JavaScript 类型 - boolean 类型](#javascript-类型---boolean-类型)
    - [JavaScript 类型 - string 类型](#javascript-类型---string-类型)
    - [JavaScript 类型 - Array 类型](#javascript-类型---array-类型)
    - [JavaScript 类型 - object 类型](#javascript-类型---object-类型)
    - [JavaScript 类型 - Symbol 类型](#javascript-类型---symbol-类型)
    - [JavaScript 类型 - undefined 和 null 类型](#javascript-类型---undefined-和-null-类型)
    - [TypeScript 类型 - any 类型](#typescript-类型---any-类型)
    - [TypeScript 类型 - unknown 类型](#typescript-类型---unknown-类型)
    - [TypeScript 类型 - void 类型](#typescript-类型---void-类型)
    - [TypeScript 类型 - never 类型](#typescript-类型---never-类型)
    - [TypeScript 类型 - tuple 类型](#typescript-类型---tuple-类型)
  - [TypeScript 类型补充](#typescript-类型补充)
    - [类型推导](#类型推导)
    - [函数的参数类型](#函数的参数类型)
    - [函数的返回值类型](#函数的返回值类型)
    - [匿名函数的参数类型](#匿名函数的参数类型)
    - [对象类型](#对象类型)
    - [可选类型](#可选类型)
    - [联合类型](#联合类型)
    - [类型别名](#类型别名)
    - [交叉类型](#交叉类型)
    - [类型断言 as](#类型断言-as)
    - [非空类型断言!](#非空类型断言)
    - [可选链的使用](#可选链的使用)
    - [?? 和 !! 的作用](#-和--的作用)
    - [字面量类型](#字面量类型)
    - [字面量推理](#字面量推理)
    - [类型缩小](#类型缩小)
  - [TypeScript 函数类型](#typescript-函数类型)
    - [函数类型参数的格式](#函数类型参数的格式)
    - [函数的调用签名（Call Signatures）](#函数的调用签名call-signatures)
    - [函数的构造签名（Construct Signatures）](#函数的构造签名construct-signatures)
    - [函数的默认参数](#函数的默认参数)
    - [函数的剩余参数](#函数的剩余参数)
    - [函数的重载](#函数的重载)
    - [可推导的 this 类型](#可推导的-this-类型)
    - [this 相关的内置工具](#this-相关的内置工具)
  - [TypeScript 面向对象](#typescript-面向对象)
    - [类的继承](#类的继承)
    - [类的多态](#类的多态)
    - [类的成员修饰符](#类的成员修饰符)
    - [只读属性 readonly](#只读属性-readonly)
    - [getters/setters](#getterssetters)
    - [类的参数属性](#类的参数属性)
    - [类的静态成员](#类的静态成员)
    - [抽象类 abstract](#抽象类-abstract)
    - [鸭子类型](#鸭子类型)
    - [类的类型](#类的类型)
    - [接口的声明](#接口的声明)
    - [别名和接口区别](#别名和接口区别)
    - [索引签名](#索引签名)
    - [接口继承](#接口继承)
    - [接口的类实现过程](#接口的类实现过程)
    - [严格字面量赋值检测](#严格字面量赋值检测)
    - [函数类型](#函数类型)
    - [抽象类和接口的区别](#抽象类和接口的区别)
    - [枚举类型基本使用](#枚举类型基本使用)
    - [枚举类型设置值](#枚举类型设置值)
  - [TypeScript 泛型编程](#typescript-泛型编程)
    - [泛型语法的基本使用](#泛型语法的基本使用)
    - [泛型接口、类的使用](#泛型接口类的使用)
      - [泛型接口的使用](#泛型接口的使用)
      - [泛型类的使用](#泛型类的使用)
    - [泛型约束和类型条件](#泛型约束和类型条件)
      - [泛型约束（Generic Constraints）](#泛型约束generic-constraints)
      - [类型条件](#类型条件)
    - [TypeScript 映射类型（Mapped Types）](#typescript-映射类型mapped-types)
      - [基本使用](#基本使用)
      - [映射修饰符 （Mapping Modifiers）](#映射修饰符-mapping-modifiers)
    - [类型工具和类型体操](#类型工具和类型体操)
      - [条件类型（Conditional Types）](#条件类型conditional-types)
      - [在条件类型中推断（infer）](#在条件类型中推断infer)
      - [分发条件类型（Distributive Conditional Types）](#分发条件类型distributive-conditional-types)
      - [内置工具](#内置工具)
        - [Parial](#parial)
        - [Required](#required)
        - [Readonly](#readonly)
        - [Record\<Keys, Type\>](#recordkeys-type)
        - [Pick\<Type, Keys\>](#picktype-keys)
        - [Omit\<Type, Keys\>](#omittype-keys)
        - [Exclude\<UnionType, ExcludedMembers\>](#excludeuniontype-excludedmembers)
        - [Extract\<Type, Union\>](#extracttype-union)
        - [NonNullable](#nonnullable)
        - [ReturnType](#returntype)
        - [InstanceType](#instancetype)
  - [TypeScript 知识扩展](#typescript-知识扩展)
    - [TypeScript 模块使用](#typescript-模块使用)
      - [非模块（Non-modules）](#非模块non-modules)
      - [内置类型导入（Inline type imports）](#内置类型导入inline-type-imports)
    - [TypeScript 命名空间](#typescript-命名空间)
    - [内置声明文件的使用](#内置声明文件的使用)
      - [类型的查找](#类型的查找)
      - [内置类型声明](#内置类型声明)
      - [内置声明的环境](#内置声明的环境)
        - [typescript webpack 环境配置](#typescript-webpack-环境配置)
    - [第三方库声明的文件](#第三方库声明的文件)
      - [declare 文件模块](#declare-文件模块)
      - [declare 命名空间](#declare-命名空间)
    - [tsconfig 配置文件解析](#tsconfig-配置文件解析)
      - [认识 tsconfig.json 文件](#认识-tsconfigjson-文件)
      - [tsconfig.json 配置](#tsconfigjson-配置)
    - [axios 封装](#axios-封装)

## 类型带来的问题

- 首先你需要知道，编程开发中我们有一个共识：**错误出现的越早越好**
  - 能在**写代码的时候**发现错误，就不要在**代码编译时**再发现（IDE 的优势就是在代码编写的过程中帮助我们发现错误）。
  - 能在**代码编译期间**发现错误，就不要在**代码运行期间**再发现（类型检测就可以很好的帮助我们做到这一点）。
  - 能在开发阶段发现错误，就不要在测试期间发现错误，能在测试期间发现错误，就不要在上线后发现错误。

## TypeScript 的编译环境

- TypeScript 的编译环境
  - 在我们我们提到过，TypeScript 最终会编译成 JavaScript 来运行，所以我们需要搭建对应的环境：
    - 我们需要在电脑上安装 TypeScript，这样就可以通过 TypeScript 的 Compiler 将其编译成 JavaScript；
    - 所以，我们需要先进行全局的安装：

      ```bash
      # 安装命令
      npm install -g typescript
      # 查看版本
      tsc -v
      ```

## TypeScript 的运行环境

- 方式一：webpack 配置
  - 自行查看对应的文章：<https://mp.weixin.qq.com/s/wnL1l-ERjTDykWM76l4Ajw>；
- 方式二：安装 `ts-node`
  - `npm install ts-node -g`
  - `npm install tslib @types/node -g`
  - `ts-node index.ts`

## JavaScript 和 TypeScript 的数据类型

### JavaScript 类型 - number 类型

- 数字类型是我们开发中经常使用的类型， TypeScript 和 JavaScript 一样，不区分整数类型（int）和浮点型（double），统一为 number 类型。

### JavaScript 类型 - boolean 类型

### JavaScript 类型 - string 类型

### JavaScript 类型 - Array 类型

- 数组类型的定义也非常简单，有两种方式：

  ```typescript
  // 方式一
  let arr: number[] = [1, 2, 3]
  // 方式二
  let arr: Array<number> = [1, 2, 3]
  ```

### JavaScript 类型 - object 类型

### JavaScript 类型 - Symbol 类型

- 在 ES5 中，我们是不可以在对象中添加相同的属性名称的，比如下面的做法：

  ```typescript
  const person = {
    identity: "程序员",
    identity: "老师",
  }
  ```

- 通常我们的做法是定义两个不同的属性名字：比如 identity1 和 identity2。
- 但是我们也可以通过 symobol 来定义相同的名称，因为 Symbol 函数返回的是不同的值：

  ```typescript
  const s1: symbol = Symbol("identity")
  const s2: symbol = Symbol("identity")

  const person = {
    [s1]: "程序员",
    [s2]: "老师",
  }
  ```

### JavaScript 类型 - undefined 和 null 类型

- 在 JavaScript 中，undefined 和 null 是两个基本数据类型。
- 在 TypeScript 中，我们可以使用 null 和 undefined 来定义这两个类型：

  ```typescript
  let n: null = null
  let u: undefined = undefined
  ```

### TypeScript 类型 - any 类型

- 在某些情况下，我们确实无法确定一个变量的类型，并且可能它会发生一些变化，这个时候我们可以使用 any 类型（类似于 Dart 中的 dynamic）。
- any 类型有点像一种讨巧的 TypeScript 手段：
  - 我们可以对 any 类型的变量进行任何的操作，包括获取不存在的属性、方法；
  - 我们给一个 any 类型的变量赋值任何的值，比如数字、字符串的值；

  ```typescript
  let a: any = "why";
  a = 123;
  a = true;

  const aArray: any[] = ["why", 18, 1.88];
  ```

- 如果对于某些情况的处理过于繁琐不希望添加规定的类型注解，或者在引入一些第三方库时，缺失了类型注解，这个时候我们可以使用 any：
  - 包括在 Vue 源码中，也会使用到 any 来进行某些类型的适配；

### TypeScript 类型 - unknown 类型

- unknown 是 TypeScript 中比较特殊的一种类型，它用于描述类型不确定的变量。
	- 和 any 类型有点类似，但是 unknown 类型的值上做任何事情都是不合法的

  ```typescript
  function foo(): string {
    return 'foo'
  }
  function bar(): number {
    return 123
  }

  const flag = true
  let result : unknown
  
  if (flag) {
    result = foo()
  } else {
    result = bar()
  }

  if (typeof result === 'string') {
    console.log(result.length)
  }
  ```

### TypeScript 类型 - void 类型

- void 通常用来指定一个函数是没有返回值的，那么它的返回值就是 void 类型：
  - 我们可以将 null 和 undefined 赋值给 void 类型，也就是函数可以返回 null 或者 undefined
  - 这个函数我们没有写任何类型，那么它默认返回值的类型就是 void，我们也可以显式的来指定返回值是 void；

### TypeScript 类型 - never 类型

- never 表示永远不会发生值的类型，比如一个函数：
  - 如果一个函数中是一个死循环或者抛出一个异常，那么这个函数会返回东西吗？
  - 不会，那么写 void 类型或者其他类型作为返回值类型都不合适，我们就可以使用 never 类型；

  ```typescript
  function loopFun(): never {
    while (true) {
      // 死循环
    }
  }

  function loopErr(): never {
    throw new Error('error')
  }
  ```

  ```typescript
  function handleMessage(message: number | string) {
    switch (typeof message) {
      case 'string':
        console.log('foo')
        break
      case 'number':
        console.log('bar')
        break
      default:
        const check: never = message
    }
  }
  ```

  - never 有什么样的应用场景呢？这里我们举一个例子，但是它用到了联合类型，后面我们会讲到：

### TypeScript 类型 - tuple 类型

- tuple 是元组类型，很多语言中也有这种数据类型，比如 Python、Swift 等。

  ```typescript
  function useState<T>(state: T): [T, (newState: T) => void]{
    let currentState = state
    const changeState = (newState: T) => {
      currentState = newState
    }

    const tuple: [T, (newState: T) => void] = [currentState, changeState]
    return tuple
  }

  const [counter, setCounter] = useState(10);
  setCounter(20);

  const [title, setTitle] = useState('why');
  const [flag, setFlag] = useState(true);
  ```

## TypeScript 类型补充

### 类型推导

- `let` 进行类型推导，推导出来的通用类型
- `const` 进行类型推导，推导出来的字面量类型

### 函数的参数类型

- 函数是 JavaScript 非常重要的组成部份，TypeScript 允许我们指定函数的参数和返回值的类型。 

### 函数的返回值类型

- 和变量的类型注解一样，我们通常情况下不需要返回类型的注解，TypeScript 可以自动推断出返回值的类型。
  - 某些第三方库处于方便理解，会明确指定返回类型，但是这个看个人喜好；

### 匿名函数的参数类型

- 匿名函数与函数声明会有一些不同：
  - 当一个函数出现在 TypeScript 可以确定该函数会被如何调用的地方时；
  - 该函数的参数会自动指定类型；

    ```typescript
    const names = ["abe", "cba", "nba"]
    names.forEach((item) => {
      console.log(item.toUpperCase())
    })
    ```

  - 我们并没有指定 item 的类型，但是 item 是一个 string 类型：
    - 这是因为 TypeScript 会根据 forEach 函数的类型以及数组的类型推断出 item 的类型；
    - 这个过程称之为**上下文类型（Contextual Typing）**，因为函数执行的上下文可以帮助确定参数和返回值的类型；

### 对象类型

### 可选类型

- 对象类型也可以指定哪些属性是可选的，可以在属性的后面添加一个？：

  ```typescript
  function printCoordinate(point: { x: number; y: number; z?: number }) {
    console.log("x 坐标: " + point.x)
    console.log("y 坐标: " + point.y)
    if (point.z) {
      console.log("z 坐标: " + point.z)
    }
  }

  printCoordinate({ x: 100, y: 100 })
  printCoordinate({ x: 100, y: 100, z: 100 })
  ```

### 联合类型

- TypeScript 的类型系统允许我们使用多种运算符，从现有类型中构建新类型。
- 我们来使用第一种组合类型的方法：联合类型（Union Type）
  - 联合类型是由两个或者多个其他类型组成的类型；  
  - 表示可以是这些类型中的任何一个值；
  - 联合类型中的每一个类型被称之为联合成员（union's members）；

### 类型别名

```typescript
type Point = {
  x: number
  y: number
}

function printCoordinate(point: Point) {
  console.log("x 坐标: " + point.x)
  console.log("y 坐标: " + point.y)
}

function sumPoint(point: Point) {
  console.log(point.x + point.y)
}

printCoordinate({ x: 100, y: 100 })
sumPoint({ x: 100, y: 100 })
```

```typescript
type ID = number | string

function printID(id: ID) {
  console.log("您的id", id)
}
```

### 交叉类型

```typescript
// 交叉类型：两种（多种）类型要同时满足
interface IKun {
	name: string
	age: string
}

interface ICoder {
	name: string
	coding: () => void
}

const info: IKun & ICoder = {
	name: "why",
	age: 18,
	coding: function() {
		consoe.log("coding")
	}
}
```

### 类型断言 as

- 有时候 TypeScript 无法获取具体的类型信息，这个时候我们需要使用类型断言（Type Assertions）。
  - 比如我们通过 document.getElementById 获取到的元素，TypeScript 只知道它的类型是 HTMLElement，但并不知道它具体的类型；
  
  ```typescript
  const myEl = document.getElementById("my-img") as HTMLImageElement
  myEl.src = "xxx"
  ```

- TypeScript 只允许类型断言转换为**更具体**或者**不太具体**的类型版本，此规则可防止不可能的强制转换：

  ```typescript
  const name = "coderwhy" as number;
  const name = ("coderwhy" as unknown) as number;
  ```

### 非空类型断言!

- 当我们编写下面的代码时，在执行 ts 的编译阶段会报错：
  - 这是因为传入的 message 有可能是为 undefined 的，这个时候是不能执行方法的；

    ```typescript
    function printMessage(message?: string) {
      console.log(message.toUpperCase())
    }

    printMessage("hello")
    ```

- 但是，我们确定传入的参数是有值的，这个时候我们可以使用非空类型断言：
  - 非空断言使用的是 `!`，表示可以确定某个标识符是有值的，跳过 ts 在编译阶段对它的检测；

    ```typescript
    function printMessage(message?: string) {
      console.log(message!.toUpperCase())
    }

    printMessage("hello")
    ```

### 可选链的使用

- 可选链事实上并不是 TypeScript 独有的特性，它是 ES11（ES2020）中增加的特性：
  - 可选链使用可选链操作符（`?.`）来访问对象的属性或者方法；
  - 它的作用是当对象的属性不存在时，会短路，直接返回 undefined，如果存在，那么才会继续执行；

    ```typescript
    type Info = {
      name: string,
      friend?: { 
        name: string,
        age?: number
      }
    }

    const info: Info = {
      name: 'coderwhy',
      friend: {
        name: 'kobe'
        age: 18
      }
    }

    console.log(info.friend?.age)
    ```

### ?? 和 !! 的作用

- 有时候我们还会看到 !! 和 ?? 操作符，这些都是做什么呢？
- !! 操作符：
  - 将一个其他类型转换成 boolean 类型；
  - 类似于 Boolean （变量）的方式；
- ?? 操作符：
  - 它是 ES11 增加的新特性；
  - **空值合并操作符（??）是一个逻辑运算符，当操作符的左侧是 null 或者 undefined 时，返回其右侧操作数，否则返回左侧操作数；**
  
### 字面量类型

- 除了前面我们所讲过的类型之外，也可以使用字面量类型（literal types）：

  ```typescript
  let message: "Hello World" = "Hello World"
  ```

- 那么这样做有什么意义呢？
  - 默认情况下这么做是没有太大的意义的，但是我们可以将多个类型联合在一起；

  ```typescript
  type Alignment = "left" | "right" | "center" 
  function changeAlign(align: Alignment) {
    console.log("修改方向：", align)
  }

  changeAlign("left")
  ```

### 字面量推理

- 我们来看下面的代码：

  ```typescript
  const info = {
    url: "https://coderwhy.org/abc",
    method: "GET"
  }

  function request(url: string, method: "GET" | "POST") {
    console.log(url, method)
  }

  request(info.url, info.method)
  ```

- 这是因为我们的对象在进行字面量推理的时候，info 其实是一个 {url: string, method: string}，所以我们没办法将一个 string 赋值给一个字面量类型。

  ```typescript
  // 方式一：
  request(info.url, info.method as "GET")

  // 方式二：
  const info = {
    url: "https://coderwhy.org/abc",
    method: "GET"
  } as const
  ```

### 类型缩小

- 什么是类型缩小呢？
  - 类型缩小的英文是 Type Narrowing；
  - 我们可以通过类似于 typeof padding === "number" 的判断语句，来改变 TypeScript 的执行路径；
  - 在给定的执行路径中，我们可以缩小比声明时更小的类型，这个过程称之为缩小；
  - 而我们编写的 typeof padding === "number" 可以称之为**类型保护（type guards）**；
- 常见的类型保护有如下几种：
  - typeof
  - 平等缩小（比如===、!==）
  - instanceof
  - in
  - 等等……

  ```typescript
  // 1. typeof 的类型缩小
  type IDType = number | string
  function printID(id: IDType) {
    if (typeof id === "string") {
      console.log(id.toUpperCase())
    } else {
      console.log(id)
    }
  }

  // 2. 平等的类型缩小（===、!==、switch）
  type Direction = "left" | "right" | "top" | "bottom"
  function printDirection(direction: Direction) {
    if (direction === "left") {
      console.log("向左")
    } else if (direction === "right") {
      console.log("向右")
    } else if (direction === "top") {
      console.log("向上")
    } else {
      console.log("向下")
    }
  }

  function printDirection(direction: Direction) {
    switch (direction) {
      case "left":
        console.log("向左")
        break
      case "right":
        console.log("向右")
        break
      case "top":
        console.log("向上")
        break
      default:
        console.log("向下")
    }
  }

  // 3. instanceof 的类型缩小
  function printTime(time: string | Date) {
    if (time instanceof Date) {
      console.log(time.toLocaleTimeString())
    } else {
      console.log(time)
    }
  }

  class Student {
    studying() {
      console.log("学习")
    }
  }

  class Teacher {
    teaching() {
      console.log("讲课")
    }
  }

  function work(person: Student | Teacher) {
    if (person instanceof Student) {
      person.studying()
    } else {
      person.teaching()
    }
  }

  // 4. in
  function printValue(value: number | string) {
    if ("length" in value) {
      console.log(value.length)
    } else {
      console.log(value)
    }
  }
  ```

## TypeScript 函数类型

- 在 JavaScript 开发中，函数是重要的组成部分，并且函数可以作为一等公民（可以作为参数，也可以作为返回值进行传递）。
- 那么在使用函数的过程中，函数是否也可以有自己的类型呢？
  - 我们可以编写函数类型的表达式（Function Type Expressions），来表示函数类型；

### 函数类型参数的格式

```typescript
// TypeScript 对于传入的函数类型的参数个数不进行检测（校验）
type CalcType = (num1: number, num2: number) => number
function calc(calcFn: CalcType) {
	calcFn(10, 20)
}

function foo(num1: number) {
	return 123
})

type res = typeof foo extends CalcType ? true : false

calc(foo)

// forEach 例子：
const names = ["abc", "cba", "nba"]
names.forEach(function(item, index. arr) {
	console.log(item.length )
}) 

// typescript 对于很多类型的检测报不报错，取决于它的内部规则
interface IPerson {
	name: string
	age: number
}

const p = {
	name: "why",
	age: 18,
	height: 1.88,
	address: "广州市"
}

const info: IPersion = p
```

### 函数的调用签名（Call Signatures）

- **在 JavaScript 中，函数除了可以被调用，自己也是可以有属性值的。**
	- 然而前面讲到的函数类型表达式**并不能支持声明属性**；
	- 如果我们想描述一个带有属性的函数，我们可以在一个对象类型中写一个**调用签名（call signature）**；

```typescript
// 1.函数类型表达式
type BarType = (num1: number) => number

 // 2.函数的调用签名（从对象的角度来看待这个函数，也可以有其他属性）
 interface IBar {
	 name: string
	 age: number
	 // 函数可以调用：函数调用签名
	 (num1: number): number
 }

 const bar: IBar = (num1: number): number => {
	 return 123
 }

 bar.name = "aaa"
 bar.age = 18
 bar(123)

 // 开发中如何选择：
 // 1.如果只是描述函数类型本身（函数可以被调用），使用函数类型表达式（Function Type Expression）
 // 2.如果在描述函数作为对象可以被调用，同时也有其他属性时，使用函数调用签名（Call Signature）
```

### 函数的构造签名（Construct Signatures）

- **JavaScript 函数也可以使用 new 操作符调用，当被调用的时候，TypeScript 会认为这是一个构造函数（constructors），因为他们会产生一个新对象。**
	- 你可以写一个**构造签名（Construct Signatures）**，方法是在调用签名前面加一个 new 关键词；

```typescript
class Person {
	
}

interface ICTORPerson {
	new (): Person
}

function factory(fn: ICTORPerson) {
	const f = new fn()
	return f
}

factory(Person)
```

### 函数的默认参数

```typescript
// 函数的参数可以有默认值
// 1. 有默认值的情况下，参数的类型注解可以省略
// 2. 有默认值的参数，是可以接收一个 undefined 的值
function foo(x: number, y = 100) {
	console.log(y+10)
}

foo(10)
foo(10, undefined)
foo(10, 55)
```

### 函数的剩余参数

```typescript
function sum(...nums: number[]) {
	let total = 0
	for (const num of nums) {
		total += num
	}
	return total
}

const result1 = sum(10, 20, 30)
console.log(result1)

cosnt result2 = sum(10, 20, 30, 40)
console.log(result2)
```

### 函数的重载

- 在 TypeScript 中，如果我们编写了一个 add 函数，希望可以对字符串和数字类型进行相加，应该如何编写呢？

  ```typescript
  // 函数的重载：函数的名称相同，但是参数不同的几个函数，就是函数的重载
  function add(num1: number, num2: number): number; // 没函数体
  function add(num1: string, num2: string): string; // 没函数体

  function add(num1: any, num2: any): any {
    if (typeof num1 === 'string' && typeof num2 ==='string') {
      return num1.length + num2.length
    }
    return num1 + num2
  }

  const result = add(20, 30)
  const result2 = add("abc", "def")
  console.log(result)
  console.log(result2)

  // 在函数的重载中，实现函数是不能直接被调用的
  add({name: 'why'}, {age: 18})

  export {}
  ```

- 联合类型和重载
  - 我们现在有一个需求：定义一个函数，可以传入字符串或者数组，获他们它们的长度。
  - 这里有两种实现方案：
    - 方案一：使用联合类型来实现；
    - 方案二：使用函数重载来实现；

    ```typescript
    function getLength(a: string|any[]) {
      return a.length
    }

    function getLength(a: string): number;
    function getLength(a: any[]): number;
    function getLength(a: any): number {
      return a.length
    }
    ```

  - 在开发中我们选择使用哪一种呢？
    - 在可能的情况下，尽量选择使用联合类型来实现；
	  
### 可推导的 this 类型

- **如何指定呢？函数的第一个参数类型：**
	- 函数的第一个参数我们可以根据该函数之后被调用的情况，用于声明 this 的类型（名词必须叫 this）；
	- 在后续调用函数传入参数时，从第二个参数开始传递的，this 参数会在编译后被抹除；

```typescript
// 在没有对 ts 进行特殊配置的情况下，this 是 any 类型
// 在设置配置选项（编译选项 compilerOptions, noImplicitThis 设置为 true，不允许模糊的 this 存在）
// 1.对象中的函数中的 this
const obj = {
	name: "why",
	studying: function() {
		// 默认情况下，this 是 any 类型
		console.log(this.name, "studying")
	}
}

obj.studying()

// 2.普通的函数
function foo(this: { name: string }, info: { name: string }) {
	console.log(this, info)
}

foo.call({ name: "why" }, { name: "kobe"})

foo()
```

```typescript
// tsconfig.json
"noImplicitThis": true,
```

### this 相关的内置工具

- TypeScript 提供了一些工具类型来辅助进行常见的类型转换，这些类型全局可用。
	- **ThisParameterType：**
		- 用于提取一个函数类型 Type 的 this（opens new window）参数类型；
		- 如果这个函数类型没有 this 参数返回 unknown；
	- **OmitThisParameter：**
		- 用于移除一个函数类型 Type 的 this 参数类型，并且返回当前的函数类型

```typescript
function foo(this: { name: string }, info: { name: string }) {
	console.log(this, info)
}

type FooType = typeof foo

// 1. ThisParameterType: 获取 FooType 类型中 this 的类型
type FooThisType = ThisParameterType<FooType>

// 2. OmitThisParameter: 删除 this 参数类型，剩余的函数类型
type PureFooType = OmitThisParameter<FooType>

// 3. ThisType： 用于绑定一个上下文的 this
interface IState {
	name: string
	age: number
}

interface IStore {
	state: IState
	eating: () => void
	running: () => void
}
const store: IStore & ThisType<IState> = {
	state: {
		name: "why",
		age: 18
	},
	eating: function(this: IState) {
		console.log(this.name)
	},
	running: function() {
		console.log(this.name)
	}
}

store.eating.call(store.state)
```

## TypeScript 面向对象

### 类的继承

```typescript
class Person {
  name: string = ""
  age: number = 0

  eating() {
    console.log("eating")
  }
}

class Student extends Person {
  sno: number = 0

  studying() {
    console.log("studying")
  }
}

class Teacher extends Person {
  title: string = "" 

  teaching() {
    console.log("teaching")
  }
}

const stu = new Student()
stu.name = "coderwhy"
stu.age = 10
console.log(stu.name)
console.log(stu.age)
stu.eating()
```

```typescript
class Person {
  name: string
  age: number

  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }

  eating() {
    console.log("eating")
  }
}

class Student extends Person {
  sno: number

  constructor(name: string, age: number, sno: number) {
    // 调用父类的构造器
    super(name, age)
    this.sno = sno
  }

  eating() {
    super.eating()
    console.log("student eating")
  }

  studying() {
    console.log("studying")
  }
}

const stu = new Student("why", 18, 111)
console.log(stu.name)
console.log(stu.age)
console.log(stu.sno)
stu.eating()
```

### 类的多态

```typescript
class Animal {
  action() {
    console.log("animal running")
  }
}

class Dog extends Animal {
  action() {
    console.log("dog running!!!")
  }
}

class Fish extends Animal {
  action() {
    console.log("fish swimming!!!")
  }
}

// animal: dog/fish
// 多态的目的是为了写出更加具备通用性的代码
function makeActions(animals: Animal[]) {
  animals.forEach(animal => {
    animal.action()
  })
}

// 父类引用（类型）指向子类对象（实例）
// const animal: Animal = new Dog()
// animal.action()
makeActions([new Dog(), new Fish()])
```

### 类的成员修饰符

- 在 TypeScript 中，类的属性和方法支持三种修饰符：public、private、protected
  - public 修饰的是在任何地方可见、公有的属性或方法，默认编写的属性就是 public 的；
  - private 修饰的是仅在同一类中可见、私有的属性或方法；
  - protected 修饰的是仅在类自身及子类中可见、受保护的属性或方法；

### 只读属性 readonly

```typescript
class Person {
  // 1. 只读属性是可以在构造器中赋值，赋值之后就不可以修改
  // 2. 属性本身不能进行修改，但是如果它是对象类型，对象中的属性是可以修改
  readonly name: string
  age?: number
  readonly friend?: Person
  constructor(name: string, friend?: Person) {
    this.name = name
    this.friend = friend
  }
}

const person = new Person("why", new Person("kobe"))
console.log(person.name)
console.log(person.friend)

if (person.friend) {
  person.friend.age = 30
}
```

### getters/setters

```typescript
class Person {
  private _name: string
  constructor(name: string) {
    this._name = name
  }

  // 访问器 setter/getter
  // setter
  set name(newNme: string) {
    this._name = newNme
  }

  get name() {
    return this._name
  }
}

const person = new Person("why")
console.log(person.name)
person.name = "123"
```

### 类的参数属性

```typescript
class Person {
	// 语法糖
	constructor(public name: string,private _age: number,readonly height: number) {
		this._age = age
		this.height = height
	}

	running() {
		console.log(this.age)
	}
}

cosnt p = new Person("why", 18, 1.88)
console.log(p.name)
```

### 类的静态成员

```typescript
class Person {
  name: string = ""
  age: number = 12
}

class Student {
  static time: string = "20:00"

  static attendClass() {
    console.log("去学习~")
  }
}

console.log(Student.time)
Student.attendClass()
```

### 抽象类 abstract

- 我们知道，继承是多态使用的前提。
  - 所以在定义很多通用的**调用接口时，我们通常会让调用者传入父类，通过多态来实现更加灵活的调用方式。**
  - **但是，父类本身可能并不需要对某些方法进行具体的实现，所以父类中定义的方法，我们可以定义为抽象方法。**

```typescript
function makeArea(shape: Shape) {
  return shape.getArea()
}

abstract class Shape {
  abstract getArea(): number
}

class Rectangle extends Shape {
  private width: number
  private height: number

  constructor(width: number, height: number) {
    this.width = width
    this.height = height
  }

  getArea() {
    return this.width * this.height
  }
}

class Circle extends Shape {
  private radius: number

  constructor(radius: number) {
    this.radius = radius
  }

  getArea() {
    return this.radius * this.radius * Math.PI
  }
}
const rectangle = new Rectangle(10, 20)
makeArea(rectangle)

const circle = new Circle(10)
makeArea(circle)
```

### 鸭子类型

```typescript
// TypeScript 对于类型检测的时候使用的鸭子类型
// 鸭子类型，只关心属性和行为，不关心你具体是不是对应的类型
class Person {
	constructor(public name: string, public age: number) {}
	running() {}
}

class Dog {
	constructor(public name: string, public age: number) {}
	running() {}
}

function printPerson(p: Person) {
	console.log(p.name, p.age)
}

printPerson(new Person("why", 18))
printperson({name: "kobe", age: 30,running: function() {}})
printPerson(new Dog("旺财", 3))

const person: Person = new Dog("果汁", 5)
```

### 类的类型

```typescript
class Person {}

/**
* 类的作用：
* 1. 可以创建类对应的实例对象
* 2. 类本身可以作为这个实例的类型
* 3. 类也可以当作一个有构造签名的函数
*/

const p: Person = new Person()
function printPerson(p: Person) {}

function factory(ctor: new () => void) {}
factory(Person)
```

### 接口的声明

```typescript
// 通过类型（type）别名来声明对象类型
// type InfoType = { name: string, age: number }

// 另外一种方式声明对象类型：接口（interface）
// 在其中可以定义可选类型
// 也可以定义只读属性
interface IInfoType {
  readonly name: string
  age: number
  friend?: {
    name: string
  }
}

const info: IInfoType = {
  name: "why",
  age: 18,
  friend: {
    name: "kobe"
  }
}

console.log(info.friend?.name)
console.log(info.name)
// info.name = "coderwhy"
info.age = 20
```

### 别名和接口区别

```typescript
// 1, 区别一：type 类型使用范围更广，接口类型只能用来声明对象
type MyNumber = number
type IDType = number | string

// 2. 区别二：在声明对象时，interface 可以多次声明
// 2.1 type 不允许两个相同名称的别名同时存在
type PointType1 = {
	x: number
	y: number
}
type PointType1 = {
	z?: number
}
// 2.2 interface 可以多次声明同一个接口名称
interface PointType2 {
	x: number
	y: number
}
interface PointType2 {
	z?: number
}

const point: PointType2 = {
	x: 100,
	y: 200,
	z: 300
}

// 3. interface 支持继承的
interface IPerson {
	name: string
	age: number
}

interface IKun extends IPerson {
	kouhao: string
}

const ikun1: IKun = {
	kouhao: "你干嘛，哎呦",
	name: "kobe",
	age: 30
}

// 4. interface 可以被类实现(TS面向对象)
class Person implements IPerson {
	
}

// 总结：如果是非对象类型的定义使用 type，如果是对象类型的声明那么使用 interface
```

### 索引签名

```typescript
// 通过 interface 来定义索引类型
interface IndexLanguage {
	// 返回值类型的目的是告知通过索引去获取到的值是什么类型
  [index: number]: string
}

const frontLanguage: IndexLanguage = {
  0: "html",
  1: "css",
  2: "javascript",
  3: "vue"
}

interface ILanguageYear {
  [index: string]: number
}

const languageYear: ILanguageYear = {
  "c": 1972,
  "c++": 1983,
  "java": 1995,
  "python": 1989
}

interface IIndexType {
	// 两个索引类型的写法
	[index: number]: string
	[key: string]: any

	// 要求一：下面的写法不允许：数字类型索引的类型，必须是字符串类型索引的类型的子类型
	// 原因：所有的数字类型都是会转成字符串类型去对象中获取内容
	[index: number]: number|string
	[key: string]: string

	// 要求二：如果索引签名中有定义其他属性，其他属性返回的类型，必须符合 string 类型返回的属性
	[index: number]: string
	[key: string]: number|string
	// 下面的写法不允许
	aaa: boolean
}

const names: IIndexType = ["abc", "cba", "nba"]
const item1 = names[0]
const forEachFn = names["forEach"]
```

### 接口继承

```typescript
interface IPerson {
	name: string
	age: number
}

// 可以从其他的接口中继承过来属性
// 1.减少了相同代码的重复编写
// 2.如果使用第三方库，给我们定义一些属性
//  > 自定义一个接口，同时你希望自定义接口拥有第三方某一个类型中所有的属性
//  > 可以使用继承来完成
interface IKun extends IPerson {
	slogan: string
}

const ikun: IKun = {
	name: "why",
	age: 18,
	slogan: "你干嘛，哎呦"
}


```

### 接口的类实现过程

```typescript
interface IKun {
	name: string
	age: number
	slogan: string

	playBasketball: () => void
}

interface IRun {
	 running: () => void
}

const ikun: IKun = {
	name: "why",
	age: 18, 
	slogan: "你干嘛！",
	playBasketball: function() {}
}

// 作用：接口被类实现
class Person implements IKun, IRun {
	name: string
	age: number
	slogan: string

	playBasketball() {
		
	}

	running() {
		
	}
}

const ikun2 = new Person()
console.log(ikun2.name, ikun2.age, ikun2.slogan)
ikun2.playBasketball()
ikun2.running()
```

### 严格字面量赋值检测

```typescript
interface IPerson {
	name: string
	age: number
}

// 1.奇怪的现象一：
// 定义 info，类型时IPerson 类型
const obj = {
	name: "why",
	age: 18,
	// 多了一个 height属性
	height: 1.88
}

const info: IPerson = obj

// 2. 奇怪的现象二：
function printPerson(person: IPerson) {
	
}

const kobe = { name: "kobe", age: 30, height: 1.98}
printPerson(kobe)
```

### 函数类型 

```typescript
// type CalcFn = (n1: number, n2: number) => number
interface CalcFn {
  (n1: number, n2: number): number
}

function calc(num1: number, num2: number, calcFn: CalcFn) {
  return calcFn(num1, num2)
}

const add: CalcFn = (n1, n2) => n1 + n2

calc(10, 20, add)
```

### 抽象类和接口的区别

- **抽象类在很大程度上和接口会有点类似：都可以在其中定义一个方法，让子类或实现类来实现对应的方法。**
- **那么抽象类和接口有什么区别呢？**
	- 抽象类是事物的抽象，抽象类用来捕捉子类的通用特性，接口通常是一些行为的描述；
	- 抽象类通常用于一系列关系紧密的类之间，接口只是用来描述一个类应该具体有什么行为；
	- 接口可以被多层实现，而抽象类只能单一继承；
	- 抽象类中可以有实现体，接口中只能有函数的声明；
- **通常我们会这样来描述类和抽象类、接口之间的关系：**
	- 抽象类是对事物的抽象，表达的是 `is a` 的关系。猫是一种动物（动物就可以定义成一个抽象类）
	- 接口是对行为的抽象，表达的是 `has a` 的关系。猫拥有跑（可以定义一个单独的接口）、爬树（可以定义一个单独的接口）的行为。

### 枚举类型基本使用

- 枚举类型是为数不多的 TypeScript 特有的特性之一：
	- 枚举其实就是将一组可能出现的值，一个个列举出来，定义在一个类型中，这个类型就是枚举类型；
	- 枚举允许开发者定义一组命名常量，常量可以是数字、字符串类型；

```typescript
// 定义枚举类型
enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

const d1: Direction = Direction.LEFT

function turnDirection(direction: Direction) {
	switch(dirction) {
		case Direction.LEFT:
			console.log("角色向左移动一个格子")
			break
		case Direction.RIGHT:
			console.log("角色向右移动一个格子")
			break
	}
}

// 监听键盘的点击
turnDirection(Direction.LEFT)
```

### 枚举类型设置值

```typescript
enum Direction {
	LEFT = 100,
	RIGHT
}

enum Direction {
	LEFT = "LEFT",
	RIGHT = "RIGHT"
}

enum Operation {
	READ = 1 << 0,
	WRITE = 1 << 1,
	EXECUTE = 1 << 2
}

const d1: Direction = Direction.LEFT
```

## TypeScript 泛型编程

### 泛型语法的基本使用

- 泛型—类型的参数化

	```typescript
	// 定义函数：将传入的内容返回
	function bar<T>(arg: T) {
		return arg
	}
	
	// 完整的写法
	const res1 = bar<number>(123)
	
	const res2 = bar<string>("abc")
	
	const res3 = bar<{ name: string }>({ name: "why"})
	
	// 省略的写法
	const res4 = bar("aaaaaaa")
	const res5 = bar(1111111)
	 ```

- 泛型-useState 的练习

	```typescript
	// 元组：useState 函数
	function useState<T>(initialState: T): [T, (newState: T) => void] {
		let state = initialState
		function setState(newState: T) {
			state = newState
		}
		return [state, setState]
	}
	
	// 初始化 count
	const [count, setCount] = useState(100)
	const [message, setMessage] = useState("Hello World")
	const [banners, setBanners] = useState<any[]>([])
	```

- 泛型-传入多个类型

	```typescript
	function foo<T, E>(arg1: T, arg2: E) {
		
	}
	
	foo(10, 20)
	foo(10, "abc")
	foo<string, { name: string }>("abc", { name: "why"})
	```

- 平时在开发中我们可能会看到一些常用的名称：
	- T：Type 的缩写，类型
	- K、V：key 和 value 的缩写，键值对
	- E：Element 的缩写，元素
	- O：Object 的缩写，对象

### 泛型接口、类的使用

#### 泛型接口的使用

```typescript
interfacd IKun<T = string> {
	name: T
	age: number
	slogan: T
}

const kunkun: IKun<string> = {
	name; "why",
	age: 18,
	slogan: "哈哈哈"
}

const ikun2: IKun<number> = {
	name: 123,
	age: 20,
	slogan: 666
}

const ikun3: IKun = {
	name: "kobe",
	age: 30, 
	slogan: "坤坤加油！"
}
```

#### 泛型类的使用

```typescript
class Point<T = number> {
	x: T
	y: T
	constructor(x: T, y: T) {
		this.x = x
		this.y = y
	}
}

const p1 = new Point(10, 20)
console.log(p1.x)
const p2 = new Point("123", "321")
console.log(p2.x)
```

### 泛型约束和类型条件

#### 泛型约束（Generic Constraints）

- **有时候我们希望传入的类型有某些共性，但是这些共性可能不是在同一种类型中：**
	- 比如 string 和 array 都是有 length 的，或者某些对象也是会有 length 属性的；
	- 那么只要是拥有 length 的属性都可以作为我们的参数类型，那么应该如何操作呢？

```typescript
interface ILength {
	length: number
}

// 1.getLength 没有必要用泛型
function getLength(arg: ILength) {
	return arg.length
}

const length1 = getLength("aaaa")
const length2 = getLength(["aaa", "bbb", "ccc"])
const length3 = getLength({ length: 100 })

// 2. 获取传入的内容，这个内容必须有 Length 属性
// T 相当于是一个变量，用于记录本次调用的类型，所以在整个函数的执行周期中，一直保留着参数的类型
function getInfo<T extends ILength>(args: T): T {
	return args
}

const info1 = getInfo("aaaa")
const info2 = getInfo(["aaa", "bbb", "ccc"])
const info3 = getInfo({ length: 100 })

```

#### 类型条件

- **在泛型约束中使用类型参数（Using Type Parameters in Generic Constraints）**
	- 你可以声明一个类型参数，这个类型参数被其他类型参数约束；

```typescript
// 传入 key 的类型应该是 obj 当中的 key 的其中之一
interface IKun {
	name: string
	age: number
}

type IKunKeys = keyof IKun // "name"|"age"

function getObjectProperty<O, K extends keyof O>(obj: O, key: K) {
	reutrn obj[key]
}

const info = {
	name: "why",
	age: 18,
	height: 1.88
}

const name = getObjectProperty(info, "name") 
```

### TypeScript 映射类型（Mapped Types）

#### 基本使用

- **有的时候，一个类型需要基于另外一个类型，但是你又不想拷贝一份，这个时候可以考虑使用映射类型**
	- 大部分内置的工具都是通过映射类型来实现的；
	- 大多数类型体操的题目也是通过映射类型完成的；
- **映射类型建立在索引签名的语法上：**
	- 映射类型，就是使用了 PropertyKeys 联合类型的泛型；
	- 其中 PropertyKeys 多是通过 keyof 创建，然后循环遍历键名创建一个类型；

```typescript
// TypeScript 提供了映射类型：函数
// 映射类型不能使用 interface 定义
// Type = IPerson
// keyof = "name"|"age"
type MapPerson<T> = {
	// 索引类型依次进行使用
	[Property in keyof T]: T[Property]
}

interface IPerson {
	name: string
	age: number
}

// 拷贝一份 IPerson
// interface NewPerson {
// 	name?: string
// 	age?: number
// }

type NewPerson = MapPerson<IPerson>
```

#### 映射修饰符 （Mapping Modifiers）

- **在使用映射类型时，有两个额外的修饰符可能会用到：**
	- 一个是 readonly，用于设置属性只读；
	- 一个是 ？，用于设置属性可选；
- **你可以通过前缀 - 或者 + 删除或者添加这些修饰符，如果没有写前缀，相当于使用了 + 前缀。**

```typescript
type MapPerson<Type> = {
	readonly [Property in keyof Type]?: Type[Property]
}

interface IPerson {
	name: string
	age: number
	height: number
	address: string
}

type IPersonOptional = MapPerson<IPerson>

const p: IPersonOptional = {
	
}
```


```typescript
type MapPerson<Type> = {
	-readonly [Property in keyof Type]-?: Type[Property]
}

interface IPerson {
	name: string
	age?: number
	readonly height: number
	address?: string
}

type IPersonRequired = MapPerson<IPerson>

const p: IPersonRequired = {
	name: "why",
	age: 18,
	height: 1.88,
	address: "广州市"
}
```

### 类型工具和类型体操

- **类型系统其实在很多语言里面都是有的，比如 Java、Swift、C++ 等等，但是相对来说 TypeScript 的类型非常灵活：**
	- 这是因为 TypeScript 的目的是为了 JavaScript **添加一套类型校验系统**，因为 JavaScript 本身的灵活性，也让 **TypeScript 类型系统不得不增加更附加的功能**以适配 JavaScript 的灵活性；
	- 所以 TypeScript 是一种可以**支持类型编程的类型系统**；
- **这种类型编程系统为 TypeScript 增加了很大的灵活度，同时也增加了它的难度：**
	- 如果你不仅仅在开发业务的时候为了自己的 JavaScript 代码增加上类型约束，那么基本不需要太多的类型编程能力；
	- 但是如果**你在开发一些框架、库，或者通用性的工具，为了考虑各种适配的情况，就需要使用类型编程**；
- **TypeScript 本身为我们提供了类型工具，帮助我们辅助进行类型转换（前面有用过关于 this 的类型工具）。**
- **很多开发者为了进一步增强自己的 TypeScript 的编程能力，还会专门去做一些类型体操的题目：**
	- <https://github.com/type-challenges/type-challenges>
	- <https://ghaiklor.github.io/type-challenges-solutions/en/>

#### 条件类型（Conditional Types）

- 很多时候，日常开发中我们需要基于**输入的值来决定输出的值**，同样我们**也需要基于输入的值的类型来决定输出的值的类型。**
- 条件类型（Conditional types）就是用来帮助我们描述**输入类型和输出类型之间**的关系。
	- 条件类型的写法有点类似于 JavaScript 中的条件表达式（condition ? trueExpression : falseExpression）：
	- `SomeType extends OtherType ? TrueType : FalseType`

		```typescript
		type IDType = number | string
		
		// 判断 number 是否是 extends IDType
		type ResType = number extends IDType ? true : false
		
		// 举个例子：函数的重载
		// function sum(num1: number, num2: number): number
		// function sum(num1: string, num2: string): string
		
		function sum<T extends number | string>(num1: T, num2: T): T extends number? number:string
		function sum(num1, num2) {
			return num1 + num2
		}
		
		const res = sum(20, 30)
		const res2 = sum("abd", "cba")
		```

#### 在条件类型中推断（infer）

- **在条件类型中推断（Inferrring Within Conditional Types）**
	- 条件类型提供了 infer 关键词，可以从正在比较的类型中推断类型，然后在 true 分支里引用该推断结果；
- **比如我们现在有一个函数类型，想要获取到一个函数的参数类型和返回值类型：**

	```typescript
	type CalcFnType = (num1: number, num2: number) => number
	
	function foo() {
		return "abc"
	}
	
	// 总结类型体操题目：MyReturnType
	
	type MyReturnType<T extends (...args: any[]) => any> = T extends (...args: any[]) => infer R? R: never
	
	type MyParameterType<T extends (...args: any[]) => any> = T extends (...args: infer A) => any？ A: never
	
	// 获取一个函数的返回值类型：内置工具
	type FooReturnType = MyReturnType<CalcFnType>
	type FooReturnType = MyReturnType<typeof foo>
	
	type CalcParameterType = MyParameterType<CalcFnType> 
	```

#### 分发条件类型（Distributive Conditional Types）

- 当在泛型中使用条件类型的时候，如果传入一个联合类型，就会变成**分发的（distributive）**
- **如果我们在 ToArray 传入一个联合类型，这个条件类型会被应用到联合类型的每个成员：**
	- 当传入 string | number 时，会遍历联合类型中的每一个成员；
	- 相当于 ToArray<string> | ToArray<number>；
	- 所以最后的结果时：string[] | nubmer[]；

		```typescript
		type toArray<Type> = Type extends any ? Type[]: never
		
		type NumArray = toArray<number>
		
		// string[] | number[]
		type newType = toArray<number | string>
		```

#### 内置工具

##### Parial<Type>
 - **用于构造一个 Type 下面的所有属性都设置为可选的类型**

```typescript
// 自定义自己的 Partial 类型
type MyPartial<T> = {
	[K in keyof T]?: T[K]
}

interface IPerson {
	name: string
	age: number
	height: number
}

const info: IPerson = {
	name: 'why',
	age: 18,
	height: 1.88
}

functon updatePerson(person: IPerson, partPerson: MyPartial<IPerson>) {
	return {...person, ...partPerson }
}


```

##### Required<Type>

- **用于构造一个 Type 下面的所有属性全都设置为必填的类型，这个工具类型跟 Partial 相反。**

```typescript
interface IKun {
	name: string
	age: number
	slogan?: string
}

// 类型体操
type HYRequired<T> = {
	[P in keyof T]-?: T[P]
}

// IKun2 都变成必选的
type IKun2 = HYRequired<IKun>
```

##### Readonly<Type>

- **用于构造一个 Type 下面的所有属性全都设置为只读的类型，意味着这个类型的所有的属性全都不可以重新赋值。**

```typescript
interface IKun {
	name: string
	age: number
	slogan?: string
}

// 类型体操
type HYReadonly<T> = {
	readonly [P in kyeof T]: T[P]
}

// IKun3 都是 readonly 的
type IKun3 = Readonly<IKun>
```

##### Record<Keys, Type>

- **用于构造一个对象类型，它所有的 key （键）都是 Keys 类型，它所有的 value（值）都是 Type 类型。**

```typescript
interface IKun = {
	name： string
	age: number
	slogan?: string
}

// 类型体操
// name | age | slogan
type keys = keyof IKun
type Res = keyof any // => number|string|symbol

// 确保keys一定是可以作为key的联合类型
type HRecord<Keys extends keyof any, T> = {
	[P in Keys]: T
} 


type t1 = "上海" | "北京" | "洛杉矶"
type IKuns = HRecord<t1, IKun>
const ikuns: IKuns = {
	"上海": {
		name: "xxx",
		age: 10
	},
	"北京": {
		name: "yyy",
		age: 5
	},
	"洛杉矶": {
		name: "zzz",
		age: 3
	}
}
```

##### Pick<Type, Keys>

- **用于构造一个类型，它是从 Type 类型里面挑了一些属性 Keys**

```typescript
type HYPick<T, K extends keyof T> = {
	[P in K]: T[P]
}

interface IPerson {
	name: string
	age: number
	height: number
}

type IKun = Pick<IPerson, "name"|"age">
```

##### Omit<Type, Keys>

- **用于构建一个类型，它是从 Type 类型里面过滤了一些属性 Keys**

```typescript
// 如果每次都 pick 可能类型太多了
type HYOmit<T, K extends keyof T> = {
	[P in keyof T as P extends K? never: P]: T[P]
}

interface IPerson {
	name: string
	age: number
	height: number
}

type IKun = Omit<IPerson, "height">
```

##### Exclude<UnionType, ExcludedMembers>

- **用于构造一个类型，它是从 UnionType 联合类型里面排除了所有可以赋给 ExcludedMembers 的类型。**

```typescript
type HYExclude<T, U>= T extends U? never: T
type HYOmit<T, K> = Pick<T, HYExclude<keyof T, K>>

type PropertyTypes = "name" | "age" | "height"
type PropertyTypes2 = HYExclude<PropertyType, "height">
```

- 有了 HYExclude，我们可以使用它来实现 HYOmit。

##### Extract<Type, Union>

- **用于构造一个类型，它是从 Type 类型里面提取了所有可以赋给 Union 的类型。**

```typescript
type HYExtract<T, U> = T extends U? T: never
```

##### NonNullable<Type>

- **用于构造一个类型，这个类型从 Type 中排除了所有的 null、undefined 的类型。**

  
```typescript
type IKun = "sing" | "dance" | "rap" | null | undefined

type HYNonNullable<T> = T extends null|undefined ? never: T

type IKuns = NonNullable<IKun>
```

##### ReturnType<Type>

- **用于构造一个含有 Type 函数的返回值的类型。**

```typescript
// 第一个 extends 是对传入的条件进行限制
// 第二个 extends 是为了进行条件获取类型
type HYReturnType<T extends (...args: any) => any> = T extends (...args: any) => infer R? R: never

type T1 = HYReturnType<() => string>
type T2 = HYReturnType<() => void>
type T3 = HYReturnType<(num1: number, num2: number) => string>

function sum(sum1: number, num2: number) {
	return num1 + num2
}

function getInfo(info: { name: string, age: number }) {
	return info.name + info.age
}

type T4 = HYReturnType<typeof sum>
type T5 = HYReturnType<typeof getInfo>
type T6 = HYReturnType<() => void>
```

##### InstanceType<Type>

- **用于构造一个由所有 Type 的构造函数的实例类型组成的类型。**

```typescript
type HYInstanceType<T extends new (...agrs: any[]) => any> = T extends new (...args: any[]) => infer R? R: never

class Person {
	name: string
	age: number
	constructor(name: string, age: number) {
		this.name = name
		this.age = age
	}
}

type T = typeof Person
type PersonType = InstanceType<typeof Person>

// 对于普通的定义来说似乎是没有区别的
const info: Person = { name: "why", age: 18}
const info2: PersonType = { name: "kobe", age: 30}

// 但是如果我么想要做一个工厂函数，用于帮助我们创建某种类型的对象
// 这里的返回值不可以写 T，因为 T 的类型会是 typeof Person
// 这里就可以使用 InstanceType<T>，它可以帮助我们返回构造函数的返回值类型（构造函数创建出来的对象类型）
function factory<T extends new (...args: any[]) => any>(ctor: T): HYInstacneType<T> {
	return new ctor()
}

const p1 = factory(Person)
```

```typescript
class Person {}
class Dog {}

// 类型体操
type HYInstanceType<T extends new (...args: any[]) => any> = T extends new (...args: any[]) => infer R? R: never

const p1: Person = new Person()

// typeof Person：构造函数具体的类型
// InstanceType 构造函数创建出来的实例对象的类型
type HYPerson = InstacneType<typeof Person>
const p2: HYPerson = new Person()

// 工厂函数的例子
// 通用的创建实例的工具函数时会用到这个 InstanceType
function factory<T extends new(...args: any[]) => any>(ctor: T): InstacneType<T> {
	return new ctor()
}

const p3 = factory(Person)
const d = factory(Dog)
```

## TypeScript 知识扩展

### TypeScript 模块使用

- commonjs => node 环境 => webpack/vite
	- `module.exports = {}`
- esmodule: import/export

- ES 模块在 2015 年被添加到 JavaScript 规范中，到 2020 年，大部分的 web 浏览器和 JavaScript 运行环境都已经广泛支持。
- 所以在 **TypeScript 中最主要使用的模块化方案就是 ES Module**；

```typescript
export function add(num1: number, num2: number) {
	return num1 + num2
}

export function sub(num1: numbe, num2: number) {
	return num1 -num2
}
```

#### 非模块（Non-modules）

- **我们需要先理解 TypeScript 认为什么是一个模块**
	- JavaScript 规范声明任何**没有 export 的 JavaScript 文件都应该被认为是一个脚本，而非一个模块**。
	- 在一个脚本文件中，**变量和类型会被声明在共享的全局作用域**，将多个输入文件合并成一个输出文件，或者在 HTML 使用多个 <script> 标签加载这些文件。
- **如果你有一个文件，现在没有任何 import 或者 export，但是你希望它被作为模块处理，添加这行代码：**

	```typescript
	export {}
	```

- 这会**把文件改成一个没有导出任何内容的模块**，这个语法可以生效，无论你的模块目标是什么。

#### 内置类型导入（Inline type imports）

- TypeScript 4.5 也允许单独的导入，你需要使用 type 前缀，表明被导入的是一个类型：

	```typescript
	// utils/math.ts
	export function sum(num1: number, num2: number) {
		return num1 + num2
	}
	
	export interface IPerson {
		name: string
		age: number
	}

	export type IDType = number | string
	```
  
	```typescript
	// index.ts
	import { sum } from "./utils/math";
	// 导入的是类型，推荐在类型的前面加上 type 关键字
	import { type IDType, type IPerson } from "./utils/math"

	console.log(sum(20, 30))

	// type IDType = number | string

	const id1: IDType = 111
	const p: IPerson = { name: "why", age: 18 }
	```

- 这些可以让一个非 TypeScript 编译器比如 Babel，swc 或者 esbuild 知道什么样的导入可以被安全移除。

### TypeScript 命名空间

- **Typescript有它自己的模块格式，名为 namespaces，它在 ES 模块标准之前出现。**
	- 命名空间**在 TypeScript 早期**时，称之为**内部模块**，目的是**将一个模块内部再进行作用域的划分， 防止一些命名冲突的问题**；
	- 虽然**命名空间没有被废弃，但是由于 ES 模块已经拥有了命名空间的大部分特性**，因此**更推荐使用 ES 模块**， 这样才能与 JavaScript 的（发展）方向保持一致。

```typescript
export namespace Time {
	export function format(time: string) {
		return "2022-10-10"
	}

	export const name = "time"
}

export namespace Price {
	export funcion format(price: string) {
		return "￥20.00"
	}
}
```

### 内置声明文件的使用

#### 类型的查找

- 之前我们所有的 typescript 中的类型，几乎都是我们自己编写的，但是我们也有用到一些其他的类型：
  
	```typescript
	const imageEl = document.getElementById("image") as HTMLImageElement;
	```

- 我们的 HTMLImageElement 类型来自哪里呢？甚至是 document 为什么可以有 getElementById 的方法呢？
	- 其实这里就涉及到 **typescript 对类型的管理和查找规则**了。
- 我们这里先给大家介绍另外的一种 typescript 文件：`.d.ts` 文件
	- 我们之前编写的 typescript 文件都是 .ts 文件，这些文件最终会输出 .js 文件，也是我们通常编写代码的地方；
	- 还有另外一种文件 .d.ts 文件，它是用来做类型的声明（declare），称之为**类型声明（Type Declaration）** 或者 **类型定义（Type Definition）** 文件。
	- 它仅仅用来做类型检测，告知 typescript 我们有哪些类型；
- **那么 typescript 会在哪里查找我们的类型声明呢？**
	- 内置类型声明；
	- 外部定义类型声明；
	- 自己定义类型声明；

#### 内置类型声明

- **内置类型声明是 typescript 自带的，帮助我们内置了 JavaScript 运行时的一些标准 API 的声明文件；**
	- 包括比如 Function、String、Math、Date 等内置类型；
	- 也包括运行环境中的 DOM API，比如 Window、Document 等；
- **TypeScript 使用模式命名这些声明文件 `lib.[something].d.ts`**
	![内置声明文件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic202501011314973.png)
- **内置类型声明通常在我们安装 typescript 的环境中会带有的；**
	- <https://github.com/microsoft/TypeScript/tree/main/lib>
 
#### 内置声明的环境

- **我们可以通过 target 和 lib 来决定哪些内置类型声明是可以使用的：**
	- 例如：startsWith 字符串方法只能从称为 ECMAScript 6 的 JavaScript 版本开始使用；
- **我们可以通过 target 的编译选项来配置：TypeScript 通过 lib 根据您的 target 设置更改默认包含的文件来帮助解决此问题。**
	- <https://www.typescriptlang.org/tsconfig#lib>
 ##### typescript webpack 环境配置
 
 - `npm init -y`
 - `npm install webpack webpack-cli -D`
 - `npm install ts-loader -D`
 - `tsc --init` 
 - `npm install html-webpack-plugin -D`
 - `webpack.config.js`
	
	```typescript
	// ./src/index.ts
	const message: string = "Hello World"
	console.log(message.length, message)

	// lib.dom.d.ts
	const h2El = document.createElement("h2")
	h2El.textContent = "Hello TypeScript"
	document.body.appent(h2El)

	// lib.es2015.d.ts
	const promise = new Promise((resolve, reject) => {})
	const.log(message.startsWith("Hello"))
	```
	
	```javascript
	// webpack.config.js
	const path = require("path")
	const HtmlWebpackPlugin = require("html-webpack-plugin")
	
	module.exports = {
		mode: "development",
		entry: "./src/index.ts",
		output: {
			path: path.resolve(__dirname, "./dist"),
			filename: "bundle.js"
		},
		resolve: {
			extensions: [".ts", ".js", ".cjs", ".json"]
		},
		devServer: {},
		module: {
			rules: [
				{
					test: /\.ts$/,
					loader: "ts-loader"
				},
				{
					test: /\.(png|jpe?g|svg|gif)$/
					type: "asset/resource"
				}
			]
		},
		plugins: [
			new HtmlWebpackPlugin({
				template: "./index.html"
			})
		]
	}
	```

- `npm install webpack-dev-server -D`
- `package.json`

	```json
	// package.json
	{
		"scripts": {
			"serve": "webpack serve"
		},
	}
	```

- `npm run serve`

### 第三方库声明的文件

- **外部类型声明通常是我们使用一些库（比如第三方库）时，需要的一些类型声明。**
- **这些库通常有两种类型声明方式：**
	- 方式一：在**自己库中进行类型声明（编写 d.ts 文件）**，比如 axios `npm install axios`

 
		```typescript
		import axios from "axios"
		import type { AxiosRequestConfig, AxiosInstance } from "axios"
		
		```

	- 方式二：通过**社区的一个公有库 DefinitelyTyped 存放类型声明文件**
		- 该库的 GitHub 地址： <https://github.com/DefinitelyTyped/DefinitelyTyped/>
		- 该库查找声明安装方式的地址： <https://www.typescriptlang.org/dt/search?search=>
		- 比如我们安装 react 的类型声明： `npm install react` `npm i @type/react -D`
 
		```typescript
		import React from "react"
		```

	- 方式三：**自定义声明**
		 - **什么情况下需要自己来定义声明文件呢？**
			 - 情况一：我们**使用的第三方库是一个纯的 JavaScript 库**，没有对应的声明文件，比如 lodash；
		 	- `npm install lodash`
			- 新建 `types/index.d.ts`
		
			```typescript
			declare module "lodash" {
				export function join(...args: any[]): any
			}
			```
		
		
			```typescript
			import _ from "lodash"
			
			// lodash
			console.log(_.join(["abc", "cba"]))
			```

			-  情况二：我们**给自己的代码中声明一些类型**，方便在其他地方直接进行使用；

			```typescript
			// index.ts
			// 给自己的代码添加类型声明文件
			// 平时使用的代码中用到的类型，直接在当前位置进行定义或者在业务文件夹某一个位置编写一个类型文件即可
			type IDType = number | string
			interface IKun {
				name: string
				age: number
				slogan: string
			}
			const id1: IDType = 123

			// 需要编写类型声明
			console.log(whyName, whyAge, whyHeight)
			console.log(foo("why"))
			const p = new Person("kobe", 30)
			console.log(p.name, p.age)
			```

			```typescript
			// types/index.d.ts
			declare module "lodash" {
				export function join(...args: any[]): any
			}

			// 为自己的变量/函数/类定义类型声明
			declare const whyName: string
			declare const whyAge: number
			declare const whyHeight: number
			
			declare function foo(bar: string): string

			declare class Person {
				constructor(public name: string, public age: number)
			} 

			// 作为一个第三方库为其他开发者提供类型声明文件 .d.ts => axios.d.ts
			
			```

#### declare 文件模块
- **在开发 vue 的过程中，默认是不识别我们的 .vue 文件的，需要对其进行文件的声明；**
- **在开发中我们使用了 jpg 这类图片文件，默认 typescript 也是不支持的，也需要对其进行声明；**

```typescript
// index.ts
import KobeImage from "./img/kobe02.png"

// 图片文件的使用
const imgEl = document.createElement("img")
imgEl.src = KobeImage
document.body.append(imgEl)
```

```typescript
// types/index.d.ts
// 声明文件模块
declare module "*.png"
declare module "*.jpg"
declare module "*.jpeg"
declare module "*.svg"
```

```html
// App.vue
<template>
	<div class="home">
		<h2>home</h2>
	</div>
</template>

<script setup lang="ts">

</script>

<style lang="less" scoped>

</style>
```

```typescript
// index.ts
import App from "./vue/App.vue"
```

```typescript
// types/index.d.ts
// 声明文件模块
declare module "*.vue" {
	import { DefineComponent } from "vue"
	const component: DefineComponent

	export default component
}
```

#### declare 命名空间

- **比如我们在 index.html 中直接引入了 jQuery：**
	- CDN 地址：<https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js
- **我们可以进行命名空间的声明：**

	```typescript
	// types/index.d.ts
	declare namespace $ {
		function ajax(settings: any): void
	}
	```

	```typescript
	// index.ts
	$.ajax({
		url: "http://123.207.32.32:8000/home/multidata",
		success: (res: any) => {
			console.log(res);
		}
	})
	```

### tsconfig 配置文件解析

#### 认识 tsconfig.json 文件

- **什么是 tsconfig.json 文件呢？（官方的解释）**
	- 当目录中出现了 tsconfig.json 文件，则说明该目录是 TypeScript 项目的根目录；
	- tsconfig.json 文件指定了编译项目所需的根目录下的文件以及编译选项。
- **tsconfig.json 文件有两个作用：**
	- **作用一（主要的作用）：** 让 Typescript Compiler 在编译的时候，知道如何去编译 TypeScript 代码和进行类型检测；
		- 比如是否允许不明确的 this 选项，是否允许隐式的 any 类型；
		- 将 TypeScript 代码编译成什么版本的 JavaScript 代码；
	- **作用二：** 让编辑器（比如 VSCode）可以按照正确的方式识别 TypeScript 代码；
		- 对于哪些语法进行提示、类型错误检测等等；
- **JavaScript 项目可以使用 jsconfig.json 文件，它的作用与 tsconfig.json 基本相同，只是默认启用了一些 JavaScript 相关的编译选项。**
	- 在之前的 Vue 项目、React 项目中我们也有使用过；
 
#### tsconfig.json 配置

- **tsconfig.json 在编译时如何被使用呢？**
	- 在**调用 tsc 命令并且没有其它输入文件参数**时，编译器**将由当前目录开始向父级目录寻找包含 tsconfig 文件**的目录。
	- 调用 **tsc 命令并且没有其他输入文件参数，可以使用 --project （或者只是 -p）的命令行选项来指定包含了 tsconfig.json** 的目录；
	- 当命令行中**指定了输入文件参数，tsconfig.json 文件会被忽略；**
- **webpack 中使用 ts-loader 进行打包时，也会自动读取 tsconfig 文件，根据配置编译 TypeScript 代码。**
- **tsconfig.json 文件包含哪些选项呢？**
	- tsconfig.json 本身包括的选项非常非常多，我们不需要每一个都记住；
	- 可以查看文档对于每个选项的解释：<https://www.typescriptlang.org/tsconfig>
	- 当我们开发项目的时候，选择 TypeScript 模板时，tsconfig 文件默认都会帮助我们配置好的；
- **接下来我们学习一下哪些重要的、常见的选项。**
- tsconfig.json 顶层选项
	![tsconfig顶层选项](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic202501021855617.png)
	- `compilerOptions` 选项
		![compilerOptions-1](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic202501021906645.png)
		![compilerOptions-2](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic202501021907405.png)

### axios 封装

```typescript
// ./src/service/config/index.ts
export const BASE_URL = "http://codercba.com:8000"
export const TIME_OUT = 1000
```

```typescript
// ./src/service/request/type.ts
import type { AxiosInstance, AxiosRequestConfig, AxiosResponse } from "axios"

// 针对 AxiosRequestConfig 配置进行扩展
export interface HYInterceptors<T = AxiosResponse> {
	requestSuccessFn?: (config: AxiosRequestConfig) => AxiosRequestConfig
	requestFailureFn?: (err: any) => any
	responseSuccessFn?: (res: T) => T
	responseFailureFn?: (err: any) => any
}

export interface HYRequestConfig<T = AxiosResponse> extends AxiosRequestConfig {
	interceptors?: HYInterceptors<T>
}
```

```typescript
// ./src/service/request/index.ts
inmport axios from "axios"
import type { AxiosInstance, AxiosRequestConfig, AxiosResponse } from "axios"
import type { HYRequestConfig } from "./type"

// 拦截器：蒙版Loading/token/修改配置

// 两个难点：
// 1. 拦截器进行精细控制 全局>实例>单词请求拦截器
// 2. 响应结果的类型处理（泛型）

class HYRequest {
	instance: AxiosInstance
	
	// request 实例 => axios 实例
	constructor(config: HYRequestConfig) {
		this.instance = axios.create(config)

		// 每个 instance 实例都添加拦截器
		this.instance.interceptors.request.use(config => {
			// loading/token
			console.log("全局请求成功的拦截")
			return config
		}, err => {
			console.log("全局请求失败的拦截")
			return err
		})
		this.instance.interceptors.response.use(res => {
			console.log("全局响应成功的拦截")
			return res
		}, err => {
			console.log("全局响应失败的拦截")
			return err
		})

		// 针对特定的 hyRequest 实例添加拦截器
		this.instance.interceptors.request.use(
			config.interceptors?.requestSuccessFn,
			config.interceptors?.requestFailureFn
		)
		this.instance.interceptors.response.use(
			config.interceptors?.responseSuccessFn,
			config.interceptors?.responseFailureFn
		)
	}

	// 封装网络请求的方法
	request(config: HYRequestConfig) {
		// 单次请求的成功拦截处理
		if (config.interceptors?.requestSuccessFn) {
			config = config.interceptors.requestSuccessFn(config)
		}
		return new Promise<AxiosResponse>((resolve, reject) => {
			// 单词响应的成功拦截处理
			this.instance.request(config).then(res => {
				if (config.interceptors?.responseSuccessFn) {
					res = config.interceptors.responseSuccessFn(res)
				}
				resolve(res)
			}).catch(err => {
				reject(err)
			})
		})
	}

	get<T = any>(config: HYRequestConfig<T>) {
		return this.request({ ...config, method: "GET" })
	}

	post<T = any>(config: HYRequestConfig<T>) {
		return this.request({ ...config, method: "POST" })
	}
	delete<T = any>(config: HYRequestConfig<T>) {
		return this.request({ ...config, method: "DELETE" })
	}
	patch<T = any>(config: HYRequestConfig<T>) {
		return this.request({ ...config, method: "PATCH" })
	}
}

export default HYRequest
```

```typescript
// ./src/service/index.ts
import { BASE_URL, TIME_OUT } from "./config";
import HYRequest from "./request";

const hyRequest = new HYRequest({
	baseURL: BASE_URL,
	timeout: TIME_OUT,
})

export const hyRequest2 = new HYRequest({
	baseURL: "http://codercba.com:1888/airbnb/api",
	timeout: 8000,

	interceptors: {
		requestSucdessFn: (config) => {
			console.log("爱彼迎的请求成功的拦截")
			return config
		},
		requestFailureFn: (err) => {
			console.log("爱彼迎的请求失败的拦截")
			return err
		},
		responseSuccessFn: (res) => {
			console.log("爱彼迎的响应成功的拦截")
			return res
		},
		responseFailureFn: (err) => {
			console.log("爱彼迎的响应失败的拦截")
			return err
		}
	}
})

export default hyRequest
```

```typescript
// ./src/service/modules/home.ts
import hyRequest from "..";

// 发送网络请求
// hyRequest.post
hyRequest.request({
	url: "/home/multidata"
}).then(res => {
	console.log(res.data)
})
```

```typescript
// ./src/service/modules/entire.ts
import { hyRequest2 } from "..";

// 发送网络请求
// hyRequest2.post
hyRequest.request({
	url: "/entire/list",
	params: {
		offset: 0,
		size: 20
	}
}).then(res => {
	console.log(res.data)
})

hyRequest2.request({
	url: "/home/highscore",
	interceptors: {
		requestSuccessFn: config => {
			console.log("/home/highscore请求成功的拦截")
			return config
		},
		responseSuccessFn: res => {
			console.log("/home/highscore响应成功的拦截")
			return res
		}
	}
}).then(res => {
	console.log(res.data)
})
```

```typescript
// ./src/index.ts
import "./service/modules/home"
import "./service/modules/entire"

// webpack 依赖图
```

