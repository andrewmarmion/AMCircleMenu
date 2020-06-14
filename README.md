# AMCircleMenu

A SwiftUI implementation of ramotion's [Circle Menu](https://github.com/Ramotion/circle-menu).

It dynamically positions the buttons on screen based on the number of buttons that you pass to it. 

![AMCircleButton.CircleMenu dark mode](https://github.com/andrewmarmion/AMCircleMenu/blob/main/Images/dark.gif?raw=true)
![AMCircleButton.CircleMenu light mode](https://github.com/andrewmarmion/AMCircleMenu/blob/main/Images/light.gif?raw=true)
![AMCircleButton.VerticalCircleMenu light mode](https://github.com/andrewmarmion/AMCircleMenu/blob/main/Images/verticalMenu.gif?raw=true)
![AMCircleButton.VerticalCircleMenu dark mode](https://github.com/andrewmarmion/AMCircleMenu/blob/main/Images/verticalMenuDark.gif?raw=true)

## Requirements

- iOS 13.0 +
- Xcode 11.0 +

## Installation

Add the SPM package to your Xcode project at `main`

    https://github.com/andrewmarmion/AMCircleMenu.git
    
## Usage

    import AMCircleMenu

Create your the buttons the you want to display

    let button = AMCircleMenu.CircleItem(image: Image(systemName: "0.circle.fill"),
                   color: .red,
                   action: { print("Hello from 0")})

    let buttons: [AMCircleMenu.CircleItem] = [...]

    let centerButton = AMCircleMenu.CenterButton(image: Image(systemName: "headphones"), 
                                                 color: .yellow)

For the expanding circle menu use the following:

    AMCircleMenu.CircleMenu(centerButton: centerButton, 
                            circleItems: buttons)

For the vertical action menu use the following:

    AMCircleMenu.VerticalMenu(centerButton: centerButton, circleItems: buttons)

## Notes:

- For the CircleMenu the maximum number of buttons that you can use is currently 10, the VerticalCircleMenu is limited by the height of the screen.
- You cannot currently set the size of the buttons or the how far away they move out from the center button.
