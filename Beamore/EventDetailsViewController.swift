//
//  EventDetailsViewController.swift
//  Beamore
//
//  Created by Onur Celik on 06/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController  {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var surveyView: UIView!
    @IBOutlet weak var flowView: UIView!
    
    public static var eventKey: String = ""
    public static var eventPhotoText: String = ""
    public static var eventNameText: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        
    }


    private func configure() {
        self.title = EventDetailsViewController.eventNameText
        homeView.isHidden = false
        notificationView.isHidden = true
        surveyView.isHidden = true
        flowView.isHidden = true
    }
    
    
    @IBAction func backButtonClick(_ sender: Any) {
        dismiss(animated: true) {}
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            homeView.isHidden = false
            notificationView.isHidden = true
            surveyView.isHidden = true
            flowView.isHidden = true
            break
        case 1:
            homeView.isHidden = true
            notificationView.isHidden = true
            surveyView.isHidden = false
            flowView.isHidden = true
            break
        case 2:
            homeView.isHidden = true
            notificationView.isHidden = false
            surveyView.isHidden = true
            flowView.isHidden = true
            break
        case 3:
            homeView.isHidden = true
            notificationView.isHidden = true
            surveyView.isHidden = true
            flowView.isHidden = false
            break
        default:
            break
        }
    }
    
}
