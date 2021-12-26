//
//  BaseNavigationView.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/26.
//

import SwiftUI

struct BaseNavigationView<Content : View> : View {
  let title: String
  @ViewBuilder let contentView: Content
  var body: some View {
    NavigationView {
      ZStack {
        Spacer()
          .frame(width: .infinity, height: .infinity)
        contentView
      }
      .background(
        Image("deer.gray").offset(x: -150, y: -10),
        alignment: .bottom
      )
      .navigationBarTitle(title)
    }
    .navigationViewStyle(.stack)
  }
}

struct BaseNavigationView_Previews: PreviewProvider {
  static var previews: some View {
    BaseNavigationView(title: "标题") {
      Text("内容")
    }
  }
}
