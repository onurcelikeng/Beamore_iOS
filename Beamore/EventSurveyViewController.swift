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
    var refreshControl: UIRefreshControl!
    var surveyList: [SurveyModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.getEventSurveys()
    }

    
    private func configure() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        surveyTableView.addSubview(refreshControl)
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
    
    @objc func refresh(_ sender: Any) {
        self.surveyList.removeAll()
        self.getEventSurveys()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = surveyList[indexPath.row].questionText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.surveyList[indexPath.row].isAnswared {
            let alertSuccess = UIAlertController(title: "Bildirim", message: "Bu anketi daha önce cevapladınız.", preferredStyle: UIAlertControllerStyle.alert)
            let closeAction = UIAlertAction(title: "Kapat", style: UIAlertActionStyle.destructive) {
                (result : UIAlertAction) -> Void in
            }
            alertSuccess.addAction(closeAction)
            self.present(alertSuccess, animated: true, completion: nil)
        } else {
            SurveyAnswerViewController.questionId = self.surveyList[indexPath.row].questionId
            SurveyAnswerViewController.questionText = self.surveyList[indexPath.row].questionText
            
            performSegue(withIdentifier: "threeSegue", sender: nil)
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
}
