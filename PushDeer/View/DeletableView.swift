//
//  DeletableView.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/26.
//

import SwiftUI
struct DeletableView<Content : View> : View {
  @ViewBuilder let itemView: Content
  let delete : () -> ()
  @State private var offsetX = 0.0
  @State private var isShowDelete = false
  var body: some View {
    ZStack {
      HStack {
        Spacer()
        Button(action: {
          print("删除")
          delete()
        }, label: {
          Image(systemName: "trash")
            .imageScale(.large)
            .foregroundColor(Color.red)
            .padding()
        })
      }
      itemView
        .offset(x: offsetX, y: 0)
        .gesture(
          DragGesture()
            .onChanged({ value in
              let width = value.translation.width
              print("onChanged", width)
              let endX = isShowDelete ? 60.0 : 0.0
              if width < endX {
                offsetX = width - endX
              } else {
                offsetX = 0
              }
            })
            .onEnded({ value in
              withAnimation(.easeOut) {
                let width = value.translation.width
                print("onEnded", width)
                if width > -20 {
                  offsetX = 0
                  isShowDelete = false
                } else {
                  offsetX = -60
                  isShowDelete = true
                }
              }
            })
        )
    }
  }
}

struct DeletableView_Previews: PreviewProvider {
  static var previews: some View {
    DeletableView(itemView: {
      DeviceItemView(name: "未知设备")
    }, delete: {
      
    })
  }
}
