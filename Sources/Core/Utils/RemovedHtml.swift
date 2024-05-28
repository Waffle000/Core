//
//  File.swift
//  
//
//  Created by Enrico Maricar on 28/05/24.
//

import Foundation
import SwiftUI

public func RemovedHtml(from text: String) -> String {
    let pattern = "<.*?>"
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let range = NSRange(location: 0, length: text.utf16.count)
    let htmlLessString = regex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "")
    return htmlLessString
}
