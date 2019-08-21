//
//  UnitTestWithArchitectureCoreTests.swift
//  UnitTestWithArchitectureCoreTests
//
//  Created by EquipeSuporteAplicacao on 5/23/18.
//  Copyright © 2018 Thufik. All rights reserved.
//

import CoreArchitecture
import XCTest
@testable import UnitTestWithArchitectureCore

class UnitTestWithArchitectureCoreTests: XCTestCase {
    
    var core : Core!
    var component : Component<LoginState>!
    
    override func setUp() {
        super.setUp()
        
        component = FakeLoginComponent(state: LoginState(isLoading: false, hasError: nil, isSuccessfull: nil))
        core = Core(rootComponent: component)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginWithEmptyMailAndPass(){
        component = LoginComponent(state: LoginState(isLoading: false, hasError: nil, isSuccessfull: nil))
        core = Core(rootComponent: component)
        
        core.dispatch(LoginAction.login(email: "", pass: ""))
        
        XCTAssert(component.state.hasError != nil)
        XCTAssert(component.state.hasError == .userOrPassEmpty)
        XCTAssert(component.state.isSuccessfull == nil)
    }
    
    func testLoginWithInvalidCredentials(){
        core.dispatch(LoginFakeAction.loginWithInvalidCredentials)
        
        XCTAssert(component.state.hasError != nil)
        XCTAssert(component.state.hasError == .invalidCredentials)
        XCTAssert(component.state.isSuccessfull == nil)
    }
    
    func testLoginWithUnknownError(){
        core.dispatch(LoginFakeAction.loginWithUnknownError)
        
        XCTAssert(component.state.hasError != nil)
        XCTAssert(component.state.hasError == .unknownError)
        XCTAssert(component.state.isSuccessfull == nil)
    }
    
    func testLoginSuccess(){
        core.dispatch(LoginFakeAction.loginSuccessfull)
        
        XCTAssert(component.state.isSuccessfull != nil)
        XCTAssert(component.state.hasError == nil)
    }
}

