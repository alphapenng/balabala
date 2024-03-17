> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [readmedium.com](https://readmedium.com/en/https:/medium.com/techtofreedom/8-levels-of-using-structural-pattern-matching-in-python-d76282d5630f)

> Beyond simple value matching

Python
------

Beyond simple value matching
----------------------------

![](https://cdn-images-1.readmedium.com/v2/resize:fit:800/1*a20cml81MiAgkA-3szkV0A.png)Image from [Wallhaven](https://wallhaven.cc/w/o5wlp9)

After years of anticipation and watching other programming languages flaunt their “switch-case” statements, we Python developers finally got a long-awaited feature from version 3.10: structural pattern matching.

Why so long?

As always, if a feature is not elegant and powerful enough, Python wouldn’t bother to have it.

This is why structural pattern matching is more than a counterpart to the conventional switch-case mechanism in many languages.

It’s a leap forward, transcending mere value matching to offer a multifaceted and powerful tool for complex conditions.

This article will show you how to leverage it in 8 levels from elementary to profound. After reading, your Python toolkit will be enhanced with this additional weapon.

The fundamental purpose of pattern matching in Python, as the `switch-case` syntax of C++, is to avoid writing too many if-else statements and improve our code’s readability.

For example, the following program defines a function that returns different messages based on its received status code. Thanks to the usage of structural pattern matching, we don’t need to add extensive if conditions:

```
def handle_http_status(status_code):
    match status_code:
        case 200:
            return "Success!"
        case 400:
            return "Bad Request"
        case 401:
            return "Unauthorized"
        case 404:
            return "Not Found"
        case 500:
            return "Internal Server Error"


print(handle_http_status(200))

print(handle_http_status(404))

print(handle_http_status(2077))
```

In this scenario, Python’s `match-case` syntax is similar to the `switch-case` in C++:

```
#include <iostream>
#include <string>

std::string handle_http_status(int status_code) {
    switch (status_code) {
        case 200:
            return "Success!";
        case 400:
            return "Bad Request";
        case 401:
            return "Unauthorized";
        case 404:
            return "Not Found";
        case 500:
            return "Internal Server Error";
    }
}

int main() {
    std::cout << handle_http_status(200) << std::endl;  
    std::cout << handle_http_status(404) << std::endl;  
    return 0;
}
```

Matching strings, integers, or other fixed values is the simplest case of pattern matching, so-called literal matching.

As we mentioned, Python’s `match-case` tricks are more than simple values matching as other languages.

Now, let’s investigate more about its potential.

In many cases, we can’t expect that one `match-case` structure includes all conditions.

Therefore, adding a final matching case to handle all other values is a good practice. In Python, it’s as easy as using an underscore to match everything at the end:

```
def handle_http_status(status_code):
    match status_code:
        case 200:
            return "Success!"
        case 400:
            return "Bad Request"
        case 401:
            return "Unauthorized"
        case 404:
            return "Not Found"
        case 500:
            return "Internal Server Error"
        case _:
            return "Unknown Status"


print(handle_http_status(200))

print(handle_http_status(404))

print(handle_http_status(2077))
```

An underscore may seem weird at first glance. But Python leverages it very well to make programs clean and neat. There are [4 more using scenarios](https://readmedium.com/four-usage-scenarios-of-underscores-in-python-e61de6a1003) of it.

Do we have to list all cases one by one?

Of course not. This is how to keep our code Pythonic with an “‘or” pattern (`|`):

```
def handle_http_status(status_code):
    match status_code:
        case 200:
            return "Success!"
        case 400 | 401 | 403 | 404:
            return "Client Error"
        case 500 | 501 | 502 | 503 | 504:
            return "Server Error"
        case _:
            return "Unknown Status"



print(handle_http_status(200))

print(handle_http_status(404))

print(handle_http_status(500))
```

As the above program shows, grouping a few values into one case with `|` based on its logic can streamline our code significantly.

However, if a case can match multiple possible values, there is a new question:

> How can we know which value it really matched?

Here comes the “as pattern”.

As the following example demonstrates, the `as` trick helps to capture the value of the `status_code` and then we are able to use it under its `case`:

```
def handle_http_status(status_code):
    match status_code:
        case 200:
            return "Success!"
        case 400 | 401 | 403 | 404 as Err:
            return f"Client Error:{Err}"
        case 500 | 501 | 502 | 503 | 504 as Err:
            return f"Server Error:{Err}"
        case _:
            return "Unknown Status"



print(handle_http_status(200))

print(handle_http_status(404))

print(handle_http_status(500))
```

Beyond literal values, there are more complex data structures of Python, such as tuples and lists.

Matching these types of data is also possible:

```
def execute_command(command):
    match command:
        case ("print", message):
            print(f"{message}")
        case ["save", filename, data]:
            print(f"Saving {data} to {filename}")
        case ("delete", filename):
            print(f"Deleting {filename}")
        case ('todo', *something):
            print(f"To do: {' '.join(something)}")
        case _:
            print("Unknown Command")


execute_command(("print", "Hello, Yang Zhou!"))

execute_command(("save", "test.txt", "Sample Data"))

execute_command(["delete", "old_file.txt"])

execute_command(("todo", "Write", "an", "article"))

execute_command(("invalid", "data"))
```

The above code handles various commands represented either as tuples or lists. The `match-case` can match and deconstruct the relative data structures conveniently.

In particular, the fourth case applied a [destructuring assignment](https://readmedium.com/5-best-practices-of-destructuring-assignments-in-python-81bce95c5fda) trick using an [asterisk](https://readmedium.com/5-uses-of-asterisks-in-python-3007911c198f), this is an elegant way to assign all the rest values of the tuple into one variable.

Dictionaries are everywhere in programming. But it’s hard to match them in a simple pattern-matching structure in other languages such as C++.

In Python, capturing dictionaries with structural pattern matching technique is never too hard:

```
def handle_user_action(action):
    match action:
        case {"type": "login", "username": user, "password": pw}:
            return f"Login attempt by {user} with password {pw}"
        case {"type": "logout", "username": user}:
            return f"User {user} logged out"
        case {"type": "signup", "username": user, "email": email}:
            return f"New signup by {user} with email {email}"
        case _:
            return "Unknown action"


print(handle_user_action({"type": "login", "username": "Yang Zhou", "password": "123456"}))

print(handle_user_action({"username": "Mark", "type": "logout"}))

print(handle_user_action({"type": "signup", "username": "Elon", "email": "elon@example.com"}))

print(handle_user_action({"type": "hack", "data": "some_data"}))
```

As demonstrated above, when a case is a dictionary-like structure, it will match one dictionary. The order of the key-value pairs doesn’t matter.

The structure pattern matching feature is to prevent our programs from extensive if conditions.

However, a surprising gem hidden in its syntax is that we can still use if conditions in a single case statement:

```
def handle_user_op(action):
    match action:
        case "login" if user_not_logged_in():
            return "User needs to log in"
        case "login":
            return "Already logged in"
        case "logout":
            return "Logging out"
        case _:
            return "Unknown action"
```

An if statement inside a `match-case` structure named a guard. It’s a way to add extra conditions to the case.

This, again, shows how flexible and versatile Python is.

If we define some classes by ourselves, is that still possible to match them in `match-case` structures?

Yes, for sure. The following example intuitively shows how to do it:

```
class Circle:
    def __init__(self, radius):
        self.radius = radius


class Rectangle:
    def __init__(self, length, width):
        self.length = length
        self.width = width


class Triangle:
    def __init__(self, base, height):
        self.base = base
        self.height = height


def process_shape(shape):
    match shape:
        case Circle(radius=r):
            return f"Processing a circle with radius {r}"
        case Rectangle(length=l, width=w):
            return f"Processing a rectangle with length {l} and width {w}"
        case Triangle(base=b, height=h):
            return f"Processing a triangle with base {b} and height {h}"
        case _:
            return "Unknown shape"


circle = Circle(5)
rectangle = Rectangle(10, 5)
triangle = Triangle(3, 6)

print(process_shape(circle))  

print(process_shape(rectangle))  

print(process_shape(triangle))
```

It seems simple, isn’t it?

However, a common mistake will confuse many junior Python developers.

For instance, we edit this part of the code a bit:

```
def process_shape(shape):
    match shape:
        case Circle(radius):
            return f"Processing a circle with radius {radius}"
        case Rectangle(length=l, width=w):
            return f"Processing a rectangle with length {l} and width {w}"
        case Triangle(base=b, height=h):
            return f"Processing a triangle with base {b} and height {h}"
        case _:
            return "Unknown shape"
```

And now execute it again:

```
Traceback (most recent call last):
  File "/Users/yang/test.py", line 34, in <module>
    print(process_shape(circle))
          ^^^^^^^^^^^^^^^^^^^^^
  File "/Users/yang/test.py", line 20, in process_shape
    case Circle(radius):
         ^^^^^^^^^^^^^^
TypeError: Circle() accepts 0 positional sub-patterns (1 given)
```

As the above result shows, an unexpected `TypeError` was raised.

In fact, to match classes, we need to _specify attribute names in class patterns explicitly_, rather than just pass arguments expecting them to match the positional attributes. Otherwise, errors will be raised.

Python’s Structural Pattern Matching brings a new level of expressiveness and efficiency to code, allowing us to elegantly deconstruct and match data structures in ways previously unimagined in the Pythonic realm.

This long-awaited feature has not only met the expectations of the Python community but has indeed surpassed them, opening doors to innovative coding approaches and sophisticated data-handling techniques.

**_Thanks for reading._ ❤️ _If you like it_, _let’s connect:_**

[**_X_**](https://twitter.com/YangZhou1993) **_| [Linkedin](https://www.linkedin.com/in/yang-zhou-237868174/) | [Medium](https://yangzhou1993.medium.com/follow)_**

**_Further reading:_**