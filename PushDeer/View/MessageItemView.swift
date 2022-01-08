//
//  MessageItemView.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/29.
//

import SwiftUI

struct MessageItemView: View {
  let messageItem: MessageItem
  /// 删除按钮点击的回调
  let deleteAction : () -> ()
  
  var body: some View {
    VStack {
      HStack {
        HLine().stroke(Color(UIColor.lightGray))
          .frame(width: 20, height: 1)
        Image("avatar2")
          .resizable()
          .scaledToFit()
          .frame(width: 38, height: 38)
        Text("key名字")
          .font(.system(size: 14))
          .foregroundColor(Color(UIColor.darkGray))
        Text(messageItem.createdDateStr)
          .font(.system(size: 12))
          .foregroundColor(Color(UIColor.darkGray))
        HLine().stroke(Color(UIColor.lightGray))
          .frame(height: 1)
      }
      
      DeletableView(contentView: {
        CardView {
          HStack{
            Text(messageItem.text)
              .font(.system(size: 14))
              .foregroundColor(Color(UIColor.darkGray))
              .padding()
            Spacer(minLength: 0)
          }
          .contextMenu {
            Button("复制") {
              UIPasteboard.general.string = "someText"
            }
          }
        }
      }, deleteAction: deleteAction)
        .padding(EdgeInsets(top: 10, leading: 26, bottom: 0, trailing: 24))
      
    }
    .padding(.top, 25)
  }
}

struct MessageItemView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      MessageItemView(messageItem: MessageItem(id: 1, uid: "1", text: "纯文本的效果", desp: "", type: "text", created_at: "2022-01-08T18:00:48.000000Z")){}
      MessageItemView(messageItem: MessageItem(id: 1, uid: "1", text: "*MarkDown*的**效果**", desp: "", type: "markdown", created_at: "2021-12-28T13:44:48.000000Z")){}
      Spacer()
    }
  }
}
