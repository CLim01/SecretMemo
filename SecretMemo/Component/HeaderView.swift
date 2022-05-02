//
//  HeaderView.swift
//  SecretMemo
//
//  Created by 임성빈 on 2022/04/28.
//

import SwiftUI

struct HeaderView: View {
    // MARK: PROPERTY
    
    var imageName: String = ""
    
    // MARK: BODY
    var body: some View {
        HStack(alignment: .center, spacing: 10, content: {
            Capsule()
                .frame(height: 3)
            
            Button(action: {
                
            }, label: {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30, maxHeight: 30)
            })
            Capsule()
                .frame(height: 3)
        }) // END: Hstack
        .foregroundColor(.accentColor)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var sampleData: String = "magnifyingglass"
    static var previews: some View {
        HeaderView(imageName: sampleData)
    }
}
