//
//  UIImageView+extension.swift
//  passData
//
//  Created by Anderson F Carvalho
//  Copyright © 2020 coda. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit

/**
   It loads the image from URL and save cache 1 day

### EXAMPLE ###
````
let imageView = UIImageView()
imageView.loadImageWith(url: *[THE URL]*)
````
*/
public extension UIImageView {
    
    private static let directoryName = "imageCache/"
    
    /**
        Call this function to get the image by URL
     
     - Paramters:
        - url: The url of image
     */
    func loadImageWith(url: String?) {
        
        guard let url = url, let validUrl = URL(string: url), url.isValidURL else {
            return
        }
        
        if let image = loadCache(url: url) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            
            URLSession.shared.dataTask(with: validUrl) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode <= 200,
                    error == nil, let data = data {
                    self.setupImage(data, url)
                }
            }.resume()
        }
    }
    
    private func saveCache(url: String, image: UIImage) {
        let imagePath = getDocumentsDirectory().appendingPathComponent(safeName(url))
        do {
            try FileManager.default.createDirectory(atPath: getDocumentsDirectory().appendingPathComponent(UIImageView.directoryName).path, withIntermediateDirectories: true, attributes: nil)
            try image.pngData()?.write(to: imagePath)
        } catch _ as NSError {}
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func safeName(_ imgURL: String) -> String {
        return UIImageView.directoryName + (imgURL.replacingOccurrences(of: ":", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: ".", with: ""))
    }
    
    private func getImage(_ imagePath: String) -> UIImage? {
        let expirated = cacheExpirated(filePath: imagePath)
        
        if expirated {
            return nil
        } else if let imageData: AnyObject = NSData(contentsOfFile: imagePath), let dat: NSData = (imageData as? NSData) {
            return UIImage(data: dat as Data)
        } else {
            return nil
        }
    }
    
    private func loadCache(url: String) -> UIImage? {
        let imagePath = getDocumentsDirectory().appendingPathComponent(safeName(url)).path
        let fileManager = FileManager.default
        let exists = fileManager.fileExists(atPath: imagePath)
        
        if exists {
            return getImage(imagePath)
        } else {
            return nil
        }
    }
    
    private func getTimeDiffDuration(_ fileDate: Date) -> Bool {
        // 1 day
        if Int(Date().timeIntervalSince(fileDate)) < 86400 {
            return false
        } else {
            //remove all files from directory
            try? FileManager.default.removeItem(atPath: getDocumentsDirectory().appendingPathComponent(UIImageView.directoryName).path)
            return true
        }
    }
    
    private func cacheExpirated(filePath: String) -> Bool {
        do {
            let fileManager = FileManager.default
            let atributes = try fileManager.attributesOfItem(atPath: filePath)
            
            if let fileDate = atributes[FileAttributeKey.modificationDate] as? Date {
                return getTimeDiffDuration(fileDate)
            } else {
                return true
            }
        } catch _ as NSError {
            return true
        }
    }
    
    private func setupImage(_ data: Data, _ url: String) {
        if let myimage = UIImage(data: data) {
            DispatchQueue.main.async {
                self.saveCache(url: url, image: myimage)
                UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.image = myimage
                }, completion: nil)
            }
        }
    }
}
#endif
