//
//  LoginController.swift
//  UI_Project
//
//  Created by Ilya Dunaev on 03.12.2020.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGuesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGuesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Adding authorization status listener
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "Log In", sender: nil)
                self.loginInput.text = nil
                self.passwordInput.text = nil
            }
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(handle)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    //
    //        let checkResult = checkUserData()
    //
    //        if !checkResult {
    //            showLoginError()
    //        }
    //        return checkResult
    //    }
    //
    //    func checkUserData() -> Bool {
    //        guard let userLogin = loginInput.text, let userPassword = passwordInput.text else {return false}
    //
    //        if userLogin == "1" && userPassword == "1" {
    //            return true
    //        } else {
    //            return false
    //        }
    //
    //    }
    //
        func showLoginError() {
            let alert = UIAlertController(title:"Error", message: "Error", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    
    @IBOutlet var loginInput: UITextField!
    
    @IBOutlet var passwordInput: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var handle: AuthStateDidChangeListenerHandle!
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        // 1
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        // 2
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        // 3
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        // 4
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            // 4.1
            guard let emailField = alert.textFields?[0],
                  let passwordField = alert.textFields?[1],
                  let password = passwordField.text,
                  let email = emailField.text else { return }
            // 4.2
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
                if let error = error {
                    print(error.localizedDescription)
//                    self?.showAlert(title: "Error", message: error.localizedDescription)
                } else {
                    // 4.3
                    Auth.auth().signIn(withEmail: email, password: password)
                }
            }
        }
        // 5
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        // 1
        guard
            let email = loginInput.text,
            let password = passwordInput.text,
            email.count > 0,
            password.count > 0
        else {
            print("Login/password is not entered")
            //            self.showAlert(title: "Error", message: "Login/password is not entered")
            return
        }
        // 2
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                print(error.localizedDescription)
//                alert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
}
