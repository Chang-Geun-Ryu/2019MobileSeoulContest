//
//  UserInfomatoin.swift
//  MountainTop
//
//  Created by CHANGGUEN YU on 16/09/2019.
//  Copyright © 2019 CHANGGUEN YU. All rights reserved.
//

import Foundation

final class UserInfo {
  
  static public let def = UserInfo()
  
  public var login = LoginUserInfo()
  
  private init() {}
  
  public func getUserInfomation() {
    /// 사용자 정보 요청하기
    KOSessionTask.userMeTask { (error, me) in
      
      if let error = error as NSError? {
        UIAlertController.showMessage(error.description)
        
      } else if let me = me as KOUserMe? {
        
        guard let id = me.id else { return }
        
        UserInfo.def.login.id = id
        
        if let account = me.account {
          if let email = account.email {
            UserInfo.def.login.email = email
          }
        }
        if let properties = me.properties {
          UserInfo.def.login.name = properties["nickname"] ?? ""
          UserInfo.def.login.profile = properties["thumbnail_image"] ?? ""
        }
      }
    }
  }
}
