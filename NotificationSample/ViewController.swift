//
//  ViewController.swift
//  NotificationSample
//
//  Created by 原田 周作 on 2017/04/16.
//  Copyright © 2017年 Shusaku HARADA. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func currentDateString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }

    @IBAction func OnTapNotificationButton(sender: UIButton) {
        let dateString = currentDateString()
        let notificationId = "Local-\(dateString.hashValue)"
        
        // 通知の内容を設定する
        let content = UNMutableNotificationContent()
        content.title = "Local"
        content.body = dateString
        content.userInfo = ["id": notificationId]
        
        // 通知の条件を設定する
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // 通知のリクエストを生成する
        let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
        // 通知をシステムに登録する
        UNUserNotificationCenter.current().add(request)
    }

}

