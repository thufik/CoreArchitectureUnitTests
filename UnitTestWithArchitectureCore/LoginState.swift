//
//  LoginState.swift
//  UnitTestWithArchitectureCore
//
//  Created by EquipeSuporteAplicacao on 5/24/18.
//  Copyright © 2018 Thufik. All rights reserved.
//

import CoreArchitecture
import UIKit

struct LoginState : State {
    var isLoading : Bool
    var hasError : ErrorTypes?
    var isSuccessfull : [String : Any]?
}
