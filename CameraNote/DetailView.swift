import SwiftUI

struct DetailView: View {

    let note: Note

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            Image(uiImage: note.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(note.id.uuidString)
                .foregroundColor(.white)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(note: Note(image: UIImage(named: "Image 3")!))
    }
}
