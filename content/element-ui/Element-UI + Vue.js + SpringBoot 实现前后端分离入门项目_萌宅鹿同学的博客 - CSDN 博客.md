> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_43734095/article/details/107053438)

### Element UI

*   [项目简介与演示](#_4)
*   [刷新页面时让组件默认为当前路由路径](#_9)
*   [删除时确认](#_18)
*   [分页功能的实现](#_53)
*   [el-date-picke 日期少一天](#eldatepicke__147)

> 前端部分源码：[https://github.com/szluyu99/elementui-users_1](https://github.com/szluyu99/elementui-users_1)  
> 后端部分源码：

项目简介与演示
=======

Element-UI + Vue.js + SpringBoot 实现的[前后端分离](https://so.csdn.net/so/search?q=%E5%89%8D%E5%90%8E%E7%AB%AF%E5%88%86%E7%A6%BB&spm=1001.2101.3001.7020)入门项目。  
![](https://img-blog.csdnimg.cn/20200702005406511.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
![](https://img-blog.csdnimg.cn/20200702005456271.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

刷新页面时让组件默认为当前路由路径
=================

`activeIndex` 表示当前激活的页面，如果写死了刷新后会有 bug，因此动态获取当前路由路径。

```
data() {
  return {
    activeIndex: this.$route.path,
  };
},
```

删除时确认
=====

注意 `@onConfirm` 这个事件是加载 `el-popconfirm` 标签上的。

```
<el-popconfirm title="这是一段内容确定删除吗？" @onConfirm="handleDelete(scope.$index, scope.row)">
	<el-button slot="reference" size="mini" type="danger">删除</el-button>
</el-popconfirm>
```

```
<script>
  export default {
    data() {},
    methods: {
      handleDelete(index, row) {
        console.log(index, row);
        this.$http.get("http://localhost:8989/user/delete?id=" + row.id).then((res) => {
          if (res.data.state) {
            this.$message({
              showClose: true,
              message: res.data.msg,
              type: 'success'
            });
          } else {
            this.$message({
              showClose: true,
              message: res.data.msg,
              type: 'error'
            });
          }
        });
        this.findAllTableData();
      },
    },
  }
</script>
```

分页功能的实现
=======

mysql 分页查询：

```
<!--分页查询-->
<select id="findByPage" resultType="User">
    SELECT id, name, bir, sex, address
    FROM t_user
    LIMIT #{start}, #{rows}
</select>
```

后端控制器：

```
@RestController
@RequestMapping("/user")
@CrossOrigin
public class UserController {

    @Autowired
    private UserService userService;
	
	// 分页查询	
	@GetMapping("/findByPage")
	public Map<String, Object> findByPage(Integer pageNow, Integer pageSize) {
	    Map<String, Object> result = new HashMap<>();
	    pageNow = pageNow == null ? 1 : pageNow; // 不传当前页数默认为1
	    pageSize = pageSize == null ? 4 : pageSize; // 不传当前页面显示条数默认显示4条
	    List<User> users = userService.findByPage(pageNow, pageSize); // 分页查询
	    Long totals = userService.findTotals();
	    result.put("users", users);
	    result.put("total", totals);
	    return result;
	}

}
```

前端页面：使用 [分页组件](https://element.eleme.cn/#/zh-CN/component/pagination)；  
![](https://img-blog.csdnimg.cn/20200702001446809.png)

```
<el-row>
  <el-col :span="12" :offset="8">
    <div>
      <!-- 分页组件 -->
      <el-pagination 
        style="margin: 15px 0px;" 
        prev-text="上一页" next-text="下一页" background
        layout="prev, pager, next, sizes, jumper, total"
        :page-sizes="[2,4,6,8,10]" 
        :page-size="pageSize"
        :total="total"   
        :current-page="pageNow"   
        @current-change="findPage"
        @size-change="findSize">
      </el-pagination>
    </div>
  </el-col>
</el-row>
```

```
<script>
  export default {
    data() {
      return {
        total: 0, // 总页数, 从后台查询获取
        pageNow: 1, // 当前页数, 默认为1
        pageSize: 4 // 当前页显示的数据条数, 默认为4
      }
    },
    methods: {
      findPage(page) { // 用来处理分页相关方法
        console.log("当前页数: " + page);
        this.pageNow = page;
        this.findAllTableDataByPage();
      },
      findSize(size) { // 用来处理每页显示记录发生变化的方法
        console.log("当前页面记录条数: " + size);
        this.pageSize = size;
        this.findAllTableDataByPage();
      },
      findAllTableDataByPage() {
        this.$http.get("http://localhost:8989/user/findByPage?pageNow=" + this.pageNow + "&pageSize=" + this.pageSize).then((res) => {
          // console.log(res.data);
          this.tableData = res.data.users;
          this.total = res.data.total;
        });
      }
    },
    created() {
      this.findAllTableDataByPage();
    }
  }
</script>
```

el-date-picke 日期少一天
===================

Element-UI 中时间控件的默认时间为 **国际标准时间**，因此与北京时间差 8 个小时。

解决方案：在标签中增加属性 `value-format="yyyy-MM-dd"`，然后 刷新页面；

```
<el-date-picker 
	type="date" 
	placeholder="选择日期" 
	v-model="form.bir" 
	value-format="yyyy-MM-dd">
</el-date-picker>
```