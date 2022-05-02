//
//  SecretDetailView.swift
//  SecretMemo
//
//  Created by 임성빈 on 2022/04/28.
//

import SwiftUI

struct SecretDetailView: View {
    // MARK: PROPERTY
    
//    @State private var isEditActive: Bool = false
    
    let secret: Secret
    let count: Int
    let index: Int
    
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
                Text(secret.text)
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

struct SecretDetailView_Previews: PreviewProvider {
    static var sampleData: Secret = Secret(id: UUID(), text: "Hello, World! ")
    
    static var previews: some View {
        SecretDetailView(secret: sampleData, count: 5, index: 1)
    }
}
