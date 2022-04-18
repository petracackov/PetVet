//
//  BarcodeView.swift
//  PetVet
//
//  Created by Petra Cackov on 18/04/2022.
//

import SwiftUI

struct BarcodeView: UIViewRepresentable {

    let barcode: String
    let backgroundColor: UIColor = Appearance.Color.backgroundGray
    let foregroundColor: UIColor = Appearance.Color.black

    func makeUIView(context: Context) -> UIImageView {
        UIImageView()
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = generateBarcode(from: barcode)
        uiView.backgroundColor = .red
        uiView.tintColor = .yellow
    }

    private func generateBarcode(from string: String) -> UIImage? {
        let data = barcode.data(using: .ascii)

        guard let filter = CIFilter(name: "CICode128BarcodeGenerator"), let colorFilter = CIFilter(name: "CIFalseColor") else {
            return nil
        }

        filter.setValue(data, forKey: "inputMessage")

        colorFilter.setValue(filter.outputImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(color: backgroundColor), forKey: "inputColor1")
        colorFilter.setValue(CIColor(color: foregroundColor), forKey: "inputColor0")

        guard let ciImage = colorFilter.outputImage else {
            return nil
        }

        return UIImage(ciImage: ciImage)
    }
}

