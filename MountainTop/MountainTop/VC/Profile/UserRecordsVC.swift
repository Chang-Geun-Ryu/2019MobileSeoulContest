//
//  UserRecordsVC.swift
//  MountainTop
//
//  Created by CHANGGUEN YU on 15/09/2019.
//  Copyright © 2019 CHANGGUEN YU. All rights reserved.
//

import UIKit

class UserRecordsVC: UIViewController {
  
  // MARK: - Property
  private lazy var tableView: UITableView = {
    let tb = UITableView(frame: .zero, style: .plain)
    tb.register(cell: RecordCell.self)
    tb.register(cell: VoidCell.self)
    tb.register(cell: RecordImageCell.self)
    tb.register(RecordHeaderView.self, forHeaderFooterViewReuseIdentifier: RecordHeaderView.identifier)
    tb.dataSource = self
    tb.delegate = self
//    tb.backgroundColor = .black
    tb.alwaysBounceVertical = true
    tb.separatorStyle = .none
    view.addSubview(tb)
    return tb
  }()
  
  public var climbingList: [UserRecord] = []
  
  // MARK: - View life cycle
  
  deinit {
    NotificationCenter.default.removeObserver(self,
                                              name: .dismissVC,
                                              object: nil)
  }
  
  override func loadView() {
    super.loadView()
    view.backgroundColor = .white
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    settingTableView()
    setupNotification()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationBar()
  }
  
  // MARK: - setup control
  private func setupNavigationBar() {
    self.navigationController?.navigationBar.isHidden = true
  }
  
  private func settingTableView() {
    tableView.snp.makeConstraints {
      $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.margin/3)
    }
  }
  
  private func setupNotification() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(dismissUserRecordVC(_:)),
                                           name: .dismissVC,
                                           object: nil)
  }
  
  // MARK: - Notification Function
  @objc private func dismissUserRecordVC(_ notification: Notification) {
    self.navigationController?.popViewController(animated: true)
  }
  
  private func getDate(_ date: Date) -> String {
    let formet = DateFormatter()
    formet.dateFormat = "yyyy-MM-dd"
//    formet.
    return formet.string(from: date)
  }
  
  private func getRecord(start: Date, finish: Date) -> String {
    
    let record = finish.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
    return record.asTimeString2()
  }
  
  private func getMountainName(_ id: Int) -> String {
    guard id > 0 else { return "unknown"}
    return UserInfo.def.mountainList[id - 1].name
  }
  
  private func getDistance(start: Date, finish: Date) -> String {
    let record = finish.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
    return "\(String(format: "%0.2f", record*0.002))km"
  }
}

extension UserRecordsVC: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.climbingList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row % 2 == 0 {
      let cell = tableView.dequeue(RecordCell.self)
      
      if let finish = climbingList[self.climbingList.count - indexPath.row - 1].finish {
      
        cell.setupCell(date: getDate(climbingList[indexPath.row].start),
                       level: .high,
                       name: getMountainName(climbingList[indexPath.row].mountainID),
                       record: getRecord(start: climbingList[indexPath.row].start,
                                         finish: finish),
                       distance: getDistance(start: climbingList[indexPath.row].start,
                       finish: finish))
      }
      return cell
    } else {
      let cell = tableView.dequeue(VoidCell.self)
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecordHeaderView.identifier)
    
    return header
  }
  
  
}

extension UserRecordsVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row % 2 == 0 {
      return 120
    } else {
      return 10
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 100
  }
}
