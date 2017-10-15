//
//  EventHomeViewController.swift
//  Beamore
//
//  Created by Onur Celik on 15/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class EventHomeViewController: UIViewController {

    @IBOutlet weak var eventPhotoImageView: UIImageView!
    @IBOutlet weak var eventPersonSizeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getEventParticipant()
    }

    
    private func configure() {
        let imageURL = URL(string: EventDetailsViewController.eventPhotoText)
        let session = URLSession(configuration: .default)
        let downloadImageTask = session.dataTask(with: imageURL!) { (data, response, error) in
            if (response as? HTTPURLResponse) != nil {
                if let imageData = data {
                    DispatchQueue.main.async {
                        self.eventPhotoImageView.image = UIImage(data: imageData)
                        self.eventPhotoImageView.layer.cornerRadius = self.eventPhotoImageView.layer.frame.height / 2
                        self.eventPhotoImageView.layer.masksToBounds = true
                    }
                }
            }
        }
        downloadImageTask.resume()
    }
    
    private func getEventParticipant() {
        let client = EventService()
        DispatchQueue.global(qos: .userInitiated).async {
            client.getEventParticipant(eventKey: EventDetailsViewController.eventKey) { (model) -> Void in
                DispatchQueue.main.async {
                    self.eventPersonSizeLabel.text = String(model.data) + " kişi kayıtlı"
                }
            }
        }
    }
}
