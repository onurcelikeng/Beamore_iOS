//
//  ForgotPasswordViewController.swift
//  Beamore
//
//  Created by Onur Celik on 13/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    
    private func resetPassword() {
        if emailTextFiled.text != "" {
            
        } else {
            let alertSuccess = UIAlertController(title: "Bildirim", message: "Lütfen bilgilerinizi girdiğinizden emin olunuz.", preferredStyle: UIAlertControllerStyle.alert)
            let closeAction = UIAlertAction(title: "Kapat", style: UIAlertActionStyle.destructive) {
                (result : UIAlertAction) -> Void in
            }
            alertSuccess.addAction(closeAction)
            self.present(alertSuccess, animated: true, completion: nil)
        }
    }
    
    @IBAction func resetButtonClick(_ sender: Any) {
        self.resetPassword()
    }
    
    private func configure() {
        var frame = emailTextFiled.frame
        frame.size.height = 35
        emailTextFiled.frame = frame
        emailTextFiled.layer.cornerRadius = 10
        emailTextFiled.layer.borderColor = (UIColor .lightGray).cgColor;
        emailTextFiled.layer.borderWidth = 0.5
        emailTextFiled.keyboardType = UIKeyboardType.emailAddress
        
        resetButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
    }

    @IBAction func cancelButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
