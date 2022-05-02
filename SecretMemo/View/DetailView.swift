//
//  DetailView.swift
//  SecretMemo
//
//  Created by 임성빈 on 2022/04/28.
//

import SwiftUI

struct DetailView: View {
    // MARK: PROPERTY
    
//    @State private var isEditActive: Bool = false
    
    let memo: Memo
    let count: Int
    let index: Int
    
    @State private var newText: String = ""
    
    // MARK: BODY
    var body: some View {
        VStack(alignment: .center, spacing: 3, content: {
            // MARK: HEADER
            HeaderView(imageName: "pencil.and.outline")
            
            HStack(content: {
                Spacer()
                
                Text("\(count) / 500")
                    .foregroundColor(.secondary)
            })
            .padding(.horizontal)
            
            Spacer()

            // MARK: CONTENT
            ScrollView(.vertical, content: {
                TextField("\(memo.text)", text: $newText)
                    .multilineTextAlignment(.leading)
            }) // END: ScrollView
            .font(.body)
            .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
           
            Spacer()
            // MARK: FOOTER
            Text("\(index + 1) / \(count)")
                .foregroundColor(.secondary)
            
        }) // END: VStack
    }
}

struct DetailView_Previews: PreviewProvider {
    static var sampleData: Memo = Memo(id: UUID(), text: "Hello, World! ")
    
    static var previews: some View {
        DetailView(memo: sampleData, count: 5, index: 1)
    }
}
