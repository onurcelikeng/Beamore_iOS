//
//  EventNotificationViewController.swift
//  Beamore
//
//  Created by Onur Celik on 15/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class EventNotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var notificationTableView: UITableView!
    var notificationList: [NotificationModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getEventNotification()
    }
    

    private func getEventNotification() {
        let client = NotificationService()
        DispatchQueue.global(qos: .userInitiated).async {
            
            client.getEventNotifications(eventKey: EventDetailsViewController.eventKey) { (list) -> Void in
                for event in list {
                    self.notificationList.append(event)
                }
                
                DispatchQueue.main.async {
                    self.notificationTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = notificationList[indexPath.row].message
        return cell
    }
    
}
