//
//  ContentView.swift
//  SwiftUIArchitectureMVC
//
//  Created by Narumichi Kubo on 2022/03/04.
//

import SwiftUI
import Combine

struct SearchMainView: View {
    /// 検索したユーザーを管理しているクラス
    @StateObject var model = SearchModel()
    /// 検索ワード
    @State private var searchText: String = ""
    /// 選択中ユーザーのURL
    @State private var selection = Selection<String>(item: nil)
    
    var body: some View {
        ZStack {
            // ナビゲーション
            if let reposUrl = selection.item {
                navigation(reposUrl: reposUrl)
            }
            // コンテント
            content
            // エラー
            if let modelError = model.error {
                error(messege: modelError.localizedDescription)
            }
        }
        .navigationTitle("🔍Search Github User")
    }
    
    // MARK: - ナビゲーション
    private func navigation(reposUrl: String) -> some View {
        NavigationLink(isActive: $selection.isSelected) {
            RepositoryView(repositoryUrl: reposUrl)
        } label: {
            EmptyView()
        }
    }
    
    // MARK: - コンテント
    private var content: some View {
        VStack {
            // 検索項目
            TextField("Search User Name", text: $searchText)
                .onChange(of: searchText, perform: { newValue in
                    UserController(model: model, query: searchText).loadStart()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.asciiCapable)
                .padding()
            Spacer()
            
            // 検索結果リスト
            List {
                ForEach(model.users) { user in
                    UserCard(user: user)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // 通信を行う模擬実装
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                selection = .init(item: user.reposUrl)
                            }
                        }
                }
            }
            .refreshable {
                UserController(model: model, query: searchText).loadStart()
            }
        }
    }
    
    // MARK: - エラー
    private func error(messege: String) -> some View {
        Text(messege)
    }
}

// MARK: - Navigationを利用するために作成. ViewからStateとして管理する.
struct Selection<T> {
    /// isActiveフラグのBinding先として定義
    var isSelected: Bool
    /// 選択中のアイテム
    var item: T? {
        didSet {
            // アイテムをセットしてフラグを更新
            isSelected = item != nil
        }
    }
    init(item: T?) {
        self.item = item
        isSelected = item != nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMainView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
    }
}
