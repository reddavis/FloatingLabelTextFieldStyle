import FloatingLabelTextFieldStyle
import SwiftUI


struct ContentView: View
{
    @State var email = ""
    
    // MARK: Body
    
    var body: some View {
        VStack {
            TextField("example@red.to", text: self.$email)
                .textFieldStyle(
                    .floating(
                        title: .init(text: "Email")
                    )
                )
            
            Spacer()
        }
        .padding()
    }
}



// MARK: Preview

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View {
        ContentView()
    }
}
