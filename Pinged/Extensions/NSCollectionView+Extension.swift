//
//  NSCollectionView+Extension.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

final class MyCollectionView: NSCollectionView {
    
    override func addSubview(_ view: NSView) {
        self.wantsLayer = true
        self.layer?.backgroundColor = Constants.DARK_CHARCOAL_COLOR
        if let v = view as? NSScrollView {
            v.drawsBackground = false
            v.hasHorizontalScroller = false
            v.hasVerticalScroller = false
        }
        if let vxf = view as? NSVisualEffectView {
            vxf.isHidden = true
        }
        super.addSubview(view)
    }
}

final class ClearCollectionView: NSCollectionView {
    
    override func addSubview(_ view: NSView) {
        self.enclosingScrollView?.drawsBackground = false
        self.wantsLayer = true
        self.layer?.backgroundColor = .clear
        if let v = view as? NSScrollView {
            v.drawsBackground = false
            v.hasHorizontalScroller = false
            v.hasVerticalScroller = false
        }
        if let vxf = view as? NSVisualEffectView {
            vxf.isHidden = true
        }
        super.addSubview(view)
    }
}


extension NSCollectionView {
    func scrollToBottom(datasource: Int, duration: Double, implicit: Bool) {
        if datasource >= 1 {
            let indexPath = IndexPath(item: datasource - 1, section: 0)
            NSAnimationContext.runAnimationGroup { (context) in
                context.duration = duration
                context.allowsImplicitAnimation = implicit
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else {return}
                    strongSelf.scrollToItems(at: [indexPath], scrollPosition: .bottom)
                }
            }
        }
    }
}
