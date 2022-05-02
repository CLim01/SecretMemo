//
//  SearchView.swift
//  SecretMemo
//
//  Created by 임성빈 on 2022/04/29.
//

import SwiftUI

struct SearchView: View {
    // MARK: PROPERTY
    
    @State private var memos: [Memo] = [Memo]()
    @State private var searchQuery: String = ""
    
    // MARK: FUNCTION
    
    func filterMemos() {
        if searchQuery.isEmpty {
            
        } else {
            
        }
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        do {
            // Convert the memos array to data using JSONEncoder
            let data = try JSONEncoder().encode(memos)
            
            // Create a new URL to save the file using getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("memos")
            
            // Write the data to the given URL
            try data.write(to: url)
        } catch {
            print("Saving data has failed")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                // Get the memos URL path
                let url = getDocumentDirectory().appendingPathComponent("memos")
                
                // Create a new property for the data
                let data = try Data(contentsOf: url)
                
                // Decode the data
                memos = try JSONDecoder().decode([Memo].self, from: data)
            } catch {
                // Do nothing
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            memos.remove(atOffsets: offsets)
            save()
        }
    }
    
    // MARK: BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, content: {
                // MARK: HEADER
                
                // MARK: CONTENT
                
                List(memos.filter({ searchQuery.isEmpty ? true : $0.text.contains(searchQuery) })) { i in
                    NavigationLink(destination: {
                        DetailView(memo: memos[i], count: memos.count, index: i)
                    }, label: {
                        HStack(alignment: .center, spacing: 3, content: {
                            Capsule()
                                .frame(width:3)
                                .foregroundColor(Color("ColorOrange"))
                            
                            Text(memos[i].text)
                                .lineLimit(1)
                                .padding(.leading, 10)
                        }) // END: HStack
                    }) // END: Navigation Link
                } // END: List
                
                Spacer()
            }) // END: VStack
            .navigationTitle("Search")
            .searchable(text: $searchQuery)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                load()
            })
        } // END: NavigationView
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .previewDevice("iPhone 13 Pro")
            .preferredColorScheme(.dark)
    }
}

