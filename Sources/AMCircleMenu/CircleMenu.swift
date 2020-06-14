//
//  CircleMenu.swift
//  CircleMenuApp
//
//  Created by Andrew Marmion on 14/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

public struct AMCircleMenu {
    public struct CircleMenu: View {
        
        // MARK: - State
        @State private var isExpanded: Bool = false
        @State private var animateStroke: Bool = false
        @State private var showAnimatedArc: Bool = false
        @State private var tappedIndex: Int = 0
        @State private var timeRemaining: Double = 0.8
        @State private var actionCalled: Bool = false

        // MARK: - Computed Properties
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

        /// The color of the arc when the CircleItem is tapped
        var arcColor: Color {
            tappedItem.color
        }

        /// The starting angle of the arc
        var arcStartAngle: Angle {
            let buttonAngle = calculateAngle(index: tappedIndex)
            guard self.isClockwise else {
                return buttonAngle
            }
            return Angle(degrees: -buttonAngle.degrees + 180)
        }

        /// The item that we have tapped
        var tappedItem: CircleItem {
            circleItems[tappedIndex]
        }

        /// The axis that the arc should be flipped in to have clockwise ot anticlockwise rotation.
        var arcAxis: (x: CGFloat, y: CGFloat, z: CGFloat) {
            self.isClockwise ? (0, 1, 0) : (0, 0, 0)
        }

        // MARK: - Constants
        let centerButton: CenterButton
        let circleItems: [CircleItem]
        let isClockwise: Bool

        public init(centerButton: CenterButton, circleItems: [CircleItem], isClockwise: Bool = true) {
            self.centerButton = centerButton
            self.circleItems = circleItems
            self.isClockwise = isClockwise
        }

        // MARK: - Body
        public var body: some View {

            ZStack {
                // Hide the background with an Color when the button is expanded.
                // this stops interaction with items below.
                if isExpanded {
                    Color(.systemBackground).opacity(0.9).edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                self.isExpanded = false
                            }
                    }
                }

                // Display the circle buttons
                // These start small and are hidden underneath the center circle.
                ForEach(buttons, id: \.self) { index in
                    CircleButton(action: { self.circleItemTapped(at: index) },
                                 item: self.circleItems[index],
                                 angle: self.calculateAngle(index: index),
                                 isExpanded: self.isExpanded)
                }

                // The button in the center that we tap to open the menu.
                Circle()
                    .fill(centerButton.color)
                    .frame(width: 60, height: 60)
                    .overlay(centerButton.image.foregroundColor(.white))
                    .rotationEffect(self.rotate)
                    .opacity(self.opacity)
                    .onTapGesture {
                        withAnimation {
                            self.isExpanded.toggle()
                        }
                }

                // This handles the animation of the arc
                // When the arc is shown it calculates its start point based on the index
                // of the button that was tapped.
                if showAnimatedArc {
                    Color.clear.edgesIgnoringSafeArea(.all)
                    Circle()
                        .trim(from: animateStroke ? 0 : 1, to: 1)
                        .stroke(arcColor, lineWidth: 60)
                        .frame(width: 200, height: 200)
                        .rotationEffect(arcStartAngle)
                        .rotation3DEffect(Angle(degrees: 180), axis: arcAxis)
                        .animation(.linear(duration: 0.5))
                        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in

                            if self.timeRemaining > 0 {
                                self.timeRemaining -= 0.2
                            } else {
                                // this can get called multiple times
                                // so wrap it in a boolean so the action is only called once

                                if !self.actionCalled {
                                    self.actionCalled = true
                                    self.tappedItem.action()
                                }

                                self.showAnimatedArc = false
                                withAnimation {
                                    self.animateStroke = false
                                    self.isExpanded = false
                                }
                            }
                    }
                    .onAppear {
                        self.animateStroke = true
                    }

                    // Make a copy of the button we tapped and bring it to the front
                    // this fixes the issue where the button would appear under the arc.
                    CircleButton(action: {},
                                 item: tappedItem,
                                 angle: calculateAngle(index: tappedIndex),
                                 isExpanded: true)
                }
            }
        }

        /// Calculates the angle for the button
        /// - Parameter index: The index of the button
        /// - Returns: The angle that is used to calculate the button's offset
        private func calculateAngle(index: Int) -> Angle {
            Angle(degrees: Double(index * 360 / self.circleItems.count) - 90.0)
        }

        /// Sets up the variables for the animations when an item is tapped.
        /// - Parameter index: index of the circle we have tapped
        private func circleItemTapped(at index: Int) {
            self.actionCalled = false
            self.showAnimatedArc = true
            self.tappedIndex = index
            self.timeRemaining = 1
        }
    }
}

struct CircleMenu_Previews: PreviewProvider {
    static var previews: some View {
        AMCircleMenu.CircleMenu(centerButton: AMCircleMenu.CenterButton(image: Image(systemName: "headphones"),
                                              color: Color.yellow),
                   circleItems: [])
    }
}
