> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [juejin.cn](https://juejin.cn/post/7257321872425058359)

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2d8bc4689808433a997fb2a5330d67dd~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

**本文详细解析了 Python 的 logging 模块，从基本介绍到实际应用和最佳实践。我们通过具体的代码示例解释了如何高效地使用这个模块进行日志记录，以及如何避免常见的陷阱，旨在帮助读者更好地掌握这个强大的工具。**

一、Python 日志模块简介
===============

日志的概念及其在软件开发中的作用
----------------

在开发过程中，为了记录应用程序的运行情况，通常我们会采用打印日志的方式，这种方式不仅可以帮助我们了解软件系统的运行状态，还可以在系统出现错误时，帮助我们快速定位问题。

例如，假设你有以下一段代码，它只是简单地输出一些信息：

```
print("This is some information.")
```

输出：

```
This is some information.
```

但是，如果我们需要记录更复杂的信息，如错误信息、警告或者其他重要的运行时信息，仅仅使用 print 就显得力不从心。这就是我们需要日志模块的地方。

Python logging 日志模块简介
---------------------

Python 内置的 logging 模块为我们提供了一套完整的日志记录解决方案。在许多情况下，你可能希望你的应用程序能够在运行时输出某种形式的状态信息，特别是当应用程序需要处理长时间运行的任务，或者当你面临需要诊断的问题时，logging 模块便是你的得力助手。

logging 模块可以帮助我们捕获、处理和记录日志信息，使得我们可以在程序运行的任何地方快速记录日志信息。相比于简单的 print 函数，它更具有灵活性，能够同时输出日志到多个地方，如：控制台、文件、HTTP GET/POST，SMTP，Socket 等，并且可以独立设置每个输出的日志等级。

以下是一个简单的例子来说明如何使用 logging 模块：

```
import logging

# Create a logger and set the log level to INFO
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# Add a StreamHandler to send log messages to console
console_handler = logging.StreamHandler()
logger.addHandler(console_handler)

# Log an informational message
logger.info("This is an informational message.")
```

这段代码会输出以下信息到控制台：

```
This is an informational message.
```

logging 模块的基本组成
---------------

logging 模块主要由以下几个部分组成：

Logger： 用于提供应用程序直接使用的接口。

Handler： 将（logger 产生的）日志记录发送到合适的目的输出。

Filter： 提供了更精细的工具来决定输出哪些日志记录。

Formatter： 指定日志记录的最终输出格式。

二、logging 日志模块详解
================

logging 的基础使用
-------------

使用 Python 的 logging 模块相当简单，下面是一个基本的例子，说明如何创建一个日志并输出到控制台。

```
import logging

# This will log the message to the console
logging.warning('This is a warning message')
```

这段代码将输出以下警告信息：

```
WARNING:root:This is a warning message
```

理解日志级别
------

在 logging 模块中，我们有 5 个级别来描述日志的重要性。这些级别分别是：

DEBUG：详细信息，通常仅在诊断问题时使用。

INFO：确认事情按预期进行。

WARNING：出现了一些预期之外的事情，或者在不久的将来可能出现问题（例如，“磁盘空间不足”）。但是软件仍在正常工作。

ERROR：由于更严重的问题，软件不能执行某些功能。

CRITICAL：严重的错误，表明程序本身可能无法继续运行。

默认情况下，logging 模块将日志记录到控制台，并且只处理级别为 WARNING 以上的日志。

Loggers、Handlers 和 Formatters
-----------------------------

这一部分我们将会详解 Loggers、Handlers 和 Formatters 这三个主要组件。

### Loggers 的作用和使用

Logger 是一个日志对象，主要任务就是记录日志。在应用程序代码中任何需要日志的地方，都可以创建一个 logger 实例，并用其记录需要的信息。下面是一个简单的使用 logger 的例子：

```
import logging

# Create a logger
logger = logging.getLogger(__name__)

# Log some messages
logger.debug("This is a debug message.")
logger.info("This is an informational message.")
logger.warning("Careful! Something does not look right.")
logger.error("You have encountered an error.")
logger.critical("The program cannot recover from this situation!")
```

注意：当我们运行这段代码时，我们并没有看到任何输出。这是因为默认情况下，logger 的级别设置为 WARNING，因此只有级别为 WARNING 以上的日志会被处理。

### Handlers 的种类和作用

Handler 对象负责发送日志记录到合适的目的地。不同的 handler 可以将日志发送到控制台，文件，邮件，甚至 HTTP POST 参数等。下面是一个简单的例子，说明如何使用 handler 将日志记录到文件和控制台：

```
import logging

# Create a logger
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# Create a file handler
file_handler = logging.FileHandler('my_log.log')
logger.addHandler(file_handler)

# Create a console handler
console_handler = logging.StreamHandler()
logger.addHandler(console_handler)

# Log some messages
logger.debug("This is a debug message.")
logger.info("This is an informational message.")
logger.warning("Careful! Something does not look right.")
logger.error("You have encountered an error.")
logger.critical("The program cannot recover from this situation!")
```

### Formatters 的功能和自定义日志格式

Formatter 对象指定日志记录的最终顺序，结构和内容。你可以自定义日志信息的格式，使得日志信息更具有可读性。下面是一个如何使用 formatter 的例子：

```
import logging

# Create a logger
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# Create a console handler
console_handler = logging.StreamHandler()

# Create a formatter
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# Add the formatter to the console handler
console_handler.setFormatter(formatter)

# Add the console handler to the logger
logger.addHandler(console_handler)

# Log some messages
logger.debug("This is a debug message.")
logger.info("This is an informational message.")
logger.warning("Careful! Something does not look right.")
logger.error("You have encountered an error.")
logger.critical("The program cannot recover from this situation!")
```

三、Python 日志模块在实践中的应用
--------------------

使用日志记录异常信息
----------

在 Python 编程中，经常需要捕获和处理异常。这时，使用 logging 模块记录异常信息会非常方便。在 logging 模块中，我们可以使用 exception () 方法记录异常堆栈信息。如下例所示：

```
import logging

logger = logging.getLogger(__name__)

try:
    a = [1, 2, 3]
    value = a[3]
except IndexError as e:
    logger.error("Unhandled exception", exc_info=True)
		```
当运行此段代码，日志记录器将记录下出现的异常信息，如下：

```python
ERROR:__main__:Unhandled exception
Traceback (most recent call last):
  File "<stdin>", line 4, in <module>
IndexError: list index out of range
```

使用 RotatingFileHandler 进行日志滚动
-----------------------------

当我们的应用程序运行很长时间，并产生大量的日志时，所有的日志都写入一个文件可能会导致这个日志文件过大。这时，我们可以使用 RotatingFileHandler 来进行日志滚动。当达到一定的大小或者一定的时间，RotatingFileHandler 会自动备份当前日志文件，并创建一个新的日志文件继续写入。如下例所示：

```
import logging
from logging.handlers import RotatingFileHandler

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# Create a file handler
handler = RotatingFileHandler('my_log.log', maxBytes=2000, backupCount=10)
logger.addHandler(handler)

# Log some messages
for _ in range(10000):
    logger.info("Hello, world!")
		```
这段代码将在日志文件大小达到2000字节时创建一个新的日志文件，并保留最新的10个日志文件。

## 配置日志级别
根据我们的需要，可以在运行时改变日志的级别。例如，当我们在调试应用程序时，我们可能需要输出所有级别的日志。但是在生产环境中，我们可能只关心错误及以上级别的日志。我们可以通过setLevel()函数来改变日志级别。如下例所示：
```python
import logging

# Create a logger
logger = logging.getLogger(__name__)

# Set log level to DEBUG
logger.setLevel(logging.DEBUG)

# Log some messages
logger.debug("This is a debug message.")
logger.info("This is an informational message.")
logger.warning("Careful! Something does not look right.")
logger.error("You have encountered an error.")
logger.critical("The program cannot recover from this situation!")
```

四、Python 日志模块的最佳实践
==================

在模块级别使用__name__创建 logger
------------------------

在 Python 中，__name__变量是一个内置变量，它代表当前模块的名称。当我们在每个模块级别上创建 logger 并使用__name__作为名称，我们可以轻松地追踪日志记录发生在哪个模块。

```
import logging

# Create a logger at the module level
logger = logging.getLogger(__name__)
```

使用合适的日志级别
---------

不同的日志级别表示了不同的严重性。正确地使用日志级别可以帮助我们在大量的日志中找到我们关心的信息。一般来说，对于非常严重的错误，我们应使用 CRITICAL 或 ERROR；对于警告信息，我们应使用 WARNING；对于常规的运行信息，我们应使用 INFO；对于调试信息，我们应使用 DEBUG。

使用结构化的日志消息
----------

当我们的应用程序有大量的日志时，我们可能希望以一种可解析的方式记录日志消息。例如，我们可以使用 JSON 格式记录日志。这样，我们就可以使用各种日志分析工具分析日志。

```
import logging
import json

# Create a logger
logger = logging.getLogger(__name__)

# Log a structured message
logger.info(json.dumps({
    'action': 'User login',
    'username': 'user123',
    'ip_address': '123.123.123.123',
    'status': 'success',
}))
```

使用异常日志记录
--------

当捕获到异常时，我们应使用 logger.exception ()，这样就可以在日志中记录下完整的异常堆栈信息。

```
import logging

logger = logging.getLogger(__name__)

try:
    x = 1 / 0
except ZeroDivisionError:
    logger.exception("Zero Division Error Caught.")
```

这样的日志会包含足够的信息帮助我们找到和修复问题。

不要在日志中记录敏感信息
------------

日志可能被攻击者用来寻找系统的漏洞，因此我们绝对不能在日志中记录敏感信息，如密码、密钥和用户的私有数据。

五、总结
====

在这篇文章中，我们详细介绍了 Python 的 logging 模块，包括它的基本介绍，详解，实践中的应用，以及一些最佳实践。总结上述内容：

1.  logging 模块是 Python 内置的一种灵活且强大的日志记录工具，它可以将程序运行过程中的信息输出到各种输出源，如标准输出、文件、邮件、网络等。
2.  logging 模块提供了多种级别的日志记录，包括 DEBUG，INFO，WARNING，ERROR 和 CRITICAL。我们可以根据需求设置不同的日志级别，以记录和展示不同严重性的信息。
3.  在实践中，我们可以使用 logging 模块来记录异常信息，使用 RotatingFileHandler 进行日志滚动，以及在运行时改变日志级别。
4.  对于 logging 模块的最佳实践，我们提到了在模块级别使用__name__创建 logger，使用合适的日志级别，使用结构化的日志消息，使用异常日志记录，以及不在日志中记录敏感信息。

**Python 的 logging 模块是一个非常强大的工具，希望你在阅读本文后能有更深的理解和更灵活的运用。**

> 如有帮助，请多关注 个人微信公众号：【Python 全视角】 TeahLead_KrisChang，10 + 年的互联网和人工智能从业经验，10 年 + 技术和业务团队管理经验，同济软件工程本科，复旦工程管理硕士，阿里云认证云服务资深架构师，上亿营收 AI 产品业务负责人。