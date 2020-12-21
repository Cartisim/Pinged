//
//  VerifyViewController.swift
//  Pinged
//
//  Created by Cole M on 12/19/20.
//

import Cocoa

class VerifyViewController: NSViewController {
    
    var publicKey: String
    
    init(publicKey: String) {
        self.publicKey = publicKey
        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = VerifyView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setUpView()
    }
    fileprivate func setUpView() {
        let verifyView = self.view as! VerifyView
        verifyView.codeLabel.stringValue = publicKey
        createImage()
    }
    
    
    func createImage() {
        let verifyView = self.view as! VerifyView
        let data = verifyView.codeLabel.stringValue.data(using: String.Encoding.utf8, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
        verifyView.codeImage = (filter?.outputImage)
            displayQRCodeImage()

        
    }
    
    func displayQRCodeImage() {
        let verifyView = self.view as! VerifyView
        DispatchQueue.main.async {
            let scaleX = verifyView.qrView.frame.size.width / verifyView.codeImage.extent.size.width
            let scaleY = verifyView.qrView.frame.size.height / verifyView.codeImage.extent.size.height
            let transformedImage = verifyView.codeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            let rep: NSCIImageRep = NSCIImageRep(ciImage: transformedImage)
            verifyView.qrView.image?.size = rep.size
            verifyView.qrView.image?.addRepresentation(rep)
        }
    }

}
