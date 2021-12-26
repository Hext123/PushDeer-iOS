//
//  DeviceView.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/25.
//

import SwiftUI

struct DeviceView: View {
  @State var devices = Array(0..<10)
  var body: some View {
    NavigationView {
      
      ScrollView {
        LazyVStack(alignment: .center) {
          ForEach(devices, id: \.self) { name in
            DeletableView(itemView: {
              DeviceItemView(name: "设备 \(name)")
            }, delete: {
              devices.removeAll { _name in
                _name == name
              }
            })
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
