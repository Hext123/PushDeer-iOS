//
//  Line.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/27.
//

import SwiftUI

struct HLine: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.minX, y: rect.midY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
    }
  }
}

struct VLine: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.midX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
    }
  }
}

struct Line_Previews: PreviewProvider {
  static var previews: some View {
    HLine().stroke(style: StrokeStyle(lineWidth: 1,dash: [5]))
    VLine().stroke()
  }
}
