//
//  Memo.swift
//  SecretMemo
//
//  Created by 임성빈 on 2022/04/28.
//

import Foundation

struct Memo: Identifiable, Codable {
    let id: UUID
    let text: String
}

struct Secret: Identifiable, Codable {
    let id: UUID
    let text: String
}
