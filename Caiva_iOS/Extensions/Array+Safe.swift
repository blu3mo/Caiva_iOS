//////////
// from: https://qiita.com/shtnkgm/items/f02553cb6bb16a59d8fe
//////////

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
