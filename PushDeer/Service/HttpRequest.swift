//
//  HttpRequest.swift
//  PushDeer
//
//  Created by HEXT on 2022/1/4.
//

import Foundation
import Moya

struct HttpRequest {
  
  static let provider = MoyaProvider<PushDeerApi>(callbackQueue: DispatchQueue.main)
  
  /// 统一处理接口请求, 并且封装成 Swift Concurrency 模式 (async / await)
  static func request<T: Codable>(_ targetType: PushDeerApi, resultType: T.Type) async throws -> T {
    return try await withCheckedThrowingContinuation { continuation in
      provider.request(targetType) { result in
        switch result {
        case let .success(response):
          do {
            let result = try JSONDecoder().decode(ApiResult<T>.self, from: response.data)
            print(result)
            if let content = result.content, result.code == 0 {
              continuation.resume(returning: content)
            } else {
              continuation.resume(throwing: NSError(domain: result.error ?? "接口报错", code: result.code, userInfo: nil))
            }
          } catch {
            print(error)
            continuation.resume(throwing: error)
          }
        case let .failure(error):
          print(error)
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  static func fake() async throws -> TokenContent {
    return try await request(.fake, resultType: TokenContent.self)
  }
  
  static func login(idToken: String) async throws -> TokenContent {
    return try await request(.login(idToken: idToken), resultType: TokenContent.self)
  }
  
  static func getUserInfo() async throws -> UserInfoContent {
    return try await request(.getUserInfo(token: AppState.shared.token), resultType: UserInfoContent.self)
  }
  
  static func regDevice() async throws -> DeviceContent {
    return try await request(.regDevice(
      token: AppState.shared.token,
      name: UIDevice.current.name,
      device_id: AppState.shared.device_token,
      is_clip: 0
    ), resultType: DeviceContent.self)
  }
  
  static func rmDevice(id: Int) async throws -> ActionContent {
    return try await request(.rmDevice(token: AppState.shared.token, id: id), resultType: ActionContent.self)
  }
  
  @MainActor static func getDevices() {
    _Concurrency.Task {
      let result = try await request(.getDevices(token: AppState.shared.token), resultType: DeviceContent.self)
      AppState.shared.devices = result.devices
    }
  }
}
