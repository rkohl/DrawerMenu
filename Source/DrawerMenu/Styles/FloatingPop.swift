//
//  FloatingPop.swift
//  DrawerMenu Style
//
//  Created by Ryan Kohl on 2/28/20.
//  Copyright © 2020 Kohl Development Group LLC. All rights reserved.
//

import UIKit

public enum FloatingPopDisplay: CGFloat {
  public typealias RawValue = CGFloat
  case standard = 0.6, barButton = 0.4, large = 0.8
}

public struct FloatingPop: DrawerMenuStyle {
  
  internal var offsetView: UIView = UIView()
  public let offsetViewPadding:CGFloat = 42.0
  public let leftMenuOffset:CGFloat = 0.6
  public var cornerRadius: CGFloat = 40.0
  public var centerViewOpacity: CGFloat = 0.05
  public var centerScale: CGFloat = 0.80
  public var shadowColor: UIColor = .black
  public var shadowRadius: CGFloat = 8.0
  public var shadowOpacity: CGFloat = 0.5
  public var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    
  public init() {}
  
  public init(_ offset: FloatingPopDisplay) {
    leftMenuOffset = offset.rawValue
  }
    
  public func setup(drawer: DrawerMenu) {
    offsetView.frame = drawer.centerContainerView.bounds
    offsetView.backgroundColor = UIColor.label.withAlphaComponent(0.5)
    offsetView.layer.masksToBounds = true
    drawer.view.addSubview(offsetView)
    drawer.view.bringSubviewToFront(drawer.centerContainerView)
    drawer.centerContainerView.layer.masksToBounds = true
        
    addShadow(view: drawer.centerContainerView,
              color: shadowColor,
              radius: shadowRadius,
              opacity: shadowOpacity,
              offset: shadowOffset)
  }
    
  public func leftProgress(menuWidth: CGFloat, drawer: DrawerMenu) -> CGFloat {
    guard let left = drawer.leftContainerView else { return 0 }
    return left.frame.maxX / menuWidth
  }
    
  public func rightProgress(menuWidth: CGFloat, drawer: DrawerMenu) -> CGFloat {
    guard let right = drawer.rightContainerView else { return 0 }
    return (drawer.view.frame.width - right.frame.origin.x) / menuWidth
  }
    
  public func leftTransition(menuWidth: CGFloat, progress: CGFloat, drawer: DrawerMenu) {
    let menuOffset = -(menuWidth - (menuWidth * progress))
    drawer.rightContainerView?.frame.origin.x = drawer.view.frame.width
    drawer.leftContainerView?.frame.origin.x = menuOffset
        
    let scale = 1 - ((1 - centerScale) * progress)
    let offsetScale = 1 - ((1 - (centerScale * 0.88)) * progress)
    let translation = (drawer.centerContainerView.bounds.width * leftMenuOffset) * progress
    let centerTranslate = CGAffineTransform(translationX: translation, y: 0.0)
    let centerScale = CGAffineTransform(scaleX: scale, y: scale)
    let offsetCenterScale = CGAffineTransform(scaleX: offsetScale, y: offsetScale)
        
    if progress.isLessThanOrEqualTo(0.5) {
      drawer.centerContainerView.layer.cornerRadius = Rescale(from: (0, 0.5), to: (0, cornerRadius)).rescale(progress)
      offsetView.layer.cornerRadius = drawer.centerContainerView.layer.cornerRadius+12
    }else{
      drawer.centerContainerView.layer.cornerRadius = cornerRadius
      offsetView.layer.cornerRadius = cornerRadius+10
    }
    
    if !progress.isLessThanOrEqualTo(0.7) {
      let padding = Rescale(from: (0.7, 1.0), to: (0, offsetViewPadding)).rescale(progress)
      let off = translation - padding
      let offsettViewTranslate = CGAffineTransform(translationX: off, y: 0.0)
      offsetView.layer.transform = CATransform3DMakeAffineTransform(offsetCenterScale.concatenating(offsettViewTranslate))
    } else {
      let offsettViewTranslate = CGAffineTransform(translationX: translation, y: 0.0)
      offsetView.layer.transform = CATransform3DMakeAffineTransform(offsetCenterScale.concatenating(offsettViewTranslate))
    }
        
    drawer.centerContainerView.layer.transform = CATransform3DMakeAffineTransform(centerScale.concatenating(centerTranslate))
  }
  
  public func rightTransition(menuWidth: CGFloat, progress: CGFloat, drawer: DrawerMenu) {
    drawer.leftContainerView?.frame.origin.x = -menuWidth
    drawer.rightContainerView?.frame.origin.x = drawer.view.frame.width - (menuWidth * progress)
    drawer.opacityView.alpha = centerViewOpacity * progress
        
    let scale = 1 - ((1 - centerScale) * progress)
    let centerTranslate = CGAffineTransform(translationX: -((drawer.centerContainerView.bounds.width * 0.55) * progress), y: 0.0)
    let centerScale = CGAffineTransform(scaleX: scale, y: scale)
    drawer.centerContainerView.layer.transform = CATransform3DMakeAffineTransform(centerScale.concatenating(centerTranslate))
  }
}
