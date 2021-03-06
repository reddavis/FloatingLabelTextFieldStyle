import SwiftUI


/// A floating label style for `TextField` with support for displaying
/// error messages.
public struct FloatingLabelTextFieldStyle: TextFieldStyle {
    private let borderColor: Color
    private let backgroundColor: Color
    private let titleStyle: FloatingLabelTextFieldStyle.TitleStyle
    private let errorStyle: FloatingLabelTextFieldStyle.ErrorStyle?
    private let showClearButton: Bool
    
    // MARK: Initialization
    
    /// Initialize a new `FloatingLabelTextFieldStyle` instance.
    /// - Parameters:
    ///   - borderColor: The default border colour.
    ///   - backgroundColor: The background colour.
    ///   - showClearButton: Indicate whether to display clear text button.
    ///   - titleStyle: The title style.
    ///   - errorStyle: The error style.
    public init(
        borderColor: Color,
        backgroundColor: Color,
        showClearButton: Bool = true,
        titleStyle: FloatingLabelTextFieldStyle.TitleStyle,
        errorStyle: FloatingLabelTextFieldStyle.ErrorStyle? = nil
    ) {
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.titleStyle = titleStyle
        self.errorStyle = errorStyle
        self.showClearButton = showClearButton
    }
    
    // MARK: TextFieldStyle
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        let mirror = Mirror(reflecting: configuration)
        let text = mirror.descendant("_text") as! Binding<String>
        
        FloatingLabelTextField(
            text: text,
            textField: configuration,
            defaultBorderColor: self.borderColor,
            backgroundColor: self.backgroundColor,
            showClearButton: self.showClearButton,
            title: self.titleStyle,
            error: self.errorStyle
        )
    }
}

// MARK: Dot helper

extension TextFieldStyle where Self == FloatingLabelTextFieldStyle {
    /// A text field style with floating label decoration.
    public static func floating(
        borderColor: Color = .black.opacity(0.1),
        backgroundColor: Color = .white,
        showClearButton: Bool = true,
        titleStyle: FloatingLabelTextFieldStyle.TitleStyle,
        errorStyle: FloatingLabelTextFieldStyle.ErrorStyle? = nil
    ) -> Self {
        .init(
            borderColor: borderColor,
            backgroundColor: backgroundColor,
            showClearButton: showClearButton,
            titleStyle: titleStyle,
            errorStyle: errorStyle
        )
    }
}




// MARK: Preview

struct FloatingLabelTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextField("e.g. me@red.to", text: .constant(""))
                .textFieldStyle(
                    .floating(
                        titleStyle: .init(text: "Email")
                    )
                )
            
            TextField("e.g. me@red.to", text: .constant("me@red.to"))
                .textFieldStyle(
                    .floating(
                        titleStyle: .init(text: "Email")
                    )
                )
            
            TextField("e.g. me@red.to", text: .constant("????"))
                .textFieldStyle(
                    .floating(
                        titleStyle: .init(text: "Email"),
                        errorStyle: .init(text: "???? is not a valid email address.")
                    )
                )
        }
        .padding()
    }
}
