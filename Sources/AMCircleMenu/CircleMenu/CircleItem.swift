//
//  CircleItem.swift
//  CircleMenuApp
//
//  Created by Andrew Marmion on 13/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

public extension AMCircleMenu {

    struct CircleItem: Identifiable {
        public let id = UUID()
        public let image: Image
        public let color: Color
        public let action: () -> Void

        public init(image: Image, color: Color, action: @escaping () -> Void) {
            self.image = image
            self.color = color
            self.action = action
        }
    }

    struct CenterButton {
        public let image: Image
        public let color: Color

        public init(image: Image, color: Color) {
            self.image = image
            self.color = color
        }
    }
    
}
