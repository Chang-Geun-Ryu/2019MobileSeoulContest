//
//  DBTestVC.swift
//  MountainTop
//
//  Created by CHANGGUEN YU on 16/09/2019.
//  Copyright © 2019 CHANGGUEN YU. All rights reserved.
//

import UIKit

class DBTestVC: UIViewController {
  
  // MARK: - Property
  let moutainDB = MauntainDatabase()
  
  private lazy var startButton: UIButton = {
    let btn = UIButton(type: .custom)
    btn.setTitle("start", for: .normal)
    btn.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    btn.addTarget(self, action: #selector(touchStartButton(_:)), for: .touchUpInside)
    self.view.addSubview(btn)
    return btn
  }()
  
  private lazy var endButton: UIButton = {
    let btn = UIButton(type: .custom)
    btn.setTitle("end", for: .normal)
    btn.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    btn.addTarget(self, action: #selector(touchEndButton(_:)), for: .touchUpInside)
    self.view.addSubview(btn)
    return btn
  }()
  
  // MARK: - View life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    startButton.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.equalToSuperview().inset(Metric.margin*2)
      $0.height.equalTo(70)
    }
    
    endButton.snp.makeConstraints {
      $0.top.equalTo(startButton.snp.bottom).offset(Metric.margin)
      $0.leading.width.height.equalTo(startButton)
    }
  }

  // MARK: - Button Action Function
  @objc private func touchDismissVC(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc private func touchStartButton(_ sender: UIButton) {
    guard UserInfo.def.recordingID == nil else {
      print("UserInfo.def.recordingID isn't nil")
      return
    }
    
    if let record = UserInfo.def.record {
      UserInfo.def.recordingID = record.insertRecode(start: Date().timeIntervalSinceNow,
                                                     finish: nil,
                                                     recode: "00:00:00",
                                                     mountainID: 1)
    }
  }
  
  @objc private func touchEndButton(_ sender: UIButton) {
    guard let id = UserInfo.def.recordingID else {
      print("UserInfo.def.recordingID is nil")
      return
    }
    if let record = UserInfo.def.record {
      record.updateRecode(updateID: id, finish: Date().timeIntervalSinceNow, record: "???")
      
      // 초기화 update 후 초기화 필요
      UserInfo.def.recordingID = nil
    }
  }
}