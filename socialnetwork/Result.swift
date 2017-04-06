//
//  Result.swift
//  socialnetwork
//
//  Created by Jose Fernando Meyer on 06/04/17.
//  Copyright © 2017 Jose Fernando Meyer. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Failure(Error)
}
