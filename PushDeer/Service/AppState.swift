//
//  AppState.swift
//  PushDeer
//
//  Created by HEXT on 2022/1/4.
//

import Foundation
import AuthenticationServices

class AppState: ObservableObject {
  @Published var token : String = ""
  @Published var devices: [DeviceItem] = []
  @Published var keys: [KeyItem] = []
  @Published var messages: [MessageItem] = []
  @Published var tab_selected: Int = 0
  @Published var device_token: String = ""
  @Published var userInfo: UserInfoContent?
  
  static let shared = AppState()
  private init() {}
  
  func appleIdLogin(_ result: Result<ASAuthorization, Error>) async throws -> TokenContent {
    switch result {
    case let .success(authorization):
      if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
        // 用户唯一ID，在一个开发者账号下的APP获取到的是一样的
        print(appleIDCredential.user) // 000791.7a323f1326dd4674bc16d32fd6339875.1424
        // 注意：当第一次认证成功之后，将不会再返回email，fullName等信息，可以在设置->Apple ID->密码与安全性->使用您AppleID的App 中删除对应的APP。
        print(appleIDCredential.email as Any) // easychen@qq.com
        print(appleIDCredential.fullName as Any) // givenName: lijie familyName: chen
        // 「JWT」格式的token，用于验证信息合法性。其值用.分割成3段, 中间一段base64后会看到包含了 用户唯一标识 和 邮箱 等字段
        let idToken = String(data:appleIDCredential.identityToken!, encoding: .utf8)
        print(idToken as Any)
        
        do {
          // 请求接口
          let result = try await HttpRequest.login(idToken: idToken!)
          print(result)
          // 登录成功
          return result
          
        } catch {
          print(error)
        }
      }
    case let .failure(error):
      print(error)
    }
    // 登录失败
    throw NSError(domain: "登录失败", code: -1, userInfo: nil)
  }
  
}
