import SwiftUI
import RunesData
import DesignSystem
import Stash

struct RunesView: View {
  @Environment(RunesData.self) private var data: RunesData
  @Environment(Stash.self) private var stash: Stash
  
  @State private var isInCraftMode = false
  @State private var selectedRune: [Rune] = []
  @State private var isRunewordsSheetPresented = false
  
  private var availableRunewords: [Runeword] {
    data.runewordsFor(runes: selectedRune.map{ $0.name })
  }
  
  var body: some View {
    ZStack(alignment: .bottom) {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 20) {
          ForEach(data.runes) { rune in
            if isInCraftMode {
              makeCrafingModeRow(rune: rune)
            } else {
              makeStandardModeRow(rune: rune)
            }
          }
        }
      }
      .navigationTitle("Runes")
      .toolbar {
        Button {
          isInCraftMode.toggle()
        } label: {
          Text(isInCraftMode ? "Cancel" : "Craft")
        }
      }
      if isInCraftMode {
        runewordsAvailableView
          .padding(.bottom, 8)
      }
    }
  }
  
  @ViewBuilder
  private func makeCrafingModeRow(rune: Rune) -> some View {
    let isSelectedBinding = Binding<Bool>(
        get: { self.selectedRune.contains(where: { $0 == rune }) },
        set: { isSelected in
            withAnimation(.easeOut) {
                if isSelected {
                  self.selectedRune.append(rune)
                } else {
                  self.selectedRune.removeAll(where: { $0 == rune })
                }
            }
        }
    )
    RuneRowView(
      rune: rune,
      displayMode: .crafting, 
      isSelected: isSelectedBinding
    )
      .onTapGesture {
        isSelectedBinding.wrappedValue.toggle()
      }
  }
  
  private func makeStandardModeRow(rune: Rune) -> some View {
    NavigationLink(value: rune) {
      RuneRowView(rune: rune, displayMode: .normal, isSelected: .constant(false))
    }
    .contextMenu {
      Button {
        withAnimation(.easeIn) {
          selectedRune.append(rune)
        }
      } label: {
        Text("Select for crafting")
      }
      
      Button {
        stash.toggleRune(rune: rune)
      } label: {
        if stash.isInStash(rune: rune) {
          Text("Remove from my stash")
        } else {
          Text("Add to my stash")
        }
      }
    }
  }
    
  private var runewordsAvailableView: some View {
    Button {
      isRunewordsSheetPresented = true
    } label: {
      Text("\(availableRunewords.count) possible Runewords")
        .font(.AVQestFont(textStyle: .callout))
        .foregroundColor(.white)
        .padding(8)
        .background(Color.itemsColor(color: .magic))
        .clipShape(Capsule())
    }
    .sheet(isPresented: $isRunewordsSheetPresented) {
      List(availableRunewords) { runeword in
        RunewordRowView(runeword: runeword, displayMode: .large)
      }
    }.presentationDetents([.medium])
  }
}
