import SwiftUI


/// A floating label style for `TextField` with support for displaying
/// error messages.
public struct FloatingLabelTextFieldStyle: TextFieldStyle
{
    // Private
    private let title: FloatingLabelTextFieldStyle.Title
    private let showClearButton: Bool
    private let error: FloatingLabelTextFieldStyle.Error?
    
    // MARK: Initialization
    
    /// Initialize a new `FloatingLabelTextFieldStyle` instance.
    /// - Parameters:
    ///   - title: The title configuration.
    ///   - error: The error configuration.
    public init(
        title: FloatingLabelTextFieldStyle.Title,
        error: FloatingLabelTextFieldStyle.Error? = nil,
        showClearButton: Bool = true
    )
    {
        self.title = title
        self.error = error
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
            title: self.title,
            error: self.error,
            showClearButton: self.showClearButton
        )
    }
}

// MARK: Dot helper

extension TextFieldStyle where Self == FloatingLabelTextFieldStyle
{
    /// A text field style with floating label decoration.
    public static func floating(
        title: FloatingLabelTextFieldStyle.Title,
        error: FloatingLabelTextFieldStyle.Error? = nil,
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
                        title: .init(text: "Email")
                    )
                )
            
            TextField("e.g. me@red.to", text: .constant("me@red.to"))
                .textFieldStyle(
                    .floating(
                        title: .init(text: "Email")
                    )
                )
            
            TextField("e.g. me@red.to", text: .constant("💩"))
                .textFieldStyle(
                    .floating(
                        title: .init(text: "Email"),
                        error: .init(text: "💩 is not a valid email address.")
                    )
                )
        }
        .padding()
    }
}
