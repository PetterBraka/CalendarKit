//
//  DragGestureWrapper.swift
//
//
//  Created by Petter vang Brakalsvålet on 30/12/2023.
//

import SwiftUI

private struct DragGestureWrapper: ViewModifier {
    @State var lastChange: Direction?
    
    let minimumDistance: CGFloat
    let coordinateSpace: CoordinateSpace
    let directions: [Direction]
    
    let onChange: (Direction) -> Void
    let onEnd: (Direction) -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: minimumDistance,
                            coordinateSpace: coordinateSpace)
                .onChanged { value in
                    let width = value.translation.width
                    let height = value.translation.height
                    
                    var direction: Direction? = nil
                    if directions.contains([.left, .right]) {
                        if width > minimumDistance {
                            direction = .right
                        } else if width < -minimumDistance {
                            direction = .left
                        }
                    }
                    if directions.contains([.up, .down]) {
                        if height > minimumDistance {
                            direction = .down
                        } else if height < -minimumDistance {
                            direction = .up
                        }
                    }
                    if let direction, lastChange != direction {
                        lastChange = direction
                        onChange(direction)
                    }
                }
                    .onEnded { value in
                        let width = value.translation.width
                        let height = value.translation.height
                        
                        lastChange = nil
                        if directions.contains([.left, .right]) {
                            if width > minimumDistance {
                                onEnd(.right)
                            } else if width < -minimumDistance {
                                onEnd(.left)
                            }
                        }
                        if directions.contains([.up, .down]) {
                            if height > minimumDistance {
                                onEnd(.down)
                            } else if height < -minimumDistance {
                                onEnd(.up)
                            }
                        }
                    }
            )
    }
}

extension View {
    func dragGesture(
        minimumDistance: CGFloat = 10,
        coordinateSpace: CoordinateSpace = .global,
        directions: [Direction],
        onChange: @escaping (Direction) -> Void,
        onEnd: @escaping (Direction) -> Void
    ) -> some View {
        modifier(DragGestureWrapper(
            minimumDistance: minimumDistance,
            coordinateSpace: coordinateSpace,
            directions: directions,
            onChange: onChange,
            onEnd: onEnd)
        )
    }
}

#Preview {
    RoundedRectangle(cornerRadius: 25)
        .fill(.orange)
        .shadow(radius: 5)
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 200)
        .dragGesture(directions: Direction.allCases) { direction in
            print("\(direction) swipe")
        } onEnd: { direction in
            print("Ended \(direction) swipe")
        }
}
