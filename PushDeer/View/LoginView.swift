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
  @State private var showLoading = false
  
  var body: some View {
    VStack{
      Spacer()
      Image("logo.with.space")
        .resizable()
        .scaledToFit()
      if Env.isSelfHosted {
        Button("重置API endpoint") {
          store.api_endpoint = ""
        }
      }
      Spacer()
      if showLoading {
        ProgressView()
          .scaleEffect(1.5)
          .frame(height: 64)
      } else {
        AppleSignInButton(
          onRequest: { request in
            request.requestedScopes = [.fullName, .email]
          },
          onCompletion: { result in
            do {
              showLoading = true
              store.token = try await store.appleIdLogin(result).token
              // 获取成功去主页
            } catch {
              showLoading = false
              HToast.showError(error.localizedDescription)
            }
          }
        )
          .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white))
          .frame(maxWidth: 375, minHeight: 64, maxHeight: 64)
          .padding()
        
        Button("微信登录") {
          let req = SendAuthReq()
          req.scope = "snsapi_userinfo";
          req.state = "login";
          WXApi.send(req) { b in
            print("WXApi.send:", b)
          }
        }
        .frame(maxWidth: 375, minHeight: 64, maxHeight: 64)
        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.green))
        .padding()
        
      }
      Spacer()
    }
    .padding()
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
