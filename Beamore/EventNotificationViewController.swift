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
    var refreshControl: UIRefreshControl!
    var notificationList: [NotificationModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.getEventNotification()
    }
    
    
    private func configure() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        notificationTableView.addSubview(refreshControl)
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
    
    @objc func refresh(_ sender: Any) {
        self.notificationList.removeAll()
        self.getEventNotification()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = notificationList[indexPath.row].message
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notification = self.notificationList[indexPath.row].message
        let alertSuccess = UIAlertController(title: "", message: notification, preferredStyle: UIAlertControllerStyle.alert)
        let closeAction = UIAlertAction(title: "Kapat", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
        }
        alertSuccess.addAction(closeAction)
        self.present(alertSuccess, animated: true, completion: nil)
    }
    
    
}
