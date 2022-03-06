//
//  ModelError.swift
//  SwiftUIArchitectureMVC
//
//  Created by Narumichi Kubo on 2022/03/06.
//

import Foundation

enum ModelError: Error {
    case encodingError
    case urlError
    case responseError(Error)
    case responseDataEmpty
    case jsonParseError(String)

    var localizedDescription: String {
        switch self {
        case .encodingError: return "エンコーディングできない文字列が入ってきました"
        case .urlError: return "URLに変換しようとしたところで失敗しました"
        case .responseError(let error): return "API叩いたらエラーが返ってきました。詳細: （\(error)）"
        case .responseDataEmpty: return "APIから取得したデータがnilでした"
        case .jsonParseError(let message): return "JSONのパースに失敗しました。失敗したデータ: (\(message)"
        }
    }
}
