import XCTest
import SwiftUI
@testable import DesignSystem

final class DesignSystemTests: XCTestCase {
  func testColors() throws {
    let items = Color.ItemsPalette.allCases
    let mappedColors = items.map{ Color.itemsColor(color: $0) }.compactMap{ $0 }
    XCTAssertEqual(mappedColors.count, items.count)
  }
}
