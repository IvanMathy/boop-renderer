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

class GifGenerator: NSObject {
    
    @IBOutlet weak var textView: RecordingSyntaxTextView!
    @IBOutlet var viewController: MainViewController!
    
    func getImages() -> [NSImage] {
        
        return textView.frames.map({ frame -> NSImage in
            textView.replayFrame(frame: frame)
            return textView.getImageRepresentation()
        })
    }
    
    func generate() {
        
        let images = getImages()
        
        let fileProperties = [kCGImagePropertyGIFDictionary: [kCGImagePropertyGIFLoopCount: 0]]
        let frameProperties = [kCGImagePropertyGIFDictionary: [kCGImagePropertyGIFDelayTime: 0.1]]
        
        let documentsDirectoryURL: URL? = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        guard let fileURL = documentsDirectoryURL?.appendingPathComponent("boop.gif") else {
            fatalError("Could not create .gif path")
        }
        
            
        guard let destination = CGImageDestinationCreateWithURL(fileURL as CFURL, UTType.gif.identifier as CFString, images.count, nil) else {
            return
        }
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)
        for image in images {
            CGImageDestinationAddImage(destination, image.cgImage(forProposedRect: nil, context: nil, hints: nil)!, frameProperties as CFDictionary)
        }
        guard CGImageDestinationFinalize(destination) else {
            fatalError("Failed to create gif")
        }
        
        print(fileURL)
    }
}
