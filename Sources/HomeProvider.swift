//
//  HomeProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 25/09/24.
//

import CoalModel

class HomeProvider: HomeSectionProvider {
  func getCarouselItems() -> [CarouselModel] {
    return [
      CarouselModel(image: "https://www.apple.com/v/iphone-15-pro/c/images/overview/camera/camera__bo5k5tfk6cmu_large_2x.jpg"),
      CarouselModel(image: "https://www.apple.com/v/iphone-15-pro/c/images/overview/camera/pro_lens2__e9qgfxdvjt26_large_2x.jpg"),
      CarouselModel(image: "https://www.apple.com/v/iphone-15-pro/c/images/overview/5x-zoom/pro-zoom_endframe__bpmc72f8qwgi_large_2x.jpg"),
      CarouselModel(image: "https://www.apple.com/v/iphone-15-pro/c/images/overview/camera/camera__bo5k5tfk6cmu_large_2x.jpg"),
      CarouselModel(image: "garuda")
    ]
  }
}
