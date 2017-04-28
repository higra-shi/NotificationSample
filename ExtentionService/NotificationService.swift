//
//  NotificationService.swift
//  ExtentionService
//
//  Created by 原田 周作 on 2017/04/22.
//  Copyright © 2017年 Shusaku HARADA. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"

            if let imageUrl = Bundle.main.url(forResource: "sakura_20170415_01", withExtension: "jpg") {
                let imageAttachment = try! UNNotificationAttachment(identifier: "image",
                                                                    url: imageUrl,
                                                                    options: nil)
                bestAttemptContent.attachments = [imageAttachment]
            }

            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
