//
//  MountainVC.swift
//  MountainTop
//
//  Created by Daisy on 03/09/2019.
//  Copyright © 2019 CHANGGUEN YU. All rights reserved.
//

import UIKit
import Lottie

class MountainVC: UIViewController {
  
  // MARK: - Property
  private let mountainName = ["도봉산", "수락산", "불암산", "용마산", "아차산", "구룡산", "대모산", "우면산", "관악산(관음사)", "북한산(효자동)", "북한산(우이동)", "북악산(한양도성)", "청계산(매봉)", "삼성산", "인왕산(사직단)"]
  
  private let mountainXaxis = [0.530, 0.685, 0.716, 0.741, 0.762, 0.600, 0.685, 0.543, 0.473, 0.388, 0.434, 0.416, 0.656, 0.438, 0.374]
  private let mountainYaxis = [0.188, 0.266, 0.268, 0.473, 0.494, 0.748, 0.730, 0.699, 0.748, 0.240, 0.226, 0.374, 0.819, 0.755, 0.399]
  
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.zoomScale = 1
    scrollView.minimumZoomScale = 1
    scrollView.maximumZoomScale = 3
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    view.addSubview(scrollView)
    return scrollView
  }()
  
  private lazy var myImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "customMap")
    imageView.contentMode = .scaleAspectFit
    scrollView.addSubview(imageView)
    return imageView
  }()
  
  private lazy var mapAnimationView: AnimationView = {
    let animationView = AnimationView()
    myImageView.addSubview(animationView)
    return animationView
  }()
  
  var array = [UIButton]() // FIXME: - 여기
  
  private lazy var mapButtons: [UIButton] = {
    for i in 0..<mountainName.count {
      let btn = UIButton(type: .custom)
      btn.tag = i + 1
      btn.setTitle("\(mountainName[i])", for: .normal)
      btn.setTitleColor(.darkGray, for: .normal)
      btn.titleLabel?.font = UIFont.systemFont(ofSize: 5)
      btn.backgroundColor = .white
      btn.alpha = 0.8
      btn.layer.cornerRadius = 5 // FIXME: - 나중에 보고 수정
      btn.clipsToBounds = true
      btn.addTarget(self, action: #selector(didTapMoutainButton(_:)), for: .touchUpInside)
      self.mapAnimationView.addSubview(btn)
      self.myImageView.isUserInteractionEnabled = true
      btn.isUserInteractionEnabled = true
      array.append(btn)
    }
    return array
  }()
  
  // MARK: - App Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.delegate = self
    startAnimation()
    configureAutoLayout()
  }
  
  // MARK: - Action Method
  private func startAnimation() {
    let starAnimation = Animation.named("8720-hi-wink")
    mapAnimationView.animation = starAnimation
    mapAnimationView.center = view.center
    mapAnimationView.play { fisnished in
      print("🐠 Animaion finished 🐠")
      // FIXME: - 깃발 꽂히는 애니메이션효과
      self.dispalyFlags()
      self.zoomingLottieView()
    }
  }
  
  @objc func didTapMoutainButton(_ sender: UIButton) {
    let rankingVC = RankingVC()
    rankingVC.buttonTag = sender.tag
    rankingVC.modalPresentationStyle = .overCurrentContext
    present(rankingVC, animated: false)
  }
  
  private func zoomingLottieView() {
    UIView.animate(withDuration: 1) {
      self.scrollView.zoomScale = 2.5
      self.scrollView.minimumZoomScale = 2.5
    }
  }
  
  private func dispalyFlags() {
    for i in 0..<mapButtons.count {
      mapButtons[i].snp.makeConstraints {
        $0.centerX.equalTo(self.myImageView.snp.trailing).multipliedBy(self.mountainXaxis[i])
        $0.centerY.equalTo(self.myImageView.snp.bottom).multipliedBy(self.mountainYaxis[i])
        print(mountainXaxis[i])
      }
    }
    self.scrollView.canCancelContentTouches = true
    print("mapButtons.count: \(mapButtons.count), \(self.scrollView.canCancelContentTouches)")
    return
  }
  
  // MARK: - AutoLayout
  private func configureAutoLayout() {
    let deviceWidht = UIScreen.main.bounds.width
    
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.center.equalTo(view.snp.center)
    }
    
    myImageView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.height.equalTo(deviceWidht)
    }
    
    mapAnimationView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}


extension MountainVC: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return myImageView
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print("⛱ did scroll ⛱")
  }
}

