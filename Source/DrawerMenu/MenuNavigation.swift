//
//  MenuNavigation.swift
//  
//
//  Created by Ryan Kohl on 4/29/20.
//

import UIKit

public class MenuNavigation: UINavigationController {
  
  private var attributes: NavigationBarAttributes = NavigationBarAttributes()
    
  public init(rootViewController: UIViewController, _ attributes: NavigationBarAttributes) {
    
    super.init(rootViewController: rootViewController)
    self.view.backgroundColor = .systemGroupedBackground
    self.attributes = attributes
    self.setNBarConfig()
  }
    
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.view.backgroundColor = .systemGroupedBackground
    self.setNBarConfig()
  }
  
  private func setNBarConfig() {
    navigationBar.prefersLargeTitles = attributes.useLargeTitle
    navigationBar.layoutMargins.left = attributes.leftMargin
    navigationBar.layoutMargins.right = attributes.rightMargin
    navigationItem.largeTitleDisplayMode  = attributes.largeTitleDisplay
    navigationBar.shadowImage = UIImage()
    navigationBar.barTintColor = attributes.barColor
    navigationBar.backgroundColor = attributes.barColor
    navigationBar.tintColor = attributes.tintColor
    self.navigationBar.isTranslucent = attributes.barTanslucent
    self.view.backgroundColor = attributes.viewBackgroundColor
  }
}

public struct NavigationBarAttributes {
    public var useLargeTitle: Bool = true
    public var leftMargin: CGFloat = 16
    public var rightMargin: CGFloat = 16
    public var barColor: UIColor = .clear
    public var tintColor: UIColor = UIColor.init(red: 224, green: 0, blue: 56, alpha: 1)
    public var barTanslucent: Bool = false
    public var viewBackgroundColor: UIColor = .systemGroupedBackground
    public var largeTitleDisplay: UINavigationItem.LargeTitleDisplayMode = .automatic
    public init() {}
}
