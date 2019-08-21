//
//  ViewController.swift
//  UnitTestWithArchitectureCore
//
//  Created by EquipeSuporteAplicacao on 5/23/18.
//  Copyright © 2018 Thufik. All rights reserved.
//

import CoreArchitecture
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtMail: UITextField!
    
    @IBOutlet weak var txtPass: UITextField!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var core : Core!
    
    var component : Component<LoginState>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        core = Core(rootComponent: component)
        component.subscribe(self)
    }
    
    @IBAction func enter(_ sender: UIButton) {
        
        guard let mail = txtMail.text, let pass = txtPass.text else {
            return
        }
        
        core.dispatch(LoginAction.login(email: mail, pass: pass))
    }
    
    private func showAlert(errorType : ErrorTypes){
        
        if let alert = self.presentedViewController as? UIAlertController{
            alert.message = errorType.message()
            return
        }else{
            let alert = UIAlertController(title: "Atenção", message: errorType.message(), preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Ok", style: .default, handler : nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func showWelcomeScreen(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let welcomeScreen = storyboard.instantiateViewController(withIdentifier: "welcomeViewController")
        
        self.present(welcomeScreen, animated: true, completion: nil)
    }
}

extension LoginViewController : Subscriber{
    
    typealias StateType = LoginState
    
    func update(with state: StateType) {
        
        if let error = state.hasError{
            self.showAlert(errorType: error)
        }
        
        if state.isLoading{
            self.indicatorView.startAnimating()
        }else{
            self.indicatorView.stopAnimating()
        }
        
        if state.isSuccessfull != nil{
            self.showWelcomeScreen()
        }
    }
    
    func perform(_ navigation: Navigation) {
        
    }
}
