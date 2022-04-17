//
//  LoginViewController.swift
//  RxSwift CookBook
//
//  Created by Hamit Seyrek on 18.04.2022.
//

import RxSwift
import RxCocoa
import UIKit
import Foundation

class LoginVC : UIViewController {
    
    @IBOutlet weak var userNameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag3 = DisposeBag()
    
    override func viewDidLoad() {
        self.title = "Login"
        
        let observable1 = self.userNameTf.rx.text.orEmpty
        let observable2 = self.passwordTf.rx.text.orEmpty
        
        let observableCombined = Observable.combineLatest(observable1, observable2)
        
        self.loginButton.rx.tap
            .withLatestFrom(observableCombined)
            .subscribe( onNext: { (user, pass) in
                self.login(user: user, pass: pass)
            })
            .disposed(by: disposeBag3)

    }
    
    func login(user : String, pass : String) {
        
        let emailRegEx = "^(?!\\.)(\"([^\"\\r\\\\]|\\\\[\"\\r\\\\])*\"|([-a-z0-9!#$%&'*+/=?^_`{|}~]|(?<!\\.)\\.)*)(?<!\\.)@[a-z0-9][\\w\\.-]*[a-z0-9]\\.[a-z][a-z\\.]*[a-z]$"
        let emailTest = NSPredicate (format: "SELF MATCHES[c] %@", emailRegEx)
        let emailValid : Bool = emailTest.evaluate(with: user)
        let passValid : Bool = (pass != "" && pass.count >= 6)
        
        if (emailValid && passValid) {
            
            let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC")
            homeVC?.title = userNameTf.text
            self.navigationController?.pushViewController(homeVC!, animated: true)
        } else {
            let alert = UIAlertController(title: "Wrong credentials", message: "Please enter a valid username and password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
