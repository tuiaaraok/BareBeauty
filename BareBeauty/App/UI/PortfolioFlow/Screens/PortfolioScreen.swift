import SwiftUI

@available(iOS 16.0, *)
struct PortfolioScreen: View {
    
    @State private var imageSections: [ImageSection] = []
    
    private let storage = Storage.shared
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Button(action: {
                let newSection = ImageSection()
                imageSections.append(newSection)
            }) {
                HStack(spacing: 0) {
                    Image("plusButtonIcon")
                        .frame(maxWidth: 25, maxHeight: 25)
                    Text("Add a new example of work")
                        .padding(.leading, 7)
                    Spacer()
                }
                .customFont(.mainText)
                .foregroundStyle(.white)
                .padding(EdgeInsets(top: 14, leading: 16, bottom: 15, trailing: 16))
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.buttons)
                .cornerRadius(20)
            }
            .padding(25)
            
            List {
                ForEach($imageSections) { $imageSection in
                    HStack(spacing: 20) {
                        ImageView(imageData: $imageSection.beforeImage, label: "Before"){ saveImageSections() }
                        
                        ImageView(imageData: $imageSection.afterImage, label: "After"){ saveImageSections() }
                    }
                    .listRowBackground(Color.background)
                }
                .onDelete { indexSet in
                    imageSections.remove(atOffsets: indexSet)
                    storage.savePortfolioImageSections(imageSections)
                }
                
            }
            .padding(.bottom, 1)
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea())
        .onAppear {
            saveImageSections()
        }
    }
    private func saveImageSections() {
        storage.savePortfolioImageSections(imageSections)
    }
}

@available(iOS 16.0, *)
struct ImageView: View {
    @Binding var imageData: UIImageData?
    let label: String
    let onImagePicked: () -> Void
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack {
            if let uiImage = imageData?.toUIImage() {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity, height: 127)
                    .padding(10)
                    .background(Color.portfolioItemBackground.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.buttons, lineWidth: 5)
                    )
                
                
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: .infinity, height: 127)
                    .foregroundColor(.gray)
                    .background(Color.gray.opacity(0.2))
                    .padding(10)
                    .background(Color.portfolioItemBackground.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.buttons, lineWidth: 5)
                    )
            }
            
            
            Text(label)
                .customFont(.portfolioItemText)
                .foregroundStyle(Color.black)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .frame(maxWidth: .infinity, maxHeight: 22)
                .background(Color.portfolioItemBackground.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 3))
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.buttons, lineWidth: 1)
                )
            
            PlusButton(action: { isImagePickerPresented = true })
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker { selectedImage in
                        imageData = UIImageData(from: selectedImage)
                    }
                    
                }
                .buttonStyle(.plain)
        }
    }
}

struct UIImageData: Codable {
    var imageData: Data
    
    init(from image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 0.8) ?? Data()
    }
    
    func toUIImage() -> UIImage? {
        return UIImage(data: imageData)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    var onImagePicked: (UIImage) -> Void
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.onImagePicked(uiImage)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

