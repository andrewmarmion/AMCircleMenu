//
//  CircleButton.swift
//  CircleMenuApp
//
//  Created by Andrew Marmion on 13/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

extension AMCircleMenu {
    struct CircleButton: View {

        var action: () -> Void
        var item: CircleItem
        var angle: Angle
        var isExpanded: Bool

        var length: CGFloat = 60
        var radius: Double = 100

        var offset: (x: CGFloat, y: CGFloat) {
            if !isExpanded { return (0, 0) }

            let x = CGFloat(radius * cos(angle.radians))
            let y = CGFloat(radius * sin(angle.radians))
            return (x, y)
        }

        var sideLength: CGFloat {
            isExpanded ? length : 0.4 * length
        }

        var body: some View {
            Circle()
                .fill(item.color)
                .overlay(item.image.foregroundColor(.white))
                .offset(x: offset.x, y: offset.y)
                .frame(width: sideLength, height: sideLength)
                .onTapGesture {
                    self.action()
            }

        }

    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        AMCircleMenu.CircleButton(action: {},
                                  item: AMCircleMenu.CircleItem(image: Image(systemName: "headphones"),
                                      color: .yellow,
                                      action: {}),
                     angle: Angle(degrees: 0),
                     isExpanded: false)
    }
}
