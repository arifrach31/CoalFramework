//
//  CoalImageLoader.swift
//
//
//  Created by ArifRachman on 14/10/24.
//

import SwiftUI

public class CoalImageLoader {
  public static func loadImage(from source: String) -> Image {
    if let url = URL(string: source), source.isValidURL {
      return loadImageFromURL(url)
    } else if let _ = UIImage(named: source) {
      return Image(source)
    } else if let _ = UIImage(systemName: source) {
      return Image(systemName: source)
    } else {
      return Image(systemName: "")
    }
  }
  
  private static func loadImageFromURL(_ url: URL) -> Image {
    var loadedImage: Image?
    
    let semaphore = DispatchSemaphore(value: 0)
    URLSession.shared.dataTask(with: url) { data, _, _ in
      if let data = data, let uiImage = UIImage(data: data) {
        loadedImage = Image(uiImage: uiImage)
      }
      semaphore.signal()
    }.resume()
    
    semaphore.wait()
    return loadedImage ?? Image(systemName: "photo")
  }
}
