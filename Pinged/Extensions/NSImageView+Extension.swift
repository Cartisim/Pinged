//
//  NSImageView+Extension.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

extension NSImageView {
    static let shared = NSImageView()
    func downloadImage(withURL url: URL, completion: @escaping (_ image: NSImage?) -> ()) {
        DispatchQueue.global().async { [weak self] in
            guard let _ = self else {return}
            let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error)  in
                if NetworkMonitor.shared.networkStatus() == false {
                    NSAlert().configuredAlert(title: "Error", text: NetworkCheck.checkNetwork.rawValue)
                } else {
                    var downloadImage: NSImage?
                    if let data = data {
                        downloadImage = NSImage(data: data)
                    }
                    let cacheKey = url.absoluteString.components(separatedBy: Constants.CACHE_KEY_COMPONENT)
                    let date = cacheKey[1].components(separatedBy: Constants.DATE_COMPONENT)
                    let expiredTime = date[1].components(separatedBy: Constants.EXPIRED_COMPONENT)
                        
                    if downloadImage != nil {
                        Constants.CACHE.setObject(downloadImage!, forKey: cacheKey[0] as NSString)
                        let timeout = DispatchTimeInterval.seconds(Int(expiredTime[0]) ?? 0)
                            DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                                Constants.CACHE.removeAllObjects()
                            }
                    }

                    DispatchQueue.main.async {
                        completion(downloadImage)
                    }
                }
                
            }
            dataTask.resume()
        }
    }
    
    func getImage(withURL url: URL, completion: @escaping (_ image: NSImage?) -> ()) {
        //seperate image url by Signature= and compare to cache objc
        let cacheKey = url.absoluteString.components(separatedBy: "Date=")
        if let image = Constants.CACHE.object(forKey: cacheKey[0] as NSString) {
            completion(image)
        } else {
            downloadImage(withURL: url, completion: completion)
        }
    }
    
    func resizeImage(image:NSImage, maxSize:NSSize) -> NSImage {
        var ratio:Float = 0.0
        let imageWidth = Float(image.size.width)
        let imageHeight = Float(image.size.height)
        let maxWidth = Float(maxSize.width)
        let maxHeight = Float(maxSize.height)
        
        // Get ratio (landscape or portrait)
        if imageWidth >= imageHeight {
            // Landscape
            ratio = maxWidth / imageWidth
        }
        else {
            // Portrait
            ratio = maxHeight / imageHeight
        }
        
        // Calculate new size based on the ratio
        let newWidth = imageWidth * ratio
        let newHeight = imageHeight * ratio
        
        // Create a new NSSize object with the newly calculated size
        let newSize:NSSize = NSSize(width: Int(newWidth), height: Int(newHeight))
        
        // Cast the NSImage to a CGImage
        var imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let imageRef =  image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
        
        // Create NSImage from the CGImage using the new size
        let imageWithNewSize = NSImage(cgImage: imageRef!, size: newSize)
        
        // Return the new image
        return imageWithNewSize
    }
    
    
    //Used for fetching token protected images on server rather than s3 CDN
    func load(url: URL) {
        let token = UserData.shared.accessToken
        DispatchQueue.global().async { [weak self] in
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = Network.get.rawValue
            request.addValue("\(HeaderValues.bearerAuth.rawValue)" + "\(token)", forHTTPHeaderField: HeaderFields.authorization.rawValue)
            let task = session.dataTask(with: request) {data, response, error in
                if error != nil || data == nil {
                    print("Client error!")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }
                guard let d = data else {
                    print("error, data was nil from \(url)")
                    return
                }
                //                guard let mime = response.mimeType, mime == "application/json" else {
                //                    print("Wrong MIME type!")
                //                    return
                //                }
                if let image = NSImage(data: d) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
            task.resume()
        }
    }
}
