//
//  EventViewController.swift
//  Beamore
//
//  Created by Onur Celik on 06/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class EventViewController: BaseViewController {
    
    @IBOutlet var eventTableView: EventTableView! {
        didSet{
            eventTableView.actionDelegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }

    
    func configure() {
        
    }
    
    func getEvents() {
        
    }
    
}

extension EventViewController : EventTableViewDelegate {

}
