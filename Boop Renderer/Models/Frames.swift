//
//  Frames.swift
//  Boop Renderer
//
//  Created by Ivan Mathy on 9/8/22.
//

import Foundation

protocol Frame {
    var text: String { get set }
    var time: Date { get }
}

struct SingleCursorFrame: Frame {
    let time: Date
    let cursor: NSRange
    var text: String
}

struct MultiCursorFrame: Frame {
    var time: Date
    let cursors: [NSRange]
    var text: String
}
