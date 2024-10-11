//
//  HomeProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 25/09/24.
//

import CoalCore

class HomeProvider: HomeConfigProvider, HomeSectionProvider {
  
  func getConfig() -> HomeConfig {
    let homeConfig = HomeConfig(
      isShowNavBar: true,
      sections: getHomeSections(),
      carouselConfig: CoalCarouselView(cards: getCarouselItems()),
      categoryConfig: CoalGridCategoryView(
        categories: getCategories(),
        layoutType: .horizontal,
        gridRows: 1,
        title: "Category"
      ),
      catalogConfig: CoalGridCatalogView(
        catalog: getProductList(),
        layoutType: .vertical,
        gridRows: 2,
        title: "Product List"
      )
    )
    return homeConfig
  }
  
  private func getHomeSections() -> [HomeSection] {
    return [.carousel, .category, .productList]
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
    let categoryData: [(icon: String, title: String)] = [
      ("gearshape.fill", "Landing"),
      ("briefcase.fill", "Business"),
      ("paintbrush.fill", "Mobile"),
      ("iphone", "Creative"),
      ("externaldrive.fill", "Unicorn")
    ]
    
    return categoryData.map { category in
      CategoryModel(background: "#E42313", icon: category.icon, title: category.title)
    }
  }
  
  func getProductList() -> [ProductListModel] {
    let productData: [(category: String, title: String, description: String)] = [
      ("Business", "Minimalis Landing Page", "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia"),
      ("Business", "Start with Legion Design System", "Integrated design and code support for modern UI development."),
      ("E-Commerce", "E-Commerce Template", "Full-featured template for online shopping apps."),
      ("Health", "Fitness Tracking App", "Track your fitness activities and goals."),
      ("Social Media", "Social Media App UI", "Connect with friends and share your moments."),
      ("Education", "Online Education Platform", "Learn and grow with professional courses.")
    ]
    
    return productData.map { product in
      ProductListModel(
        image: "https://i.ibb.co.com/QYtbVc0/Image.png",
        category: product.category,
        title: product.title,
        description: product.description
      )
    }
  }
}
