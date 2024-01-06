//
//  Observer.swift
//
//
//  Created by Petter vang Brakalsvålet on 06/12/2023.
//

import Foundation
import Presenter

final class Observer: ObservableObject, SceneType {
    private let presenter: Presenter
    internal var pages: [PageViewModel] { presenter.pageViewModels }
    internal var viewModel: ViewModel { presenter.viewModel }
    
    internal init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    internal func perform(update: Update) {
        switch update {
        case .pages, .viewModel:
            self.objectWillChange.send()
        }
    }
    
    
    internal func perform(action: CalendarAction) {
        presenter.perform(action: action)
    }
}
