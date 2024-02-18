import SwiftUI
import RunesData

struct RuneRowView: View {
  public enum DisplayMode {
    case normal
    case crafting
  }
  
  let rune: Rune
  
  public var displayMode: DisplayMode = .normal
  @Binding public var isSelected: Bool
  
  var body: some View {
    switch displayMode {
    case .normal:
      normalView
    case .crafting:
      makeCraftingView(isSelected: isSelected)
    }
  }
  
  var normalView: some View {
    VStack {
      Image(rune.name.lowercased())
      Text(rune.name)
        .font(.AVQestFont(textStyle: .headline))
        .foregroundColor(.white)
    }
  }
  
  func makeCraftingView(isSelected: Bool) -> some View {
      ZStack(alignment: .topLeading) {
        if isSelected {
          Image(systemName: "checkmark.circle.fill")
            .foregroundColor(Color.itemsColor(color: .set))
            .offset(x: -16)
        }
        normalView
          .overlay(
            RoundedRectangle(cornerRadius: 16)
              .stroke(Color.itemsColor(color: isSelected ? .set : .runic), lineWidth: 2)
              .frame(width: 70, height: 70)
          )
        
      }
    }
}

struct RuneRowView_Previews: PreviewProvider {
  static var previews: some View {
    RuneRowView(rune: RunesData().runes.first!, displayMode: .normal, isSelected: .constant(true))
    RuneRowView(rune: RunesData().runes.first!, displayMode: .crafting, isSelected: .constant(true))
    RuneRowView(rune: RunesData().runes.first!, displayMode: .crafting, isSelected: .constant(false))
  }
}
