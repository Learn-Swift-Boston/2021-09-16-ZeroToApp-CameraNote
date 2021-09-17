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
                    .init(.adaptive(minimum: 60, maximum: 80)),
                ]) {
                    ForEach(notes) { note in
                        Image(uiImage: note.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 60, maxWidth: 80,
                                   minHeight: 60, maxHeight: 80)
                            .clipped()
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarItems(trailing: cameraButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
        .previewDevice("iPhone 12 mini (14.5)")

        Group {
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
            .previewDevice("iPhone 12 Pro Max")

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
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
        }


    }
}
