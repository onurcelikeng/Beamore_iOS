//
//  EventFlowDetailViewController.swift
//  Beamore
//
//  Created by Onur Celik on 15/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class EventFlowDetailViewController: UIViewController {

    public static var flowId: String = ""
    public static var flowTime: String = ""
    
    @IBOutlet weak var headerUILabel: UILabel!
    @IBOutlet weak var explainUILabel: UILabel!
    @IBOutlet weak var companyUILabel: UILabel!
    @IBOutlet weak var timeUILabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.getEventFlowDetails()
    }
    
    
    private func configure() {
        self.title = EventDetailsViewController.eventNameText
        self.timeUILabel.text?.append(EventFlowDetailViewController.flowTime)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func getEventFlowDetails() {
        let client = EventService()
        DispatchQueue.global(qos: .userInitiated).async {
            client.getEventFlowDetails(flowId: EventFlowDetailViewController.flowId) { (model) -> Void in
                
                DispatchQueue.main.async {
                    self.headerUILabel.text?.append(model.header)
                    self.explainUILabel.text?.append(model.explain)
                    self.companyUILabel.text?.append(model.company)
                }
            }
        }
    }
}
