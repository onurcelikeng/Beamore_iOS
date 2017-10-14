//
//  RegisterViewController.swift
//  Beamore
//
//  Created by Onur Celik on 06/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var usernameUITextFiled: UITextField!
    @IBOutlet weak var emailUITextFiled: UITextField!
    @IBOutlet weak var passwordUITextFiled: UITextField!
    @IBOutlet weak var registerUIButton: UIButton!
    @IBOutlet weak var cancelUIButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    
    private func configure() {
        var frameUserName = usernameUITextFiled.frame
        frameUserName.size.height = 35
        usernameUITextFiled.frame = frameUserName
        usernameUITextFiled.layer.cornerRadius = 10
        usernameUITextFiled.layer.borderColor = (UIColor .lightGray).cgColor;
        usernameUITextFiled.layer.borderWidth = 0.5
        usernameUITextFiled.keyboardType = UIKeyboardType.emailAddress
        
        var frameEmail = emailUITextFiled.frame
        frameEmail.size.height = 35
        emailUITextFiled.frame = frameEmail
        emailUITextFiled.layer.cornerRadius = 10
        emailUITextFiled.layer.borderColor = (UIColor .lightGray).cgColor;
        emailUITextFiled.layer.borderWidth = 0.5
        emailUITextFiled.keyboardType = UIKeyboardType.emailAddress
        
        var framePassword = passwordUITextFiled.frame
        framePassword.size.height = 35
        passwordUITextFiled.frame = framePassword
        passwordUITextFiled.layer.cornerRadius = 10
        passwordUITextFiled.layer.borderColor = (UIColor .lightGray).cgColor;
        passwordUITextFiled.layer.borderWidth = 0.5
        passwordUITextFiled.isSecureTextEntry = true
        
        registerUIButton.layer.cornerRadius = 10
        cancelUIButton.layer.cornerRadius = 10
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func registerUIButtonClick(_ sender: Any) {
        if(usernameUITextFiled.text != nil && emailUITextFiled.text != nil && passwordUITextFiled.text != nil) {
            let username = usernameUITextFiled.text
            let email = emailUITextFiled.text
            let password = passwordUITextFiled.text
            
            DispatchQueue.global(qos: .userInitiated).async {
                let accountService = AccountService()
                accountService.register(username: username!, email: email!, password: password!) { (model) -> Void in
                    if model.isSuccess {
                        DispatchQueue.main.async(execute: {
                            let alertSuccess = UIAlertController(title: "Bildirim", message: "Onay mesajı mail adresine gönderilmiştir. Lütfen hesabınızı kontrol ediniz ve onaylayınız.", preferredStyle: UIAlertControllerStyle.alert)
                            let closeAction = UIAlertAction(title: "Kapat", style: UIAlertActionStyle.destructive) {
                                (result : UIAlertAction) -> Void in
                            }
                            alertSuccess.addAction(closeAction)
                            self.present(alertSuccess, animated: true, completion: nil)
                        });
                    } else {
                        DispatchQueue.main.async(execute: {
                            let alertSuccess = UIAlertController(title: "Bildirim", message: "Lütfen bilgilerinizi doğru girdiğinizden emin olunuz.", preferredStyle: UIAlertControllerStyle.alert)
                            let closeAction = UIAlertAction(title: "Kapat", style: UIAlertActionStyle.destructive) {
                                (result : UIAlertAction) -> Void in
                            }
                            alertSuccess.addAction(closeAction)
                            self.present(alertSuccess, animated: true, completion: nil)
                        });
                    }
                }
            }
        }
    }
    
    @IBAction func cancelUIButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
