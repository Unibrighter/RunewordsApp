import SwiftUI
import RunesData
import DesignSystem
import Stash

@main
struct RunewordsApp: App {
  @State private var runesData = RunesData()
  @State private var stash = Stash()
  
  init() {
    DesignSystem.registerFonts()
    DesignSystem.registerAppaerance()
  }

  var body: some Scene {
    WindowGroup {
      AppTabView()
        .environment(runesData)
        .environment(stash)
        .preferredColorScheme(.dark)
    }
  }
}

struct RunewordsApp_Previews: PreviewProvider {
  static var previews: some View {
    AppTabView()
      .environment(RunesData())
      .environment(Stash())
      .preferredColorScheme(.dark)
  }
}

