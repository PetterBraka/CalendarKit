//
//  PresenterType.swift
//
//
//  Created by Petter vang Brakalsvålet on 06/12/2023.
//

public protocol PresenterType: AnyObject {
    func perform(action: CalendarAction)
}
