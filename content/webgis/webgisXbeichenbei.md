<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2024-05-06 21:14:39
 * @LastEditors: alphapenng
 * @LastEditTime: 2024-05-19 18:22:00
 * @FilePath: /balabala/content/webgis/webgisXbeichenbei.md
-->

# webgis-notes

- [webgis-notes](#webgis-notes)
  - [ArcGIS API for JavaScript 介绍](#arcgis-api-for-javascript-介绍)
  - [Vue 基础开发知识讲解](#vue-基础开发知识讲解)
    - [Vue Router](#vue-router)
    - [Vuex](#vuex)
  - [一张图 WebGIS 项目开发](#一张图-webgis-项目开发)

## ArcGIS API for JavaScript 介绍

1. 引用库

    ```html
    <link rel="stylesheet" href="https://js.arcgis.com/4.20/esri/themes/light/main.css">
    <script src="https://js.arcgis.com/4.20/"></script>
    ```

2. 加载模块和写代码

    ```html
    <scrip>
        require([
            "esri/Map",
            "esri/views/MapView",
            "dojo/domReady!"
        ], function(Map, MapView) {
            const map = new Map({
                basemap: "streets"
            });
            const view = new MapView({
                container: "viewDiv",
                map: map,
                zoom: 4,
                center: [-118.805, 34.027] //longitude, latitude
            });
        });
    </script>
    ```

## Vue 基础开发知识讲解

### Vue Router

```bash
npm install vue-router@3 -D
```

```javascript
# router/router.js
import Vue from 'vue'
import VueRouter from 'vue-router'
import DataVisual from '../pages/DataVisual.vue'
import OneMap from '../pages/OneMap.vue'

Vue.use(VueRouter)

export default new VueRouter({
    routes: [
        {
            path: '/',
            component: DataVisual,
        },
        {
            path: '/onemap',
            component: OneMap,
        }
    ],
    mode: 'history',
})
```

```javascript
# main.js
import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import router from './router/router'

Vue.config.productionTip = false

Vue.use(ElementUI)

new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
```

### Vuex

```bash
npm install vuex@3 -D
```

```javascript
# store/index.js
import Vue from 'vue'
import Vuex from 'vuex'


Vue.use(Vuex)

const store = new Vuex.Store({
    state: {
        _defaultView: '', // 默认地图view
    },
    getters: {
        _getDefaultView: (state) => {
            return state._defaultView        
        }
    },
    mutations: {
        _setDefaultView: (state, value) => {
            state._defaultView = value
        }
    }
})

export default store
```

```javascript
# main.js
import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import router from './router/router'
import store from './store'

Vue.config.productionTip = false

Vue.use(ElementUI)

new Vue({
  store,
  router,
  render: h => h(App),
}).$mount('#app')
```

## 一张图 WebGIS 项目开发

1. 项目需求介绍

2. 技术选型

3. Git、GitHub 流程讲解

    ```bash
    git checkout -b anotherBranch
    git add .
    git commit -m "commit message"
    git push origin anotherBranch

    # github上merge到main

    git checkout main
    git pull
    ```

4. 项目环境搭建、项目初始化

    ```bash
    # 创建项目
    vue create webgismap-vue
    ```

5. ArcGIS API for JavaScript 引入

    **第一种方式：**
    在 Vue 项目中使用 JS API 时已经不像传统的开发方式那样在 index html 中引入 JS 和 CSS 文件来使用 JS API，而是通过一个叫 "esri-loader" 的中间件，将我们的 JS API 和 Vue 项目做一个无缝链接。

    ```bash
    npm install esri-loader -D
    ```

    ```js
    # MapView.uve
    <script>
        import {loadModules} from 'esri-loader';

        const options = {
            url: 'https://js.arcgis.com/4.20/init.js',
            css: 'https://js.arcgis.com/4.20/esri/themes/light/main.css'
        }

        export default {
            name: 'MapView',
            mounted: function() {
                this._createMapView();
            },
            methods: {
                async _createMapView() {
                const [Map, MapView] = await loadModules(['esri/Map', 'esri/views/MapView'], options)

                const map = new Map({
                    basemap: 'osm',
                })

                const view = new MapView({
                    container: 'mapview',
                    map: map,
                    zoom: 10,
                    center: [104.072745, 30.663774]
                })

                view.ui.components = []

                console.log(view)
                }
            }
        }
    </script>
    ```

    **第二种方式：**

    ```bash
    npm install @arcgis/core
    ```

    ```json
    # package.json
    "scripts": {
        "start": "npm run copy && react-scripts start",
        "build": "npm run copy && react-scripts build",
        "copy": "ncp /node_modules/@arcgis/core/assets ./public/assets"
    }
    ```

6. 地图模块开发、地图基础组件开发（底图自定义、底图切换、比例尺、图例等等）

    1. 底图自定义

        ```javascript
            async _createMapView() {
            const [Map, MapView, Basemap, TileLayer] = await loadModules(['esri/Map', 'esri/views/MapView', 'esri/Basemap', 'esri/layers/TileLayer'], options)

            let basemap = new Basemap({
                baseLayers: [
                    new TileLayer({
                        url: 'http://map.geoq.cn/arcgis/rest/services/ChinaOnlineStreetPurplishBlue/MapServer',
                        title: 'Basemap'
                    })
                ],
                title: 'basemap',
                id: 'basemap'
            })

            const map = new Map({
                basemap,
            })

            const view = new MapView({
                container: 'mapview',
                map: map,
                zoom: 10,
                center: [104.072745, 30.663774]
            })

            view.ui.components = []

            this.$store.commit('_setDefaultView', view)

            console.log(view)
        }
        ```

    2. 底图切换，比例尺、缩放控件

        ```javascript
        async _createMapView() {
            const [Map, MapView, Basemap, TileLayer, BasemapToggle, ScaleBar, Zoom] = await loadModules(
                [
                    'esri/Map', 
                    'esri/views/MapView', 
                    'esri/Basemap', 
                    'esri/layers/TileLayer', 
                    'esri/widgets/BasemapToggle',
                    'esri/widgets/ScaleBar',
                    'esri/widgets/Zoom'
                ], 
                options
            )

            let basemap = new Basemap({
                baseLayers: [
                    new TileLayer({
                        url: 'http://map.geoq.cn/arcgis/rest/services/ChinaOnlineStreetPurplishBlue/MapServer',
                        title: 'Basemap'
                    })
                ],
                title: 'basemap',
                id: 'basemap'
            })

            const map = new Map({
                basemap,
            })

            const view = new MapView({
                container: 'mapview',
                map: map,
                zoom: 10,
                center: [104.072745, 30.663774]
            })

            // 实例化地图切换控件
            const basemapToggle = new BasemapToggle({
                view: view,
                nextBasemap: 'satellite',
                container: 'basemap-toggle'
            })
            view.ui.add(basemapToggle)

            // 实例化比例尺
            const scaleBar = new ScaleBar({
                view: view,
                unit: 'metric',
                container: 'scale-bar'
            })
            view.ui.add(scaleBar)

            // 实例化缩放控件
            const zoom = new Zoom({
                view: view,
                container: 'zoom'
            })
            view.ui.add(zoom)

            view.ui.components = []

            this.$store.commit('_setDefaultView', view)

            console.log(view)
        }
        ```

7. 目录树开发、图层加载

    1. arcgis 数据导入、处理（坐标转换）、发布

        arcgis pro 试用
        arcgis online 试用

    2. 行政区划导航、属性加载

8. 属性查询、空间查询、卷帘分析，多屏对比功能模块开发

9. 首页大屏开发、图层数据可视化（Echarts）

10. 系统非 GIS 功能模块开发（登录、图表查询、用户管理等）

11. 以上各个功能模块中涉及到的数据处理及服务发布

12. 项目部署，公网服务器访问 