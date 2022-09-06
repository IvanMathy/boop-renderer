//
//  RecordingSyntaxTextView.swift
//  Boop Renderer
//
//  Created by Ivan Mathy on 9/5/22.
//

import Foundation
import SavannaKit
import AppKit


class RecordingSyntaxTextView: SyntaxTextView {
    override func interpretKeyEvents(_ eventArray: [NSEvent]) {
        super.interpretKeyEvents(eventArray)
    }
    
    func getImageRepresentation() -> NSImage {
        let mySize = self.bounds.size
        let imgSize = NSMakeSize(mySize.width, mySize.height)

        let bir = self.bitmapImageRepForCachingDisplay(in: self.bounds)
        bir?.size = imgSize
        if let bir = bir {
            self.cacheDisplay(in: self.bounds, to: bir)
        }

        let image = NSImage(size: imgSize)
        if let bir = bir {
            image.addRepresentation(bir)
        }
        
        return image;
    }
}
