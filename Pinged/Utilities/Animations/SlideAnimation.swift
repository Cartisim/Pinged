//
//  SlideAnimation.swift
//  Pinged
//
//  Created by Cole M on 12/19/20.
//

import Cocoa

private class BackgroundView: NSView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor(calibratedWhite: 0, alpha: 0.5).cgColor
        alphaValue = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



class SlideAnimation: NSObject, NSViewControllerPresentationAnimator {
    fileprivate let backgroundView = BackgroundView(frame: .zero)
    fileprivate var centerXConstraint: NSLayoutConstraint!
    
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        
        let contentView = fromViewController.view
        backgroundView.frame = contentView.bounds
        backgroundView.autoresizingMask = [.width, .height]
        contentView.addSubview(backgroundView)
        
        
        let regView = viewController.view
        regView.translatesAutoresizingMaskIntoConstraints = false
        centerXConstraint = regView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor, constant: 100)
        backgroundView.addSubview(regView)
        NSLayoutConstraint.activate([
            regView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            centerXConstraint,
            regView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, constant: 0),
            regView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, constant: 0)
        ])
            NSAnimationContext.runAnimationGroup ({ (context) -> Void in
                context.duration = 0.5
                self.backgroundView.animator().alphaValue = 1
                self.centerXConstraint.animator().constant = 0
            }, completionHandler: nil)
        }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        NSAnimationContext.runAnimationGroup { _ in
            self.backgroundView.animator().alphaValue = 0
            self.centerXConstraint.animator().constant = 100
        } completionHandler: {
            self.backgroundView.removeFromSuperview()
        }

    }
    
    
}
