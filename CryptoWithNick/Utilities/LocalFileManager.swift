//
//  LocalFileManager.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/26.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
   static let shared = LocalFileManager()
    
    init () { }
     
    func getImgFromFile(imgName: String, folderName: String) -> UIImage? {
        guard
            let imgURL = getImageURL(folderName: folderName, imageName: imgName),
            FileManager.default.fileExists(atPath: imgURL.path)
        else { return nil }
        return UIImage(contentsOfFile: imgURL.path)
    }
    
     func saveImage(image: UIImage, folderName: String, imgName: String) {
        
        createFolderIfNeed(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = getImageURL(folderName: folderName, imageName: imgName)
        else { return }
        do {
            try data.write(to: url)
        } catch let error {
            print("ImgData Saving Error : \(error)")
        }
    }
    
   private func createFolderIfNeed(folderName: String) {
        guard let folderURL = getFolderURL(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: folderURL.path) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("CreateDirectory Error: \(error)")
            }
        }
    }
    
   private func getFolderURL(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
   private func getImageURL(folderName: String, imageName: String) -> URL? {
        guard let folderURL = getFolderURL(folderName: folderName) else {return nil}
        
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
