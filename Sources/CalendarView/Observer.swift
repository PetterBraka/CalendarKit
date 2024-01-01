//
//  Observer.swift
//
//
//  Created by Petter vang Brakalsvålet on 06/12/2023.
//

import Foundation

final class Observer: ObservableObject, SceneType {
    private let presenter: Presenter
    private var viewModel: [ViewModel] { presenter.viewModels }
    public var currentPage: Int { presenter.currentPage }
    
    internal init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    internal func perform(update: Update) {
        switch update {
        case .viewModel:
            self.objectWillChange.send()
        }
    }
    
    
    internal func perform(action: CalendarAction) {
        presenter.perform(action: action)
    }
}
