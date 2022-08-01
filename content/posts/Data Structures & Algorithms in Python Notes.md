---
2022-08-01 19:17:39
---

# Data Structures & Algorithms in Python Notes
 
[toc]{type: "ul", level: [2,3]}

## 第 1 章 Python 入门

### 1.1 Python 概述

#### 1.1.2 Python 程序预览

```python
print('Welcome to the GPA calculator.')
print('Please enter all your letter grades, one per line.')
print('Enter a blank line to designate the end.')
# map from letter grade to point value
points = {'A+':4.0, 'A':4.0, 'A-':3.67, 'B+':3.33, 'B':3.0, 'B-':2.67,
          'C+':2.33, 'C':2.0, 'C':1.67, 'D+':1.33, 'D':1.0, 'F':0.0}
num_courses = 0
total_points = 0
done = False
while not done:
  grade = input()                          # read line from user
  if grade == '':                          # empty line was entered
    done = True
  elif grade not in points:                # unrecognized grade entered
    print("Unknown grade '{0}' being ignored".format(grade))
  else:
    num_courses += 1
    total_points += points[grade]
if num_courses > 0:                        # avoid division by zero
  print('Your GPA is {0:.3}'.format(total_points / num_courses))
```

### 1.5 函数

#### 1.5.1 信息传递

```python
def compute_gpa(grades, points={'A+':4.0, 'A':4.0, 'A-':3.67, 'B+':3.33,
                                'B':3.0, 'B-':2.67,'C+':2.33, 'C':2.0,
                                'C':1.67, 'D+':1.33, 'D':1.0, 'F':0.0}):
  num_courses = 0
  total_points = 0
  for g in grades:
    if g in points:                      # a recognizable grade
      num_courses += 1
      total_points += points[g]
  return total_points / num_courses
```

```python
def range(start, stop=None, step=1):
  if stop is None:
    stop = start
    start = 0
  ...
```

### 1.6 简单的输入和输出

#### 1.6.1 控制台输入和输出

```python
age = int(input('Enter your age in years: '))
max_heart_rate = 206.9 - (0.67 * age)        # as per Med Sci Sports Exerc.
target = 0.65 * max_heart_rate
print('Your target fat-burning heart rate is', target)
```

### 1.7 异常处理

#### 1.7.1 抛出异常

```python
def sqrt(x):
    if not isinstance(x, (int, float)):
        raise TypeError('x must be numeric')
    elif x < 0:
        raise ValueError('x must be negative')
    # do the real work here...
```

```python
import collections

def sum(values):
  if not isinstance(values, collections.Iterable):
    raise TypeError('parameter must be an iterable type')
  total = 0
  for v in values:
    if not isinstance(v, (int, float)):
      raise TypeError('elements must be numeric')
    total = total+ v
  return total
```

```python
def sum(values):
  total = 0
  for v in values:
    total = total + v
  return total
```

#### 1.7.2 捕捉异常

```python
age = -1                    # an initially invalid choice
while age <= 0:
  try:
    age = int(input('Enter your age in years: '))
    if age <= 0:
      print('Your age must be positive')
  except (ValueError, EOFError):
    print('Invalid response')
```

```python
age = -1                    # an initially invalid choice
while age <= 0:
  try:
    age = int(input('Enter your age in years: '))
    if age <= 0:
      print('Your age must be positive')
  except ValueError:
    print('That is an invalid age specification')
  except EOFError:
    print('There was an unexpected error reading input.')
    raise                   # let's re-raise this exception
```

### 1.8 生成器和迭代器

#### 生成器

```python
def factors(n):             # traditional function that computes factors
  results = []              # store factors in a new list
  for k in range(1,n+1):
    if n % k == 0:          # divides evenly, thus k is a factor
      results.append(k)     # add k to the list of factors
  return results            # return the entire list
```

```python
def factors(n):             # generator that computes factors
  for k in range(1,n+1):
    if n % k == 0:          # divides evenly, thus k is a factor
      yield k               # yield this factor as next result
```

```python
def factors(n):             # generator that computes factors
  k = 1
  while k * k < n:          # while k < sqrt(n)
    if n % k == 0:
      yield k
      yield n // k
    k += 1
  if k * k == n:            # special case if n is perfect square
    yield k
```

```python
def fibonacci():
  a = 0
  b = 1
  while True:             # keep going...
    yield a               # report value, a, during this pass
    future = a + b
    a = b                 # this will be next value reported
    b = future            # and subsequently this
```

### 1.9 Python 的其他便利特点

#### 1.9.3 序列类型的打包和解包

```python
def fibonacci():
  a, b = 0, 1
  while True:
    yield a
    a, b = b, a+b
```

## 第 2 章 面向对象编程

### 2.3 类定义

#### 2.3.1 例子：CreditCard 类

```python
class CreditCard:
  """A consumer credit card."""
  
  def __init__(self, customer, bank, acnt, limit):
    """Create a new credit card instance.

    The initial balance is zero.

    customer  the name of the customer (e.g., 'John Bowman')
    bank      the name of the bank (e.g., 'California Savings')
    acnt      the acount identifier (e.g., '5391 0375 9387 5309')
    limit     credit limit (measured in dollars)
    """
    self._customer = customer
    self._bank = bank
    self._account = acnt
    self._limit = limit
    self._balance = 0

  def get_customer(self):
    """Return name of the customer."""
    return self._customer
    
  def get_bank(self):
    """Return the bank's name."""
    return self._bank

  def get_account(self):
    """Return the card identifying number (typically stored as a string)."""
    return self._account

  def get_limit(self):
    """Return current credit limit."""
    return self._limit

  def get_balance(self):
    """Return current balance."""
    return self._balance

  def charge(self, price):
    """Charge given price to the card, assuming sufficient credit limit.

    Return True if charge was processed; False if charge was denied.
    """
    if price + self._balance > self._limit:  # if charge would exceed limit,
      return False                           # cannot accept charge
    else:
      self._balance += price
      return True

  def make_payment(self, amount):
    """Process customer payment that reduces balance."""
    self._balance -= amount

if __name__ == '__main__':
  wallet = []
  wallet.append(CreditCard('John Bowman', 'California Savings',
                           '5391 0375 9387 5309', 2500) )
  wallet.append(CreditCard('John Bowman', 'California Federal',
                           '3485 0399 3395 1954', 3500) )
  wallet.append(CreditCard('John Bowman', 'California Finance',
                           '5391 0375 9387 5309', 5000) )

  for val in range(1, 17):
    wallet[0].charge(val)
    wallet[1].charge(2*val)
    wallet[2].charge(3*val)

  for c in range(3):
    print('Customer =', wallet[c].get_customer())
    print('Bank =', wallet[c].get_bank())
    print('Account =', wallet[c].get_account())
    print('Limit =', wallet[c].get_limit())
    print('Balance =', wallet[c].get_balance())
    while wallet[c].get_balance() > 100:
      wallet[c].make_payment(100)
      print('New balance =', wallet[c].get_balance())
    print()
```

#### 2.3.3 例子：多维向量类

```python
import collections

class Vector:
  """Represent a vector in a multidimensional space."""

  def __init__(self, d):
    if isinstance(d, int):
      self._coords = [0] * d
    else:                                  
      try:                                     # we test if param is iterable
        self._coords = [val for val in d]
      except TypeError:
        raise TypeError('invalid parameter type')

  def __len__(self):
    """Return the dimension of the vector."""
    return len(self._coords)

  def __getitem__(self, j):
    """Return jth coordinate of vector."""
    return self._coords[j]

  def __setitem__(self, j, val):
    """Set jth coordinate of vector to given value."""
    self._coords[j] = val

  def __add__(self, other):
    """Return sum of two vectors."""
    if len(self) != len(other):          # relies on __len__ method
      raise ValueError('dimensions must agree')
    result = Vector(len(self))           # start with vector of zeros
    for j in range(len(self)):
      result[j] = self[j] + other[j]
    return result

  def __eq__(self, other):
    """Return True if vector has same coordinates as other."""
    return self._coords == other._coords

  def __ne__(self, other):
    """Return True if vector differs from other."""
    return not self == other             # rely on existing __eq__ definition

  def __str__(self):
    """Produce string representation of vector."""
    return '<' + str(self._coords)[1:-1] + '>'  # adapt list representation

  def __neg__(self):
    """Return copy of vector with all coordinates negated."""
    result = Vector(len(self))           # start with vector of zeros
    for j in range(len(self)):
      result[j] = -self[j]
    return result

  def __lt__(self, other):
    """Compare vectors based on lexicographical order."""
    if len(self) != len(other):
      raise ValueError('dimensions must agree')
    return self._coords < other._coords

  def __le__(self, other):
    """Compare vectors based on lexicographical order."""
    if len(self) != len(other):
      raise ValueError('dimensions must agree')
    return self._coords <= other._coords

if __name__ == '__main__':
  # the following demonstrates usage of a few methods
  v = Vector(5)              # construct five-dimensional <0, 0, 0, 0, 0>
  v[1] = 23                  # <0, 23, 0, 0, 0> (based on use of __setitem__)
  v[-1] = 45                 # <0, 23, 0, 0, 45> (also via __setitem__)
  print(v[4])                # print 45 (via __getitem__)
  u = v + v                  # <0, 46, 0, 0, 90> (via __add__)
  print(u)                   # print <0, 46, 0, 0, 90>
  total = 0
  for entry in v:            # implicit iteration via __len__ and __getitem__
    total += entry
```

#### 2.3.4 迭代器

```python
class SequenceIterator:
  """An iterator for any of Python's sequence types."""

  def __init__(self, sequence):
    """Create an iterator for the given sequence."""
    self._seq = sequence          # keep a reference to the underlying data
    self._k = -1                  # will increment to 0 on first call to next

  def __next__(self):
    """Return the next element, or else raise StopIteration error."""
    self._k += 1                  # advance to next index
    if self._k < len(self._seq):
      return(self._seq[self._k])  # return the data element
    else:
      raise StopIteration()       # there are no more elements

  def __iter__(self):
    """By convention, an iterator must return itself as an iterator."""
    return self
```

#### 2.3.5 例子：Range 类

```python
class Range:
  """A class that mimic's the built-in range class."""

  def __init__(self, start, stop=None, step=1):
    """Initialize a Range instance.

    Semantics is similar to built-in range class.
    """
    if step == 0:
      raise ValueError('step cannot be 0')
      
    if stop is None:                  # special case of range(n)
      start, stop = 0, start          # should be treated as if range(0,n)

    # calculate the effective length once
    self._length = max(0, (stop - start + step - 1) // step)

    # need knowledge of start and step (but not stop) to support __getitem__
    self._start = start
    self._step = step

  def __len__(self):
    """Return number of entries in the range."""
    return self._length

  def __getitem__(self, k):
    """Return entry at index k (using standard interpretation if negative)."""
    if k < 0:
      k += len(self)                  # attempt to convert negative index

    if not 0 <= k < self._length:
      raise IndexError('index out of range')

    return self._start + k * self._step
```

### 2.4 继承

#### 2.4.1 扩展 CreditCard 类

```python
from .credit_card import CreditCard

class PredatoryCreditCard(CreditCard):
  """An extension to CreditCard that compounds interest and fees."""
  
  def __init__(self, customer, bank, acnt, limit, apr):
    """Create a new predatory credit card instance.

    The initial balance is zero.

    customer  the name of the customer (e.g., 'John Bowman')
    bank      the name of the bank (e.g., 'California Savings')
    acnt      the acount identifier (e.g., '5391 0375 9387 5309')
    limit     credit limit (measured in dollars)
    apr       annual percentage rate (e.g., 0.0825 for 8.25% APR)
    """
    super().__init__(customer, bank, acnt, limit)  # call super constructor
    self._apr = apr

  def charge(self, price):
    """Charge given price to the card, assuming sufficient credit limit.

    Return True if charge was processed.
    Return False and assess $5 fee if charge is denied.
    """
    success = super().charge(price)          # call inherited method
    if not success:
      self._balance += 5                     # assess penalty
    return success                           # caller expects return value

  def process_month(self):
    """Assess monthly interest on outstanding balance."""
    if self._balance > 0:
      # if positive balance, convert APR to monthly multiplicative factor
      monthly_factor = pow(1 + self._apr, 1/12)
      self._balance *= monthly_factor
```

#### 2.4.2 数列的层次图

```python
class Progression:
  """Iterator producing a generic progression.

  Default iterator produces the whole numbers 0, 1, 2, ...
  """

  def __init__(self, start=0):
    """Initialize current to the first value of the progression."""
    self._current = start

  def _advance(self):
    """Update self._current to a new value.

    This should be overridden by a subclass to customize progression.

    By convention, if current is set to None, this designates the
    end of a finite progression.
    """
    self._current += 1

  def __next__(self):
    """Return the next element, or else raise StopIteration error."""
    if self._current is None:    # our convention to end a progression
      raise StopIteration()
    else:
      answer = self._current     # record current value to return
      self._advance()            # advance to prepare for next time
      return answer              # return the answer

  def __iter__(self):
    """By convention, an iterator must return itself as an iterator."""
    return self                  

  def print_progression(self, n):
    """Print next n values of the progression."""
    print(' '.join(str(next(self)) for j in range(n)))

class ArithmeticProgression(Progression):  # inherit from Progression
  """Iterator producing an arithmetic progression."""
  
  def __init__(self, increment=1, start=0):
    """Create a new arithmetic progression.

    increment  the fixed constant to add to each term (default 1)
    start      the first term of the progression (default 0)
    """
    super().__init__(start)                # initialize base class
    self._increment = increment

  def _advance(self):                      # override inherited version
    """Update current value by adding the fixed increment."""
    self._current += self._increment

    
class GeometricProgression(Progression):   # inherit from Progression
  """Iterator producing a geometric progression."""
  
  def __init__(self, base=2, start=1):
    """Create a new geometric progression.

    base       the fixed constant multiplied to each term (default 2)
    start      the first term of the progression (default 1)
    """
    super().__init__(start)
    self._base = base

  def _advance(self):                      # override inherited version
    """Update current value by multiplying it by the base value."""
    self._current *= self._base


class FibonacciProgression(Progression):
  """Iterator producing a generalized Fibonacci progression."""
  
  def __init__(self, first=0, second=1):
    """Create a new fibonacci progression.

    first      the first term of the progression (default 0)
    second     the second term of the progression (default 1)
    """
    super().__init__(first)              # start progression at first
    self._prev = second - first          # fictitious value preceding the first

  def _advance(self):
    """Update current value by taking sum of previous two."""
    self._prev, self._current = self._current, self._prev + self._current


if __name__ == '__main__':
  print('Default progression:')
  Progression().print_progression(10)

  print('Arithmetic progression with increment 5:')
  ArithmeticProgression(5).print_progression(10)

  print('Arithmetic progression with increment 5 and start 2:')
  ArithmeticProgression(5, 2).print_progression(10)

  print('Geometric progression with default base:')
  GeometricProgression().print_progression(10)

  print('Geometric progression with base 3:')
  GeometricProgression(3).print_progression(10)

  print('Fibonacci progression with default start values:')
  FibonacciProgression().print_progression(10)
  
  print('Fibonacci progression with start values 4 and 6:')
  FibonacciProgression(4, 6).print_progression(10)
```

#### 2.4.3 抽象基类

```python
from abc import ABCMeta, abstractmethod           # need these definitions

class Sequence(metaclass=ABCMeta):
  """Our own version of collections.Sequence abstract base class."""

  @abstractmethod
  def __len__(self):
    """Return the length of the sequence."""

  @abstractmethod
  def __getitem__(self, j):
    """Return the element at index j of the sequence."""

  def __contains__(self, val):
    """Return True if val found in the sequence; False otherwise."""
    for j in range(len(self)):
      if self[j] == val:                          # found match
        return True
    return False

  def index(self, val):
    """Return leftmost index at which val is found (or raise ValueError)."""
    for j in range(len(self)):
      if self[j] == val:                          # leftmost match
        return j
    raise ValueError('value not in sequence')     # never found a match

  def count(self, val):
    """Return the number of elements equal to given value."""
    k = 0
    for j in range(len(self)):
      if self[j] == val:                          # found a match
        k += 1
    return k
```

## 第 3 章 算法分析

### 3.3 渐进分析

```python
def find_max(data):
  """Return the maximum element from a nonempty Python list."""
  biggest = data[0]               # The initial value to beat
  for val in data:                # For each value:
    if val > biggest:             # if it is greater than the best so far,
      biggest = val               # we have found a new best (so far)
  return biggest                  # When loop ends, biggest is the max
```

#### 3.3.3 算法分析示例

- 二次 - 时间算法
```python
def prefix_average1(S):
  """Return list such that, for all j, A[j] equals average of S[0], ..., S[j]."""
  n = len(S)
  A = [0] * n                     # create new list of n zeros
  for j in range(n):
    total = 0                     # begin computing S[0] + ... + S[j]
    for i in range(j + 1):
      total += S[i]
    A[j] = total / (j+1)          # record the average
  return A
```

```python
def prefix_average2(S):
  """Return list such that, for all j, A[j] equals average of S[0], ..., S[j]."""
  n = len(S)
  A = [0] * n                     # create new list of n zeros
  for j in range(n):
    A[j] = sum(S[0:j+1]) / (j+1)  # record the average
  return A
```

- 线性 - 时间算法
```python
def prefix_average3(S):
  """Return list such that, for all j, A[j] equals average of S[0], ..., S[j]."""
  n = len(S)
  A = [0] * n                   # create new list of n zeros
  total = 0                     # compute prefix sum as S[0] + S[1] + ...
  for j in range(n):
    total += S[j]               # update prefix sum to include S[j]
    A[j] = total / (j+1)        # compute average based on current sum
  return A
```

- 三集不相交
```python
def disjoint1(A, B, C):
  """Return True if there is no element common to all three lists."""
  for a in A:
    for b in B:
      for c in C:
        if a == b == c:
          return False      # we found a common value
  return True               # if we reach this, sets are disjoint
```

```python
def disjoint2(A, B, C):
  """Return True if there is no element common to all three lists."""
  for a in A:
    for b in B:
      if a == b:            # only check C if we found match from A and B
        for c in C:
          if a == c         # (and thus a == b == c)
            return False    # we found a common value
  return True               # if we reach this, sets are disjoint
```

- 元素唯一性
```python
def unique1(S):
  """Return True if there are no duplicate elements in sequence S."""
  for j in range(len(S)):
    for k in range(j+1, len(S)):
      if S[j] == S[k]:
        return False              # found duplicate pair
  return True                     # if we reach this, elements were unique
```

```python
def unique2(S):
  """Return True if there are no duplicate elements in sequence S."""
  temp = sorted(S)                # create a sorted copy of S
  for j in range(1, len(temp)):
    if temp[j-1] == temp[j]:
      return False                # found duplicate pair
  return True                     # if we reach this, elements were unique
```

## 第 4 章 递归

### 4.1 说明性的例子

#### 4.1.1 阶乘函数

```python
def factorial(n):
  if n == 0:
    return 1
  else:
    return n * factorial(n-1)
```

#### 4.1.2 绘制英式标尺

```python
def draw_line(tick_length, tick_label=''):
  """Draw one line with given tick length (followed by optional label)."""
  line = '-' * tick_length
  if tick_label:
    line += ' ' + tick_label
  print(line)

def draw_interval(center_length):
  """Draw tick interval based upon a central tick length."""
  if center_length > 0:                   # stop when length drops to 0
    draw_interval(center_length - 1)      # recursively draw top ticks
    draw_line(center_length)              # draw center tick
    draw_interval(center_length - 1)      # recursively draw bottom ticks

def draw_ruler(num_inches, major_length):
  """Draw English ruler with given number of inches and major tick length."""
  draw_line(major_length, '0')            # draw inch 0 line
  for j in range(1, 1 + num_inches):
    draw_interval(major_length - 1)       # draw interior ticks for inch
    draw_line(major_length, str(j))       # draw inch j line and label


if __name__ == '__main__':
  draw_ruler(2,4)
  print('='*30)
  draw_ruler(1,5)
  print('='*30)
  draw_ruler(3,3)
```

#### 4.1.3 二分查找

```python
def binary_search(data, target, low, high):
  """Return True if target is found in indicated portion of a Python list.

  The search only considers the portion from data[low] to data[high] inclusive.
  """
  if low > high:
    return False                    # interval is empty; no match
  else:
    mid = (low + high) // 2
    if target == data[mid]:         # found a match
      return True
    elif target < data[mid]:
      # recur on the portion left of the middle
      return binary_search(data, target, low, mid - 1)
    else:
      # recur on the portion right of the middle
      return binary_search(data, target, mid + 1, high)
```

#### 4.1.4 文件系统

```python
import os

def disk_usage(path):
  """Return the number of bytes used by a file/folder and any descendents."""
  total = os.path.getsize(path)                  # account for direct usage
  if os.path.isdir(path):                        # if this is a directory,
    for filename in os.listdir(path):            # then for each child:
      childpath = os.path.join(path, filename)   # compose full path to child
      total += disk_usage(childpath)             # add child's usage to total

  print ('{0:<7}'.format(total), path)           # descriptive output (optional)
  return total                                   # return the grand total
```

### 4.3 递归算法的不足

```python
def bad_fibonacci(n):
  """Return the nth Fibonacci number."""
  if n <= 1:
    return n
  else:
    return bad_fibonacci(n-2) + bad_fibonacci(n-1)

def good_fibonacci(n):
  """Return pair of Fibonacci numbers, F(n) and F(n-1)."""
  if n <= 1:
    return (n,0)
  else:
    (a, b) = good_fibonacci(n-1)
    return (a+b, a)
```

### 4.4 递归的其他例子

#### 4.4.1 线性递归

- 元素序列的递归求和
```python
def linear_sum(S, n):
  """Return the sum of the first n numbers of sequence S."""
  if n == 0:
    return 0
  else:
    return linear_sum(S, n-1) + S[n-1]
```

- 使用递归逆序序列
```python
def reverse(S, start, stop):
  """Reverse elements in implicit slice S[start:stop]."""
  if start < stop - 1:                         # if at least 2 elements:
    S[start], S[stop-1] = S[stop-1], S[start]  # swap first and last
    reverse(S, start+1, stop-1)                # recur on rest
```
- 用于计算幂的递归算法

    - 用简单的递归计算幂函数
    ```python
    def power(x, n):
      """Compute the value x**n for integer n."""
      if n == 0:
        return 1
      else:
        return x * power(x, n-1)
    ```

    - 使用重复的平方计算幂函数
    ```python
    def power(x, n):
      """Compute the value x**n for integer n."""
      if n == 0:
        return 1
      else:
        partial = power(x, n // 2)          # rely on truncated division
        result = partial * partial
        if n % 2 == 1:                      # if n odd, include extra factor of x
          result *= x                       
        return result
    ```

#### 4.4.2 二路递归

```python
def binary_sum(S, start, stop):
  """Return the sum of the numbers in implicit slice S[start:stop]."""
  if start >= stop:                      # zero elements in slice
    return 0
  elif start == stop-1:                  # one element in slice
    return S[start]
  else:                                  # two or more elements in slice
    mid = (start + stop) // 2
    return binary_sum(S, start, mid) + binary_sum(S, mid, stop)
```

### 4.6 消除尾递归

- 二分查找算法的非递归实现
```python
def binary_search_iterative(data, target):
  """Return True if target is found in the given Python list."""
  low = 0
  high = len(data)-1
  while low <= high:
    mid = (low + high) // 2
    if target == data[mid]:         # found a match
      return True
    elif target < data[mid]:
      high = mid - 1                # only consider values left of mid
    else:
      low = mid + 1                 # only consider values right of mid
  return False                      # loop ended without success
```

- 使用迭代逆置一个序列的元素
```python
def reverse_iterative(S):
  """Reverse elements in sequence S."""
  start, stop = 0, len(S)
  while start < stop - 1:
    S[start], S[stop-1] = S[stop-1], S[start]  # swap first and last
    start, stop = start + 1, stop - 1          # narrow the range
```

## 第 5 章 基于数组的序列

### 5.3 动态数组和摊销

```python
import sys

try:
    n = int(sys.argv[1])
except:
    n = 100

import sys                              # provides getsizeof function
data = []
for k in range(n):                      # NOTE: must fix choice of n
  a = len(data)                         # number of elements
  b = sys.getsizeof(data)               # actual size in bytes
  print('Length: {0:3d}; Size in bytes: {1:4d}'.format(a, b))
  data.append(None)     
```

#### 5.3.1 实现动态数组

```python
import ctypes                                      # provides low-level arrays

class DynamicArray:
  """A dynamic array class akin to a simplified Python list."""

  def __init__(self):
    """Create an empty array."""
    self._n = 0                                    # count actual elements
    self._capacity = 1                             # default array capacity
    self._A = self._make_array(self._capacity)     # low-level array
    
  def __len__(self):
    """Return number of elements stored in the array."""
    return self._n
    
  def __getitem__(self, k):
    """Return element at index k."""
    if not 0 <= k < self._n:
      raise IndexError('invalid index')
    return self._A[k]                              # retrieve from array
  
  def append(self, obj):
    """Add object to end of the array."""
    if self._n == self._capacity:                  # not enough room
      self._resize(2 * self._capacity)             # so double capacity
    self._A[self._n] = obj
    self._n += 1

  def _resize(self, c):                            # nonpublic utitity
    """Resize internal array to capacity c."""
    B = self._make_array(c)                        # new (bigger) array
    for k in range(self._n):                       # for each existing value
      B[k] = self._A[k]
    self._A = B                                    # use the bigger array
    self._capacity = c

  def _make_array(self, c):                        # nonpublic utitity
     """Return new array with capacity c."""   
     return (c * ctypes.py_object)()               # see ctypes documentation

  def insert(self, k, value):
    """Insert value at index k, shifting subsequent values rightward."""
    # (for simplicity, we assume 0 <= k <= n in this verion)
    if self._n == self._capacity:                  # not enough room
      self._resize(2 * self._capacity)             # so double capacity
    for j in range(self._n, k, -1):                # shift rightmost first
      self._A[j] = self._A[j-1]
    self._A[k] = value                             # store newest element
    self._n += 1

  def remove(self, value):
    """Remove first occurrence of value (or raise ValueError)."""
    # note: we do not consider shrinking the dynamic array in this version
    for k in range(self._n):
      if self._A[k] == value:              # found a match!
        for j in range(k, self._n - 1):    # shift others to fill gap
          self._A[j] = self._A[j+1]
        self._A[self._n - 1] = None        # help garbage collection
        self._n -= 1                       # we have one less item
        return                             # exit immediately
    raise ValueError('value not found')    # only reached if no match
```

#### 5.3.3 Python 列表类

- 测量 Python 列表类增添操作的摊销花费
```python
import sys
from time import time

try:
    maxN = int(sys.argv[1])
except:
    maxN = 10000000

from time import time            # import time function from time module
def compute_average(n):
  """Perform n appends to an empty list and return average time elapsed."""
  data = []
  start = time()                 # record the start time (in seconds)
  for k in range(n):
    data.append(None)
  end = time()                   # record the end time (in seconds)
  return (end - start) / n       # compute average per operation

n = 10
while n <= maxN:
  print('Average of {0:.3f} for n {1}'.format(compute_average(n)*1000000, n))
  n *= 10
```

### 5.4 Python 序列类型的效率

#### 5.4.1 Python 的列表和元组类

- 向列表中增添元素
```python
  def insert(self, k, value):
    """Insert value at index k, shifting subsequent values rightward."""
    # (for simplicity, we assume 0 <= k <= n in this verion)
    if self._n == self._capacity:                  # not enough room
      self._resize(2 * self._capacity)             # so double capacity
    for j in range(self._n, k, -1):                # shift rightmost first
      self._A[j] = self._A[j-1]
    self._A[k] = value                             # store newest element
    self._n += 1
```

- 从列表中删除元素
```python
  def remove(self, value):
    """Remove first occurrence of value (or raise ValueError)."""
    # note: we do not consider shrinking the dynamic array in this version
    for k in range(self._n):
      if self._A[k] == value:              # found a match!
        for j in range(k, self._n - 1):    # shift others to fill gap
          self._A[j] = self._A[j+1]
        self._A[self._n - 1] = None        # help garbage collection
        self._n -= 1                       # we have one less item
        return                             # exit immediately
    raise ValueError('value not found')    # only reached if no match
```

### 5.5 使用基于数组的序列

#### 5.5.1 为游戏存储高分

```python
class GameEntry:
  """Represents one entry of a list of high scores."""

  def __init__(self, name, score):
    """Create an entry with given name and score."""
    self._name = name
    self._score = score

  def get_name(self):
    """Return the name of the person for this entry."""
    return self._name
    
  def get_score(self):
    """Return the score of this entry."""
    return self._score

  def __str__(self):
    """Return string representation of the entry."""
    return '({0}, {1})'.format(self._name, self._score) # e.g., '(Bob, 98)'

class Scoreboard:
  """Fixed-length sequence of high scores in nondecreasing order."""

  def __init__(self, capacity=10):
    """Initialize scoreboard with given maximum capacity.

    All entries are initially None.
    """
    self._board = [None] * capacity        # reserve space for future scores
    self._n = 0                            # number of actual entries

  def __getitem__(self, k):
    """Return entry at index k."""
    return self._board[k]

  def __str__(self):
    """Return string representation of the high score list."""
    return '\n'.join(str(self._board[j]) for j in range(self._n))

  def add(self, entry):
    """Consider adding entry to high scores."""
    score = entry.get_score()

    # Does new entry qualify as a high score?
    # answer is yes if board not full or score is higher than last entry
    good = self._n < len(self._board) or score > self._board[-1].get_score()

    if good:
      if self._n < len(self._board):        # no score drops from list
        self._n += 1                        # so overall number increases

      # shift lower scores rightward to make room for new entry
      j = self._n - 1
      while j > 0 and self._board[j-1].get_score() < score:
        self._board[j] = self._board[j-1]   # shift entry from j-1 to j
        j -= 1                              # and decrement j
      self._board[j] = entry                # when done, add new entry

if __name__ == '__main__':
  board = Scoreboard(5)
  for e in (
    ('Rob', 750), ('Mike',1105), ('Rose', 590), ('Jill', 740),
    ('Jack', 510), ('Anna', 660), ('Paul', 720), ('Bob', 400),
    ):
    ge = GameEntry(e[0], e[1])
    board.add(ge)
    print('After considering {0}, scoreboard is:'.format(ge))
    print(board)
    print()
```

#### 5.5.2 为序列排序

- 插入排序算法
```python
def insertion_sort(A):
  """Sort list of comparable elements into nondecreasing order."""
  for k in range(1, len(A)):         # from 1 to n-1
    cur = A[k]                       # current element to be inserted
    j = k                            # find correct index j for current
    while j > 0 and A[j-1] > cur:    # element A[j-1] must be after current
      A[j] = A[j-1]
      j -= 1
    A[j] = cur                       # cur is now in the right place
```

#### 5.5.3 简单密码技术

```python
class CaesarCipher:
  """Class for doing encryption and decryption using a Caesar cipher."""

  def __init__(self, shift):
    """Construct Caesar cipher using given integer shift for rotation."""
    encoder = [None] * 26                           # temp array for encryption
    decoder = [None] * 26                           # temp array for decryption
    for k in range(26):
      encoder[k] = chr((k + shift) % 26 + ord('A'))
      decoder[k] = chr((k - shift) % 26 + ord('A'))
    self._forward = ''.join(encoder)                # will store as string
    self._backward = ''.join(decoder)               # since fixed

  def encrypt(self, message):
    """Return string representing encripted message."""
    return  self._transform(message, self._forward)

  def decrypt(self, secret):
    """Return decrypted message given encrypted secret."""
    return  self._transform(secret, self._backward)

  def _transform(self, original, code):
    """Utility to perform transformation based on given code string."""
    msg = list(original)
    for k in range(len(msg)):
      if msg[k].isupper():
        j = ord(msg[k]) - ord('A')                  # index from 0 to 25
        msg[k] = code[j]                            # replace this character
    return ''.join(msg)

if __name__ == '__main__':
  cipher = CaesarCipher(3)
  message = "THE EAGLE IS IN PLAY; MEET AT JOE'S."
  coded = cipher.encrypt(message)
  print('Secret: ', coded)
  answer = cipher.decrypt(coded)
  print('Message:', answer)
```
### 5.6 多维数据集

- 二维数组和位置型游戏
```python
class TicTacToe:
  """Management of a Tic-Tac-Toe game (does not do strategy)."""

  def __init__(self):
    """Start a new game."""
    self._board = [ [' '] * 3 for j in range(3) ]
    self._player = 'X'

  def mark(self, i, j):
    """Put an X or O mark at position (i,j) for next player's turn."""
    if not (0 <= i <= 2 and 0 <= j <= 2):
      raise ValueError('Invalid board position')
    if self._board[i][j] != ' ':
      raise ValueError('Board position occupied')
    if self.winner() is not None:
      raise ValueError('Game is already complete')
    self._board[i][j] = self._player
    if self._player == 'X':
      self._player = 'O'
    else:
      self._player = 'X'

  def _is_win(self, mark):
    """Check whether the board configuration is a win for the given player."""
    board = self._board                             # local variable for shorthand
    return (mark == board[0][0] == board[0][1] == board[0][2] or    # row 0
            mark == board[1][0] == board[1][1] == board[1][2] or    # row 1
            mark == board[2][0] == board[2][1] == board[2][2] or    # row 2
            mark == board[0][0] == board[1][0] == board[2][0] or    # column 0
            mark == board[0][1] == board[1][1] == board[2][1] or    # column 1
            mark == board[0][2] == board[1][2] == board[2][2] or    # column 2
            mark == board[0][0] == board[1][1] == board[2][2] or    # diagonal
            mark == board[0][2] == board[1][1] == board[2][0])      # rev diag

  def winner(self):
    """Return mark of winning player, or None to indicate a tie."""
    for mark in 'XO':
      if self._is_win(mark):
        return mark
    return None

  def __str__(self):
    """Return string representation of current game board."""
    rows = ['|'.join(self._board[r]) for r in range(3)]
    return '\n-----\n'.join(rows)


if __name__ == '__main__':
  game = TicTacToe()
  # X moves:            # O moves:
  game.mark(1, 1);      game.mark(0, 2)
  game.mark(2, 2);      game.mark(0, 0)
  game.mark(0, 1);      game.mark(2, 1)
  game.mark(1, 2);      game.mark(1, 0)
  game.mark(2, 0)

  print(game)
  winner = game.winner()
  if winner is None:
    print('Tie')
  else:
    print(winner, 'wins')
```

## 第 6 章 栈、队列和双端队列
