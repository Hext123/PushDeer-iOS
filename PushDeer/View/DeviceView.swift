//
//  DeviceView.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/25.
//

import SwiftUI

struct DeviceView: View {
  var body: some View {
    NavigationView {
      
      ScrollView {
        LazyVStack(alignment: .center) {
          ForEach(1...10, id: \.self) { index in
            HStack{
              Image(systemName: "ipad.and.iphone")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 8))
              Text("我的 iPhone \(index)")
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
            
            .padding(EdgeInsets(top: 18, leading: 26, bottom: 0, trailing: 24))
          }
        }
        
      }
      .background(
        Image("deer.gray").offset(x: -150, y: -10),
        alignment: .bottom
      )
      .navigationBarTitle("设备")
      .navigationBarItems(trailing: Button.init(action: {
        
      }, label: {
        Image(systemName: "plus")
          .foregroundColor(Color(UIColor.lightGray))
      }))
    }
    .navigationViewStyle(.stack)
  }
}

struct DeviceView_Previews: PreviewProvider {
  static var previews: some View {
    DeviceView()
  }
}
