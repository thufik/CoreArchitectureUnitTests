//
//  FakeLoginComponent.swift
//  UnitTestWithArchitectureCoreTests
//
//  Created by EquipeSuporteAplicacao on 5/29/18.
//  Copyright © 2018 Thufik. All rights reserved.
//


import CoreArchitecture
@testable import UnitTestWithArchitectureCore

public enum LoginFakeAction : Action{
    case loginWithEmptyValues
    case loginSuccessfull
    case loginWithInvalidCredentials
    case loginWithUnknownError
}

class FakeLoginComponent: Component<LoginState> {
    
    override func process(_ action: Action) {
        
        guard let action = action as? LoginFakeAction else{
            return
        }
        
        switch action {
        case .loginWithEmptyValues : self.loginWithEmptyValues()
        case .loginSuccessfull : self.loginSuccessfull()
        case .loginWithInvalidCredentials : self.loginWithInvalidCredentials()
        case .loginWithUnknownError : loginWithUnknownError()
        }
    }
    
    private func loginWithUnknownError(){
        var state = self.state
        state.hasError = .unknownError
        
        self.commit(state)
    }
    
    private func loginWithInvalidCredentials(){
        var state = self.state
        state.hasError = .invalidCredentials
        
        self.commit(state)
    }
    
    private func loginWithEmptyValues(){
        var state = self.state
        state.hasError = .userOrPassEmpty
        
        self.commit(state)
    }
    
    private func loginSuccessfull(){
        var state = self.state
        state.isSuccessfull = ["mensagem" : "ok"]
        
        self.commit(state)
    }
}
