//
//  SwiftUIView.swift
//  
//
//  Created by Manali Patil on 3/20/23.
//

import SwiftUI

struct SwiftUIView: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    @State var showNextView = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    var body: some View {
        NavigationView {
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("No image selected")
                }
                
                    Button(action:{
                        print("Take picture button tapped!")
                        showNextView = true
                    }) {
                        Text("Take picture")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .frame(maxWidth: .infinity)
//                            .cornerRadius(10)
                    }
                    .padding()
                    NavigationLink(
                        destination: CameraView(),
                        isActive: $showNextView,
                        label: {
                            EmptyView()
                        }
                    )
                    
                    Button(action: {
                        // Your action code goes here
                        print("Browse button tapped!")
                        showImagePicker = true
                    }) {
                        Text("Browse")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .frame(maxWidth: .infinity)
//                            .cornerRadius(10)
                    }
                    .padding()
                    .sheet(isPresented: $showImagePicker) {
                        ImagePickerView(selectedImage: self.$selectedImage)
                    }
                
            }
            .navigationTitle("Styler App")

            }
        }
    }


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}




