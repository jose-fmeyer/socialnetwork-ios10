//
//  DownloadError.swift
//  socialnetwork
//
//  Created by Jose Fernando Meyer on 10/04/17.
//  Copyright © 2017 Jose Fernando Meyer. All rights reserved.
//

import Foundation

enum DownloadError: Error {
    case resourceNotFound
    
    func description() -> String {
        switch self {
        case .resourceNotFound:
            return "The resource sent to download wasn't found."
        }
    }
}
