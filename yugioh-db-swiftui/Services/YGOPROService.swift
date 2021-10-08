//
//  YGOPROService.swift
//  yugioh-db-swiftui
//
//  Created by bhrs on 10/8/21.
//

import Foundation

struct YGOPROService {
    static let mockData = 1 ... 10
    
    static func fetch(completion: @escaping (Result<String, Error>) -> ()) {
        mockData.forEach { (value) in
            let delay = DispatchTimeInterval.seconds(value)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == 8 {
                    completion(.failure(ServiceError.invalid))
                } else {
                    completion(.success("\(value)"))
                }
            }
        }
    }
    
    static func fetchModel(completion: @escaping (Result<TimeModel, Error>) -> ()) {
        mockData.forEach { (value) in
            let delay = DispatchTimeInterval.seconds(value)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == 8 {
                    completion(.failure(ServiceError.invalid))
                } else {
                    completion(.success(TimeModel(seconds: value)))
                }
            }
        }
    }
}


struct ServiceError {
    static let invalid = NSError(domain: "Number 8 is invalid", code: 1, userInfo: nil)
}
