//
//  LoginComponent.swift
//  UnitTestWithArchitectureCore
//
//  Created by EquipeSuporteAplicacao on 5/24/18.
//  Copyright © 2018 Thufik. All rights reserved.
//

import Alamofire
import CoreArchitecture
import UIKit

public enum LoginAction: Action {
    case login(email : String, pass : String)
}

public enum ErrorTypes{
    case userOrPassEmpty
    case invalidCredentials
    case unknownError
    
    private func key() -> String{
        switch self {
            case .userOrPassEmpty : return "error.empty.mail.pass"
            case .invalidCredentials : return "error.invalid.credentials"
            case .unknownError : return "error.unknown"
        }
    }
    
    func message() -> String{
        switch self{
            default : return NSLocalizedString(self.key(), comment: "")
        }
    }
}

class LoginComponent: Component<LoginState> {

    override func process(_ action: Action) {
        
        guard let action = action as? LoginAction else{
            return
        }
        
        switch action {
            case .login(email: let mail, pass: let pass): self.login(email: mail, pass: pass)
        }
    }
    
    private func login(email : String, pass : String){
        self.resetStates()
        
        var state = self.state
        
        let isEmailOrPassEmpty = self.isEmailOrPassEmpty(email: email, pass: pass)
        
        if isEmailOrPassEmpty{
            let error : ErrorTypes = .userOrPassEmpty
            
            state.hasError = error
            self.commit(state)
        }else{
            self.requestToServer(email: email, pass: pass)
        }
    }
    
    func requestToServer(email : String, pass : String){

        self.commitStateLoading()
        
        let params = ["login" : email, "password" :pass]
        
        let baseUrl = Configuration.baseUrl()
        
        Alamofire.request("\(baseUrl!)/login/2121", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { response in
            
            self.commitStateIsNotLoading()
            
            switch response.result{
            case .success( _) :
                self.commitSuccessfullState()
            case .failure( _) :
                self.commitErrorState(errorType: .unknownError)
            }
        })
    }
    
    func isEmailOrPassEmpty(email : String, pass : String) -> Bool{
        if (email == "") || (pass == ""){
            return true
        }
        
        return false
    }
    
    func resetStates(){
        var state = self.state
        
        state.hasError = nil
        state.isLoading = false
        state.isSuccessfull = nil
    }
    
    func commitStateLoading(){
        var state = self.state
        
        state.isLoading = true
        self.commit(state)
    }
    
    func commitStateIsNotLoading(){
        var state = self.state
        
        state.isLoading = false
        self.commit(state)
    }
    
    func commitSuccessfullState(){
        var state = self.state
        
        state.isSuccessfull = ["sucesso" : "ok"]
        self.commit(state)
    }
    
    func commitErrorState(errorType : ErrorTypes){
        var state = self.state
        
        state.hasError = errorType
        self.commit(state)
    }
}
