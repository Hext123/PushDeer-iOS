//
//  MessageItemView.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/29.
//

import SwiftUI
import MarkdownUI
//import NetworkImage

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
        MessageContentView(messageItem: messageItem)
      }, deleteAction: deleteAction)
        .padding(messageItem.type == "image" ? EdgeInsets.init() : EdgeInsets(top: 10, leading: 26, bottom: 0, trailing: 24))
      
    }
    .padding(.top, 25)
  }
}

struct MessageContentView: View {
  let messageItem: MessageItem
  var body: some View {
    switch messageItem.type {
    case "markdown":
      CardView {
        Markdown(Document(messageItem.text))
          .markdownStyle(
            DefaultMarkdownStyle(
              font: .system(size: 14),
              foregroundColor: UIColor.darkGray
            )
          )
          .padding()
      }
      
    case "image":
      //      NetworkImage.init(url: URL(string: messageItem.text))
      //        .resizable().scaledToFill()
      Markdown("![](\(messageItem.text))")
        .markdownStyle(
          DefaultMarkdownStyle(
            font: .system(size: 14),
            foregroundColor: UIColor.darkGray
          )
        )
      //        .frame(width: .infinity)
      
      
    default:
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
            UIPasteboard.general.string = messageItem.text
          }
        }
      }
    }
  }
}

struct MessageItemView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      MessageItemView(messageItem: MessageItem(id: 1, uid: "1", text: "纯文本的效果", desp: "", type: "text", created_at: "2022-01-08T18:00:48.000000Z")){}
      MessageItemView(messageItem: MessageItem(id: 1, uid: "1", text: "纯文本的效果纯文本的效果纯文本的效果纯文本的效果纯文本的效果纯文本的效果纯文本的效果", desp: "", type: "text", created_at: "2022-01-08T18:00:48.000000Z")){}
      MessageItemView(messageItem: MessageItem(id: 1, uid: "1", text: "https://blog.wskfz.com/usr/uploads/2018/06/2498727457.png", desp: "", type: "image", created_at: "2022-01-08T18:00:48.000000Z")){}
      MessageItemView(messageItem: MessageItem(id: 1, uid: "1", text: "https://blog.wskfz.com/usr/uploads/2018/06/2151130181.png", desp: "", type: "image", created_at: "2022-01-08T18:00:48.000000Z")){}
      MessageItemView(messageItem: MessageItem(id: 1, uid: "1", text: "https://blog.wskfz.com/usr/uploads/2018/06/1718629805.png", desp: "", type: "image", created_at: "2022-01-08T18:00:48.000000Z")){}
      MessageItemView(messageItem: MessageItem(id: 1, uid: "1", text: "*MarkDown*的**效果**", desp: "", type: "markdown", created_at: "2021-12-28T13:44:48.000000Z")){}
      MessageItemView(messageItem: MessageItem(id: 1, uid: "1", text: """
It's very easy to make some words **bold** and other words *italic* with Markdown.

**Want to experiment with Markdown?** Play with the [reference CommonMark
implementation](https://spec.commonmark.org/dingus/).
""", desp: "", type: "markdown", created_at: "2021-12-28T13:44:48.000000Z")){}
      Spacer()
    }
  }
}
