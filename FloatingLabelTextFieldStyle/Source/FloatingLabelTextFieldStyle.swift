import SwiftUI


/// A floating label style for `TextField` with support for displaying
/// error messages.
public struct FloatingLabelTextFieldStyle: TextFieldStyle
{
    // Private
    private let borderColor: Color
    private let titleStyle: FloatingLabelTextFieldStyle.TitleStyle
    private let errorStyle: FloatingLabelTextFieldStyle.ErrorStyle?
    private let showClearButton: Bool
    
    // MARK: Initialization
    
    /// Initialize a new `FloatingLabelTextFieldStyle` instance.
    /// - Parameters:
    ///   - borderColor: The default border colour.
    ///   - showClearButton: Indicate whether to display clear text button.
    ///   - titleStyle: The title style.
    ///   - errorStyle: The error style.
    public init(
        borderColor: Color,
        showClearButton: Bool = true,
        titleStyle: FloatingLabelTextFieldStyle.TitleStyle,
        errorStyle: FloatingLabelTextFieldStyle.ErrorStyle? = nil
    )
    {
        self.borderColor = borderColor
        self.titleStyle = titleStyle
        self.errorStyle = errorStyle
        self.showClearButton = showClearButton
    }
    
    /// Initialize a new `FloatingLabelTextFieldStyle` instance.
    /// - Parameters:
    ///   - title: The title style.
    ///   - error: The error style.
    ///   - showClearButton: Indicate whether to display clear text button.
    @available(*, deprecated, message: "Use: .init(borderColor:showClearButton:titleStyle:errorStyle)")
    public init(
        title: FloatingLabelTextFieldStyle.TitleStyle,
        error: FloatingLabelTextFieldStyle.ErrorStyle? = nil,
        showClearButton: Bool = true
    )
    {
        self.borderColor = Color.black.opacity(0.1)
        self.titleStyle = title
        self.errorStyle = error
        self.showClearButton = showClearButton
    }
    
    // MARK: TextFieldStyle
    
    public func _body(configuration: TextField<Self._Label>) -> some View
    {
        let mirror = Mirror(reflecting: configuration)
        let text = mirror.descendant("_text") as! Binding<String>
        
        FloatingLabelTextField(
            text: text,
            textField: configuration,
            defaultBorderColor: self.borderColor,
            showClearButton: self.showClearButton,
            title: self.titleStyle,
            error: self.errorStyle
        )
    }
}

// MARK: Dot helper

extension TextFieldStyle where Self == FloatingLabelTextFieldStyle
{
    /// A text field style with floating label decoration.
    public static func floating(
        borderColor: Color = Color.black.opacity(0.1),
        showClearButton: Bool = true,
        titleStyle: FloatingLabelTextFieldStyle.TitleStyle,
        errorStyle: FloatingLabelTextFieldStyle.ErrorStyle? = nil
    ) -> FloatingLabelTextFieldStyle
    {
        FloatingLabelTextFieldStyle(
            borderColor: borderColor,
            showClearButton: showClearButton,
            titleStyle: titleStyle,
            errorStyle: errorStyle
        )
    }
    
    /// A text field style with floating label decoration.
    @available(*, deprecated, message: "Use: .floating(borderColor:showClearButton:titleStyle:errorStyle)")
    public static func floating(
        title: FloatingLabelTextFieldStyle.TitleStyle,
        error: FloatingLabelTextFieldStyle.ErrorStyle? = nil,
        showClearButton: Bool = true
    ) -> FloatingLabelTextFieldStyle
    {
        FloatingLabelTextFieldStyle(
            title: title,
            error: error,
            showClearButton: showClearButton
        )
    }
}




// MARK: Preview

struct FloatingLabelTextFieldStyle_Previews: PreviewProvider
{
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
            
            TextField("e.g. me@red.to", text: .constant("💩"))
                .textFieldStyle(
                    .floating(
                        titleStyle: .init(text: "Email"),
                        errorStyle: .init(text: "💩 is not a valid email address.")
                    )
                )
        }
        .padding()
    }
}
