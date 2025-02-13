import SwiftUI

struct ConverterIconView: View {
  let size: Double
  
  let lightColor = Color(.systemGray)
  let darkColor = Color(.systemGray6)
  
  var body: some View {
    ZStack {
      //MARK: Background
//      RoundedRectangle(cornerRadius: 30)
//      .fill(lightColor)
//      .frame(width: 200, height: 200)
//      .overlay(
//        RoundedRectangle(cornerRadius: 30)
//          .stroke(lightColor, lineWidth: 15)
//      )
      
      Rectangle()
        .fill(lightColor)
        .frame(width: 200, height: 200)
        .overlay(
          Rectangle()
            .stroke(lightColor, lineWidth: 15)
        )
      
      //MARK: Circular Arrows
      CircleArrow()
        .stroke(darkColor, lineWidth: 15)
        .frame(width: 120, height: 120)
        .rotationEffect(.degrees(-20))
      
      CircleArrow()
        .stroke(darkColor, lineWidth: 15)
        .frame(width: 120, height: 120)
        .rotationEffect(.degrees(-200))
      
      CircleArrow()
        .stroke(darkColor, lineWidth: 15)
        .frame(width: 120, height: 120)
        .rotationEffect(.degrees(-110))
      
      CircleArrow()
        .stroke(darkColor, lineWidth: 15)
        .frame(width: 120, height: 120)
        .rotationEffect(.degrees(-290))
      
      //MARK: Arrowheads
      Arrowhead()
        .fill(darkColor)
        .frame(width: 30, height: 25)
        .offset(x: 60, y: 0) // Adjusted for better positioning
        .rotationEffect(.degrees(250))
      
      Arrowhead()
        .fill(darkColor)
        .frame(width: 30, height: 25)
        .offset(x: 60, y: 0) // Adjusted for better positioning
        .rotationEffect(.degrees(70))
      
      Arrowhead()
        .fill(darkColor)
        .frame(width: 30, height: 25)
        .offset(x: 60, y: 0) // Adjusted for better positioning
        .rotationEffect(.degrees(340))
      
      Arrowhead()
        .fill(darkColor)
        .frame(width: 30, height: 25)
        .offset(x: 60, y: 0) // Adjusted for better positioning
        .rotationEffect(.degrees(160))
      
      //MARK: Labels
      Text("kWh")
        .foregroundColor(darkColor)
        .font(.system(size: 20, weight: .bold))
        .offset(x: 65, y: -65)
      
      Text("btu")
        .foregroundColor(darkColor)
        .font(.system(size: 20, weight: .bold))
        .offset(x: -65, y: 65)
      
      Text("in-lb")
        .foregroundColor(darkColor)
        .font(.system(size: 20, weight: .bold))
        .offset(x: 65, y: 65)
      
      Text("Nm")
        .foregroundColor(darkColor)
        .font(.system(size: 20, weight: .bold))
        .offset(x: -65, y: -65)
      
      Image(systemName: "flame")
        .foregroundColor(darkColor)
        .font(.system(size: 45, weight: .bold))
    }
//    .frame(width: 220, height: 220)
//    .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.5)
    .scaleEffect(size)
  }
}

// Circular Arrows Path
struct CircleArrow: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.width / 2,
                startAngle: SwiftUI.Angle(degrees: 95),
                endAngle: SwiftUI.Angle(degrees: 145),
                clockwise: false)
    return path
  }
}

// Arrowhead Shape
struct Arrowhead: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.midX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.closeSubpath()
    return path
  }
}

// Preview
struct ConverterIconView_Previews: PreviewProvider {
  static var previews: some View {
    ConverterIconView(size: 1.25)
      .preferredColorScheme(.dark)
  }
}
