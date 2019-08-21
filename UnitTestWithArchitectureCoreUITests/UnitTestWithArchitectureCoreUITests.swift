//
//  UnitTestWithArchitectureCoreUITests.swift
//  UnitTestWithArchitectureCoreUITests
//
//  Created by EquipeSuporteAplicacao on 5/28/18.
//  Copyright © 2018 Thufik. All rights reserved.
//

import XCTest

class UnitTestWithArchitectureCoreUITests: XCTestCase {
    
    var app : XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        //continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()

        app = XCUIApplication()

        app.launchEnvironment = ["TESTE" : "TESTE"]
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginWithEmptyValues() {
        
        let button = app.buttons.firstMatch
        let txtMail = app.textFields["txtMail"]
        let txtPass = app.textFields["txtPass"]
        
        txtMail.tap()
        txtMail.typeText("")
        txtPass.tap()
        txtPass.typeText("")
        
        button.tap()
        
        let alert = app.alerts.firstMatch
        
        let bundle = Bundle(for: UnitTestWithArchitectureCoreUITests.self)
        
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(alert.staticTexts[NSLocalizedString("error.empty.mail.pass", bundle : bundle, comment: "")].exists)
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLoginWithSuccessfull() {
        let button = app.buttons.firstMatch
        let txtMail = app.textFields["txtMail"]
        let txtPass = app.textFields["txtPass"]
        
        txtMail.tap()
        txtMail.typeText("teste")
        txtPass.tap()
        txtPass.typeText("teste")
        
        button.tap()
        
        let welcomeLabel = app.otherElements["lblWelcome"]
        
        XCTAssertTrue(welcomeLabel.exists)
        
//        let alert = app.alerts.firstMatch
//
//        let bundle = Bundle(for: UnitTestWithArchitectureCoreUITests.self)
//
//        XCTAssertTrue(alert.exists)
//        XCTAssertTrue(alert.staticTexts[NSLocalizedString("error.empty.mail.pass", bundle : bundle, comment: "")].exists)
        
    }
    
}
