//
//  Truncate.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 21/05/24.
//

import Foundation

extension String {
    func truncated(to length: Int, trailing: String = "...") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
}
