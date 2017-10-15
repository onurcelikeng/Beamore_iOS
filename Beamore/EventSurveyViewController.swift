//
//  EventSurveyViewController.swift
//  Beamore
//
//  Created by Onur Celik on 15/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class EventSurveyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var surveyTableView: UITableView!
    var surveyList: [SurveyModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getEventSurveys()
    }

    
    private func getEventSurveys() {
        let client = SurveyService()
        DispatchQueue.global(qos: .userInitiated).async {
            
            client.getEventSurveys(eventKey: EventDetailsViewController.eventKey) { (list) -> Void in
                for event in list {
                    self.surveyList.append(event)
                }
                
                DispatchQueue.main.async {
                    self.surveyTableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = surveyList[indexPath.row].questionText
        return cell
    }
    
}
