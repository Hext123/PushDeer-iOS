//
//  DeviceItemView.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/26.
//

import SwiftUI

struct DeviceItemView: View {
  var name: String
  var body: some View {
    HStack{
      Image(systemName: "ipad.and.iphone")
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40, alignment: .center)
        .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 8))
      Text(name)
        .font(.system(size: 20))
      Spacer()
    }
    .frame(height: 80)
    .overlay(RoundedRectangle(cornerRadius: 8).stroke())
    .foregroundColor(Color("DeviceViewMainColor"))
    .background(
      Color(UIColor.systemBackground)
        .cornerRadius(8)
        .shadow(
          color: Color.black.opacity(0.16),
          radius: 6, x: 0, y: 3
        )
    )
  }
}

struct DeviceItemView_Previews: PreviewProvider {
  static var previews: some View {
    DeviceItemView(name: "未知设备")
  }
}
