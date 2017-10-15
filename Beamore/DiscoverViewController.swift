//
//  DiscoverViewController.swift
//  Beamore
//
//  Created by Onur Celik on 06/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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


    private func getEvents() {
        let client = EventService()
        DispatchQueue.global(qos: .userInitiated).async {
            
            client.getAllEvents { (list) -> Void in
                for event in list {
                    self.eventList.append(event)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func refresh(_ sender: Any) {
        self.eventList.removeAll()
        getEvents()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discoverTableCell", for: indexPath) as! DiscoverTableViewCell
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
        let eventKey = eventList[indexPath.row].eventKey
        
        let alert = UIAlertController(title: "Bildirim", message: "Etkinliğe kayıt olmak istediğinize emin misiniz?", preferredStyle: UIAlertControllerStyle.alert)
        let DestructiveAction = UIAlertAction(title: "Hayır", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
        }
        
        let okAction = UIAlertAction(title: "Evet", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            let client = EventService()
            _ = client.subscribeEvent(eventKey: eventKey, completionHandler: { (model) -> Void in
                if (model.isSuccess) {
                    let alertSuccess = UIAlertController(title: "Bildirim", message: model.message, preferredStyle: UIAlertControllerStyle.alert)
                    let closeAction = UIAlertAction(title: "Kapat", style: UIAlertActionStyle.destructive) {
                        (result : UIAlertAction) -> Void in
                    }
                    alertSuccess.addAction(closeAction)
                    self.present(alertSuccess, animated: true, completion: nil)
                    
                }
            })

        }
        
        alert.addAction(DestructiveAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
