//
//  PushDeerWidget.swift
//  PushDeerWidget
//
//  Created by HEXT on 2022/3/2.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), configuration: ConfigurationIntent())
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), configuration: configuration)
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    Task {
      let currentDate = Date()
      let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
      var entries: [SimpleEntry] = []
      var entry = SimpleEntry(date: entryDate, configuration: configuration)
      AppState.shared.token = UserDefaults(suiteName: Env.appGroupId)?.string(forKey: "PushDeer_token") ?? ""
      AppState.shared.api_endpoint = UserDefaults(suiteName: Env.appGroupId)?.string(forKey: "PushDeer_api_endpoint") ?? ""
      print("token", AppState.shared.token)
      do {
        let messages = try await HttpRequest.getMessages().messages
        entry.messages = handleList(messages, context: context)
      } catch {
        
      }
      entries.append(entry)
      let timeline = Timeline(entries: entries, policy: .atEnd)
      completion(timeline)
    }
  }
  
  func handleList(_ origList: [MessageItem], context: Context) -> [MessageItem] {
    var list = origList
    var limit = 0
    switch context.family {
    case .systemSmall, .systemMedium:
      limit = 4
    default:
      limit = 10
    }
    if list.count <= limit + 1 {
      return list;
    }
    list = list.prefix(limit) + []
    list.append(
      MessageItem(id: -1, uid: "", text: "+其它\(origList.count - limit)条", desp: "", type: "text", pushkey_name: "", created_at: "")
    )
    return list;
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let configuration: ConfigurationIntent
  var messages: [MessageItem] = placeholderList
}

struct PushDeerWidgetEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    if AppState.shared.token.isEmpty {
      Text("未登录")
    } else if entry.messages.isEmpty {
      Text("无消息")
    } else {
      VStack(alignment: .leading, spacing: 5) {
        ForEach(entry.messages) {
          if entry.messages.first?.id != $0.id {
            Divider()
          }
          if $0.id == -1 {
            Text(try! AttributedString(markdown: $0.text))
              .foregroundColor(.accentColor)
          } else {
            Text(try! AttributedString(markdown: $0.text))
          }
        }
        .font(.system(size: 15))
        Spacer(minLength: 0)
      }
      .padding(.top, 5)
      .padding()
    }
  }
}

@main
struct PushDeerWidget: Widget {
  let kind: String = "PushDeerWidget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      PushDeerWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("My Widget")
    .description("This is an example widget.")
  }
}

struct PushDeerWidget_Previews: PreviewProvider {
  static var previews: some View {
    AppState.shared.token = "1"
    return Group {
      PushDeerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
      PushDeerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
        .previewContext(WidgetPreviewContext(family: .systemMedium))
      PushDeerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
        .previewContext(WidgetPreviewContext(family: .systemLarge))
      PushDeerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
        .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
    }
  }
}

let placeholderList = [
  MessageItem(id: 1, uid: "", text: "第一条消息, 嘿", desp: "", type: "text", pushkey_name: "", created_at: ""),
  MessageItem(id: 2, uid: "", text: "第二条消息, 哈哈", desp: "", type: "text", pushkey_name: "", created_at: ""),
  MessageItem(id: 3, uid: "", text: "第三条消息, 我来了", desp: "", type: "text", pushkey_name: "", created_at: ""),
  MessageItem(id: 4, uid: "", text: "第四条消息, 我又走了", desp: "", type: "text", pushkey_name: "", created_at: ""),
  MessageItem(id: 5, uid: "", text: "第五条消息, 我很长很长很长很长很长很长很长很长很长很长很长", desp: "", type: "text", pushkey_name: "", created_at: "")
]
