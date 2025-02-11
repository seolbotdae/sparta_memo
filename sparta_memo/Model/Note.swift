//
//  Note.swift
//  sparta_memo
//
//  Created by Seol WooHyeok on 2/11/25.
//

import Foundation

struct Note: Codable {
    var content: String
    
    init(content: String) {
        self.content = content
    }
}
