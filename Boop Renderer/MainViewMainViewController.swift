//
//  MainViewController.swift
//  Boop Renderer
//
//  Created by Ivan Mathy on 9/5/22.
//

import Foundation
import AppKit
import SavannaKit

class MainViewController : NSViewController {
    
    @IBOutlet weak var syntaxTextView: SyntaxTextView!
    
    @objc dynamic var width: NSNumber = 200 {
        didSet {
            updateEditorSize()
        }
    }
    @objc dynamic var height: NSNumber = 200 {
        didSet {
            updateEditorSize()
        }
    }
    
    
    override func awakeFromNib() {
        
        syntaxTextView.scrollView.hasVerticalScroller = false
        syntaxTextView.scrollView.hasHorizontalScroller = false
        updateEditorSize()
    }
    
    func updateEditorSize() {
        self.syntaxTextView.setFrameSize(NSMakeSize(CGFloat(width), CGFloat(height)))
    }
    
}
