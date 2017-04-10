//
//  Providers.swift
//  socialnetwork
//
//  Created by Jose Fernando Meyer on 10/04/17.
//  Copyright © 2017 Jose Fernando Meyer. All rights reserved.
//

import Foundation

enum Provider {
    case FACEBOOK
    case FIREBASE
    
    func providerValue() -> String {
        switch self {
        case .FACEBOOK:
            return "facebook.com"
        case .FIREBASE:
            return "Firebase"
        }
    }
}
