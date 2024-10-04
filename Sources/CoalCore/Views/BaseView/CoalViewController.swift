//
//  CoalViewController.swift
//
//
//  Created by ArifRachman on 14/09/24.
//

import UIKit

open class CoalViewController: UIViewController {
  
  private let backgroundImageView = UIImageView()
  public var backgroundColor: UIColor
  
  public init(backgroundColor: UIColor, backgroundImage: UIImage?) {
    self.backgroundColor = backgroundColor
    self.backgroundImageView.image = backgroundImage
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = backgroundColor
    
    setupView()
    setupNavigationBar()
    setupBackgroundImage()
  }
  
  open func setupView() {}
  public func setupNavigationBar() {}
  
  private func setupBackgroundImage() {
    backgroundImageView.contentMode = .scaleAspectFill
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(backgroundImageView)
    
    NSLayoutConstraint.activate([
      backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}
