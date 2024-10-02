//
//  UIImage.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit

public extension UIImage {
  private static var imageNames: [UIImage: String] = [:]
  
  static func image(named name: String, in bundle: Bundle? = nil) -> UIImage? {
    let image = UIImage(named: name, in: bundle, with: nil)
    if let image = image {
      imageNames[image] = name
    }
    return image
  }
  
  func resize(to size: CGSize) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    draw(in: CGRect(origin: .zero, size: size))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return resizedImage
  }
  
  var imageName: String? {
    return UIImage.imageNames[self]
  }
  
  static let coalLogo: UIImage? = image(named: "imgLogo", in: .module)
  static let mainBackground: UIImage? = image(named: "imgBackground", in: .module)
  static let icHome: UIImage? = image(named: "icHome", in: .module)
  static let icAccount: UIImage? = image(named: "icAccount", in: .module)
}
