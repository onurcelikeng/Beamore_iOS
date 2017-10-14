//
//  LoginViewController.swift
//  Beamore
//
//  Created by Onur Celik on 06/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginUIButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            if (token != nil) {
                let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabbar")
                appDelegate.window?.rootViewController = initialViewController
                appDelegate.window?.makeKeyAndVisible()
            }
        }
        
        self.configure()
    }
    
    
    private func configure() {
        var frameEmail = emailTextField.frame
        frameEmail.size.height = 35
        emailTextField.frame = frameEmail
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderColor = (UIColor .white).cgColor;
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        
        var framePassword = passwordTextField.frame
        framePassword.size.height = 35
        passwordTextField.frame = framePassword
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = (UIColor .lightGray).cgColor;
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.isSecureTextEntry = true
        
        loginUIButton.layer.cornerRadius = 10
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginUIButtonClick(_ sender: Any) {
        if(emailTextField.text != "" && passwordTextField.text != "") {
            let email = emailTextField.text
            let password = passwordTextField.text
            
            DispatchQueue.global(qos: .userInitiated).async {
                let accountService = AccountService()
                accountService.login(username: email!, password: password!) { (model) -> Void in
                    if !model.access_token.isEmpty {
                        DispatchQueue.main.async(execute: {
                            let defaults = UserDefaults.standard
                            defaults.set(model.access_token, forKey: "token")
                            defaults.synchronize()
                            
                            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                            let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabbar")
                            appDelegate.window?.rootViewController = initialViewController
                            appDelegate.window?.makeKeyAndVisible()
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
        } else {
            let alertSuccess = UIAlertController(title: "Bildirim", message: "Lütfen bilgilerinizi girdiğinizden emin olunuz.", preferredStyle: UIAlertControllerStyle.alert)
            let closeAction = UIAlertAction(title: "Kapat", style: UIAlertActionStyle.destructive) {
                (result : UIAlertAction) -> Void in
            }
            alertSuccess.addAction(closeAction)
            self.present(alertSuccess, animated: true, completion: nil)
        }
    }

}
