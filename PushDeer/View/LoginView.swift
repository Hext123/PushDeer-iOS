//
//  LoginView.swift
//  PushDeer
//
//  Created by HEXT on 2021/12/25.
//

import SwiftUI
import AuthenticationServices

/// 登录界面
struct LoginView: View {
  
  @EnvironmentObject private var store: AppState
  @State private var showLoading = true
  
  var body: some View {
    VStack{
      Spacer()
      Image("logo.with.space")
        .resizable()
        .scaledToFit()
      Spacer()
      if showLoading {
        ProgressView()
          .scaleEffect(2)
      } else {
        AppleSignInButton(
          onRequest: { request in
            request.requestedScopes = [.fullName, .email]
          },
          onCompletion: { result in
            do {
              showLoading = true
              store.token = try await store.appleIdLogin(result).token
              store.userInfo = try await HttpRequest.getUserInfo()
              // 获取成功去主页
            } catch {
              showLoading = false
            }
          }
        )
          .frame(maxWidth: 375, minHeight: 64, maxHeight: 64)
          .padding()
      }
      Spacer()
    }
    .padding()
    .onAppear {
      Task {
        do {
          store.userInfo = try await HttpRequest.getUserInfo()
          // 获取成功去主页
        } catch {
          showLoading = false
        }
      }
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
