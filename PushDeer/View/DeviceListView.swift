//
//  DeviceListView.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/25.
//

import SwiftUI

/// 设备界面
struct DeviceListView: View {
  @EnvironmentObject private var store: AppState
  var body: some View {
    BaseNavigationView(title: "设备") {
      ScrollView {
        LazyVStack(alignment: .center) {
          ForEach(store.devices.reversed()) { deviceItem in
            DeletableView(contentView: {
              DeviceItemView(deviceItem: deviceItem)
            }, deleteAction: {
              store.devices.removeAll { _deviceItem in
                _deviceItem.id == deviceItem.id
              }
              HToast.showSuccess("已删除")
              Task {
                do {
                  _ = try await HttpRequest.rmDevice(id: deviceItem.id)
                } catch {
                  
                }
              }
            })
              .padding(EdgeInsets(top: 18, leading: 26, bottom: 0, trailing: 24))
          }
          Spacer(minLength: 30)
        }
      }
      .navigationBarItems(trailing: Button(action: {
        Task {
          let hasContains = store.devices.contains { store.deviceToken == $0.device_id }
          if hasContains {
            HToast.showInfo("已添加过当前设备")
            return;
          }
          let devices = try await HttpRequest.regDevice().devices
          withAnimation(.easeOut) {
            store.devices = devices
          }
          HToast.showSuccess("已添加当前设备")
        }
      }, label: {
        Image(systemName: "plus")
          .foregroundColor(Color(UIColor.lightGray))
      }))
    }
    .onAppear {
      HttpRequest.loadDevices()
    }
  }
}

struct DeviceView_Previews: PreviewProvider {
  static var previews: some View {
    DeviceListView().environmentObject(AppState.shared)
  }
}
