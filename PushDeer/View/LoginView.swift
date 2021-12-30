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
  var body: some View {
    VStack{
      Spacer()
      Image("logo.with.space")
        .resizable()
        .scaledToFit()
      Spacer()
      AppleSignInButton(
        onRequest: { request in
          request.requestedScopes = [.fullName, .email]
        },
        onCompletion: { result in
          
        }
      )
        .frame(maxWidth: 375, minHeight: 64, maxHeight: 64)
        .padding()
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
