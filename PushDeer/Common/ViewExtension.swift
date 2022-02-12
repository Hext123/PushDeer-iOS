//
//  ViewExtension.swift
//  PushDeer
//
//  Created by HEXT on 2022/2/12.
//

import SwiftUI

extension View {
  func refresh(action: @escaping @Sendable () async -> Void) -> some View {
    self.modifier(RefreshModifier(action: action))
  }
}

struct RefreshModifier: ViewModifier {
  let action: @Sendable () async -> Void
  
  func body(content: Content) -> some View {
    if #available(iOS 15.0, *) {
      content
        .refreshable(action: action)
    } else {
      content
    }
  }
}

struct RefreshModifier_Previews: PreviewProvider {
  static var previews: some View {
    List {
      Text("A List Item")
      Text("A Second List Item")
      Text("A Third List Item")
    }
//    .modifier(RefreshModifier {
//
//    })
    .refresh {

    }
  }
}
