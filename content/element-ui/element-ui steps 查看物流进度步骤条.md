> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [juejin.cn](https://juejin.cn/post/7174218525035200525)

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5238aaa9612d4104a4366ac7f1a63290~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

```
<!-- 查看物流 -->
    <el-drawer
      title="查看物流"
      :size="700"
      :visible.sync="drawerDetailVisible"
      direction="rtl">
      <div class="drawer" v-loading="isLoadingDialog">
        <div class="title">物流单号：{{detailCode}}</div>
        <div class="steps-wrap" v-if="detailData && detailData.length">
          <el-steps class="steps" direction="vertical" process-status="finish" :active="0">
            <el-step 
               v-for="(item, index) in detailData" 
                :icon="!index ? 'el-icon-document-checked' : 'el-icon-success'" 
                :key="index" 
                :title="item.opeTitle">
              <div slot="description">
                <p class="row-remark">{{item.opeRemark}}</p>
                <p class="row-time">{{item.opeTime}}</p>
              </div>
            </el-step>
          </el-steps>
        </div>
      </div>
    </el-drawer>
```

```
<script>
  <export default{
    data(){
      isLoadingDialog: false,
      drawerDetailVisible: false, // 查看物流弹窗
      detailCode: '', // 查看的物流单号
      detailData: [], // 物流详情
    },
    methods:{
      handleViewDetail(row) {
      const params = {
        id: row.id
      }
      this.isLoadingDialog = true
      this.drawerDetailVisible = true
      this.detailCode = row.wldh
      this.$requestInternet.get('/api/xx', { params }).then(res => {
        this.detailData = res
        // 也可以这样写 
        //  this.detailData = res.reverse()
      }).catch(() => {
        this.detailData = []
      }).finally(() => {
        this.isLoadingDialog = false
      })
      }
    }
  }
</script>
```