//
//  VerticalCircleButton.swift
//  CircleMenuApp
//
//  Created by Andrew Marmion on 14/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

extension AMCircleMenu {
    struct VerticalCircleButton: View {
        var action: () -> Void
        var item: CircleItem
        var isExpanded: Bool
        var index: Int

        var length: CGFloat = 60
        var radius: Int = 80

        var offset: (x: CGFloat, y: CGFloat) {
            if !isExpanded { return (0, 0) }

            let y = CGFloat(radius * index)
            return (0, -y)
        }

        var sideLength: CGFloat {

            switch (isExpanded, isTapped) {
            case (false, _):
                return 0.4 * length
            case (true, false):
                return length
            case (true, true):
                return length * 0.8
            }
        }


        @State private var isTapped: Bool = false

        var body: some View {
            Circle()
                .fill(item.color)
                .overlay(item.image.foregroundColor(.white))
                .offset(x: offset.x, y: offset.y)
                .frame(width: sideLength, height: sideLength)
                .onTapGesture {

                    withAnimation(.linear(duration: 0.25)) {
                        self.isTapped.toggle()
                    }

                    withAnimation(Animation.linear(duration: 0.25).delay(0.25)) {
                        self.isTapped.toggle()
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.action()
                    })
            }
        }
    }
}

struct VerticalCircleButton_Previews: PreviewProvider {
    static var previews: some View {
        AMCircleMenu.VerticalCircleButton(action: {},
                             item: AMCircleMenu.CircleItem(image: Image(systemName: "headphones"),
                                                           color: .yellow,
                                                           action: {}),
                             isExpanded: true,
                             index: 0)
    }
}
