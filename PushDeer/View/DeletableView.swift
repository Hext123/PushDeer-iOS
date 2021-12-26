//
//  DeletableView.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/26.
//

import SwiftUI
struct DeletableView<Content : View> : View {
  @ViewBuilder let contentView: Content
  let deleteAction : () -> ()
  @State private var offsetX = 0.0
  @State private var isShowDelete = false
  var body: some View {
    ZStack {
      HStack {
        Spacer()
        Button(action: {
          print("点击删除")
          deleteAction()
        }, label: {
          Image(systemName: "trash")
            .imageScale(.large)
            .foregroundColor(Color.red)
            .padding()
        })
      }
      contentView
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
    DeletableView(contentView: {
      DeviceItemView(name: "未知设备")
    }, deleteAction: {
      
    })
  }
}
