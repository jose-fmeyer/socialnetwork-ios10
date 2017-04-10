//
//  PostService.swift
//  socialnetwork
//
//  Created by Jose Fernando Meyer on 10/04/17.
//  Copyright © 2017 Jose Fernando Meyer. All rights reserved.
//

import UIKit
import FirebaseStorage

class PostService {
    
    public class var instance: PostService {
        struct Singleton {
            static let instance: PostService = PostService()
        }
        return Singleton.instance
    }
    
    private init() {}
    
    func downloadPostImageFromStorage(imageUrl: String, completion: @escaping (Result<Data>) -> ()) {
        let ref = FIRStorage.storage().reference(forURL: imageUrl)
        ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
            if error != nil {
                completion(Result.Failure(error!))
            }
            if data == nil {
                completion(Result.Failure(DownloadError.resourceNotFound))
            }
            completion(Result.Success(data!))
        })
    }
}
