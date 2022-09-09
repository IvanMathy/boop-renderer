//
//  RecordingSyntaxTextView.swift
//  Boop Renderer
//
//  Created by Ivan Mathy on 9/5/22.
//

import Foundation
import SavannaKit
import AppKit


class RecordingSyntaxTextView: SyntaxTextView, Frame {
    
    var frames: [Frame] = []
    
    let lexer = BoopLexer()
    
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
    
    override func textViewDidChangeSelection(_ notification: Notification) {
        //print(self.contentTextView)
    }
}



extension RecordingSyntaxTextView: SyntaxTextViewDelegate {
    func theme(for appearance: NSAppearance) -> SyntaxColorTheme {
        return DefaultTheme(appearance: appearance)
    }
    
    
    public func didChangeText(_ syntaxTextView: SyntaxTextView) {
        
        guard let view = (syntaxTextView.contentTextView as? InnerTextView) else {
            return
        }
        
        guard let ranges = view.insertionRanges else {
            frames.append(SingleCursorFrame(cursor: view.selectedRange(), text: syntaxTextView.text))
            return
        }
        
        
        frames.append(MultiCursorFrame(cursors: ranges, text: syntaxTextView.text))
        
    }
    
    public func didChangeSelectedRange(_ syntaxTextView: SyntaxTextView, selectedRange: NSRange) {
    
        guard let view = (syntaxTextView.contentTextView as? InnerTextView) else {
            return
        }
        
        guard view.insertionRanges == nil else {
            return
        }
        
        guard view.selectedRange() != (frames.last as? SingleCursorFrame)?.cursor else {
            return
        }
        
        
        frames.append(SingleCursorFrame(cursor: view.selectedRange(), text: syntaxTextView.text))
        
    }
    
    func didUpdateSelectionRanges(_ syntaxTextView: SyntaxTextView) {
        guard let view = (syntaxTextView.contentTextView as? InnerTextView) else {
            return
        }
        guard let ranges = view.insertionRanges else {
            return
        }
        
        guard(ranges != (frames.last as? MultiCursorFrame)?.cursors) else {
            return
        }
        frames.append(MultiCursorFrame(cursors: ranges, text: syntaxTextView.text))
        
    }
    
    public func lexerForSource(_ source: String) -> Lexer {
        return lexer
    }
    
}
