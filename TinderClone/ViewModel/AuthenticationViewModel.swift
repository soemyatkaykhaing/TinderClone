//
//  AuthenticationViewModel.swift
//  TinderClone
//
//  Created by MacBook on 16/07/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
protocol AuthenticationViewModel {
    var formIsValid: Bool{
        get
    }
}
struct LoginViewModel {
    var email: String?
    var password: String?
    var formIsValid: Bool{
        return email?.isEmpty == false &&
            password?.isEmpty == false
    }
}
struct RegistrationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var formIsValid: Bool{
        return email?.isEmpty == false &&
            password?.isEmpty == false && fullname?.isEmpty == false
    }
}
