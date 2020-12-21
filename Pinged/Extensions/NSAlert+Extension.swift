//
//  NSAlert+Extension.swift
//  Cartisim
//
//  Created by Cole M on 10/10/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

extension NSAlert {
    func configuredAlert(title: String, text: String, switchRun: Bool = false)  {
        self.messageText = title
        self.informativeText = text
        self.alertStyle = NSAlert.Style.warning
        self.addButton(withTitle: "OK")
        self.addButton(withTitle: "Cancel")
        if !switchRun {
        self.runModal()
        }
    }
    
    func configuredCustomButtonAlert(title: String, text: String, firstButtonTitle: String, secondButtonTitle: String, switchRun: Bool = false)  {
        self.messageText = title
        self.informativeText = text
        self.alertStyle = NSAlert.Style.warning
        self.addButton(withTitle: firstButtonTitle)
        self.addButton(withTitle: secondButtonTitle)
        if !switchRun {
        self.runModal()
        }
    }
}
