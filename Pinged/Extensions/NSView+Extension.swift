//
//  NSView+Extension.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

extension NSView {
    func anchors(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func greaterThanAnchors(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
          translatesAutoresizingMaskIntoConstraints = false
          if let top = top {
              self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
          }
          if let leading = leading {
              self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
          }
          if let bottom = bottom {
              self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
          }
          if let trailing = trailing {
              self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
          }
          if width != 0 {
            widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
          }
          if height != 0 {
            heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
          }
      }
    
    func greaterThanHeightAnchors(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
          translatesAutoresizingMaskIntoConstraints = false
          if let top = top {
              self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
          }
          if let leading = leading {
              self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
          }
          if let bottom = bottom {
              self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
          }
          if let trailing = trailing {
              self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
          }
          if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
          }
          if height != 0 {
            heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
          }
      }
    
    func lessThanAnchors(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
          translatesAutoresizingMaskIntoConstraints = false
          if let top = top {
              self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
          }
          if let leading = leading {
              self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
          }
          if let bottom = bottom {
              self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
          }
          if let trailing = trailing {
              self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
          }
          if width != 0 {
            widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
          }
          if height != 0 {
            heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
          }
      }
    
    enum Direction: Int {
      case topToBottom = 0
      case bottomToTop
      case leftToRight
      case rightToLeft
    }
    
    func startShimmeringAnimation(animationSpeed: Float = 1.4,
                                  direction: Direction = .leftToRight,
                                  repeatCount: Float = MAXFLOAT) {
      
      // Create color  ->2
        let lightColor = NSColor.white.cgColor
      let blackColor = NSColor.black.cgColor
      
      // Create a CAGradientLayer  ->3
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [blackColor, lightColor, blackColor]
      gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: -self.bounds.size.height, width: 3 * self.bounds.size.width, height: 3 * self.bounds.size.height)
      
      switch direction {
      case .topToBottom:
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
      case .bottomToTop:
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
      case .leftToRight:
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
      case .rightToLeft:
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
      }
      
      gradientLayer.locations =  [0, 1] //[0.4, 0.6]
      self.layer?.mask = gradientLayer
      
      // Add animation over gradient Layer  ->4
      CATransaction.begin()
      let animation = CABasicAnimation(keyPath: "locations")
      animation.fromValue = [0.0, 0.1, 0.2]
      animation.toValue = [0.8, 0.9, 1.0]
      animation.duration = CFTimeInterval(animationSpeed)
      animation.repeatCount = repeatCount
      CATransaction.setCompletionBlock { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.layer?.mask = nil
      }
      gradientLayer.add(animation, forKey: "shimmerAnimation")
      CATransaction.commit()
    }
    
    func stopShimmeringAnimation() {
      self.layer?.mask = nil
    
        
//    func addShadow(shadowColor: NSColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: NSCorner, fillColor: NSColor = .white) {
//        
//        let shadowLayer = CAShapeLayer()
//        let size = CGSize(width: cornerRadius, height: cornerRadius)
//        let cgPath = NSBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
//        shadowLayer.path = cgPath //2
//        shadowLayer.fillColor = fillColor.cgColor //3
//        shadowLayer.shadowColor = shadowColor.cgColor //4
//        shadowLayer.shadowPath = cgPath
//        shadowLayer.shadowOffset = offSet //5
//        shadowLayer.shadowOpacity = opacity
//        shadowLayer.shadowRadius = shadowRadius
//        self.layer?.addSublayer(shadowLayer)
//    }
}

}
