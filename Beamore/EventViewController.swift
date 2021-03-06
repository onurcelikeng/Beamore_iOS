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
        self.configure()
        self.getEvents()
    }

    private func configure() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: Any) {
        self.eventList.removeAll()
        self.getEvents()
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
    
    private func unSubscribeEvent(eventKey: String) {
        let client = EventService()
        DispatchQueue.global(qos: .userInitiated).async {
            client.unSubscribeEvent(eventKey: eventKey) { (model) -> Void in
                DispatchQueue.main.async {
                    if model.isSuccess {
                        self.eventList.removeAll()
                        self.getEvents()
                    }
                }
            }
        }
    }
    
    @IBAction func exitButtonClick(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "token")
        defaults.synchronize()
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "login")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableCell", for: indexPath) as! EventTableViewCell
        if(eventList.count > 0) {
            cell.eventName.text = eventList[indexPath.row].eventName
            cell.eventEmail.text = eventList[indexPath.row].eventEmail
            
            let imageURL = URL(string: self.eventList[indexPath.row].logoUrl)
            let session = URLSession(configuration: .default)
            let downloadImageTask = session.dataTask(with: imageURL!) { (data, response, error) in
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        DispatchQueue.main.async {
                            cell.eventPhoto.image = UIImage(data: imageData)
                            cell.eventPhoto.layer.cornerRadius = cell.eventPhoto.layer.frame.height / 2
                            cell.eventPhoto.layer.masksToBounds = true
                        }
                    }
                }
            }
            downloadImageTask.resume()
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let eventKey = eventList[indexPath.row].eventKey
            self.unSubscribeEvent(eventKey: eventKey)
        }
    }

}
