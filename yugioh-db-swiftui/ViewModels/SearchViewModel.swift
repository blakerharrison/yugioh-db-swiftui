//
//  SearchViewModel.swift
//  yugioh-db-swiftui
//
//  Created by bhrs on 10/8/21.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<TimeModel, Error>()
    
    @Published var time: String = "0 seconds"
    @Published var seconds: String = "0"
    
    @Published var timeModel = TimeModel(seconds: 0)
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        passthroughSubject
            .dropFirst(2)
            .filter({ (value) -> Bool in
                value != "5"
            })
            .map { value in
                return value + " seconds"
            }
            .sink { (completion) in
                switch completion {
                case .finished:
                    self.time = "Finished"
                case .failure(let error):
                    self.time = error.localizedDescription
                }
            } receiveValue: { (value) in
                self.time = value
            }
            .store(in: &cancellables)
        
        passthroughModelSubject.sink { (completion) in
            print(completion)
        } receiveValue: { (timeModel) in
            self.timeModel = timeModel
        }.store(in: &cancellables)

    }
    
    func startFetch() {
        YGOPROService.fetch { (result) in
            switch result {
            case .success(let value):
                if value == "10" {
                    self.passthroughSubject.send(completion: .finished)
                } else {
                    self.passthroughSubject.send(value)
                }
                self.seconds = value
            case .failure(let error):
                self.passthroughSubject.send(completion: .failure(error))
                self.seconds = error.localizedDescription
            }
        }
        
        YGOPROService.fetchModel { (result) in
            switch result {
            case .success(let timeModel):
                self.passthroughModelSubject.send(timeModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
