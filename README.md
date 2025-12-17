# 签到助手 (Attendance Assistant)

一款专为学生设计的iOS签到应用，帮助您轻松管理各类课程和自习时间的签到提醒。

## 功能特点

- 实时显示早自习、晚自习以及多门课程的签到时间
- 自动检测当前是否处于签到时间范围
- 倒计时显示距离签到结束的剩余时间
- 一键跳转至签到页面进行位置签到
- 地图定位功能，方便确认当前位置

## 签到时间安排

可在 [`ContentView.swift`](up/ContentView.swift) 文件中替换

1. **早自习**: 06:30 - 08:20
2. **第12节课**: 08:30 - 09:30
3. **第34节课**: 10:25 - 11:25
4. **第56节课**: 14:40 - 15:40
5. **第89节课**: 16:30 - 17:30
6. **晚自习**: 18:50 - 20:00

## 使用说明

1. 应用启动后会自动检测当前时间并显示相关签到信息
2. 处于签到时间范围内时，会显示倒计时提醒
3. 点击"点击打卡签到"按钮会跳转到指定的签到链接
4. 不同时间段会跳转到不同的签到页面：
   - 早自习和晚自习时间段：使用专用签到链接
   - 课程签到时间段：使用课程签到链接
   - 非签到时间段：同样跳转到课程签到链接

## 技术细节

本应用基于SwiftUI开发，使用了以下技术：

- SwiftUI界面框架
- MapKit地图功能
- CoreLocation定位服务
- Combine框架处理异步事件

## 安装与运行

### 所需准备工作

在使用本应用之前，您需要准备以下工具和环境：

1. 一台运行 macOS 的 Mac 电脑（建议 macOS 10.15 Catalina 或更高版本）
2. Xcode 开发环境（可从 Mac App Store 免费下载）
3. 一部 iPhone 设备（用于实际测试，也可使用 Xcode 内置模拟器）
4. Apple 开发者账号（免费账号即可，但如需在真机上运行则需要配置相关证书）
5. 获取签到链接，在 [`ContentView.swift`](up/ContentView.swift) 文件中替换（默认跳转微信小程序"群报数"）

### 运行步骤

1. 克隆本仓库到本地
2. 使用Xcode打开项目文件([up.xcodeproj](up.xcodeproj))
3. 连接iOS设备或使用模拟器
4. 编译并运行应用

## 使用GPX文件模拟定位

本项目包含了多个GPX文件，可用于在Xcode中模拟不同的地理位置：

1. [loction_gdut_J1J2.gpx](up/gpx/loction_gdut_J1J2.gpx) - J1J2教学楼位置
2. [loction_gdut_J3J4.gpx](up/gpx/loction_gdut_J3J4.gpx) - J3J4教学楼位置
3. [loction_gdut_J5J6.gpx](up/gpx/loction_gdut_J5J6.gpx) - J5J6教学楼位置

### 在Xcode中使用GPX文件模拟定位：

1. 在Xcode中运行您的应用
2. 打开调试导航器（Debug Navigator）
3. 点击位置模拟按钮（Simulate Location）
4. 选择所需的GPX文件或自定义位置

### 创建自定义GPX文件：

您可以创建自己的GPX文件来模拟特定位置：

1. 在Xcode中右键点击[gpx](up/gpx/)文件夹
2. 选择"New File"
3. 选择"GPX File"模板
4. 输入文件名
5. 修改文件中的经纬度坐标以设置所需位置

## 开源许可

本项目采用MIT许可证，详情请参阅[LICENSE](LICENSE)文件。

## 作者

罗霖 - luolin_0926@icloud.com

项目地址：[https://github.com/LUOLIN926/up-Attendance-Assistant](https://github.com/LUOLIN926/up-Attendance-Assistant)