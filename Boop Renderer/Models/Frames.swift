//
//  Frames.swift
//  Boop Renderer
//
//  Created by Ivan Mathy on 9/8/22.
//

import Foundation

protocol Frame {
    var text: String { get set }
}

struct SingleCursorFrame: Frame {
    let cursor: NSRange
    var text: String
}

struct MultiCursorFrame: Frame {
    
    let cursors: [NSRange]
    var text: String
}
