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
  /// 后端 Api 的 baseURL 地址
  static let baseURL = "http://pushdeer.wskfz.com:8800"
  
}
