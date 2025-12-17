//
//  ContentView.swift
//  up
//
//  Created by LIN on 2025/12/2.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

struct ContentView: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var timeRemainingMorning = ""
    @State private var timeRemainingEvening = ""
    @State private var isMorningTime = false
    @State private var isEveningTime = false
    @State private var showMap = false
    // 课程签到状态变量
    @State private var timeRemainingClass12 = ""
    @State private var timeRemainingClass34 = ""
    @State private var timeRemainingClass56 = ""
    @State private var timeRemainingClass89 = ""
    @State private var isClass12Time = false
    @State private var isClass34Time = false
    @State private var isClass56Time = false
    @State private var isClass89Time = false
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.9042, longitude: 116.4074),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image(systemName: "alarm.fill")
                        .imageScale(.large)
                        .font(.largeTitle)
                        .foregroundStyle(.yellow)
                        .padding(.top, 20)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("早自习打卡时间06:30-08:20")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text(getMorningDisplayText())
                            .fontWeight(.regular)
                            .foregroundColor(getMorningTextColor())
                        
                        //课程签到时间显示
                        Divider()
                            .padding(.vertical)
                        
                        Text("第12节课签到时间08:30-09:30")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text(getClass12DisplayText())
                            .fontWeight(.regular)
                            .foregroundColor(getClass12TextColor())
                        
                        Text("第34节课签到时间10:25-11:25")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text(getClass34DisplayText())
                            .fontWeight(.regular)
                            .foregroundColor(getClass34TextColor())
                        
                        Text("第56节课签到时间14:40-15:40")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text(getClass56DisplayText())
                            .fontWeight(.regular)
                            .foregroundColor(getClass56TextColor())
                        
                        Text("第89节课签到时间16:30-17:30")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text(getClass89DisplayText())
                            .fontWeight(.regular)
                            .foregroundColor(getClass89TextColor())
                        
                        Divider()
                            .padding(.vertical)
                        
                        Text("晚自习打卡时间18:50-20:00")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text(getEveningDisplayText())
                            .fontWeight(.regular)
                            .foregroundColor(getEveningTextColor())
                    }
                    .padding(.horizontal)
                    .onAppear {
                        updateTimeRemaining()
                    }
                    
                    Button(action: {
                        showMap = true
                    }) {
                        Text("点击打卡签到")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
            .padding()
            .alert("提示", isPresented: $showAlert) {
                Button("确定") { }
            } message: {
                Text(alertMessage)
            }
            .fullScreenCover(isPresented: $showMap) {
                MapView()
            }
        }
    }
    
    // 获取早上显示文本
    func getMorningDisplayText() -> String {
        if isMorningTime {
            return "距离早自习打卡截止还有 \(timeRemainingMorning) 分钟"
        } else {
            return "未到打卡时间"
        }
    }
    
    // 获取晚上显示文本
    func getEveningDisplayText() -> String {
        if isEveningTime {
            return "距离晚自习打卡截止还有 \(timeRemainingEvening) 分钟"
        } else {
            return "未到打卡时间"
        }
    }
    
    // 获取第12节课显示文本
    func getClass12DisplayText() -> String {
        if isClass12Time {
            return "距离第12节课签到截止还有 \(timeRemainingClass12) 分钟"
        } else {
            return "未到签到时间"
        }
    }
    
    // 获取第34节课显示文本
    func getClass34DisplayText() -> String {
        if isClass34Time {
            return "距离第34节课签到截止还有 \(timeRemainingClass34) 分钟"
        } else {
            return "未到签到时间"
        }
    }
    
    // 获取第56节课显示文本
    func getClass56DisplayText() -> String {
        if isClass56Time {
            return "距离第56节课签到截止还有 \(timeRemainingClass56) 分钟"
        } else {
            return "未到签到时间"
        }
    }
    
    // 获取第89节课显示文本
    func getClass89DisplayText() -> String {
        if isClass89Time {
            return "距离第89节课签到截止还有 \(timeRemainingClass89) 分钟"
        } else {
            return "未到签到时间"
        }
    }
    
    // 获取早上文本颜色
    func getMorningTextColor() -> Color {
        return isMorningTime ? .black : .green
    }
    
    // 获取晚上文本颜色
    func getEveningTextColor() -> Color {
        return isEveningTime ? .black : .green
    }
    
    // 获取第12节课文本颜色
    func getClass12TextColor() -> Color {
        return isClass12Time ? .black : .green
    }
    
    // 获取第34节课文本颜色
    func getClass34TextColor() -> Color {
        return isClass34Time ? .black : .green
    }
    
    // 获取第56节课文本颜色
    func getClass56TextColor() -> Color {
        return isClass56Time ? .black : .green
    }
    
    // 获取第89节课文本颜色
    func getClass89TextColor() -> Color {
        return isClass89Time ? .black : .green
    }
    
    // 计算距离各个课程签到结束的时间
    func updateTimeRemaining() {
        let calendar = Calendar.current
        let now = Date()
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let currentTimeInMinutes = hour * 60 + minute
        
        // 早自习时间段 06:30 (390分钟) - 08:20 (500分钟)
        let morningStartTime = 6 * 60 + 30
        let morningEndTime = 8 * 60 + 20
        
        // 晚自习时间段 18:50 (1130分钟) - 20:00 (1200分钟)
        let eveningStartTime = 18 * 60 + 50
        let eveningEndTime = 20 * 60 + 0
        
        // 第12节课签到时间 08:30 (510分钟) - 09:30 (570分钟)
        let class12StartTime = 8 * 60 + 30
        let class12EndTime = 9 * 60 + 30
        
        // 第34节课签到时间 10:25 (625分钟) - 11:25 (685分钟)
        let class34StartTime = 10 * 60 + 25
        let class34EndTime = 11 * 60 + 25
        
        // 第56节课签到时间 14:40 (880分钟) - 15:40 (940分钟)
        let class56StartTime = 14 * 60 + 40
        let class56EndTime = 15 * 60 + 40
        
        // 第89节课签到时间 16:30 (990分钟) - 17:30 (1050分钟)
        let class89StartTime = 16 * 60 + 30
        let class89EndTime = 17 * 60 + 30
        
        // 计算早自习剩余时间
        if currentTimeInMinutes >= morningStartTime && currentTimeInMinutes <= morningEndTime {
            let minutesLeft = morningEndTime - currentTimeInMinutes
            timeRemainingMorning = "\(minutesLeft)"
            isMorningTime = true
        } else {
            timeRemainingMorning = ""
            isMorningTime = false
        }
        
        // 计算晚自习剩余时间
        if currentTimeInMinutes >= eveningStartTime && currentTimeInMinutes <= eveningEndTime {
            let minutesLeft = eveningEndTime - currentTimeInMinutes
            timeRemainingEvening = "\(minutesLeft)"
            isEveningTime = true
        } else {
            timeRemainingEvening = ""
            isEveningTime = false
        }
        
        // 计算第12节课签到剩余时间
        if currentTimeInMinutes >= class12StartTime && currentTimeInMinutes <= class12EndTime {
            let minutesLeft = class12EndTime - currentTimeInMinutes
            timeRemainingClass12 = "\(minutesLeft)"
            isClass12Time = true
        } else {
            timeRemainingClass12 = ""
            isClass12Time = false
        }
        
        // 计算第34节课签到剩余时间
        if currentTimeInMinutes >= class34StartTime && currentTimeInMinutes <= class34EndTime {
            let minutesLeft = class34EndTime - currentTimeInMinutes
            timeRemainingClass34 = "\(minutesLeft)"
            isClass34Time = true
        } else {
            timeRemainingClass34 = ""
            isClass34Time = false
        }
        
        // 计算第56节课签到剩余时间
        if currentTimeInMinutes >= class56StartTime && currentTimeInMinutes <= class56EndTime {
            let minutesLeft = class56EndTime - currentTimeInMinutes
            timeRemainingClass56 = "\(minutesLeft)"
            isClass56Time = true
        } else {
            timeRemainingClass56 = ""
            isClass56Time = false
        }
        
        // 计算第89节课签到剩余时间
        if currentTimeInMinutes >= class89StartTime && currentTimeInMinutes <= class89EndTime {
            let minutesLeft = class89EndTime - currentTimeInMinutes
            timeRemainingClass89 = "\(minutesLeft)"
            isClass89Time = true
        } else {
            timeRemainingClass89 = ""
            isClass89Time = false
        }
    }
    
    func openLinkInBrowser() {
        // 根据当前时间判断使用哪个链接
        let calendar = Calendar.current
        let now = Date()
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let currentTimeInMinutes = hour * 60 + minute
        
        // 定义各个时间段
        let morningStartTime = 6 * 60 + 30
        let morningEndTime = 8 * 60 + 20
        let eveningStartTime = 18 * 60 + 50
        let eveningEndTime = 20 * 60 + 0
        let class12StartTime = 8 * 60 + 30
        let class12EndTime = 9 * 60 + 30
        let class34StartTime = 10 * 60 + 25
        let class34EndTime = 11 * 60 + 25
        let class56StartTime = 14 * 60 + 40
        let class56EndTime = 15 * 60 + 40
        let class89StartTime = 16 * 60 + 30
        let class89EndTime = 17 * 60 + 30
        
        let urlString: String
        
        // 判断当前时间属于哪个时间段
        if (currentTimeInMinutes >= morningStartTime && currentTimeInMinutes <= morningEndTime) ||
           (currentTimeInMinutes >= eveningStartTime && currentTimeInMinutes <= eveningEndTime) {
            // 早晚自习时间打卡链接
            urlString = "https://wxaurl.cn/hj6RYJJbrOi"
        } else if (currentTimeInMinutes >= class12StartTime && currentTimeInMinutes <= class12EndTime) ||
                  (currentTimeInMinutes >= class34StartTime && currentTimeInMinutes <= class34EndTime) ||
                  (currentTimeInMinutes >= class56StartTime && currentTimeInMinutes <= class56EndTime) ||
                  (currentTimeInMinutes >= class89StartTime && currentTimeInMinutes <= class89EndTime) {
            // 上课期间打卡新链接
            urlString = "https://wxaurl.cn/geRplptI37a"
        } else {
            // 不在任何签到时间段内的打卡链接
            urlString = "https://wxaurl.cn/geRplptI37a"
        }
        
        guard let url = URL(string: urlString) else {
            alertMessage = "无效的链接地址"
            showAlert = true
            return
        }
        
        // 尝试打开链接
        UIApplication.shared.open(url) { success in
            if !success {
                DispatchQueue.main.async {
                    alertMessage = "无法打开链接，请确保设备已安装浏览器应用"
                    showAlert = true
                }
            }
        }
    }
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.9042, longitude: 116.4074),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var locationManager = LocationManager()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("我的位置")
                .font(.title)
                .padding()
            
            Map(coordinateRegion: $region,
                showsUserLocation: true)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(40) 
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("返回")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    let contentView = ContentView()
                    contentView.openLinkInBrowser()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("确认位置并打卡")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .background(Color.white)
        .onAppear {
            // 请求定位权限并开始持续获取位置更新
            locationManager.startLocationUpdates { location in
                DispatchQueue.main.async {
                    // 实时更新地图区域，使用户位置保持在地图中心
                    region = MKCoordinateRegion(
                        center: location.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                }
            }
        }
    }
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var locationUpdateHandler: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 10 // 位置变化超过10米时才更新
    }
    
    func startLocationUpdates(completion: @escaping (CLLocation) -> Void) {
        self.locationUpdateHandler = completion
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationUpdateHandler?(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // 当权限获得批准后，开始位置更新
            manager.startUpdatingLocation()
        default:
            break
        }
    }
}

#Preview {
    ContentView()
}
