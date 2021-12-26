//
//  SettingsView.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/25.
//

import SwiftUI

struct SettingsView: View {
  var body: some View {
    BaseNavigationView(title: "设置") {
      VStack {
        SettingsItemView(title: "登录为 Hext", button: "退出") {
        }
        .padding(EdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20))
        
        SettingsItemView(title: "自定义服务器", button: "扫码") {
        }
        .padding(EdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20))
        
        SettingsItemView(title: "喜欢PushDeer?", button: "评分") {
        }
        .padding(EdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20))
        
        Spacer()
      }
    }
  }
}

struct SettingsItemView: View {
  let title: String
  let button: String
  let action: () -> ()
  var body: some View {
    CardView {
      HStack{
        Text(title)
          .font(.system(size: 18))
          .foregroundColor(Color(UIColor.darkGray))
          .padding()
        Spacer()
        Button(button) {
          print("点击\(button)")
          action()
        }
        .font(.system(size: 20))
        .frame(width: 80, height: 42)
        .foregroundColor(Color.white)
        .background(Color.accentColor)
        .cornerRadius(8)
        .padding()
      }
      .frame(height: 74)
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
