//
//  SceneType.swift
//  
//
//  Created by Petter vang Brakalsvålet on 06/12/2023.
//

public protocol SceneType: AnyObject {
    func perform(update: Update)
}
