//
//  Env.swift
//  PushDeer
//
//  Created by HEXT on 2022/1/30.
//

import Foundation

/// APP运行环境
struct Env {
  /// 是否是自建服务, 自建服务为 true, 在线服务为 false
  static let isSelfHosted = true
  /// 在线版本的 Api Endpoint
  static let onlineApiEndpoint = "http://pushdeer.wskfz.com:8800"
  /// AppStore 的 appId, 自建版: 1608017631; 在线版: 1596771139
  static let appStoreId = isSelfHosted ? 1608017631 : 1596771139
}
