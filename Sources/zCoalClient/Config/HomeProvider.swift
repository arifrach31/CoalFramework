//
//  HomeProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 25/09/24.
//

import CoalCore

class HomeProvider: HomeConfigProvider, HomeSectionProvider {
  func getConfig() -> HomeConfig {
    let homeSection: [HomeSection] = [
      .carousel(items: getCarouselItems()),
      .category(items: getCategories()),
      .productList(items: getProductList())
    ]
    let categoryComponent = CoalGridCategoryView(
      categories: getCategories(),
      layoutType: .horizontal,
      gridRows: 1,
      title: "Category"
    )
    let catalogComponent = CoalGridCatalogView(
      catalog: getProductList(),
      layoutType: .vertical,
      gridRows: 2,
      title: "Product List"
    )
    let homeConfig = HomeConfig(sections: homeSection, categoryConfig: categoryComponent, catalogConfig: catalogComponent)
    
    return homeConfig
  }
  
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
      ProductListModel(image: "https://i.ibb.co.com/QYtbVc0/Image.png", category: "Business", title: "Minimalis Landing Page", description: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia"),
      ProductListModel(image: "https://i.ibb.co.com/QYtbVc0/Image.png", category: "Business", title: "Start with Legion Design System", description: "Integrated design and code support for modern UI development."),
      ProductListModel(image: "https://i.ibb.co.com/QYtbVc0/Image.png", category: "E-Commerce", title: "E-Commerce Template", description: "Full-featured template for online shopping apps."),
      ProductListModel(image: "https://i.ibb.co.com/QYtbVc0/Image.png", category: "Health", title: "Fitness Tracking App", description: "Track your fitness activities and goals."),
      ProductListModel(image: "https://i.ibb.co.com/QYtbVc0/Image.png", category: "Social Media", title: "Social Media App UI", description: "Connect with friends and share your moments."),
      ProductListModel(image: "https://i.ibb.co.com/QYtbVc0/Image.png", category: "Education", title: "Online Education Platform", description: "Learn and grow with professional courses."),
      ProductListModel(image: "https://i.ibb.co.com/QYtbVc0/Image.png", category: "Social Media", title: "Social Media App UI", description: "Connect with friends and share your moments."),
      ProductListModel(image: "https://i.ibb.co.com/QYtbVc0/Image.png", category: "Education", title: "Online Education Platform", description: "Learn and grow with professional courses.")
    ]
  }
}
