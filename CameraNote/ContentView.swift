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

    @State private var notes: [Note]

    init(title: String, previewImages: [UIImage] = []) {
        self.title = title
        notes = previewImages.map { image in Note(image: image) }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    .init(.adaptive(minimum: 50, maximum: 150))
                ]) {
                    ForEach(notes) { note in
                        NavigationLink.init(
                            destination: DetailView(note: note),
                            label: {
                                Image(uiImage: note.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)

                            })
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
        ContentView(
            title: "Whatever",
            previewImages: Array(
                repeating: (1...5).map {
                    number in UIImage(named: "Image \(number)")!
                },
                count: 5
            )
            .flatMap { $0 }
        )
    }
}
