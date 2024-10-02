//
//  CoalString.swift
//  CoalFramework
//
//  Created by ArifRachman on 10/09/24.
//

import Foundation

public struct CoalString {
  public static let bundle = Bundle.module
  
  public static func localized(forKey key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    return String(format: format, arguments: args)
  }
  
  public static let loginTitle = localized(forKey: "login_title")
  public static let loginDescription = localized(forKey: "login_description")
  public static let forgotUsernameOrPassword = localized(forKey: "forgot_username_password")
  public static let doNotHaveAccount = localized(forKey: "dont_have_account")
  public static let register = localized(forKey: "register")
  public static let haveAccountProblem = localized(forKey: "have_account_problem")
  public static let contactUs = localized(forKey: "contact_us")
  public static let registerDescription = localized(forKey: "register_description")
  public static let alreadyHaveAccount = localized(forKey: "already_have_account")
  public static let zonePhone = localized(forKey: "zone_phone")
  public static let agreement = localized(forKey: "agreement")
  public static let termCondition = localized(forKey: "term_condition")
  public static let and = localized(forKey: "and")
  public static let privacyPolicy = localized(forKey: "privacy_policy")
  public static let category = localized(forKey: "category")
  public static let seeAll = localized(forKey: "see_all")
  public static let productList = localized(forKey: "product_list")
  public static let home = localized(forKey: "home")
  public static let account = localized(forKey: "account")
}
