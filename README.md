# FloatingLabelTextFieldStyle

A floating label style for `TextField` with support for displaying error messages. 

![Example](https://cln.sh/Z4zfSB/download)

## Requirements

- iOS 15.0+
- macOS 12.0+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/reddavis/FloatingLabelTextFieldStyle", from: "0.9.0")
]
```

## Usage

```swift
import FloatingLabelTextFieldStyle
import SwiftUI


struct ContentView: View
{
    @State var email = ""
    
    // MARK: Body
    
    var body: some View {
        VStack {
            TextField("e.g. me@red.to", text: self.$email)
                .textFieldStyle(
                    .floating(
                        titleStyle: .init(text: "Email")
                    )
                )
            
            TextField("e.g. me@red.to", text: .constant("💩"))
                .textFieldStyle(
                    .floating(
                        borderColor: .red,
                        titleStyle: .init(text: "Email"),
                        errorStyle: .init(text: "💩 is not a valid email address.")
                    )
                )
        }
        .padding()
    }
}

```

## License

Whatevs.
