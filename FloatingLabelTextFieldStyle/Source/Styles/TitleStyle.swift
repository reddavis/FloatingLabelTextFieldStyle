import SwiftUI


public extension FloatingLabelTextFieldStyle
{
    /// Floating label text field style title configuration.
    struct TitleStyle
    {
        /// The title's text.
        let text: LocalizedStringKey
        
        /// The title's font.
        let font: Font
        
        /// The title's font when the text field is highlighted.
        let floatingFont: Font
        
        /// The title's color.
        let color: Color
        
        /// The title's color when the text field is highlighted.
        let floatingColor: Color
        
        // MARK: Initialization
        
        /// Initialize a new `FloatingLabelTextFieldStyle.Title` instance.
        /// - Parameters:
        ///   - text: The text.
        ///   - font: The font.
        ///   - floatingFont: The font when highlighted.
        ///   - color: The color.
        ///   - floatingColor: The color when highlighted.
        public init(
            text: LocalizedStringKey,
            font: Font = .body,
            floatingFont: Font = .footnote,
            color: Color = .gray,
            floatingColor: Color = .accentColor
        )
        {
            self.text = text
            self.font = font
            self.floatingFont = floatingFont
            self.color = color
            self.floatingColor = floatingColor
        }
    }
}
