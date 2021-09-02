import SwiftUI


struct FloatingLabelTextField: View
{
    @Binding var text: String
    let textField: TextField<TextFieldStyle._Label>
    let title: FloatingLabelTextFieldStyle.Title
    let error: FloatingLabelTextFieldStyle.Error?
    
    // Private
    @State private var isHighlighted: Bool = false
    @FocusState private var isTextFieldFocussed: Bool
    
    private var isTextFieldHidden: Bool {
        if self.isHighlighted { return false }
        return self.text.isEmpty
    }
    
    private var isClearButtonHidden: Bool {
        self.text.isEmpty
    }
    
    private var borderColor: Color {
        if let error = self.error
        {
            return error.color
        }
        
        if self.isHighlighted || !self.text.isEmpty
        {
            return self.title.floatingColor
        }
        else
        {
            return .black.opacity(0.1)
        }
    }
    
    private var borderWidth: Double {
        if self.isHighlighted && !self.text.isEmpty && self.error != nil
        {
            return 2.0
        }
        else
        {
            return 1.0
        }
    }
    
    // MARK: Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 16) {
                self.textInput()
                self.clearButton()
            }
            
            if let error = self.error
            {
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
                await Task.sleep(1_000_000_000 / 6)
                self.isTextFieldFocussed = newValue
            }
        }
        .onChange(of: self.isTextFieldFocussed) { newValue in
            self.isHighlighted = self.isTextFieldFocussed
        }
    }
    
    // MARK: UI
    
    private func textInput() -> some View
    {
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
    
    private func clearButton() -> some View
    {
        Group {
            if self.isClearButtonHidden
            {
                Spacer()
            }
            else
            {
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

struct FloatingLabelTextField_Previews: PreviewProvider
{
    static var previews: some View {
        VStack {
            TextField("Placeholder", text: .constant(""))
                .textFieldStyle(
                    FloatingLabelTextFieldStyle(
                        title: .init(text: "Email")
                    )
                )
            
            TextField("Placeholder", text: .constant("me@red.to"))
                .textFieldStyle(
                    FloatingLabelTextFieldStyle(
                        title: .init(text: "Email")
                    )
                )
        }
    }
}
