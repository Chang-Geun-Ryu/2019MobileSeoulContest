//
//  RecordView.swift
//  MountainTop
//
//  Created by Daisy on 03/09/2019.
//  Copyright © 2019 CHANGGUEN YU. All rights reserved.
//

import UIKit

extension Notification.Name {
  static let presentCamera = Notification.Name("presentCamera")
  static let presentAlert = Notification.Name("presentAlert")
}

class RecordView: UIView {
  
  //notification
  private let notiCenter = NotificationCenter.default
  
  let activityIndicator = UIActivityIndicatorView(style: .gray)
  
  var timer = Timer()
  var startTime = TimeInterval()
  var (hours, minutes, seconds) = (0, 0, 0 )
  
  private lazy var cameraButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("사진찍기", for: .normal)
    button.backgroundColor = .blue
    button.addTarget(self, action: #selector(didTapCameraButton(_:)), for: .touchUpInside)
    addSubview(button)
    return button
  }()
  
  private lazy var winnerTitleLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.text = "1위 기록"
    label.font = UIFont.systemFont(ofSize: 13)
    label.textColor = .darkGray
    label.textAlignment = .center
    label.backgroundColor = .lightGray
    addSubview(label)
    return label
  }()

  private lazy var challengerTitleLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.text = "나의 기록"
    label.font = UIFont.systemFont(ofSize: 13)
    label.textColor = .lightGray
    label.textAlignment = .center
    label.backgroundColor = .yellow

    addSubview(label)
    return label
  }()
  
  private lazy var winnerRecordTimeLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.text = "00 : 00 : 00"
    label.font = UIFont(name: "Courier", size: 20)
    label.textColor = .darkGray
    label.textAlignment = .center
    label.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    addSubview(label)
    return label
  }()
  
  private lazy var challengerRecordTimeLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.text = "00 : 00 : 00"
    label.font = UIFont(name: "Courier", size: 20)
    label.textColor = .lightGray
    label.textAlignment = .center
    label.backgroundColor = .green
    
    addSubview(label)
    return label
  }()
  
  lazy var imagePickerController: UIImagePickerController = {
    let controller = UIImagePickerController()
    controller.delegate = self
    controller.sourceType = .camera
    return controller
  }()
  
  
  // MARK: - Action Method
  @objc func didTapCameraButton(_ sender: UIButton) {
    
    notiCenter.post(name: .presentCamera, object: sender, userInfo: ["presentCamera": imagePickerController])
    
  }
  
  @objc private func keepTimer() {
    
    seconds += 1
    
    if seconds == 60 {
      minutes += 1
      seconds = 0
    }
    
    if minutes == 60 {
      hours += 1
      minutes = 0
    }
    
    let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
    let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
    let hoursString = hours > 9 ? "\(hours)" : "0\(hours)"
    
    challengerRecordTimeLabel.text =  "\(hoursString) : \(minutesString) : \(secondsString)"
    
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    makeConstraints()
    backgroundColor = .white
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func saveToAlbum(named: String, image: UIImage) {
    print("📍saveToAlbum")
    let album = CustomAlbum(name: named)
    album.save(image: image) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(_):
          self.presentAlert(title: "사진 저장", message: "사진이\"\(named)\" 앨범에 저장 되었습니다.")
        case .failure(let err):
          self.presentAlert(title: "Error", message: err.localizedDescription)
        }
      }
    }
  }
  
  func presentAlert(title: String, message: String) {
     print("✏️ presentAlert")
    activityIndicator.stopAnimating()
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    
    notiCenter.post(name: .presentAlert, object: title, userInfo: ["presentAlert": alert])
  }

  // MARK: - AutoLayout
  private func makeConstraints() {
    cameraButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(safeAreaLayoutGuide).inset(10)
      $0.width.equalToSuperview().multipliedBy(0.6)
      $0.height.equalTo(cameraButton.snp.width).multipliedBy(0.2)
    }
    
    winnerTitleLabel.snp.makeConstraints {
      $0.top.equalTo(cameraButton.snp.bottom).offset(10)
      $0.width.equalToSuperview().multipliedBy(0.5)
      $0.leading.equalToSuperview()
    }
    
    challengerTitleLabel.snp.makeConstraints {
      $0.top.equalTo(cameraButton.snp.bottom).offset(10)
      $0.width.equalToSuperview().multipliedBy(0.5)
      $0.trailing.equalToSuperview()
      
    }
    
    winnerRecordTimeLabel.snp.makeConstraints {
      $0.top.equalTo(winnerTitleLabel.snp.bottom).offset(10)
      $0.centerX.equalTo(winnerTitleLabel.snp.centerX)
    }
    
    challengerRecordTimeLabel.snp.makeConstraints {
      $0.top.equalTo(challengerTitleLabel.snp.bottom).offset(10)
      $0.centerX.equalTo(challengerTitleLabel.snp.centerX)
    
    }
    
  }
  
}

extension RecordView: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else {
      print("Image not found!")
      return
    }
    
    print("📷saved image📷")
    saveToAlbum(named: "서울 봉우리", image: image)
    
    
    // FIXME: - 사진 다 찍고 니면 recordView를 올리기
    timer = Timer.scheduledTimer(timeInterval: 1, target:  self , selector: #selector(keepTimer), userInfo: nil, repeats: true)
    imagePickerController.dismiss(animated: true, completion: nil)
  }
}
