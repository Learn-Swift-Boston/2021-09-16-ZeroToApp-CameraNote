//
//  ContentView.swift
//  CameraNote
//
//  Created by Zev Eisenberg on 9/16/21.
//

import SwiftUI

struct Note: Identifiable {
    let id: UUID = UUID()
    let image: UIImage
}

struct ContentView: View {

    let title: String

    @State private var showingImagePicker = false

    @State private var pickedImage: UIImage?

    @State private var notes: [Note] = []

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [.init(.adaptive(minimum: 75, maximum: 150))]) {
                    ForEach(notes) { note in
                        Image(uiImage: note.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarItems(trailing: cameraButton)
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $pickedImage)
        }
    }

    var cameraButton: some View {
        Button(action: {
            showingImagePicker = true
        }, label: {
            Image(systemName: "camera")
        })
    }

    func loadImage() {
        guard let pickedImage = pickedImage else { return }
        let note = Note(image: pickedImage)
        notes.append(note)
        self.pickedImage = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "Whatever")
    }
}
