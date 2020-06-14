//
//  VerticalMenu.swift
//  CircleMenuApp
//
//  Created by Andrew Marmion on 14/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

public extension AMCircleMenu {
    struct VerticalMenu: View {
        let circleItems: [CircleItem]
        let centerButton: CenterButton

        @State private var isExpanded: Bool = false

        var buttons: [Int] {
            var b: [Int] = []
            for index in 0..<circleItems.count {
                b.append(index)
            }
            return b
        }

        /// The rotation of the center button when expanded
        var rotate: Angle {
            isExpanded ? Angle(degrees: 360) : Angle(degrees: 0)
        }

        /// The opacity of the center button when expanded
        var opacity: Double {
            isExpanded ? 0.8 : 1
        }

        public init(centerButton: CenterButton, circleItems: [CircleItem]) {
            self.centerButton = centerButton
            self.circleItems = circleItems
        }

        public var body: some View {
            ZStack {
                ForEach(buttons, id: \.self) { index in
                    VerticalCircleButton(action: { self.itemTapped(at: index) },
                                         item: self.circleItems[index],
                                         isExpanded: self.isExpanded,
                                         index: index + 1)
                }

                Circle()
                    .fill(centerButton.color)
                    .frame(width: 60, height: 60)
                    .overlay(centerButton.image.foregroundColor(.white))
                    .rotationEffect(self.rotate)
                    .opacity(self.opacity)
                    .onTapGesture {
                        withAnimation(Animation.spring()) {
                            self.isExpanded.toggle()
                        }
                }
            }
        }

        private func itemTapped(at index: Int) {
            self.circleItems[index].action()
            withAnimation {
                self.isExpanded.toggle()
            }
        }

    }
}

struct VerticalMenu_Previews: PreviewProvider {
    static var previews: some View {
        AMCircleMenu.VerticalMenu(centerButton: AMCircleMenu.CenterButton(image: Image(systemName: "headphones"),
                                                                          color: Color.yellow),
                                  circleItems: [])
    }
}
