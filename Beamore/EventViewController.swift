//
//  EventViewController.swift
//  Beamore
//
//  Created by Onur Celik on 06/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var eventList: [EventModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getEvents()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    
    @objc func refresh(_ sender: Any) {
        self.eventList.removeAll()
        //getEvents()
        refreshControl.endRefreshing()
    }

    private func getEvents() {
        let client = EventService()
        DispatchQueue.global(qos: .userInitiated).async {
            client.getMyEvents { (list) -> Void in
                for event in list {
                    self.eventList.append(event)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableCell", for: indexPath) as! EventTableViewCell
        if(eventList.count > 0) {
            cell.eventName.text = eventList[indexPath.row].eventName
            cell.eventEmail.text = eventList[indexPath.row].eventEmail
            
        DispatchQueue.main.async {
            let logoUrl = NSURL(string: self.eventList[indexPath.row].logoUrl)
             if logoUrl != nil {
             let data = NSData(contentsOf: (logoUrl as URL?)!)
             cell.eventPhoto.image = UIImage(data: data! as Data)
             cell.eventPhoto.layer.cornerRadius = cell.eventPhoto.layer.frame.height / 2
             }
         }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        EventDetailsViewController.eventKey = self.eventList[indexPath.row].eventKey
        EventDetailsViewController.eventPhotoText = self.eventList[indexPath.row].logoUrl
        EventDetailsViewController.eventNameText = self.eventList[indexPath.row].eventName
        
        performSegue(withIdentifier: "oneSegue", sender: nil)
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
    
    }

}
