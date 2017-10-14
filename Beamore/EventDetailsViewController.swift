//
//  EventDetailsViewController.swift
//  Beamore
//
//  Created by Onur Celik on 06/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var flowView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var surveyView: UIView!
    public static var eventKey: String = ""
    public static var eventPhotoText: String = ""
    public static var eventNameText: String = ""
    @IBOutlet weak var eventPhoto: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventPersonSize: UILabel!
    

    @IBOutlet weak var notificationTableView: UITableView!
    var notificationList: [NotificationModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.getEventParticipant()
    }

    
    private func configure() {
        homeView.isHidden = false
        flowView.isHidden = true
        notificationView.isHidden = true
        surveyView.isHidden = true
        eventName.text = EventDetailsViewController.eventNameText
        DispatchQueue.main.async {
            let logoUrl = NSURL(string: EventDetailsViewController.eventPhotoText)
            if logoUrl != nil {
                let data = NSData(contentsOf: (logoUrl as URL?)!)
                self.eventPhoto.image = UIImage(data: data! as Data)
            }
        }
    }
    
    private func getEventParticipant() {
        let client = EventService()
        DispatchQueue.global(qos: .userInitiated).async {
            client.getEventParticipant(eventKey: EventDetailsViewController.eventKey) { (model) -> Void in
                DispatchQueue.main.async {
                    if model != nil {
                        self.eventPersonSize.text = String(model.data) + " kişi kayıtlı"
                    }
                }
            }
        }
    }
    
    private func getEventNotifications() {
        self.notificationList.removeAll()
        
        let client = NotificationService()
        DispatchQueue.global(qos: .userInitiated).async {
            client.getEventNotifications(eventKey: EventDetailsViewController.eventKey) { (list) -> Void in
                for item in list {
                    self.notificationList.append(item)
                }
                
                DispatchQueue.main.async {
                    self.notificationTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        dismiss(animated: true) {}
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            homeView.isHidden = false
            flowView.isHidden = true
            notificationView.isHidden = true
            surveyView.isHidden = true
            break
        case 1:
            homeView.isHidden = true
            flowView.isHidden = false
            notificationView.isHidden = true
            surveyView.isHidden = true
            break
        case 2:
            homeView.isHidden = true
            flowView.isHidden = true
            notificationView.isHidden = false
            surveyView.isHidden = true
            self.getEventNotifications()
            break
        case 3:
            homeView.isHidden = true
            flowView.isHidden = true
            notificationView.isHidden = true
            surveyView.isHidden = false
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = notificationList[indexPath.row].message
        
        return cell
    }
    
}
