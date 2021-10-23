//
//  ViewModel.swift
//  spajam-ios
//
//  Created by yamada fuuya on 2021/10/22.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

protocol ViewModelProtocol: ObservableObject {
    associatedtype State
    associatedtype Action

    init(state: State)
    func send(_ action: Action)
}

/// sample class
final class ViewModel: ViewModelProtocol {
    struct State {
        var title = ""
        var url = ""
    }

    @Published private(set) var state: State
    ///  Viewからアクションを受け取る
    private let actionPublisher: PassthroughSubject<Action, Never> = .init()
    private var cancellables = Set<AnyCancellable>()

    init(state: State) {
        self.state = state
        
        actionPublisher.sink(receiveValue: { [weak self] action in
            switch action {
            case .fetchData:
                self?.fetchData(url: "https://qiita.com/api/v2/items")
            }
        }).store(in: &cancellables)
        
    }
    
    private func fetchData(url: String) {
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil)
            .response { [weak self] response in
                guard let data = response.data else { return }
                let entity = try! JSONDecoder().decode([EntityModel].self, from: data)
                self?.state.title = entity[0].title
                self?.state.url = entity[0].url
            }
    }
}

extension ViewModel {
    enum Action {
        case fetchData
    }
    
    func send(_ action: Action) {
        actionPublisher.send(action)
    }
}
