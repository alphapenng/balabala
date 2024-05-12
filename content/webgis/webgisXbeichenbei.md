<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2024-05-06 21:14:39
 * @LastEditors: alphapenng
 * @LastEditTime: 2024-05-09 16:54:37
 * @FilePath: /balabala/content/webgis/webgisXbeichenbei.md
-->

# webgis-notes

- [webgis-notes](#webgis-notes)
  - [ArcGIS API for JavaScript 介绍](#arcgis-api-for-javascript-介绍)
    - [其他一些主流的地图JS API 介绍 （百度地图API、高德地图 API、天地图 API、Openlayer、Cesium 等），各自开发一个 demo](#其他一些主流的地图js-api-介绍-百度地图api高德地图-api天地图-apiopenlayercesium-等各自开发一个-demo)
  - [Vue 和 React 基础开发知识讲解](#vue-和-react-基础开发知识讲解)
    - [Vue 基础知识](#vue-基础知识)
    - [React 基础知识](#react-基础知识)
  - [一张图 WebGIS 项目开发](#一张图-webgis-项目开发)

## ArcGIS API for JavaScript 介绍

1. 引用库

    ```html
    <link rel="stylesheet" href="https://js.arcgis.com/4.20/esri/themes/light/main.css">
    <script src="https://js.arcgis.com/4.20/"></script>
    ```

2. 加载模块和写代码

    ```html
    <script>
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

### 其他一些主流的地图JS API 介绍 （百度地图API、高德地图 API、天地图 API、Openlayer、Cesium 等），各自开发一个 demo

## Vue 和 React 基础开发知识讲解

### Vue 基础知识

### React 基础知识

## 一张图 WebGIS 项目开发

1. 项目需求介绍

2. 技术选型

3. Git、GitHub 流程讲解

4. 项目环境搭建、项目初始化

5. ArcGIS API for JavaScript 引入

6. 地图模块开发、地图基础组件开发（底图切换、二/三维切换、比例尺、图例等等）

7. 目录树开发、图层加载

8. 属性查询、空间查询、卷帘分析，多屏对比功能模块开发

9. 首页大屏开发、图层数据可视化（Echarts）

10. 系统非 GIS 功能模块开发（登录、图表查询、用户管理等）

11. 以上各个功能模块中涉及到的数据处理及服务发布

12. 项目部署，公网服务器访问 