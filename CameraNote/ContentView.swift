//
//  ContentView.swift
//  CameraNote
//
//  Created by Zev Eisenberg on 9/16/21.
//

import SwiftUI

struct ContentView: View {

    let title: String

    @State private var showingImagePicker = false

    @State private var pickedImage: UIImage?
    @State private var currentlyDisplayedImage: UIImage?

    var body: some View {
        NavigationView {
            VStack {
                if let image = currentlyDisplayedImage {
                    Image(uiImage: image)
                        .resizable()
                }
                List(0...100, id: \.self) { number in
                    Text("item \(number)")
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
        currentlyDisplayedImage = pickedImage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "Whatever")
    }
}
