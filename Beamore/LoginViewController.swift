//
//  LoginViewController.swift
//  Beamore
//
//  Created by Onur Celik on 06/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginUIButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    
    private func configure() {
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderColor = (UIColor .lightGray).cgColor;
        emailTextField.layer.borderWidth = 0.5
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = (UIColor .lightGray).cgColor;
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.isSecureTextEntry = true
        
        loginUIButton.layer.cornerRadius = 10
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    public func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginUIButtonClick(_ sender: Any) {
        if(emailTextField.text != nil && passwordTextField.text != nil) {
            let email = emailTextField.text
            let password = passwordTextField.text
            
            DispatchQueue.global(qos: .userInitiated).async {
                let accountService = AccountService()
                accountService.login(username: email!, password: password!) { (model) -> Void in
                    if model.access_token != nil {
                        let defaults = UserDefaults.standard
                        defaults.set("token", forKey: model.access_token)
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
    
}
