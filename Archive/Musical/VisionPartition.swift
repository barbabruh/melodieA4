//
//  test3.swift
//  Exercice1
//
//  Created by Apprenant61 on 14/03/2024.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    
    var page: Int
    var pdfDocument: PDFDocument
    
//    init(pdfData pdfDoc: PDFDocument) {
//        self.pdfDocument = pdfDoc
//    }
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.displayMode = .singlePage
        pdfView.autoScales = true
        
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: UIViewRepresentableContext<PDFKitView>) {
        pdfView.document = pdfDocument
        if let thePage = pdfView.document?.page(at: page) {
                    pdfView.go(to: thePage)
                }
    }
}

struct PDFUIView: View {

    @State var page = 0
    var doc: PDFDocument
    @State private var vx: CGFloat = 0.0
    @State private var vy: CGFloat = 0.0
        
    var body: some View {
        VStack {
            
            GeometryReader{ prox in
                PDFKitView(page: page, pdfDocument: doc)
                    
                    .onAppear{
                        vx = prox.size.width
                        vy = prox.size.height
                    }
                    .onTapGesture {location in
                        if location.y < vy && location.y >= 0{
                            if location.x >= 16 && location.x < vx / 2 && page > 0{
                                page -= 1
                            }
                            if location.x < vx-16 && location.x > vx / 2 && page+1 < doc.pageCount{
                                page += 1
                            }
                        }
                    }
            }
            
            Text("page \(page + 1) sur \(doc.pageCount)")
            
        }
//        .onAppear {
//            loadDoc()
//        }
        
//        HStack{
//
//            Button{
//
//            }label: {
//                VStack{
//                    Image(systemName: "play.square.fill")
//                    Text("faire défiler la parition")
//                        .font(.footnote)
//                }
//            }.frame(width: 100)
//
//            Button{
//
//            }label: {
//                VStack{
//                    Image(systemName: "clock.fill")
//                    Text("vitesse du défilement")
//                        .font(.footnote)
//                }
//            }.frame(width: 100)
//            /*
//            Button("save pdf"){
//                doc.write(toFile: "/Users/apprenant61/Downloads/Testing.pdf")
//            }*/
//        }.frame(height: 200)
        
    }
    
    private func loadDoc() {
        
            guard let path = NSData(contentsOfFile: "/Users/apprenant61/Downloads/Dragon.pdf") else {
            print("Could not find PDF document")
            return
        }
        do {
            if let theDoc = PDFDocument(data: Data(referencing: path)) {
                //doc = theDoc
            }
        } /*catch {
            print("error: \(error)") // todo
        }*/
    }
//    let pdfDoc: PDFDocument
//    @State private var curPage = 0
//
//
//    init() {
//        //for the sake of example, we're going to assume
//        //you have a file Lipsum.pdf in your bundle
//        let url = NSData(contentsOfFile: "/Users/apprenant61/Downloads/Enum.pdf")
//        pdfDoc = PDFDocument(data: url! as Data)!
//    }
//
//    var body: some View {
//        var currentPage = 0
//        PDFKitView(pdfData: pdfDoc)
//            .frame(width: 400,height: 400*sqrt(2.0))
//            .scaledToFit()
//
//    }
}

struct test3: View {
    var body: some View {
        
        Text("Hello, World!")
    }
}

//#Preview {
//    PDFUIView()
//}
