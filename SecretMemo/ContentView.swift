//
//  ContentView.swift
//  SecretMemo
//
//  Created by 임성빈 on 2022/04/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView(content: {
            MemoView()
                .tabItem {
                    Image(systemName: "note.text")
                    Text("Memo")
                }
            SecretView()
                .tabItem {
                    Image(systemName: "lock")
                    Text("Secret")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
            .preferredColorScheme(.dark)
    }
}
