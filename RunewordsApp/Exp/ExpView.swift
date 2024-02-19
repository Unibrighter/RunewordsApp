import SwiftUI
import DesignSystem

struct ExpView: View {
  var body: some View {
    VStack {
      GroupBox(
        label: /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/,
        content: {
          ScrollView {
            Label(
              title: { Image(systemName: "42.circle") },
              icon: { Text("Label") }
            )
            Text("👰🏻")
                .font(.largeTitle)
                .frame(width: 50, height: 50)
                .background(Color.orange) // Use a background color that fits your design.
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 2))
                .offset(x:-20, y: -20)
                .padding(.bottom, 120 )
            
            Text("2")
            Text("3")
              .foregroundColor(Color.orange)
            Text("4")
            Text("5")
            Text("6")
            Text("7")
            Text("8")
            Text("9")
            Text("10")
          }
          
      })
      .font(
        Font(
          UIFont(
            name: "AVQest", 
            size:
              UIFont.preferredFont(
                forTextStyle: UIFont.TextStyle.extraLargeTitle
              ).pointSize
          )!
          )
        )
        
      Text("11")
    }
  }
}

struct ExpView_Previews: PreviewProvider {
  static var previews: some View {
    ExpView()
  }
}
