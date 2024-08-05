//
//  ContentView.swift
//  le verbe filtrer
//
//  Created by Apprenant75 on 19/03/2024.
//

import SwiftUI

struct Filtre: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //couleurs du fond
    let saffron = Color(red: 0.9137254901960784, green: 0.7686274509803922, blue: 0.41568627450980394)
    
    let sandyBrown = Color(red: 0.9568627450980393, green: 0.6352941176470588, blue: 0.3803921568627451)
    
    @State private var downloaded = 2
    let curYear = Int(Calendar(identifier: .gregorian).component(.year, from: Date()))
    //@Binding var downloaded2: String
    
    @State private var jor: Set<Styles> = []
    @Binding var jor2: Set<Styles>
    
    @State private var yearStart = Int(Calendar(identifier: .gregorian).component(.year, from: Date())) + 1
    @Binding var yearStart2: Int
    
    @State private var yearEnd = Int(Calendar(identifier: .gregorian).component(.year, from: Date())) + 1
    @Binding var yearEnd2: Int
    
    @State private var tmp = ""
    @State private var tmp2 = ""
    @State private var tmp3 = ""
    @State private var tmp4 = ""
    @State private var tmp5 = ""
    
    @State private var selectedInstr: Set<Instruments> = []
    
    @Binding var selectedInstr2: Set<Instruments>
    
    @Binding var fifi: Bool
    
    var body: some View {
        ZStack{
                    LinearGradient(colors: [saffron, sandyBrown], startPoint: .top, endPoint: .bottom)
                    /*
                     Image("8924")
                     .resizable()
                     .frame(width: 400)
                     */
                    
                    VStack{
                        
                        Spacer()
                        
                        Text("Filtres")
                            .font(.title)
                            .bold()
                            .underline()
                        
                        List{
//                            /*
//                             partitions téléchargées et/ou non
//                             */
//                            Menu(downloaded){
//                                Picker(selection: $downloaded, label: Text("Picker")) {
//                                    Text("les deux").tag(0)
//                                    Text("non téléchargées").tag(1)
//                                    Text("téléchargées").tag(2)
//                                    
//                                }
//                            }
                            
                            /*
                             année de départ de l'interval
                             */
                            TextField(yearStart == curYear+1 ? "entre l'année..." : "\(yearStart)",text: $tmp)
                                .onSubmit {
                                    yearStart = Int(tmp) ?? curYear + 1
                                    tmp = ""
                                    if (yearStart > yearEnd && yearEnd != curYear+1) || yearStart >= curYear+1 || yearStart < 0{
                                        yearStart = curYear+1
                                    }
                                }
                            
                            /*
                             année de fin de l'interval
                             */
                            TextField(yearEnd == curYear+1 ? "et l'année..." : "\(yearEnd)", text: $tmp2)
                                .onSubmit {
                                    yearEnd = Int(tmp2) ?? curYear+1
                                    tmp2 = ""
                                    if (yearEnd < yearStart && yearStart != curYear+1) || yearEnd >= curYear+1 || yearEnd < 0{
                                        yearEnd = curYear+1
                                    }
                                }
                            
                            /*
                             filtrer par instru
                             */
                            Menu("Filtrer par instrument"){
                                ForEach(Instruments.allCases, id: \.self){ i in
                                    if i != .none{
                                        Button(i.rawValue) {
                                            selectedInstr.insert(i)
                                        }
                                    }
                                }
                            }
                            
                            ForEach(selectedInstr.shuffled(), id: \.self){ i in
                                Button{
                                    selectedInstr.remove(i)
                                }label: {
                                    Text(i.rawValue)
                                        .foregroundStyle(.black)
                                }
                            }
                            
                            
                            //MERCREDI:
                            // on veut jor et selectedinstru en set ou en array?
                            // est ce que ça binde bien?
                            // et notre bdd alors pq cracnt?
                            
                            
                            //filtrer par jor
                            Menu("Filtrer par style") {
                                ForEach(Styles.allCases, id: \.self){ i in
                                    if i != .none{
                                        Button(i.rawValue) {
                                            jor.insert(i)
                                        }
                                    }
                                }
                            }
                            ForEach(jor.shuffled(), id: \.self){ i in
                                Button{
                                    jor.remove(i)
                                }label: {
                                    Text(i.rawValue).foregroundStyle(.black)
                                }
                            }
                            
                            
                        }.padding(.horizontal)
                            .frame(height: 350)
                            .scrollContentBackground(.hidden)
                        
                        
                        Spacer()
                        Button{
                            fifi = false
                            self.presentationMode.wrappedValue.dismiss()
                        }label: {
                            Text("Annuler")
                                .foregroundStyle(.black)
                                .padding(20)
                                .background(.yellow)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Button{
                            yearStart = Int(tmp) ?? curYear + 1
                            tmp = ""
                            if (yearStart > yearEnd && yearEnd != curYear+1) || yearStart >= curYear+1 || yearStart < 0{
                                yearStart = curYear+1
                            }
                            
                            yearEnd = Int(tmp2) ?? curYear+1
                            tmp2 = ""
                            if (yearEnd < yearStart && yearStart != curYear+1) || yearEnd >= curYear+1 || yearEnd < 0{
                                yearEnd = curYear+1
                            }
                            
                            if (yearStart != curYear + 1 && yearEnd != curYear+1) || !selectedInstr.isEmpty || !jor.isEmpty{
                                fifi = true
                            }else{
                                fifi = false
                            }
                            
                            yearStart2 = yearStart
                            yearEnd2 = yearEnd
                            selectedInstr2 = selectedInstr
                            jor2 = jor
                            self.presentationMode.wrappedValue.dismiss()
                            //edirutyfbdv
                        }label: {
                            Text("Filtrer")
                                .foregroundStyle(.black)
                                .padding(20)
                                .background(.yellow)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }
                        
                        Spacer()
                        Spacer()
                        
                    }
                }
            }
}
    
/*
 var body: any View {
 
 var instruments: [Instruments]
 
 func transaction () {
 
 HStack {
 
 let piano = [Instruments]; "Piano"
 let guitare = [Instruments]; "Guitare"
 let violon = [Instruments]; "Violon"
 let basse = [Instruments]; "Base"
 let clarinette = [Instruments]; "Clarinete"
 let none = [Instruments]; "Ajouter un instrument"
 
 let instruments = [Instruments] = ("Piano", "Guitare", "Violon", "Base", "Clarinette")
 
 }
 enum Genres: String, CaseIterable{
 case rock = "Rock", pop = "Pop",
 classique = "Classique", metal = "Metal"
 
 }
 }
 }
 */



//#Preview {
//    Filtre(downloaded2: ("toto"), jor2: ("toto"), yearStart2: .constant("toto"), yearEnd2: .constant("toto"), downloded5: .constant("toto"))
//}


//        ExtractedView(instruments: instruments) {
//
//        }
//
//            struct ExtractedView: View {
//                let instruments: Instruments
//                var body: some View {
//                    HStack {
//                        Text(instruments.instruments)
//
//                }
//            }
//        }
//    }
//


