//
//  EventFlowViewController.swift
//  Beamore
//
//  Created by Onur Celik on 15/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class EventFlowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var flowTableView: UITableView!
    var refreshControl: UIRefreshControl!
    var sectionData: [Int: [FlowDayDetail]] = [:]
    var flowList: [Datum] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.getEventFlows()
    }
    
    
    private func configure() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        flowTableView.addSubview(refreshControl)
    }
    
    private func getEventFlows() {
        let client = EventService()
        DispatchQueue.global(qos: .userInitiated).async {
            client.getEventFlows(eventKey: EventDetailsViewController.eventKey) { (model) -> Void in
                var index = 0
                for item in model.data {
                    self.flowList.append(item)
                    self.sectionData[index] = item.flowDayDetail
                    index += 1
                }
                
                DispatchQueue.main.async {
                    self.flowTableView.reloadData()
                }
            }
        }
    }
    
    @objc func refresh(_ sender: Any) {
        self.flowList.removeAll()
        self.getEventFlows()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flowList.count == 0 {
            return 0
        } else {
            return (sectionData[section]?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(flowList[section].flowDay)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return flowList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
        cell.headerUILabel.text = String(flowList[section].flowDay) + ". Gün"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = sectionData[indexPath.section]![indexPath.row].flowTime + " - " + sectionData[indexPath.section]![indexPath.row].flowName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        EventFlowDetailViewController.flowId = String(sectionData[indexPath.section]![indexPath.row].flowId)
        EventFlowDetailViewController.flowTime = String(sectionData[indexPath.section]![indexPath.row].flowTime)
        
        performSegue(withIdentifier: "twoSegue", sender: nil)
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
    }
}
