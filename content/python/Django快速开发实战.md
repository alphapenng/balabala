<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-02-06 12:57:01
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-03-26 08:50:12
 * @FilePath: /balabala/content/private/Django快速开发实战.md
-->

# Django 快速开发实战

- [Django 快速开发实战](#django-快速开发实战)
  - [初识 Django \& 开发环境准备](#初识-django--开发环境准备)
    - [脉络思维导图](#脉络思维导图)
    - [Django 的 MTV 架构](#django-的-mtv-架构)
    - [VSCode 配置 Django 开发环境](#vscode-配置-django-开发环境)
  - [使用 Django 创建一个基础应用：职位管理系统](#使用-django-创建一个基础应用职位管理系统)
    - [产品需求](#产品需求)
    - [职位管理系统-建模](#职位管理系统-建模)
    - [职位列表展示](#职位列表展示)
    - [职位详情页](#职位详情页)
  - [产品实战：如何在1天之内交付一个招聘评估系统](#产品实战如何在1天之内交付一个招聘评估系统)
    - [线下流程](#线下流程)
    - [迭代思维与 MVP 产品规划方法（OOPD）](#迭代思维与-mvp-产品规划方法oopd)
    - [如何找出产品的 MVP 功能范围？](#如何找出产品的-mvp-功能范围)
    - [用户场景和功能清单：找出必须的功能](#用户场景和功能清单找出必须的功能)
    - [数据建模 \& 企业级数据库设计原则](#数据建模--企业级数据库设计原则)
    - [创建应用和模型，分组展示页面内容](#创建应用和模型分组展示页面内容)
    - [实现候选人数据导入](#实现候选人数据导入)
    - [候选人列表筛选和查询](#候选人列表筛选和查询)
    - [企业域账号集成](#企业域账号集成)
    - [面试官的导入、授权](#面试官的导入授权)
    - [增加自定义的数据操作菜单（数据导出为 CSV）](#增加自定义的数据操作菜单数据导出为-csv)
    - [日志记录](#日志记录)
    - [生产环境与开发环境配置分离](#生产环境与开发环境配置分离)
    - [产品细节完善](#产品细节完善)
  - [产品实战：用 1 天时间完善产品 —— 简历投递和面试流程闭环](#产品实战用-1-天时间完善产品--简历投递和面试流程闭环)
    - [更美观的管理后台：替换 Django admin 的主题风格](#更美观的管理后台替换-django-admin-的主题风格)
    - [定制面试官权限](#定制面试官权限)
    - [系统报错功能：钉钉群消息集成 \& 通知一面面试官](#系统报错功能钉钉群消息集成--通知一面面试官)
    - [允许候选人注册登录：集成 Registration](#允许候选人注册登录集成-registration)
    - [候选人简历存储：创建简历 Model](#候选人简历存储创建简历-model)
    - [让候选人可以在线投递简历](#让候选人可以在线投递简历)
    - [使用 Bootstrap 来定制页面样式](#使用-bootstrap-来定制页面样式)
    - [简历评估 \& 安排一面面试官](#简历评估--安排一面面试官)
    - [定制列表字段，查看简历详情](#定制列表字段查看简历详情)
  - [日常开发中常见的复杂场景：Django 进阶开发实战](#日常开发中常见的复杂场景django-进阶开发实战)
    - [遗留系统集成：为已有数据库生成管理后台](#遗留系统集成为已有数据库生成管理后台)
    - [Django 的中间件（Middleware）](#django-的中间件middleware)
    - [创建请求日志、性能日志记录中间件](#创建请求日志性能日志记录中间件)
    - [在 Django 中支持多语言](#在-django-中支持多语言)
    - [错误和异常日志上报：Sentry 集成](#错误和异常日志上报sentry-集成)
    - [错误和异常日志上报：捕获异常上报到 Sentry 并发送钉钉群通知](#错误和异常日志上报捕获异常上报到-sentry-并发送钉钉群通知)
    - [Django 安全防护：防止 XSS 跨站脚本攻击](#django-安全防护防止-xss-跨站脚本攻击)
    - [Django 安全防护：CSRF 跨站请求伪造和 SQL 注入攻击](#django-安全防护csrf-跨站请求伪造和-sql-注入攻击)
    - [Django Rest Framework 开放 API](#django-rest-framework-开放-api)
    - [在 Django 中使用缓存 \& Redis 的使用](#在-django-中使用缓存--redis-的使用)
    - [Django 与 Celery 集成： Celery 的使用](#django-与-celery-集成-celery-的使用)
    - [Django 与 Celery 集成： 异步任务](#django-与-celery-集成-异步任务)
  - [生产环境部署与应用监控告警](#生产环境部署与应用监控告警)
  - [回顾产品的快速迭代开发过程](#回顾产品的快速迭代开发过程)
  - [通往 Hacker 之路](#通往-hacker-之路)

## 初识 Django & 开发环境准备

### 脉络思维导图

![脉络思维导图](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230206130041_%E3%80%8ADjango%E5%BF%AB%E9%80%9F%E5%BC%80%E5%8F%91%E5%AE%9E%E6%88%98%E3%80%8B%E8%AF%BE%E7%A8%8B%E8%84%89%E7%BB%9C.png)

### Django 的 MTV 架构

![MTV 架构](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230206130253_Tixn8j.png)

### VSCode 配置 Django 开发环境

1. 为 Django 创建项目环境

    - 创建虚拟环境

        ```bash
        # 创建项目文件夹
        mkdir django
        # 进入项目文件夹
        cd django
        # 用 pyenv 选择合适的 python 版本
        pyenv local 3.9.7
        # 创建虚拟环境
        python -m venv .venv
        # 激活虚拟环境
        source .venv/bin/activate
        ```

    - 运行项目文件夹

        ```bash
        # 在项目文件夹 django 下键入
        code .
        ```

    - 选择 python 解释器

        打开 VSCode 后默认会自动载入 Python 解释器，如未载入，打开命令选项板（视图 > 命令选项板或（ Cmd + Shift + P））。然后选择 Python：Select Interpreter 命令，该命令提供了 VSCode 可以自动定位的可用解释器列表。从列表中，选择项目文件夹中以 `./.venv` 开头的虚拟环境。

2. 创建并运行最小的 Django 应用程序

    - 安装 Django

        ```bash
        # 在项目文件夹 django 下
        pip install django
        ```

    - 创建 Django 项目

        ```bash
        # 还是在项目文件夹 django 下
        django-admin startproject web_project
        ```

    - 运行并验证 Django 项目

        ```bash
        # 切换至 web_project 目录下
        python manage.py runserver 0.0.0.0:8080
        ```

        在浏览器中输入 `http://127.0.0.1:8080` 来访问项目

3. 创建调试器启动配置文件

    除了输入 `python manage.py runserver` 启动外，还可以在调试里面点击调试按钮启动程序，但需要在 VSCode 代码中创建自定义启动配置文件。

    切换到 VS 代码中的调试视图（使用左侧活动栏）。在调试视图的顶部，您可能会在齿轮图标上看到 “没有配置” 和一个警告点。这两个指标都意味着您还没有 `launch.json` 包含调试配置的文件：

    ![debug](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230206172127_HljHkm.jpg)

    选择齿轮图标并等待几秒钟，以便 VSCode 创建并打开 `launch.json` 文件。该 `launch.json` 文件包含许多调试配置，每个配置都是一个单独的 JSON configuration 数组中的对象。

    向下滚动并检查名称为 “Python：Django” 的配置：

    ![django_config](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230206201910_oOyTX8.jpg)

    此配置告诉 VSCode "${workspaceFolder}/web_project/manage.py"(注意 manage.py 文件的路径是否正确) 使用选定的 Python 解释器和 args 列表中的参数运行。

    然后使用此配置启动 VSCode 调试器与 `python manage.py runserver --noreload` 使用激活的虚拟环境在 VSCode 终端中运行相同。（您可以添加一个端口号就像 "8080" 到 args，如果需要的话。）

    配置文件 `launch.json` 添加内容如下：

    ```json
    {
        "name": "Python: Django",
        "type": "python",
        "request": "launch",
        "program": "${workspaceFolder}/web_project/manage.py",
        "args": ["runserver", "--nothreading", "0.0.0.0:8080"],
        "django": true,
        "justMyCode": true
    }
    ```

    保存配置文件后，在调试配置下拉列表（读取 Python：当前文件）中，选择 Python：Django 配置。

    按 `F5` 来开启调试，按 `Shift F5` 停止调试。

4. 如何访问管理后台

    ```bash
    # 进入 web-project 目录下
    cd web-project
    # 运行迁移命令,迁移数据库
    python manage.py makemigrations
    # 添加 Model
    python manage.py migrate
    # 创建超级管理员
    python manage.py createsuperuser
    ```

## 使用 Django 创建一个基础应用：职位管理系统

### 产品需求

1. 管理员能够发布职位
2. 匿名用户能够浏览职位
3. 匿名用户能够投递职位

### 职位管理系统-建模

![职位管理系统-建模](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226133926_kRxv2x.png)

1. 新建一个 jobs 应用

    ```bash
    # 进入 recruitment 项目目录下
    cd recruitment
    # 创建 jobs 应用
    python manage.py startapp jobs
    # 将 jobs 应用添加到 settings.py 里的 INSTALLED_APPS 里
    ```

2. 定义职位模型

    ![定义职位模型](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226135154_IMG_0553.PNG)

3. 把 Model 注册到管理后台 admin 里

    ![注册Model](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226141850_IMG_6A03C49111AF-1.jpeg)

4. 初始化数据库

    ```bash
    python manage.py makemigrations
    python manage.py migrate
    ```

5. 进入 Jobs 添加职位

6. 定义职位的列表页展示哪些字段

    ![定义职位的列表页展示哪些字段](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226151354_IMG_C1D43E3D2084-1.jpeg)

7. 隐藏职位编辑页面中的创建人、创建日期、修改时间

    ![隐藏字段](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226152157_IMG_26634E75441E-1.jpeg)

    在 Model 中通过在 `created_date` 和 `modified_date` 字段上添加 `default` 参数来自动生成创建日期、修改时间。
    ![自动生成创建日期修改时间](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226153012_2zOH2d.png)

### 职位列表展示

- 列表页是独立页面，使用自定义的页面
- 添加如下页面
  - 职位列表页
  - 职位详情页
- 匿名用户可以访问

💁 **Django 自定义模板**

- 模版继承与块（Template Inheritance & Block）
  - 模版继承允许定义一个骨架模版，骨架包含站点上的公共元素（如头部导航、尾部链接）
  - 骨架模版里面可以定义 Block 块，每一个 Block 块都可以在继承的页面上重新定义/覆盖
  - 一个页面可以继承自另一个页面

- 定义一个匿名访问页面的基础页面，基础页面中定义页头
- 添加页面 job/templates/base.html

1. Base 模版

    ![Base模版](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226155712_crtPS8.png)

2. 添加职位列表页模版 - 继承自 base.html

    ![职位列表页模版](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226160116_jKz5t9.png)

    ![模版内容自动转义](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226160609_6foEva.png)

3. 职位列表的视图

    ![职位列表的视图](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226162122_99h0gi.png)

4. 添加 URL 路径映射

    ![添加URL路径映射](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226162710_sAUR75.png)

5. 应用（app）的所有 URL 定义加入到项目（recruitment）中

    ![应用的所有url定义加入到项目中](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226164826_3NEBzI.png)

### 职位详情页

- 详情页模版 - 定义内容呈现（Template）
- 详情页视图 - 获取数据逻辑（View）
- 定义 URL 路由

1. 详情页模版

    ![详情页模版](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226170940_LTlfq0.png)

2. 详情页视图和 URL 路由

    ![详情页视图和 URL 路由](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226171149_munAK1.png)

## 产品实战：如何在1天之内交付一个招聘评估系统

### 线下流程

1. 准备简历 & 面试评估表

    - HR：发出面试评估表模版（Word）到一面面试官（邮箱发出来）
    - 一面面试官：登录邮箱下载 Word 模版，每个学生拷贝一份
    - 按学生名字命名文件，录入学生名字，学校，电话，学历等

2. 第一轮面试

    - 一面官：每面完一个学生，填写 Word 格式的评估表中
    - 一面官：面完一天的学生后，批量把 Word 文档 Email 到 HR
    - HR：晚上查收下载评估表，汇总结果到 Excel，通知学生复试
    - HR：同时把已经通知复试的学生信息，发送到技术二面复试官

3. 第二轮面试和 HR 面试

    - 二面官：查收 Email， 下载 Word 格式的一面评估记录
    - 二面官：复试后追加复试的评估到 Word 记录中，邮件到 HR
    - 类似如上步骤的 HR 复试。

### 迭代思维与 MVP 产品规划方法（OOPD）

- MVP：minimum viable product，最小可用产品
- OOPD：Online & Offline Product Development，线上线下相结合的产品开发方法
  - 内裤原则：MVP 包含了产品的轮廓，核心的功能，让业务可以运转
  - 优先线下：能够走线下的，优先走线下流程，让核心的功能先跑起来，快速做用户验证和方案验证
  - MVP 的核心：忽略掉一切的细枝末节，做合适的假设和简化，使用最短的时间开发出来
- 迭代思维是最强大的产品思维逻辑，互联网上唯快不破的秘诀
- 优秀的工程师和优秀的产品经理，善于找出产品 MVP 功能范围

### 如何找出产品的 MVP 功能范围？

💁 使用这些问题来帮助确定范围

- 产品的核心目标是什么？核心用户是谁？核心的场景是什么？
- 产品目标都需要在线上完成或者呈现吗？
- 最小 MVP 产品要做哪些事情，能够达到业务目标？
- 哪些功能不是在用户流程的核心路径上的？
- 做哪些简化，和假设，能够在最短的时间交付产品，并且可以让业务流程跑起来？

### 用户场景和功能清单：找出必须的功能

|角色|功能|是否必须|
|---|---|---|
|HR|可以管理职位|
|候选人|可以浏览职位列表，详情|
|候选人|可以在线投递简历|
|HR|查看候选人投递的简历，审核简历|
|HR|导入候选人|
|HR|**添加，修改候选人，查看候选人列表**|
|管理员|可以添加面试官|
|面试官|**可以进行一面、二面；HR可以进行终面**|
|管理员|能够管理HR，面试官的角色|
|HR/面试官|HR和面试官只能看到有权限的内容|

- 定义最小可用的面试评估系统
- 哪些是可以线下人肉做的事情
- 可以做出哪些假设来简化产品

### 数据建模 & 企业级数据库设计原则

- 数据建模

    ![数据建模](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230226200601_3rfQOG.png)

- 企业级数据库设计十个原则

  **3个基础原则，4个扩展性原则，3个完备性原则**

  💁 **3个基础原则**

  - 结构清晰：表明、字段命名没有歧义，能一眼看懂
  - 唯一职责：一表一用，领域定义清晰，不存储无关信息，相关数据在一张表中
  - 主键原则：设计不带物理意义的主键；有唯一约束，确保幂等

  💁 **4个扩展性原则（影响系统的性能和容量）**

  - 长短分离：可以扩展，长文本独立存储；有合适的容量设计
  - 冷热分离：当前数据与历史数据分离
  - 索引完备：有合适索引方便查询
  - 不使用关联查询：不使用一切的 SQL join 操作，不做 2 个表或者更多表的关联查询
    - 示例：查询商家每一个订单的金额
    - `select s.shop_name, o.id as order_id, o.total_amount from shop s,order o where s.id = o.shop_id

  💁 **3个完备性原则**
  
  - 完整性：保证数据的准确性和完整性，重要的内容都有记录
  - 可追溯：可追溯创建时间，修改时间，可以逻辑删除
  - 一致性原则：数据之间保持一致，尽可能避免同样的数据存储在不同表中

### 创建应用和模型，分组展示页面内容

- 创建应用

    ```bash
    python ./manage.py startapp interview
    ```

- 注册应用

    在 `settings.py` 中添加 `interview` 应用

- 添加模型

    在 `interview/models.py` 里面定义 `Candidate` 类

  💁 **参考资料**

  - 使用 MOdel 模型

    <https://developer.mozilla.org/zh-CN/docs/Learn/Server-side/Django/Models>

    <https://docs.djangoproject.com/en/3.1/topics/db/models/>

  - 使用 Admin 管理类

    <https://developer.mozilla.org/zh-CN/docs/Learn/Server-side/Django/Admin_site>

    <https://docs.djangoproject.com/en/3.1/ref/contrib/admin/>

- 在 `admin.py` 中添加 `admin.site.register(Candidate)`
- 初始化数据库

    ```bash
    python ./manage.py makemigrations
    python ./manage.py migrate
    ```

- 定义需要展示哪些字段

    在 `admin.py` 中添加：

    ```python
    class CandidateAdmin(admin.ModelAdmin):
        exclude = ('creator', 'created_date', 'modified_date')

        list_display = (
            'username', 'city', 'bachelor_school', 'first_score', 'first_result', 'first_interviewer_user', 'second_score',
            'second_result', 'second_interviewer_user', 'hr_score', 'hr_result', 'hr_interviewer_user',)
    ```

    ```python
    admin.site.register(Candidate, CandidateAdmin)
    ```

- 分组展示

    ```python
    class CandidateAdmin(admin.ModelAdmin):
        fieldsets = (
            (None, {'fields': ("userid", "username", "city", "phone", "email", "apply_position", "born_address", "gender", "candidate_remark", "bachelor_school",
            "master_school", "doctor_school", "major", "degree", "test_score_of_general_ability", "paper_score", "last_editor")}),
            ("第一轮面试记录", {'fields': ("first_score", "first_learning_ability", "first_professional_competency", "first_advantage",
            "first_disadvantage", "first_result", "first_recommend_position", "first_interviewer_user", "first_remark")}),
            ("第二轮专业复试记录", {'fields': ("second_score", "second_learning_ability", "second_professional_competency", "second_pursue_of_excellence", "second_communication_ability",
            "second_pressure_score", "second_advantage", "second_disadvantage", "second_result", "second_recommend_position", "second_interviewer_user", "second_remark")}),
            ("HR复试记录", {'fields': ("hr_score", "hr_responsibility", "hr_communication_ability", "hr_logic_ability",
            "hr_potential", "hr_stability", "hr_advantage", "hr_disadvantage", "hr_result", "hr_interviewer_user", "hr_remark")})
        )
    ```

- 多行在一行里面展示

    ```python
    class CandidateAdmin(admin.ModelAdmin):
        fieldsets = (
            (None, {'fields': ("userid", ("username", "city", "phone"), ("email", "apply_position", "born_address"), ("gender", "candidate_remark"), ("bachelor_school",
            "master_school", "doctor_school"), ("major", "degree"), ("test_score_of_general_ability", "paper_score"), "last_editor")})
        )
    ```

### 实现候选人数据导入

- 怎么样实现一个数据导入的功能最简洁
  - 开发一个自定义的 Web 页面，让用户能够上传 excel/csv 文件
  - 开发一个命令行工具，读取 excel/csv，再访问数据库写入 DB
  - 从数据库的客户端，比如 MySQL 的客户端里面导入数据

- Django 框架已经考虑到（需要使用到命令行的场景）
  - 使用自定义的 django management 命令来导入数据
  - 应用下面创建 management/commands 目录，
  - commands 目录下添加脚本 `import_candidates.py`，创建类，继承自 BaseCommand，实现命令行逻辑

    ```python
    import csv

    from django.core.management import BaseCommand
    from interview.models import Candidate

    class Command(BaseCommand):
    help = "从一个CSV文件的内容中读取候选人列表，导入到数据库中"

    def add_arguments(self, parser):
        parser.add_argument("--path", type=str)

    def handle(self, *args, **options):
        path = options["path"]
        with open(path, "rt", encoding="gbk") as f:
            reader = csv.reader(f, dialect="excel", delimiter=";")
            for row in reader:
                candidate = Candidate.objects.create(
                    username=row[0],
                    city=row[1],
                    phone=row[2],
                    bachelor_school=row[3],
                    major=row[4],
                    degree=row[5],
                    test_score_of_general_ability=row[6],
                    paper_score=row[7]
                )
                print(candidate)
    ```

- 候选人数据导入

    ```bash
    python manage.py import_candidates --path candidates.csv
    ```

### 候选人列表筛选和查询

- 能够按照名字、手机号码、学校来查询候选人信息
- 能够按照初试结果，复试结果，HR复试结果，面试官来筛选；能按照复试结果来排序

    在 `admin.py` 中添加：

    ```python
    class CandidateAdmin(admin.ModelAdmin):
        # 右侧筛选条件
        list_filter = ('city', 'first_result', 'second_result', 'hr_result',
                    'first_interviewer_user', 'second_interviewer_user', 'hr_interviewer_user')
        # 查询字段
        search_fields = ('username', 'phone', 'email', 'bachelor_school')

        # 列表页排序字段
        ordering = ('hr_result', 'second_result', 'first_result')
    ```

### 企业域账号集成

- 什么是目录服务 Directory Service？

    目录服务是一个提供资源服务的定位查找功能的存储系统。在软件工程里一个目录是指一组名字和值的映射。它允许根据一个给定的名字来查找对应的值，跟词典类似的。目录可以有树状的结构，典型的目录有域名，然后有企业组织架构，这些都可以使用目录服务来存储其中的信息。

- 什么是 `OpenLDAP`？

    `OpenLDAP` 是开放的 LDAP 服务，LDAP 是 Lightweight Directory Access Protocol，轻量级目录访问协议。

- 可以直接使用域账号登录
- 不用手工添加账号，维护独立密码
- 可以集成 OpenLDAP/ActiveDirectory
- 我们项目种选择 OpenLDAP
- 以 OpenLDAP 为例：
  - DN：DistinguishedName 目录服务中的一个唯一的对象
    - CN：CommonName David
    - OU：OrganizationUnit Shanghai
    - DC：DomainComponent ihopeit，com
- Open LDAP 服务搭建
  - Docker 启动 OpenLDAP 服务 & phpldapadmin-service
  - docker 启动 openldap

    ```bash
    docker run -p 389:389 -p 636:636 --name my-openldap-container --env LDAP_ORGANISATION="ihopeit" --env LDAP_DOMAIN="ihopeit.com" --env LDAP_ADMIN_PASSWORD="admin_passwd_4_ldap" --detach osixia/openldap:1.4.0
    ```

  - docker 启动 phpldapadmin

    ```bash
    docker run -p 80:80 -p 443:443 --name phpldapadmin-service --hostname phpldapadmin-service --link my-openldap-container:ldap-host --env PHPLDAPADMIN_LDAP_HOSTS=ldap-host --detach osixia/phpldapadmin:0.9.0
    ```

  - ⚠️ 注意：以上命令开放了 389 端口， 以及 443 端口到外网，需要在安全组里面开放 389， 443 端口。⚠️

- 系统里配置 OpenLDAP
  - Djanog 项目里安装 `django-python3-ldap`

    在项目目录下执行 `pip install django-python3-ldap`

  - 在应用里加载

    在项目目录配置文件夹 `recruitment` 下的 `settings.py` 文件里 `INSTALLED_APPS` 下添加 `django_python3–ldap`

    并进行 LDAP 的配置

    ```python
    # LDAP
    # THE URL of the LDAP server.

    LDAP_AUTH_URL = "ldap://<server-ip>:389"

    # Initiate TLS on connection.

    LDAP_AUTH_USE_TLS = False

    # The LDAP search base for looking up users.
    LDAP_AUTH_SEARCH_BASE = "dc=ihopeit,dc=com"
    # The LDAP class that represents a user.
    LDAP_AUTH_OBJECT_CLASS = "inetOrgPerson"

    # USer model fields mapped to the LDAP
    # attributes that represent them.
    LDAP_AUTH_USER_FIELDS = {
        "username": "cn",
        "first_name": "givenName",
        "last_name": "sn",
        "email": "mail",
    }

    #A tuple of django model fields used to uniquely identify a user.
    LDAP_AUTH_USER_LOOKUP_FIELDS = ("username", )

    # Path to a callable that takes a dict of {model_field_name: value},
    # returning a dict of clean model data.
    # Use this to customize how data loaded from LDAP is saved to the User model.
    LDAP_AUTH_CLEAN_USER_DATA = "django_python3_ldap.utils.clean_user_data"

    # The LDAP username and password of a user for querying the LDAP database for user
    # details. If None, then the authenticated user will be used for querying, and
    # the `Ldap_syne_users` command will perform an anonymous query.
    LDAP_AUTH_CONNECTION_USERNAME = "admin"

    LDAP_AUTH_CONNECTION_PASSWORD = "admin_passwd_4_ldap"

    AUTHENTICATION_BACKENDS = {"django_python3_ldap.auth.LDAPBackend", 'django.contrib.auth.backends.ModelBackend' , }
    ```

### 面试官的导入、授权

- 从 OpenLDAP/AD 中导入面试官信息
  - 同步账号到 Django

      ```python
      python manage.py ldap_sync_users
      ```

  - 设置面试官群组，授予群组权限；查看应聘者、修改应聘者（评估）
  - 设置用户属性 is_staff 为 true：允许登录 Django Admin
  - 添加用户到群组：使得面试官登录后，可以填写反馈

### 增加自定义的数据操作菜单（数据导出为 CSV）

- 场景：需要对数据进行操作，比如导出，状态变更（如标记候选人为“带面试”）
- 定义按钮的实现逻辑（处理函数） & 在 ModelAdmin 中注册函数到 actions

    ![数据导出为CSV](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230302210950_5qTSql.png)

    在 admin.py 中添加：

    ```python
    from django.contrib import admin
    from django.http import HttpResponse

    # Register your models here.
    from datetime import datetime
    from interview.models import Candidate

    import csv

    exportable_fields = ('username', 'city', 'phone', 'bachelor_school', 'master_school', 'degree', 'first_result', 'first_interviewer_user',
                        'second_result', 'second_interviewer_user', 'hr_result', 'hr_score', 'hr_remark', 'hr_interviewer_user')


    def export_model_as_csv(modeladmin, request, queryset):
        response = HttpResponse(content_type="text/csv")
        field_list = exportable_fields
        response[
            'Content-Disposition'
        ] = f"attachment; filename=recruitment-candidates-list-{datetime.now().strftime('%Y-%m-%d-%H-%M-%S')}.csv"

        writer = csv.writer(response)
        writer.writerow(
            [queryset.model._meta.get_field(
                f).verbose_name.title() for f in field_list]
        )

        for obj in queryset:
            # 单行的记录（各个字段的值），写入到csv文件
            csv_line_values = []
            for field in field_list:
                field_object = queryset.model._meta.get_field(field)
                field_value = field_object.value_from_object(obj)
                csv_line_values.append(field_value)
            writer.writerow(csv_line_values)

        return response


    export_model_as_csv.short_description = "导出为csv文件"

    class CandidateAdmin(admin.ModelAdmin):
        actions = [export_model_as_csv,]
    ```

### 日志记录

- 四个组件
  - Loggers：日志记录的处理类/对象，一个 Logger 可以有多个 Handlers
  - Handlers：对于每一条日志消息如何处理，记录到文件，控制台，还是网络
  - Filters：定义过滤器，用于 Logger/Handler 之上
  - Formmaters：定义日志文本记录的格式
- 四个日志级别
  - DEBUG：调试
  - INFO：常用的系统信息
  - WARNING：小的告警，不影响主要功能
  - ERROR：系统出现不可忽视的错误
  - CRITICAL：非常严重的错误
- 配置日志记录
  - Django 里面使用 dictConfig 格式来配置日志
  - Dictionary 对象，至少包含如下内容：
    - version，目前唯一有效的值是 1
    - Handler，logger 是可选内容，通常需要自己定义
    - Filter，formatter 是可选内容，可以不用定义
  - 定义日志输出格式，分别定义全局日志记错，错误日志处理，自定义的日志处理器

    ```python
    LOGGING = {
        'version': 1,
        'disable_existing_loggers': False,
        'formatters': {
            'simple': {  # exact format is not important, this is the minimum information
                'format': '%(asctime)s %(name)-12s %(lineno)d %(levelname)-8s %(message)s',
            },
        },
        'handlers': {
            'console': {
                'class': 'logging.StreamHandler',
                'formatter': 'simple',
            },

            'mail_admins': {  # Add Handler for mail_admins for `warning` and above
                'level': 'ERROR',
                'class': 'django.utils.log.AdminEmailHandler',
            },
            'file': {
                # 'level': 'INFO',
                'class': 'logging.FileHandler',
                'formatter': 'simple',
                'filename': os.path.join(os.path.dirname(BASE_DIR), 'recruitment.admin.log'),
            },

            'performance': {
                # 'level': 'INFO',
                'class': 'logging.FileHandler',
                'formatter': 'simple',
                'filename': os.path.join(os.path.dirname(BASE_DIR), 'recruitment.performance.log'),
            },
        },

        'root': {
            'handlers': ['console', 'file'],
            'level': 'INFO',
        },

        'loggers': {
            "django_python3_ldap": {
                "handlers": ["console", "file"],
                "level": "DEBUG",
            },

            "interview.performance": {
                "handlers": ["console", "performance"],
                "level": "INFO",
                "propagate": False,
            },
        },
    }
    ```

- 使用日志记录
  - 记录 debug，info，warning，error，critical不同级别日志

    ```python
    import logging

    logger = logging.getLogger(__name__)

    logger.info(f"{request.user} exported {len(queryset)} candidate records")
    ```

### 生产环境与开发环境配置分离

- 问题
  - 生产环境的配置与开发环境配隔离开，开发环境允许 Debugging
  - 敏感信息不提交到代码库中，比如数据库连接，secret key，LDAP 连接信息等
  - 生产、开发环境使用的配置可能不一样，比如分别使用 MySQL/Sqlite 数据库
- 推荐方案
  - 把 `settings.py` 抽出来，创建 3 个配置文件
    - `bash.py` 基础配置
    - `local.py` 本地开发环境配置，允许 Debug
    - `production.py` 生产环境配置，不进到代码库版本控制
  - 命令行启动时指定环境配置
    - `python ./manage.py runserver 127.0.0.1:8000 --settings=settings.local`
    - 使得 manage.py 中的如下代码失效：`os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'settings.base')`

### 产品细节完善

- 修改站点标题

    在 `recruitment/urls.py` 中修改：

    ```python
    from django.utils.translation import gettext as _

    admin.site.site_header = _("匠果科技招聘管理系统")
    ```

- 设置字段提示 `help_text`：初试分，学习能力得分，专业能力得分范围 1-5 分

    在 `interview/models.py` 中修改：

    ```python
    first_score = models.DecimalField(decimal_places=1, null=True, max_digits=2, blank=True, verbose_name=u'初试分',
                                      help_text=u'1-5分，极优秀: >=4.5，优秀: 4-4.4，良好: 3.5-3.9，一般: 3-3.4，较差: <3分')
    ```

- 面试官信息与登录用户关联，面试官只有 HR 可以修改

  - 面试官信息与登录用户关联

    在 `interview/models.py` 中修改：

    ```python
    from django.contrib.auth.models import User

    first_interviewer_user = models.ForeignKey(
        User, related_name='first_interviewer_user', blank=True, null=True, on_delete=models.CASCADE, verbose_name=u'面试官')

    second_interviewer_user = models.ForeignKey(
        User, related_name='second_interviewer_user', blank=True, null=True, on_delete=models.CASCADE, verbose_name=u'二面面试官')

    hr_interviewer_user = models.ForeignKey(
        User, related_name='hr_interviewer_user', blank=True, null=True, on_delete=models.CASCADE, verbose_name=u'HR面试官')
    ```

  - 面试官只有 HR 可以修改

    在 `interview/admin.py`中修改：

    ```python
    # readonly_fields = ('first_interviewer_user', 'second_interviewer_user',)

    def get_group_names(self, user):
        return [g.name for g in user.groups.all()]

    def get_readonly_fields(self, request, obj):
        group_names = self.get_group_names(request.user)

        if 'interviewer' in group_names:
            logger.info(
                f"interviewer is in user's group for {request.user.username}")
            return ('first_interviewer_user', 'second_interviewer_user')
        return ()
    ```

- HR 角色，可以在列表页直接修改一面面试官，二面面试官：`list_editable` 属性

    在 `interview/admin.py`中修改：

    ```python
    default_list_editable = ('first_interviewer_user',
                             'second_interviewer_user')

    def get_list_editable(self, request):
        group_names = self.get_group_names(request.user)

        if request.user.is_superuser or 'hr' in group_names:
            logger.info(f"{request.user.username} is a super user of hr")
            return self.default_list_editable
        return ()

    def get_changelist_instance(self, request):
        """
        override admin method and list_editable property value
        with values returned by our custom method implementation.
        """
        self.list_editable = self.get_list_editable(request)
        return super(CandidateAdmin, self).get_changelist_instance(request)
    ```

## 产品实战：用 1 天时间完善产品 —— 简历投递和面试流程闭环

### 更美观的管理后台：替换 Django admin 的主题风格

- 安装 `django-grappelli` 风格
  - `pip install django-grappelli`
- `settings.py` 中设置
  - `INSTALLED_APPS = ('grappelli', 'django.contrib.admin',)`
- `recruitment/urls.py` 中添加 URL 映射：

    ```python
    urlpatterns = [
        re_path(r"^", include("jobs.urls")),
        path("grappelli/", include("grappelli.urls")),
        path("admin/", admin.site.urls),
    ]
    ```

### 定制面试官权限

- 数据权限：一面面试官仅填写一面反馈，二面面试官可以填写二面反馈
  - 专业面试官仅能评估自己负责的环节

    在 `interview/admin.py` 中修改：

    ```python
    from interview import candidate_field as cf

    class CandidateAdmin(admin.ModelAdmin):
        # 一面面试官仅填写一面反馈， 二面面试官可以填写二面反馈
        def get_fieldsets(self, request, obj=None):
            group_names = self.get_group_names(request.user)

            if 'interviewer' in group_names:
                if obj.first_interviewer_user == request.user:
                    return cf.default_fieldsets_first
                if obj.second_interviewer_user == request.user:
                    return cf.default_fieldsets_second
            return cf.default_fieldsets
    ```

- 数据集权限（QuerySet）：对于面试官，获取自己是一面面试官或者二面面试官的候选人集合
  - 专业面试官只能看到分到自己的候选人

    在 `interview/admin.py` 中修改：

    ```python
    from django.db.models import Q

    # 对于非管理员，非 HR，获取自己是一面面试官或者二面面试官的候选人集合：s
    def get_queryset(self, request):
        qs = super(CandidateAdmin, self).get_queryset(request)

        group_names = self.get_group_names(request.user)
        
        if request.user.is_superuser or 'hr' in group_names:
            return qs
        return Candidate.objects.filter(Q(first_interviewer_user=request.user) | Q(second_interviewer_user=request.user))
    ```

- 功能权限（菜单/按钮）：数据导出权限仅 HR 和超级管理员可用
  - 自定义权限：在 Model 类的 Meta 中定义自定义的 permissions

    在 `interview/models.py` 中修改：

    ```python
    class Meta:
        db_table = u'candidate'
        verbose_name = u'应聘者'
        verbose_name_plural = u'应聘者'

        permissions = [
            ("export", "Can export candidate list"),
            ("notify", "notify interviewer for candidate review"),
        ]
    ```

  - 同步数据库：`./manage.py makemigrations && ./manage.py migrate`
  - 在 action 上限制权限：`export_model_as_csv.allowed_permissions = ('export',)`
  - 在 Admin 上检查权限

    在 `interview/admin.py` 中修改：

    ```python
    export_model_as_csv.allowed_permissions = ('export',)

    class CandidateAdmin(admin.ModelAdmin):

        actions = [export_model_as_csv,]

        # 当前用户是否有导出权限：
        def has_export_permission(self, request):
            opts = self.opts
            return request.user.has_perm(f"{opts.app_label}.export")
    ```

### 系统报错功能：钉钉群消息集成 & 通知一面面试官
  
- 为什么不使用 Email/SMS 通知
  - 由于邮件、短信没有限制，可以给任何人发；网络上对于 API 调用有了各种限制
  - 阿里云封禁 25 端口
- 为什么使用钉钉群消息
  - 可以使用 Web Hook 直接发送，简单易用
  - 低成本
- 其他推荐消息方式
  - Slack 消息
  - 企业微信消息
- 测试钉钉群消息

    1. 安装钉钉聊天机器人：`pip install DingtalkChatbot`
    2. 在 `interview` 下新建 `dingtalk.py`

        ```python
        from dingtalkchatbot.chatbot import DingtalkChatbot

        from django.conf import settings

        def send(message, at_mobiles=[]):
            # 引用 settings里面配置的钉钉群消息通知的WebHook地址:
            webhook = settings.DINGTALK_WEB_HOOK

            # 初始化机器人小丁, # 方式一：通常初始化方式
            xiaoding = DingtalkChatbot(webhook)

            # 方式二：勾选“加签”选项时使用（v1.5以上新功能）
            # xiaoding = DingtalkChatbot(webhook, secret=secret)

            # Text消息@所有人
            xiaoding.send_text(msg=f'面试通知: {message}', at_mobiles = at_mobiles)
        ```

    3. 在 `recruitment/settings/base.py` 中添加：

        ```python
        DINGTALK_WEB_HOOK = ""
        ```

    4. 测试群消息
        - `python ./manage.py shell --settings=settings.local`
        - `from interview import dingtalk`
        - `dingtablk.send("秋季招聘面试启动通知，自 2020/09/01 开始秋季招聘“)`

- 定制管理后台的操作按钮：通知面试官准备面试
  - 定义通知面试官的方法

    在 `interview/admin.py` 中修改：

    ```python
    from interview import dingtalk

    def notify_interviewer(modeladmin, request, queryset):
        candidates = ""
        interviewers = ""
        for obj in queryset:
            candidates = f"{obj.username};{candidates}"
            interviewers = f"{obj.first_interviewer_user.username};{interviewers}"
        dingtalk.send(f"候选人{candidates}进入面试环节，亲爱的面试官，请准备好面试：{interviewers}")


    notify_interviewer.short_description = "通知一面面试官"
    ```

  - 注册到 modeladmin 中

    在 `interview/admin.py` 中修改：

    ```python
    class CandidateAdmin(admin.ModelAdmin):
        actions = (export_model_as_csv, notify_interviewer, )
    ```

### 允许候选人注册登录：集成 Registration

- 允许注册：安装 registration

    `pip install django-registration-redux`

- 添加到 apps 中

    在 `settings/base.py` 中添加：

    ```python
    INSTALLED_APPS = [
        "registration",
    ]
    ```

    在 `recruitmeng/urls.py` 中添加：

    ```python
    urlpatterns = [
        re_path(r"^", include("jobs.urls")),
        path("grappelli/", include("grappelli.urls")),
        path("admin/", admin.site.urls),
        re_path(r"^accounts/", include("registration.backends.simple.urls")),
    ]
    ```

- 同步数据库

    `python manage.py makemigrations`
    `python manage.py migrate`

- 添加登录，退出链接到页面中
  - 注册跳转、登录跳转

    在 `settings/base.py` 中添加：

    ```python
    LOGIN_REDIRECT_URL = '/'
    SIMPLE_BACKEND_REDIRECT_URL = '/accounts/login/'
    ```

  - 设置项目首页是招聘列表 joblist

    在 `jobs/urls` 中添加：

    ```python
    urlpatterns = [
    # 职位列表
        re_path(r"^joblist/", views.joblist, name="joblist"),
        re_path(r"^job/(?P<job_id>\d+)/$", views.detail, name="detail"),

        # 首页自动跳转到职位列表
        path("", views.joblist, name="name"),
    ]
    ```

### 候选人简历存储：创建简历 Model

- 修改 `jobs/templates/base.html`:

    ```html
    <h1 style="margin: auto; width: 50%">匠果科技开发职位</h1>

    <p></p>

    {% block header %}
    <div style="flex: 4">
    <a href="/" style="text-decoration: none; color: #007bff">首页</a>
    <a href="/joblist" style="text-decoration: none; color: #007bff">职位列表</a>

    {% if user.is_authenticated %}
    <a href="/accounts/logout" style="text-decoration: none; color: #007bff"
        >退出</a
    >
    {% else %}
    <a href="/accounts/login" style="text-decoration: none; color: #007bff"
        >登录</a
    >
    {% endif %} {% if user.is_authenticated %}
    <p>终于等到你 {{ user.username }}, 期待加入我们，用技术去探索一个新世界</p>
    {% else %}
    <p>
        欢迎你，期待加入我们，登陆后可以提交简历. <br />
        {% endif %}
    </p>
    </div>
    {% endblock %}
    <hr />
    {% block content %} {% endblock %}
    ```

- 修改 `jobs/views.py` 以在首页显示用户名
  
    ```python
    def joblist(request):
        job_list = Job.objects.order_by('job_type')
        context = {'job_list': job_list}
        for job in job_list:
            job.city_name = Cities[job.job_city][1]
            job.type_name = JobTypes[job.job_type][1]

        # return HttpResponse(template.render(context))
        return render(request, "joblist.html", context)
    ```

- 创建 Model

    在 `jobs/model.py` 中创建简历 model：

    ```python
    class Resume(models.Model):
        # Translators: 简历实体的翻译
        username = models.CharField(max_length=135, verbose_name=_('姓名'))
        applicant = models.ForeignKey(User, verbose_name=_(
            "申请人"), null=True, on_delete=models.SET_NULL)
        city = models.CharField(max_length=135, verbose_name=_('城市'))
        phone = models.CharField(max_length=135,  verbose_name=_('手机号码'))
        email = models.EmailField(max_length=135, blank=True, verbose_name=_('邮箱'))
        apply_position = models.CharField(
            max_length=135, blank=True, verbose_name=_('应聘职位'))
        born_address = models.CharField(
            max_length=135, blank=True, verbose_name=_('生源地'))
        gender = models.CharField(max_length=135, blank=True, verbose_name=_('性别'))
        picture = models.ImageField(
            upload_to='images/', blank=True, verbose_name=_('个人照片'))
        attachment = models.FileField(
            upload_to='file/', blank=True, verbose_name=_('简历附件'))

        # 学校与学历信息
        bachelor_school = models.CharField(
            max_length=135, blank=True, verbose_name=_('本科学校'))
        master_school = models.CharField(
            max_length=135, blank=True, verbose_name=_('研究生学校'))
        doctor_school = models.CharField(
            max_length=135, blank=True, verbose_name=u'博士生学校')
        major = models.CharField(max_length=135, blank=True, verbose_name=_('专业'))
        degree = models.CharField(
            max_length=135, choices=DEGREE_TYPE, blank=True, verbose_name=_('学历'))
        created_date = models.DateTimeField(
            verbose_name="创建日期", default=datetime.now)
        modified_date = models.DateTimeField(verbose_name="修改日期", auto_now=True)

        # 候选人自我介绍，工作经历，项目经历
        candidate_introduction = models.TextField(
            max_length=1024, blank=True, verbose_name=u'自我介绍')
        work_experience = models.TextField(
            max_length=1024, blank=True, verbose_name=u'工作经历')
        project_experience = models.TextField(
            max_length=1024, blank=True, verbose_name=u'项目经历')

        class Meta:
            verbose_name = _('简历')
            verbose_name_plural = _('简历列表')

        def __str__(self):
            return self.username
    ```

- 注册 Model 到 Admin 中，设置展示字段

    修改 `jobs/amdin.py`：

    ```python
    class ResumeAdmin(admin.ModelAdmin):

        list_display = ('username', 'applicant', 'city', 'apply_position',
                        'bachelor_school', 'master_school', 'image_tag', 'major', 'created_date')

        readonly_fields = ('applicant', 'created_date', 'modified_date',)

        fieldsets = (
            (None, {'fields': (
                "applicant", ("username", "city", "phone"),
                ("email", "apply_position", "born_address", "gender", ),
                ("bachelor_school", "master_school"), ("major",
                                                    "degree"), ('created_date', 'modified_date'),
                "candidate_introduction", "work_experience", "project_experience",)}),
        )

        def save_model(self, request, obj, form, change):
            obj.applicant = request.user
            super().save_model(request, obj, form, change)


    admin.site.register(Resume, ResumeAdmin)
    ```

- 同步数据库

    `python manage.py makemigrations`
    `python manage.py migrate`

- 授予管理权限到 HR

### 让候选人可以在线投递简历

- 目标
  - 注册的用户可以提交简历
  - 简历跟当前用户关联
  - 能够追溯到谁投递的简历
- 步骤
  - 定义简历创建 View（继承自通用的 CreateView）

    在 `jobs/views` 中添加：

    ```python
    from django.http import HttpResponseRedirect
    from django.contrib.auth.mixins import LoginRequiredMixin
    from django.views.generic.edit import CreateView

    from jobs.models import Job, Resume

    class ResumeCreateView(LoginRequiredMixin, CreateView):
        """    简历职位页面  """
        template_name = 'resume_form.html'
        success_url = '/joblist/'
        model = Resume
        fields = ["username", "city", "phone",
            "email", "apply_position", "gender",
            "bachelor_school", "master_school", "major", "degree", "picture", "attachment",
            "candidate_introduction", "work_experience", "project_experience"]

        # 从 URL 请求参数带入默认值
        def get_initial(self):
            return {x: self.request.GET[x] for x in self.request.GET}

        def form_valid(self, form):
            self.object = form.save(commit=False)
            self.object.applicant = self.request.user
            self.object.save()
            return HttpResponseRedirect(self.get_success_url())
    ```

    新建 `jobs/templates/resume_form.html` 模版并写入：

    ```html
    <h2>提交简历</h2>
    <form method="post">
        {% csrf_token %} {{ form.as_p }}
        <input type="submit" value="提交" />
    </form>
    ```

    在 `jobs/urls.py` 中添加：

    ```python
    urlpatterns = [
        # 提交简历
        path('resume/add/', views.ResumeCreateView.as_view(), name='resume-add'),
    ]
    ```

  - 定义简历创建页的表单模版
  - 关联“申请职位”按钮的点击事件到简历提交页

    在 `jobs/templates/job.html` 中修改：

    ```html
    <div>
        <input type="button" class="btn btn-primary" style="width:120px;" value="申请" onclick="location.href='/resume/add/?apply_position={{job.job_name}}&city={{job.city_name}}'"/>
    </div>
    ```

  - 进一步完善，可以带参数跳转 && 关联登录用户到简历

### 使用 Bootstrap 来定制页面样式

- 安装依赖包： `pip install django-bootstrap4`
- 添加到 apps 中：`bootstrap4`

    在 `settings/base.py` 中添加 ：

    ```python
    INSTALLED_APPS = [
        "grappelli",
        "bootstrap4",
    ]
    ```

- 模版里面使用 bootstrap 标签

    修改 `jobs/templates/resume_form.html`：

    ```html
    {# Load the tag library #} 
    {% load bootstrap4 %} 

    {# Load CSS and JavaScript #}
    {% bootstrap_css %} 
    {% bootstrap_javascript jquery='full' %} 

    {# Display django.contrib.messages as Bootstrap alerts #} 
    {% bootstrap_messages %}

    <form
    method="post"
    method="post"
    class="form"
    enctype="multipart/form-data"
    style="width: 600px; margin-left: 5px"
    >
    {% csrf_token %} {% bootstrap_form form %} {% buttons %}
    <button type="submit" class="btn btn-primary">Submit</button>
    {% endbuttons %}
    </form>
    ```

    在 `jobs/templates/base.html` 开头添加：

    ```html
    {# Load the tag library #}
    {% load bootstrap4 %}

    {% load i18n %}

    {# Load CSS and JavaScript #}
    {% bootstrap_css %}
    {% bootstrap_javascript jquery='full' %}

    {# Display django.contrib.messages as Bootstrap alerts #}
    {% bootstrap_messages %}
    ```

### 简历评估 & 安排一面面试官

- 目标： 打通简历投递与面试流程，让**简历实体**（Resume）流转到**候选人实体**（Candidate）
- 添加一个数据操作菜单“进入面试流程”
- 定义 `enter_interview_process` 方法

    在 `jobs/amdin.py` 中添加：

    ```python
    from django.contrib import messages
    from interview.models import Candidate
    from datetime import datetime

    def enter_interview_process(modeladmin, request, queryset):
        candidate_names = ""
        for resume in queryset:
            candidate = Candidate()
            # 把 obj 对象中的所有属性拷贝到 candidate 对象中:
            candidate.__dict__.update(resume.__dict__)
            candidate.created_date = datetime.now()
            candidate.modified_date = datetime.now()
            candidate_names = f"{candidate.username},{candidate_names}"
            candidate.creator = request.user.username
            candidate.save()
        messages.add_message(
            request, messages.INFO, f'候选人: {candidate_names} 已成功进入面试流程'
        )


    enter_interview_process.short_description = u"进入面试流程"
    ```

- 注册到 `modeladmin` 中

    ```python
    class ResumeAdmin(admin.ModelAdmin):
        actions=(enter_interview_process,)
    ```

### 定制列表字段，查看简历详情

- 添加 `ResumeDetailView` 的详情页视图，使用 Django 的通用视图，继承自 `DetailView`

    在 `jobs/views.py` 中修改：

    ```python
    from django.views.generic.detail import DetailView

    class ResumeDetailView(DetailView):
        """   简历详情页    """
        model = Resume
        template_name = 'resume_detail.html'
    ```

    创建 `jobs/templates/resume_detail.html` 并写入：

    ```html
    {# Load the tag library #}
    {% load bootstrap4 %}

    {# Load CSS and JavaScript #}
    {% bootstrap_css %}
    {% bootstrap_javascript jquery='full' %}

    {# Display django.contrib.messages as Bootstrap alerts #}
    {% bootstrap_messages %}

    <h1>简历详细信息 </h1>

    <div> 姓名: {{ object.username }} </div> <div>城市： {{ object.city }}</div> <div>手机号码: {{ object.phone }}</div>

    <p></p>
    <div>邮件地址: {{ object.email}}</div>
    <div>申请职位: {{ object.apply_position}}</div>
    <div>出生地: {{ object.born_address}}</div>
    <div>性别: {{ object.gender}}</div>
    <hr>

    <div>本科学校: {{ object.bachelor_school}}</div>
    <div>研究所学校: {{ object.master_school}}</div>
    <div>专业: {{ object.major}}</div>
    <div>学历: {{ object.degree}}</div>
    <hr>

    <p>候选人介绍: {{ object.candidate_introduction}}</p>
    <p>工作经历: {{ object.work_experience}}</p>
    <p>项目经历: {{ object.project_experience}}</p>
    ```

    在 `jobs/urls.py` 中添加：

    ```python
    urlpatterns = [
        path('resume/<int:pk>/', views.ResumeDetailView.as_view(), name='resume-detail'),
    ]
    ```

- 添加 Detail 页模版：`resume_detail.html`
- 候选人列表页，对于每一行来自简历投递的数据，添加一个 “查看简历” 的链接：
  - 列表页，使用函数名称作为 list_display 中的字段
  - 定义一个函数，获取简历详情页链接

    修改 `interview/admin.py`：

    ```python
    from jobs.models import Resume
    from django.utils.safestring import mark_safe

    class CandidateAdmin(admin.ModelAdmin):
        list_display = (
            'username', 'city', 'bachelor_school', 'get_resume', 'first_score', 'first_result', 'first_interviewer_user', 'second_score',
            'second_result', 'second_interviewer_user', 'hr_score', 'hr_result', 'hr_interviewer_user',)

        def get_resume(self, obj):
            if not obj.phone:
                return ""
            resumes = Resume.objects.filter(phone=obj.phone)
            if resumes and len(resumes) > 0:
                return mark_safe(
                    f'<a href="/resume/{resumes[0].id}" target="_blank">{"查看简历"}</a'
                )
            return ""

        get_resume.short_description = '查看简历'
        get_resume.allow_tags = True
    ```

## 日常开发中常见的复杂场景：Django 进阶开发实战

### 遗留系统集成：为已有数据库生成管理后台

- 问题
  - 已经有内部系统在运行了，缺少管理功能，希望能有一个权利后台
  - 比如人事系统，CRM，ERP的产品，缺少部分数据的维护功能
- 诉求
  - 3分钟生成一个管理后台；
  - 可以灵活定制页面；
  - 不影响正在运行的业务系统。
- 为已有数据库生成管理后台
  - 创建项目：

    ```bash
    django-admin startproject empmanager
    ```

  - 编辑 `settings.py` 中的数据库配置，`vim ~/settings.py`

    ```python
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.mysql",
            "NAME": BASE_DIR / "mydatabase",
            "USER": "mydatabaseuser",
            "PASSWORD": "mypassword",
            "HOST": "127.0.0.1",
            "PORT": "5432",
        }
    }
    ```

  - 创建应用：

    ```bash
    django-admin startapp candidates
    ```

    注册应用，在 `settings.py`中添加：

    ```python
    INSTALLED_APPS = [
        "candidates",
    ]
    ```

  - 生成 model 类：

    ```bash
    python manage.py inspectdb > candidates/models.py`
    ```

    也可以指定相应的表

    ```bash
    python manage.py inspectdb candidate
    ```

  - 在 admin 中进行注册：

    修改 `candidates/admin.py`：

    ```python
    from .models import JobsJob, JobsResume, Candidate

    admin.site.register(JobsResume)
    admin.site.register(JobsJob)
    admin.site.register(Candidate)
    ```

  - 启动应用

    ```bash
    python manage.py runserver 0.0.0.0:8080
    ```

### Django 的中间件（Middleware）

- 什么是中间件 Middleware？
  - 注入在 Django **请求/响应** 处理流程中的钩子框架，能对 request/response 作处理
- 广泛的使用场景
  - 登录认证，安全拦截
  - 日志记录，性能上报
  - 缓存处理，监控告警。。。
- 自定义中间件的 2种方法
  - 使用函数实现
  - 使用类实现
- Django 的中间件（Middleware）：函数实现

    ```python
    def simple_middleware(get_response):
        # one-time configuration and initialization. 

        def middleware(request):
            # Code to be executed for each request before
            # the view (and later middleware) are called.

            response = get_response(request)

            # Code to be executed for each request/response after
            # the view called.

            return response
        
        return middleware
    ```

- Django 的中间件（Middleware）：类实现
  - Django 提供的 get_response 方法：
  - 可能是一个真实的视图，也可能是请求处理链中的下一个中间件

    ```python
    class SimpleMiddleware:
        def __init__(self, get_response):
            self.get_response = get_response
            # One-time configuration and initialization

        def __call__(self, request):
            # Code to be executed for each request before 
            # the view (and later middleware) are called.

            response = self.get_response(request)

            # Code to be executed for each request/response after
            # the view is called.

            return response
    ```

### 创建请求日志、性能日志记录中间件

- 定义实现中间件：

    创建 `interview/performance.py` 并写入：

    ```python
    import time
    import logging

    logger = logging.getLogger(__name__)


    def performance_logger_middleware(get_response):
        def middleware(request):
            start_time = time.time()
            response = get_response(request)
            duration = time.time() - start_time
            response["X-Page-Duration-ms"] = int(duration * 1000)
            logger.info("%s %s %s", duration, request.path, request.GET.dict() )
            return response

        return middleware
    ```

- 记录请求 URL，参数，响应时间
- 注册 middleware 到 settings 中

    在 `settings/base.py` 注册中间件：

    ```python
    MIDDLEWARE = [
        "interview.performance.performance_logger_middleware",
    ]
    ```

- 配置日志文件路径

    在 `settings/base.py` 中修改：

    ```python
    LOGGING = {
        'version': 1,
        'disable_existing_loggers': False,
        'formatters': {
            'simple': {  # exact format is not important, this is the minimum information
                'format': '%(asctime)s %(name)-12s %(lineno)d %(levelname)-8s %(message)s',
            },
        },
        'handlers': {
            'performance': {
                # 'level': 'INFO',
                'class': 'logging.FileHandler',
                'formatter': 'simple',
                'filename': os.path.join(os.path.dirname(BASE_DIR), 'recruitment.performance.log'),
            },
        },
        'loggers': {
            "interview.performance": {
                "handlers": ["console", "performance"],
                "level": "INFO",
                "propagate": False,
            },
        },
    }
    ```

### 在 Django 中支持多语言

- 步骤
  - 代码中使用 gettext，gettext_lazy 获取多语言资源对应的文本内容
  - 生成多语言资源文件
  - 翻译多语言内容
  - 生成二进制多语言资源文件
- 实现
  - Model，以及 Django 的 python 代码里面使用多语言

    修改 `jobs/models.py`：

    ```python
    from django.utils.translation import gettext_lazy as _

    class Job(models.Model):
        # Translators: 职位实体的翻译
        job_type = models.SmallIntegerField(blank=False, choices=JobTypes, verbose_name=_("职位类别"))
        job_name = models.CharField(max_length=250, blank=False, verbose_name=_("职位名称"))
        job_city = models.SmallIntegerField(choices=Cities, blank=False, verbose_name=_("工作地点"))
        job_responsibility = models.TextField(max_length=1024, verbose_name=_("职位职责"))
        job_requirement = models.TextField(max_length=1024, blank=False, verbose_name=_("职位要求"))
        creator = models.ForeignKey(User, verbose_name=_("创建人"), null=True, on_delete=models.SET_NULL)
        created_date = models.DateTimeField(verbose_name=_("创建日期"), auto_now_add=True)
        modified_date = models.DateTimeField(verbose_name=_("修改日期"), auto_now=True)

        class Meta:
            verbose_name = _('职位')
            verbose_name_plural = _('职位列表')

        def __str__(self):
            return self.job_name

    class Resume(models.Model):
        # Translators: 简历实体的翻译
        username = models.CharField(max_length=135, verbose_name=_('姓名'))
        applicant = models.ForeignKey(User, verbose_name=_("申请人"), null=True, on_delete=models.SET_NULL)
        city = models.CharField(max_length=135, verbose_name=_('城市'))
        phone = models.CharField(max_length=135,  verbose_name=_('手机号码'))
        email = models.EmailField(max_length=135, blank=True, verbose_name=_('邮箱'))
        apply_position = models.CharField(max_length=135, blank=True, verbose_name=_('应聘职位'))
        born_address = models.CharField(max_length=135, blank=True, verbose_name=_('生源地'))
        gender = models.CharField(max_length=135, blank=True, verbose_name=_('性别'))
        picture = models.ImageField(upload_to='images/', blank=True, verbose_name=_('个人照片')) 
        attachment = models.FileField(upload_to='file/', blank=True, verbose_name=_('简历附件'))

        # 学校与学历信息
        bachelor_school = models.CharField(max_length=135, blank=True, verbose_name=_('本科学校'))
        master_school = models.CharField(max_length=135, blank=True, verbose_name=_('研究生学校'))
        doctor_school = models.CharField(max_length=135, blank=True, verbose_name=u'博士生学校')
        major = models.CharField(max_length=135, blank=True, verbose_name=_('专业'))
        degree = models.CharField(max_length=135, choices=DEGREE_TYPE, blank=True, verbose_name=_('学历'))
        created_date = models.DateTimeField(verbose_name="创建日期", default=datetime.now)
        modified_date = models.DateTimeField(verbose_name="修改日期", auto_now=True)

        # 候选人自我介绍，工作经历，项目经历
        candidate_introduction = models.TextField(max_length=1024, blank=True, verbose_name=u'自我介绍')
        work_experience = models.TextField(max_length=1024, blank=True, verbose_name=u'工作经历')
        project_experience = models.TextField(max_length=1024, blank=True, verbose_name=u'项目经历')

        class Meta:
            verbose_name = _('简历')
            verbose_name_plural = _('简历列表')
        
        def __str__(self):
            return self.username
    ```

    修改 `jobs/templates/base.html`：

    ```html
    {# Load the tag library #}
    {% load bootstrap4 %}

    {% load i18n %}

    {# Load CSS and JavaScript #}
    {% bootstrap_css %}
    {% bootstrap_javascript jquery='full' %}

    {# Display django.contrib.messages as Bootstrap alerts #}
    {% bootstrap_messages %}

    <h3 > {% translate "匠果科技开放职位" %} </h3>

    {% block header %}
    <div style="margin-left: 5px;display: -webkit-flex;display: flex;">
        
    <div style="flex: 4; ">
    <a href="/" style="text-decoration: none; color:#007bff">{% translate "Homepage" %}</a>
    <a href="/joblist" style="text-decoration: none; color:#007bff">{% translate "job list" %}</a>

    {% if user.is_authenticated %}
    <a href="/accounts/logout" style="text-decoration: none; color:#007bff">{% translate "Logout" %}</a>
    {% else %}
    <a href="/accounts/login" style="text-decoration: none; color:#007bff">{% translate "Login" %}</a>
    {% endif %}

    {% if user.is_authenticated %}
    <p>{% blocktranslate with user_name=user.username %} 终于等到你 {{ user_name }}, 期待加入我们，用技术去探索一个新世界 {% endblocktranslate %}</p>
    {% else %}
    <br>{% translate "欢迎你，期待加入我们，登陆后可以提交简历." %}<br>
    {% endif %}
    </div>
    </div>
    <hr style="margin-top: 0px;">
    {% endblock %}

    {% block content %}
    {% endblock %}
    ```

  - 生成文本格式的多语言资源文件 `.po` 文件

    ```bash
    mkdir locale
    django-admin makemessages -l zh_HANS -l en
    ```

    翻译 `.po` 文件中的内容到不同语言

  - 编译生成可以高效使用的二进制（.mo）文件

    ```bash
    django-admin compilemessages
    ```

  - 启动多语言配置
  
    编辑 `recruitment/urls.py`：

    ```python
    urlpatterns = [
        path('i18n/', include('django.conf.urls.i18n')),
    ]
    ```

    编辑 `settings/base.py`：

    ```python
    from django.utils.translation import gettext_lazy as _

    LANGUAGES = [
        ('zh-hans', _('Chinese')),
        ('en', _('English')),
    ]

    # LANGUAGE_CODE = "en-us"
    LANGUAGE_CODE = "zh-hans"

    USE_I18N = True
    USE_L10N = True

    LOCALE_PATHS = (
        os.path.join(BASE_DIR, 'locale'),
    )
    ```

  - 人工切换语言环境

    编辑 `jobs/templates/base.html`:

    ```html
    <div style="flex: 1; align-content:right;">
    <form action="{% url 'set_language' %}" method="post" style="margin-block-end: 0em;">{% csrf_token %}
        <input name="next" type="hidden" value="{{ redirect_to }}">
        <select name="language">
            {% get_current_language as LANGUAGE_CODE %}
            {% get_available_languages as LANGUAGES %}
            {% get_language_info_list for LANGUAGES as languages %}
            {% for language in languages %}
                <option value="{{ language.code }}"{% if language.code == LANGUAGE_CODE %} selected{% endif %}>
                    {{ language.name_local }} ({{ language.code }})
                </option>
            {% endfor %}
        </select>

        <input type="submit" value={% translate "Switch" %} style="font-size:12;height:20px">
    </form>
    </div>
    ```

    在 `settings/base.py` 中加上多语言中间件：

    ```python
    MIDDLEWARE = [
        "django.contrib.sessions.middleware.SessionMiddleware",
        "django.middleware.locale.LocaleMiddleware",
        "django.middleware.common.CommonMiddleware",
    ]
    ```

### 错误和异常日志上报：Sentry 集成

- 两种方法安装 Sentry：
  - 使用 Docker 官方服务（量大需要付费，使用方便）；
  - 自己搭建服务（从源码安装，或者使用 docker 搭建服务）；
- 使用 Docker 来安装 sentry，使用 release 版本
  - <https://github.com/getsentry/onpremise/release>
  - unzip sentry.zip
  - ./install.sh
  - docker-compose up -d
- Django 配置集成 sentry， 自动上报未捕获异常，错误日志

### 错误和异常日志上报：捕获异常上报到 Sentry 并发送钉钉群通知

- 使用中间件捕获异常上报

    编辑 `interview/performance.py`

    ```python
    from sentry_sdk import capture_exception, capture_message
    from . import dingtalk

    class PerformanceAndExceptionLoggerMiddleware:
        def __init__(self, get_response):
            self.get_response = get_response
            # One-time configuration and initialization.

        def __call__(self, request):
            # Code to be executed for each request before
            # the view (and later middleware) are called.

            start_time = time.time()
            response = self.get_response(request)
            duration = time.time() - start_time
            response["X-Page-Duration-ms"] = int(duration * 1000)
            logger.info("duration:%s url:%s parameters:%s", duration, request.path, request.GET.dict() )
            if duration > 300:
                captur_message("slow request for url:%s with duration:%s"  % (request.build_absolute_uri(), duration))
            # Code to be executed for each request/response after
            # the view is called.

            return response

        def process_exception(self, request, exception):
            if exception:
                    
                message = "url:{url} ** msg:{error} ````{tb}````".format(
                    url = request.build_absolute_uri(),
                    error = repr(exception),
                    tb = traceback.format_exc()
                )
                
                logger.warning(message)
                
                # send dingtalk message
                dingtalk.send(message)

                # capture exception to sentry:
                capture_exception(exception)
                    
            return HttpResponse("Error processing the request, please contact the system administrator.", status=500)
    ```

### Django 安全防护：防止 XSS 跨站脚本攻击

- 恶意攻击者将代码通过网站注入到其他用户浏览器中的攻击方式。
  - 攻击者会把恶意 JavaScript 代码作为普通数据放入到网站数据库中；
  - 其他用户在获取和展示数据的过程中，运行 JavaScript 代码；
  - JavaScript 代码执行恶意代码（调用恶意请求，发送数据到攻击者等等）。
- 模拟攻击
  - 在 `jobs/view.py` 中添加：

    ```python
    def detail_resume(request, resume_id):
        try:
            resume = Resume.objects.get(pk=resume_id)
            content = f"name: {resume.username} <br>  introduction: {resume.candidate_introduction} <br>"
            return HttpResponse(content)
        except Resume.DoesNotExist as e:
            raise Http404("resume does not exist") from e
    ```

  - 在 `jobs/urls.py` 中添加：

    ```python
    from django.conf import settings

    if settings.DEBUG :
        # 有 XSS 漏洞的视图页面，
        urlpatterns += [re_path(r'^detail_resume/(?P<resume_id>\d+)/$', views.detail_resume, name='detail_resume'),]
    ```

  - 注册新用户并登录，申请职位应聘

### Django 安全防护：CSRF 跨站请求伪造和 SQL 注入攻击

- CSRF (Cross-site request forgery, 简称：CSRF 或 XSRF)
- 恶意攻击者在用户不知情的情况下，使用用户的身份来操作
- 黑客的准备步骤
  - 黑客创建一个请求网站 A 类的 URL 的 Web 页面，放在恶意网站 B 中，这个文件包含了一个创建用户的表单。这个表单加载完毕就会立即进行提交。
  - 黑客把这个恶意 Web 页面的 URL 发送至超级管理员，诱导超级管理员打开这个 Web 页面。
- 模拟攻击

    创建 `jobs/templates/create_hr.html`：

    ```html
    {% extends 'base.html' %}

    {% block content %}

    <body>   <!-- onload='document.EvilForm.submit() --> 

        <form action="http://127.0.0.1:8000/create_hr_user/" method="post" name='EvilForm'>
            <h2>Create a new HR account </h2>

            {% csrf_token %}

        <table>
            <tr><th><label for="id_first_name">First name:</label></th><td><input id="id_first_name" maxlength="100" name="username" type="text" value="Lily" required /></td></tr>
            <tr><th><label for="id_password">Last name:</label></th><td><input id="id_password" maxlength="100" name="password" type="password" value="Lily34567" required /></td></tr>
            <tr><th><label for="id_password_retype">Last name:</label></th><td><input id="id_password_retype" maxlength="100" name="password_retype" type="password" value="Lily34567" required /></td></tr>
        
        </table>
        <input type="submit" value="Submit" />
        </form>
        
        </body>

    {% endblock %}
    ```

    编辑 `josb/views.py`：

    ```python
    from django.contrib.auth.models import Group
    from django.contrib import messages
    from django.contrib.auth.decorators import permission_required, login_required
    from django.views.decorators.csrf import csrf_exempt

    # 这个 URL 仅允许有 创建用户权限的用户访问
    @csrf_exempt
    @permission_required('auth.user_add')
    def create_hr_user(request):
        if request.method == "GET":
            return render(request, 'create_hr.html', {})
        if request.method == "POST":
            username = request.POST.get("username")
            password = request.POST.get("password")
            
            hr_group = Group.objects.get(name='hr') 
            user = User(is_superuser=False, username=username, is_active=True, is_staff=True)
            user.set_password(password)
            user.save()
            user.groups.add(hr_group)

            messages.add_message(request, messages.INFO, 'user created %s' % username)
            return render(request, 'create_hr.html')
        return render(request, 'create_hr.html')
    ```

    在 `jobs/urls` 中添加 url：

    ```python
    urlpatterns = [
        # 管理员创建 HR 账号的 页面:
        path('create_hr_user/', views.create_hr_user, name='create_hr_user'),
    ]
    ```

    黑客创建页面 `interesting.html`：

    ```html
    <html>
        <body onload='document.EvilForm.submit()'>

        <form action="http://127.0.0.1:8000/create_hr_user/" method="post" name='EvilForm'>
            <h2>Create a new HR account </h2>

        <table>
            <tr><th><label for="id_first_name">First name:</label></th><td><input id="id_first_name" maxlength="100" name="username" type="text" value="Lily" required /></td></tr>
            <tr><th><label for="id_password">Last name:</label></th><td><input id="id_password" maxlength="100" name="password" type="password" value="Lily34567" required /></td></tr>
            <tr><th><label for="id_password_retype">Last name:</label></th><td><input id="id_password_retype" maxlength="100" name="password_retype" type="password" value="Lily34567" required /></td></tr>

        </table>
        <input type="submit" value="Submit" />
        </form>

    </body>
    </html>
    ```

    黑客启动服务：

    ```bash
    python -m http.server 7000
    ```

- SQL 注入攻击
  - SQL 注入漏洞：攻击者直接对网站数据库执行任意 SQL 语句，在无需用户权限的情况下即可实现对数据的访问、修改甚至是删除。
  - Django 的 ORM 系统自动规避了 SQL 注入攻击。
  - 原始 SQL 语句。切记避免拼接字符串，这是错误的调用方式：

    ```python
    query = 'SELECT * FROM employee Where last_name = %s' % name
    Person.objects.raw(query)
    ```

  - 正确的调用方式，使用参数绑定：

    ```python
    name_map = {'first': 'first_name', 'last': 'last_name', 'bd': 'birth_date', 'pk': 'id'}
    >>> Person.objects.raw('SELECT * FROM employee', translations=name_map)
    ```

### Django Rest Framework 开放 API

- 快速将 Rest API 开放出去
- 配置合适的权限控制
- <https://www.django-rest-framework.org>
- Installation

    ```bash
    pip install djangorestframework
    pip install markdown       # Markdown support for the browsable API.
    pip install django-filter  # Filtering support
    ```

- Add `rest_framework` to your `INSTALLED_APPS` setting.

    ```python
    INSTALLED_APPS = [
        ...
        'rest_framework',
    ]
    ```

- If you're intending to use the browsable API you'll probably also want to add REST framework's login and logout views. Add the following to your root `urls.py` file.

    ```python
    urlpatterns = [
        ...
        path('api-auth/', include('rest_framework.urls'))
    ]
    ```

- 在 `settings/base.py` 中加入鉴权方式：

    ```python
    REST_FRAMEWORK = {
        # Use Django's standard `django.contrib.auth` permissions,
        # or allow read-only access for unauthenticated users.
        'DEFAULT_PERMISSION_CLASSES': [
            'rest_framework.permissions.DjangoModelPermissionsOrAnonReadOnly'
        ]
    }
    ```

- 在 `recruitment/urls.py` 中定义 API 路由：

    ```python
    from django.contrib.auth.models import User 
    from jobs.models import Job
    from rest_framework import routers, serializers, viewsets


    # Serializers define the API representation.
    class UserSerializer(serializers.HyperlinkedModelSerializer):
        class Meta:
            model = User
            fields = ['url', 'username', 'email', 'is_staff']


    # ViewSets define the view behavior.
    class UserViewSet(viewsets.ModelViewSet):
        queryset = User.objects.all()
        serializer_class = UserSerializer


    class JobSerializer(serializers.HyperlinkedModelSerializer):
        class Meta:
            model = Job
            fields = '__all__'


    class JobViewSet(viewsets.ModelViewSet):
        """
        API endpoint that allows groups to be viewed or edited.
        """
        queryset = Job.objects.all()
        serializer_class = JobSerializer


    # Routers provide an easy way of automatically determining the URL conf.
    router = routers.DefaultRouter()
    router.register(r'users', UserViewSet)
    router.register(r'jobs', JobViewSet)


    urlpatterns = [
        # django rest api & api auth (login/logout)
        path('api/', include(router.urls)),
    ]
    ```

- 每个 api 都可以通过 curl 命令访问：

    ```bash
    curl http://127.0.0.1:8080/api/jobs/1/
    curl -u admin:123456 http://127.0.0.1:8080/api/jobs/1/
    ```

### 在 Django 中使用缓存 & Redis 的使用

- Django 缓存的存储方式
  - Memcached 缓存
  - Redis 缓存（需要安装 django-redis 包）
    - 安装 `pip install django-redis`
    - Mac 下安装 `brew install redis`
    - 启动 redis `redis-server`
    - 在 `settings/local.py` 添加配置：

        为了使用 django-redis , 你应该将你的 django cache setting 改成这样:

        ```python
        CACHES = {
            "default": {
                "BACKEND": "django_redis.cache.RedisCache",
                "LOCATION": "redis://127.0.0.1:6379/1",
                "TIMEOUT": 300,
                "OPTIONS": {
                    "CLIENT_CLASS": "django_redis.client.DefaultClient",
                    # "PASSWORD": "mysecret",
                    "SOCKET_CONNECT_TIMEOUT": 5, # in seconds
                    "SOCKET_TIMEOUT": 5, # r/w timeout in seconds
                }
            }
        }
        ```

    - 配置整站缓存

        在 `settings/base.py` 中添加配置：

        ```python
        MIDDLEWARE = [
            "django.middleware.cache.UpdateCacheMiddleware",
            "django.middleware.common.CommonMiddleware",
            "django.middleware.cache.FetchFromCacheMiddleware",
        ]
        ```

    - 修改 `jobs/views.py` 来验证缓存

        ```python
        import logging

        logger = logging.getLogger(__name__)

        def detail(request, job_id):
            try:
                job = Job.objects.get(pk=job_id)
                job.city_name = Cities[job.job_city][1]
                logger.info(f'job retrieved from db :{job_id}')
            except Job.DoesNotExist as e:
                raise Http404("Job does not exist") from e

            return render(request, "job.html", {"job": job})
        ```

  - 数据库缓存
  - 文件系统缓存
  - 本地内存缓存
  - 伪缓存（Dummy Cache， 用于开发、测试）
  - 自定义缓存
- 缓存的策略
  - 整站缓存
  - 视图缓存（用 CachePage 标记去做）
  - 模版片段缓存
- 缓存启用之后多出来的

### Django 与 Celery 集成： Celery 的使用

- 什么是 Celery？
- 一个分布式的任务队列
  - 简单：几行代码可以创建一个简单的 Celery 任务
  - 高可用：工作机会自动重试
  - 快速：可以执行一分钟上百万的任务
  - 灵活：每一块都可以扩展
- Celery 使用场景：大量需要使用异步任务的场景
  - 发送电子邮件，发送 IM 消息通知
  - 爬取网页，数据分析
  - 图像、视频处理
  - 生成报告，深度学习

    ![Celery使用场景](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230312205310_tbT0hQ.png)

- 部署 Celery
  - 安装 Celery `pip install -U celery`
  - 安装依赖包 `pip install "celery[redis,auth,msgpack]"`
  - 在项目根目录下新建 `celery` 目录
  - 在 `celery` 下新建 `tasks.py`：

    ```python
    from celery import Celery

    # 第一个参数 是当前脚本的名称，第二个参数 是 broker 服务地址
    app = Celery('tasks', backend='redis://127.0.0.1', broker='redis://127.0.0.1')


    @app.task
    def add(x, y):
        return x + y
    ```

  - 运行 Celery worker server

    ```bash
    cd celery
    celery -A tasks worker --loglevel=info
    ```

  - 添加一个运行任务的脚本 `run_task.py`

    ```python
    #coding=utf-8

    from tasks import add

    result = add.delay(4, 4)
    print('Is task ready: %s' % result.ready())

    run_result = result.get(timeout=1)
    print('task result: %s' % run_result)
    ```

  - 运行任务 `python run_task.py`，输出

    ```bash
    Is task ready: False
    task result: 8
    ```

- Flower：一个实时的 Celery 任务监控系统
  - 安装：`pip install flower`
  - 启动：`celery -A tasks flower --broker=redis://@localhost:6379/0`
  - 运行任务 `python run_task.py`

### Django 与 Celery 集成： 异步任务

- Celery 4.o 的版本支持 Django 集成
- 不需要安装额外的库
- 使用 Celery 的自动发现机制：自动发现 tasks.py

## 生产环境部署与应用监控告警

## 回顾产品的快速迭代开发过程

## 通往 Hacker 之路
