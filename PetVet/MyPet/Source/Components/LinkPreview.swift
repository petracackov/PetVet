//
//  LinkPreview.swift
//  MyPet
//
//  Created by Petra Cackov on 9. 8. 24.
//

import SwiftUI

struct LinkPreview: View {
    
    let urlString: String
    
    var body: some View {
        Text(urlString)
    }
//    
//    private func getMetadata() {
//        vets.compactMap { $0.webPage }.forEach { urlString in
//            guard let url = URL(string: urlString) else { return }
//            Task {
//                do {
//                    let provider = LPMetadataProvider()
//                    let metadata = try await provider.startFetchingMetadata(for: url)
////                    let imageData = try? await metadata.imageProvider?.loadDataRepresentation(for: .image)
////                    let title = metadata.title
////                    let iconData = try? await metadata.iconProvider?.loadDataRepresentation(for: .icns)
//                    self.metadata[urlString] = metadata//LinkMetadata(urlString: urlString, metadata: metadata, title: title, imageData: nil, iconData: nil)
//                } catch {
//                    handleError(error)
//                }
//            }
//        }
//        
//    }
}

#Preview {
    LinkPreview(urlString: "https://dezurni-veterinar-ljubljana.si")
}

//import UniformTypeIdentifiers
//
//extension NSItemProvider {
//    
//    func loadDataRepresentation(for type: UTType) async throws -> Data {
//            return try await withCheckedThrowingContinuation { continuation in
//                _ = self.loadDataRepresentation(for: type) { data, error in
//                    if let data {
//                        continuation.resume(returning: data)
//                    } else if let error {
//                        continuation.resume(throwing: error)
//                    }
//                }
//            }
//        }
//    
//}
//
//struct URLPreview : UIViewRepresentable {
//    var previewURL:URL
//
//    func makeUIView(context: Context) -> LPLinkView {
//        let view = CustomLinkView(url: previewURL)
//        
//        let provider = LPMetadataProvider()
//
//        provider.startFetchingMetadata(for: previewURL) { (metadata, error) in
//            if let md = metadata {
//                DispatchQueue.main.async {
//                    view.metadata = md
//                    view.sizeToFit()
//                }
//            }
//        }
//        
//        return view
//    }
//    
//    func updateUIView(_ uiView: LPLinkView, context: UIViewRepresentableContext<URLPreview>) {
//    }
//}
//
//class CustomLinkView: LPLinkView {
//    override var intrinsicContentSize: CGSize { CGSize(width: 0, height: super.intrinsicContentSize.height) }
//}
