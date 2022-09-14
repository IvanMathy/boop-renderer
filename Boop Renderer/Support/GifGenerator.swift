//
//  GifGenerator.swift
//  Boop Renderer
//
//  Created by Ivan Mathy on 9/13/22.
//

import Foundation
import ImageIO
import AppKit
import UniformTypeIdentifiers

struct Image {
    let image: NSImage
    let frame: Frame
}

class GifGenerator: NSObject {
    
    @IBOutlet weak var textView: RecordingSyntaxTextView!
    @IBOutlet var viewController: MainViewController!
    
    func getImages() -> [Image] {
        
        
        
        return textView.frames.map({ frame -> Image in
            textView.replayFrame(frame: frame)
            return Image(image: textView.getImageRepresentation(), frame: frame)
        })
    }
    
    func generate() {
        
        let images = getImages()
        
        let fileProperties = [kCGImagePropertyGIFDictionary: [kCGImagePropertyGIFLoopCount: 0]]
        var frameProperties = [kCGImagePropertyGIFDictionary: [kCGImagePropertyGIFDelayTime: 0.1]]
        
        let documentsDirectoryURL: URL? = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        guard let fileURL = documentsDirectoryURL?.appendingPathComponent("boop.gif") else {
            fatalError("Could not create .gif path")
        }
        
            
        guard let destination = CGImageDestinationCreateWithURL(fileURL as CFURL, UTType.gif.identifier as CFString, images.count, nil) else {
            return
        }
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)
        
        var lastTime = images.first!.frame.time.timeIntervalSince1970
        
        for image in images {
            if(viewController.autoAnimate) {
                frameProperties[kCGImagePropertyGIFDictionary]?[kCGImagePropertyGIFDelayTime] = 0.5;
            } else {
                let newTime = image.frame.time.timeIntervalSince1970
                frameProperties[kCGImagePropertyGIFDictionary]?[kCGImagePropertyGIFDelayTime] = newTime - lastTime;
                lastTime = newTime
            }
            CGImageDestinationAddImage(destination, image.image.cgImage(forProposedRect: nil, context: nil, hints: nil)!, frameProperties as CFDictionary)
            
        }
        guard CGImageDestinationFinalize(destination) else {
            fatalError("Failed to create gif")
        }
        
        print(fileURL)
    }
}
