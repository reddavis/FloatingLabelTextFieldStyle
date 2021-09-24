import SwiftUI


public extension FloatingLabelTextFieldStyle
{
    /// Floating label text field style error configuration.
    struct ErrorStyle
    {
        /// The error text.
        let text: LocalizedStringKey
        
        /// The font of the error text.
        let font: Font
        
        /// The color of the error text.
        /// This color will also be used to style the border.
        let color: Color
        
        // MARK: Initialization
        
        /// Initialize a new `FloatingLabelTextFieldStyle.Error` instance.
        /// - Parameters:
        ///   - text: The error text.
        ///   - font: The error font.
        ///   - color: The error color.
        public init(
            text: LocalizedStringKey,
            font: Font = .footnote,
            color: Color = .red
        )
        {
            self.text = text
            self.font = font
            self.color = color
        }
    }
}
