import SwiftUI


struct FloatingLabelTextField: View {
    @Binding var text: String
    let textField: TextField<TextFieldStyle._Label>
    let defaultBorderColor: Color
    let backgroundColor: Color
    let showClearButton: Bool
    let title: FloatingLabelTextFieldStyle.TitleStyle
    let error: FloatingLabelTextFieldStyle.ErrorStyle?
    
    // Private
    @State private var isHighlighted: Bool = false
    @FocusState private var isTextFieldFocussed: Bool
    
    private var isTextFieldHidden: Bool {
        if self.isHighlighted { return false }
        return self.text.isEmpty
    }
    
    private var borderColor: Color {
        if let error = self.error {
            return error.color
        }
        
        if self.isHighlighted || !self.text.isEmpty {
            return self.title.floatingColor
        } else {
            return self.defaultBorderColor
        }
    }
    
    private var borderWidth: Double {
        if self.isHighlighted && !self.text.isEmpty && self.error != nil {
            return 2.0
        } else {
            return 1.0
        }
    }
    
    // MARK: Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 16) {
                self.textInput()
                
                if self.showClearButton {
                    self.clearButton()
                } else {
                    Spacer()
                }
            }
            
            if let error = self.error {
                Text(error.text)
                    .font(error.font)
                    .foregroundColor(error.color)
            }
        }
        .contentShape(Rectangle())
        .padding(
            self.isTextFieldHidden ? EdgeInsets(top: 25, leading: 16, bottom: 25, trailing: 16)
            : EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        )
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(self.backgroundColor)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(
                    self.borderColor,
                    lineWidth: self.borderWidth
                )
        )
        .onTapGesture {
            guard self.isTextFieldHidden else { return }
            self.isHighlighted = true
        }
        .onChange(of: self.isHighlighted) { newValue in
            guard self.isHighlighted else { return }
            
            Task {
                // Required or text field doesn't actually receive focus...
                try? await Task.sleep(nanoseconds: 1_000_000_000 / 6)
                self.isTextFieldFocussed = newValue
            }
        }
        .onChange(of: self.isTextFieldFocussed) { newValue in
            self.isHighlighted = self.isTextFieldFocussed
        }
    }
    
    // MARK: UI
    
    private func textInput() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.title.text)
                .font(self.isTextFieldHidden ? .body : .footnote)
                .foregroundColor(self.isTextFieldHidden ? self.title.color : self.title.floatingColor)
                .animation(.easeInOut(duration: 0.2), value: self.isTextFieldHidden)
            
            self.textField
                .foregroundColor(Color.primary)
                .focused(self.$isTextFieldFocussed, equals: true)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                .isHidden(self.isTextFieldHidden, remove: true)
        }
    }
    
    private func clearButton() -> some View {
        Group {
            if self.text.isEmpty {
                Spacer()
            } else {
                Button(
                    action: { self.text.removeAll() },
                    label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.gray)
                    }
                )
            }
        }
    }
}



// MARK: Preview

struct FloatingLabelTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextField("Placeholder", text: .constant(""))
                .textFieldStyle(
                    FloatingLabelTextFieldStyle(
                        borderColor: .red,
                        backgroundColor: .white,
                        titleStyle: .init(text: "Email")
                    )
                )
            
            TextField("Placeholder", text: .constant("me@red.to"))
                .textFieldStyle(
                    FloatingLabelTextFieldStyle(
                        borderColor: .red,
                        backgroundColor: .gray,
                        titleStyle: .init(text: "Email")
                    )
                )
        }
    }
}
