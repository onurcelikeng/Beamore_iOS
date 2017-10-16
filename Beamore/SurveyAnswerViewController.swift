//
//  SurveyAnswerViewController.swift
//  Beamore
//
//  Created by Onur Celik on 16/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class SurveyAnswerViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    public static var questionText = ""
    public static var questionId = 0
    var answerList: [SurveyAnswerModel] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.getSurveyAnswers()
    }
    
    
    private func configure() {
        self.questionLabel.text = SurveyAnswerViewController.questionText
    }
    
    private func getSurveyAnswers() {
        let client = SurveyService()
        DispatchQueue.global(qos: .userInitiated).async {
            client.getEventSurveyAnswers(questionId: String(SurveyAnswerViewController.questionId)) { (list) -> Void in
                for answer in list {
                    self.answerList.append(answer)
                }
                
                DispatchQueue.main.async {
                    self.oneButton.setTitle(self.answerList[0].optionText, for: .normal)
                    self.twoButton.setTitle(self.answerList[1].optionText, for: .normal)
                    self.threeButton.setTitle(self.answerList[2].optionText, for: .normal)
                }
            }
        }
    }

    private func sendSurveyAnswer(answer: Int) {
        let client = SurveyService()
        DispatchQueue.global(qos: .userInitiated).async {
            client.sendAnswer(optionId: answer, questionId: SurveyAnswerViewController.questionId) { (model) -> Void in
                DispatchQueue.main.async {
                    if model.isSuccess {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    

    
    @IBAction func backButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func oneButtonClick(_ sender: Any) {
        self.sendSurveyAnswer(answer: answerList[0].optionId)
    }
    
    @IBAction func twoButtonClick(_ sender: Any) {
        self.sendSurveyAnswer(answer: answerList[1].optionId)
    }
    
    @IBAction func threeButtonClick(_ sender: Any) {
        self.sendSurveyAnswer(answer: answerList[2].optionId)
    }
}
