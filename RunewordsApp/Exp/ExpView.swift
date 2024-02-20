import SwiftUI
import DesignSystem
import MapKit
import CoreGraphics

struct ExpView: View {
  var body: some View {
    VStack{
      VStack {
        Map()
              .frame(height: 300)


          Circle()
          .frame(width: 260)
              .offset(y: -130)
              .padding(.bottom, -130)
        Image(systemName: "leaf")
            .font(.system(size: 200)) // Adjust the font size to scale the symbol
            .frame(width: 260, height: 260) // Set the frame for alignment purposes


          VStack(alignment: .leading) {
              Text("Turtle Rock")
                  .font(.title)


              HStack {
                  Text("Joshua Tree National Park")
                      .font(.subheadline)
                Spacer()
                  Text("California")
                      .font(.subheadline)
              }
          }
          .padding()
        
      }
      Spacer()
    }
          
      }
}

struct ExpView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ExpView()
      Badge()
    }
    
  }
}

struct Badge: View {
  var body: some View {
    ZStack {
      Group {
        BadgeBackground()
        
        GeometryReader { geometry in
          BadgeSymbol()
            .scaleEffect(1.0 / 2.0, anchor: .center)
//            .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
        }
      }
    }.aspectRatio(contentMode: .fit)
  }
}

struct BadgeBackground: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )


                HexagonParameters.segments.forEach { segment in
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )


                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            .fill(.linearGradient(
                            Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 0.6)
                        ))
        }.aspectRatio(1, contentMode: .fit)
            }
            static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
            static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct HexagonParameters {
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }


    static let adjustment: CGFloat = 0.085


    static let segments = [
        Segment(
            line:    CGPoint(x: 0.60, y: 0.05),
            curve:   CGPoint(x: 0.40, y: 0.05),
            control: CGPoint(x: 0.50, y: 0.00)
        ),
        Segment(
            line:    CGPoint(x: 0.05, y: 0.20 + adjustment),
            curve:   CGPoint(x: 0.00, y: 0.30 + adjustment),
            control: CGPoint(x: 0.00, y: 0.25 + adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.00, y: 0.70 - adjustment),
            curve:   CGPoint(x: 0.05, y: 0.80 - adjustment),
            control: CGPoint(x: 0.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.40, y: 0.95),
            curve:   CGPoint(x: 0.60, y: 0.95),
            control: CGPoint(x: 0.50, y: 1.00)
        ),
        Segment(
            line:    CGPoint(x: 0.95, y: 0.80 - adjustment),
            curve:   CGPoint(x: 1.00, y: 0.70 - adjustment),
            control: CGPoint(x: 1.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 1.00, y: 0.30 + adjustment),
            curve:   CGPoint(x: 0.95, y: 0.20 + adjustment),
            control: CGPoint(x: 1.00, y: 0.25 + adjustment)
        )
    ]
}

struct BadgeSymbol: View {
    static let symbolColor = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)


    var body: some View {
      
        GeometryReader { geometry in
          VStack {
            Path { path in
                  let width = min(geometry.size.width, geometry.size.height)
                  let height = width * 0.75
                  let spacing = width * 0.030
                  let middle = width * 0.5
                  let topWidth = width * 0.226
                  let topHeight = height * 0.488


                  path.addLines([
                      CGPoint(x: middle, y: spacing),
                      CGPoint(x: middle - topWidth, y: topHeight - spacing),
                      CGPoint(x: middle, y: topHeight / 2 + spacing),
                      CGPoint(x: middle + topWidth, y: topHeight - spacing),
                      CGPoint(x: middle, y: spacing)
                  ])
                  
                  path.move(to: CGPoint(x: middle, y: topHeight / 2 + spacing * 3))
                  path.addLines([
                      CGPoint(x: middle - topWidth, y: topHeight + spacing),
                      CGPoint(x: spacing, y: height - spacing),
                      CGPoint(x: width - spacing, y: height - spacing),
                      CGPoint(x: middle + topWidth, y: topHeight + spacing),
                      CGPoint(x: middle, y: topHeight / 2 + spacing * 3)
                  ])
              }
            .fill(Self.symbolColor)
          }
        }
    }
}
