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
  
  func getCategories() -> [CategoryModel] {
    return [
      CategoryModel(
        background: "#E42313", icon: "gearshape.fill", title: "Landing"
      ),
      CategoryModel(
        background: "#E42313", icon: "briefcase.fill", title: "Business"
      ),
      CategoryModel(
        background: "#E42313", icon: "paintbrush.fill", title: "Mobile"
      ),
      CategoryModel(
        background: "#E42313", icon: "iphone", title: "Creative"
      ),
      CategoryModel(
        background: "#E42313", icon: "externaldrive.fill", title: "Unicorn"
      ),
      CategoryModel(
        background: "#E42313", icon: "gearshape.fill", title: "Landing"
      ),
      CategoryModel(
        background: "#E42313", icon: "briefcase.fill", title: "Business"
      ),
      CategoryModel(
        background: "#E42313", icon: "paintbrush.fill", title: "Mobile"
      ),
      CategoryModel(
        background: "#E42313", icon: "iphone", title: "Creative"
      ),
      CategoryModel(
        background: "#E42313", icon: "externaldrive.fill", title: "Unicorn"
      )
    ]
  }
  
  func getProductList() -> [ProductListModel] {
    return [
      ProductListModel(image: "img_thumbnail", category: "Business", title: "Minimalis Landing Page", description: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia"),
      ProductListModel(image: "img_thumbnail", category: "Business", title: "Start with Legion Design System", description: "Integrated design and code support for modern UI development."),
      ProductListModel(image: "img_thumbnail", category: "E-Commerce", title: "E-Commerce Template", description: "Full-featured template for online shopping apps."),
      ProductListModel(image: "img_thumbnail", category: "Health", title: "Fitness Tracking App", description: "Track your fitness activities and goals."),
      ProductListModel(image: "img_thumbnail", category: "Social Media", title: "Social Media App UI", description: "Connect with friends and share your moments."),
      ProductListModel(image: "img_thumbnail", category: "Education", title: "Online Education Platform", description: "Learn and grow with professional courses."),
      ProductListModel(image: "img_thumbnail", category: "Social Media", title: "Social Media App UI", description: "Connect with friends and share your moments."),
      ProductListModel(image: "img_thumbnail", category: "Education", title: "Online Education Platform", description: "Learn and grow with professional courses.")
    ]
  }
}
