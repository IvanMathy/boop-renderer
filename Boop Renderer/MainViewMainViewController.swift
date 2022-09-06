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
    
    @IBOutlet weak var syntaxTextView: RecordingSyntaxTextView!
    
    let lexer = BoopLexer()
    
    @IBOutlet weak var zoomLabel: NSTextField!
    @IBOutlet weak var scrollView: NSScrollView!
    @objc dynamic var width: NSNumber = 400 {
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
        super.awakeFromNib()
        
        syntaxTextView.delegate = self
        
        syntaxTextView.scrollView.hasVerticalScroller = false
        syntaxTextView.scrollView.hasHorizontalScroller = false
        updateEditorSize()
        
        scrollView.postsBoundsChangedNotifications = true

        NotificationCenter.default.addObserver(self,
            selector: #selector(scrollViewDidResize(notification:)),
            name: NSView.boundsDidChangeNotification,
            object: scrollView.contentView)
    }
    
    func updateEditorSize() {
        self.syntaxTextView.setFrameSize(NSMakeSize(CGFloat(width), CGFloat(height)))
    }
    
    @IBAction func record(_ sender: Any) {
    }
    
    @IBAction func play(_ sender: Any) {
    }
    
    @IBAction func resetZoom(_ sender: Any) {
        scrollView.magnification = 1;
    }
    

    @objc func scrollViewDidResize(notification: Notification){
        zoomLabel.stringValue = "Zoom: \(Int(round(scrollView.magnification * 100)))%"
    }

    @IBAction func exportImage(_ sender: Any) {
        
    }
    
    @IBAction func didChangePreviewScheme(_ sender: Any) {
        guard let sender = sender as? NSSegmentedControl else {
            return
        }
        
        switch sender.selectedSegment {
        case 0:
            self.syntaxTextView.appearance = NSAppearance(named: .aqua)
        case 1:
            self.syntaxTextView.appearance = NSAppearance(named: .darkAqua)
        default:
            self.syntaxTextView.appearance = nil
        }
    }
    
}

extension MainViewController: SyntaxTextViewDelegate {
    func theme(for appearance: NSAppearance) -> SyntaxColorTheme {
        return DefaultTheme(appearance: appearance)
    }
    
    
    public func didChangeText(_ syntaxTextView: SyntaxTextView) {
        
        
    }
    
    public func didChangeSelectedRange(_ syntaxTextView: SyntaxTextView, selectedRange: NSRange) {
        print(selectedRange)
        
    }
    
    public func lexerForSource(_ source: String) -> Lexer {
        return lexer
    }
    
}
