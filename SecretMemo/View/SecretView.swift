//
//  SecretView.swift
//  SecretMemo
//
//  Created by 임성빈 on 2022/04/28.
//

import SwiftUI

struct SecretView: View {
    // MARK: PROPERTY
    
    @State private var secrets: [Secret] = [Secret]()
    @State private var text: String = ""
    
    // MARK: FUNCTION
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        do {
            // Convert the memos array to data using JSONEncoder
            let data = try JSONEncoder().encode(secrets)
            
            // Create a new URL to save the file using getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("secrets")
            
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
                let url = getDocumentDirectory().appendingPathComponent("secrets")
                
                // Create a new property for the data
                let data = try Data(contentsOf: url)
                
                // Decode the data
                secrets = try JSONDecoder().decode([Secret].self, from: data)
            } catch {
                // Do nothing
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            secrets.remove(atOffsets: offsets)
            save()
        }
    }
    
    // MARK: BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, content: {
                // MARK: HEADER
                HeaderView(imageName: "lock.square")
                
                HStack(alignment: .center, spacing: 3, content: {
                    TextField("Add New Secret", text: $text)
                    
                    Button(action: {
                        // Only run the Button's action when text field is not empty
                        guard text.isEmpty == false else { return }
                        
                        // Create a new memo item and initialize it with the text value
                        let secret = Secret(id: UUID(), text: text)
                        
                        // Add the new memo item to the memos array
                        secrets.append(secret)
                        
                        // Make the text field empty
                        text = ""
                        
                        // Save the memo
                        save()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.title)
                    })
                }) // END: HStack
                .padding(.vertical, 30)
                .padding(.horizontal, 20)
                
                Divider()
                
                // MARK: CONTENT
                
                if secrets.count >= 1 {
                    List {
                        ForEach (0..<secrets.count, id: \.self) { i in
                            NavigationLink(destination: {
                                SecretDetailView(secret: secrets[i], count: secrets.count, index: i)
                            }, label: {
                                HStack(alignment: .center, spacing: 3, content: {
                                    Capsule()
                                        .frame(width:3)
                                        .foregroundColor(Color("ColorOrange"))
                                    
                                    Image(systemName: "eye.slash")
                                        .padding(.leading, 10)
                                    
                                    Text("You can not see Preview")
                                        .padding(.leading, 10)
                                }) // END: HStack
                            }) // END: Navigation Link
                        } // END: Loop
                        .onDelete(perform: delete)
                    } // END: List
                } else {
                    Spacer()
                    
                    Image(systemName: "person.fill.questionmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                        .opacity(0.5)
                        .padding(.leading, 150)
                        .padding(.trailing, 125)
                    
                    Spacer()
                }
                
                Spacer()
            }) // END: VStack
            .navigationTitle("Secret")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                load()
        })
        }
    }
}

struct SecretView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
            .preferredColorScheme(.dark)
    }
}
