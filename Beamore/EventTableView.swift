//
//  EventTableView.swift
//  Beamore
//
//  Created by Onur Celik on 09/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

protocol EventTableViewDelegate {
    
}

class EventTableView: UITableView {

    let reuseIdentifier = "eventTableCell"
    var actionDelegate : EventTableViewDelegate?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
    }
}

extension EventTableView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    /*func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        /*if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? EventDetailActiveSurveyTableViewCell{
            let item = activeSurveys[indexPath.row]
            cell.configure(survey: item)
            return cell
        }
 
        return EventDetailActiveSurveyTableViewCell()
 */
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        if activeSurveys.count > indexPath.row{
            let item = activeSurveys[indexPath.row]
            self.actionDelegate?.activeSurveyDidSelected(item)
            self.reloadData()
        }
 */
    }
}
