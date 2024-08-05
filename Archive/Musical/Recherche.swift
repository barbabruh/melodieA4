//
//  Recherche.swift
//  musique
//
//  Created by Apprenant61 on 07/03/2024.
//

import SwiftUI
import PDFKit



struct Recherche: View {
    
    @Binding var bib: Set<PartitionFyshe>
    @Binding var prof: Profile
    @State private var added = false
    let saffron = Color(red: 0.9137254901960784, green: 0.7686274509803922, blue: 0.41568627450980394)
    
    let sandyBrown = Color(red: 0.9568627450980393, green: 0.6352941176470588, blue: 0.3803921568627451)
    
    var nomRecherche = "Rechercher"
    @Binding var name: String
    @State private var tri = "trier par..."
    @State private var lstBib = [PartitionFyshe]()
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [saffron, sandyBrown], startPoint: .top, endPoint: .bottom)
            
            VStack{
                /*
                 à enlever
                 */
                /*
                Button("add"){
                    if !added{
                        bib.insert(PartitionFyshe( ajoutéPar: "porké", titre: "Jypep", auteur: "idkbro", année: 2012, instruments: [.basse,.guitare], imageParti: PDFDocument(), lstCommentaire: []))
                        
                        bib.insert(PartitionFyshe( ajoutéPar: "porké", titre: "JypepEn10", auteur: "who?", année: 2022, instruments: [.basse,.violon], imageParti: PDFDocument(), lstCommentaire: []))
                        
                        bib.insert(PartitionFyshe( ajoutéPar: "porké", titre: "Jpp", auteur: "idkbro", année: 2014, instruments: [.clarinette,.guitare], imageParti: PDFDocument(), lstCommentaire: []))
                        
                        bib.insert(PartitionFyshe( ajoutéPar: "porké", titre: "Jeanne", auteur: "Oskour", année: 2015, instruments: [.clarinette,.piano,.violon], imageParti: PDFDocument(), lstCommentaire: []))
                        
                        bib.insert(PartitionFyshe(ajoutéPar: "porké", titre: "Aled", auteur: "Maped", année: 1, instruments: [.basse,.violon], imageParti: PDFDocument(), lstCommentaire: []))
                        
                        bib.insert(PartitionFyshe( ajoutéPar: "porké", titre: "ptdr t ki", auteur: "wesh", année: 2024, instruments: [.guitare], imageParti: PDFDocument(), lstCommentaire: []))
                        
                        bib.insert(PartitionFyshe( ajoutéPar: "porké", titre: "The table", auteur: "it's broken", année: 1989, instruments: [.piano,.violon], imageParti: PDFDocument(), lstCommentaire: []))
                        
                        lstBib = bib.shuffled()
                        added.toggle()
                        
                    }
                    
                }*/
                //Spacer()
                TextField(nomRecherche, text: $name)
                    .padding()
                    .frame(width: 300)
                    .background(sandyBrown)
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    .padding(.bottom)
                
                
                Menu(tri){
                    Button("titre (croissant)"){
                        lstBib = bib.sorted { p0, p1 in
                            p0.titre < p1.titre
                        }
                        //tri = "titre (croissant)"
                    }
                    Button("titre (décroissant)"){
                        lstBib = bib.sorted { p0, p1 in
                            p0.titre > p1.titre
                        }
                    }
                    Button("auteur (croissant)"){
                        lstBib = bib.sorted { p0, p1 in
                            p0.auteur < p1.auteur
                        }
                    }
                    Button("auteur (décroissant)"){
                        lstBib = bib.sorted { p0, p1 in
                            p0.auteur > p1.auteur
                        }
                    }
                    Button("date (croissant)"){
                        lstBib = bib.sorted { p0, p1 in
                            p0.année < p1.année
                        }
                    }
                    Button("date (décroissant)"){
                        lstBib = bib.sorted { p0, p1 in
                            p0.année > p1.année
                        }
                    }
                }
                
                
                
                ScrollView{
                    LazyVGrid(columns: [GridItem(.fixed(150)), GridItem(.fixed(150))], spacing: 30
                    ){
//                        if lstBib.isEmpty {
//                            lstBib = bib.shuffled()
//                        }
                        ForEach(bib.filter({ bi in
                            if name == ""{
                                return true
                            }
                            return bi.titre.uppercased().contains(name.uppercased()) || bi.auteur.uppercased().contains(name.uppercased())
                        }), id: \.self){b in
                            //ExtractedView(par: b)
                            
                        }
                    }
//                    HStack{
//
//                        /*
//                         2 boutons comprenant chacun une image et un titre
//                         */
//
//                        //1er bouton
//
//
//
//                        //2e bouton
//                        Button{
//
//                        }label:{
//                            VStack{
//                                Image("50bouf2")
//
//                                Text("musique classique")
//                                    .foregroundStyle(.black)
//                            }
//                        }
//
//                    }
//
//                    /*
//                     image de planche pour séparer. C bo
//                     */
//
//                    Image("planche")
//                        .resizable()
//                        .scaledToFit()
//                        .padding(.bottom)
//
//
//                    /*
//                     et on recommence les 2 boutons
//                     */
//                    HStack{
//                        //C'est un bouton
//                        Button{
//
//                        }label:{
//                            VStack{
//                                Image("mozart")
//
//                                Text("musique classique")
//                                    .foregroundStyle(.black)
//                            }
//                        }
//
//                        //Ceci en est un autre
//                        Button{
//
//                        }label:{
//                            VStack{
//                                Image("piano")
//
//                                Text("musique classique")
//                                    .foregroundStyle(.black)
//                            }
//                        }
//                    }
//
//
//                    //et, tu l'a deviné, une planche
//                    Image("planche")
//                        .resizable()
//                        .scaledToFit()
//                        .padding(.bottom)
//
//                    HStack{
//                        //C'est un bouton
//                        Button{
//
//                        }label:{
//                            VStack{
//                                Image("50bouf3")
//
//                                Text("musique classique")
//                                    .foregroundStyle(.black)
//                            }
//                        }
//
//                        //Ceci en est un autre
//                        Button{
//
//                        }label:{
//                            VStack{
//                                Image("idkbro")
//
//                                Text("musique classique")
//                                    .foregroundStyle(.black)
//                            }
//                        }
//                    }
//
//
//                    //et, tu l'a deviné, une planche
//                    Image("planche")
//                        .resizable()
//                        .scaledToFit()
//                        .padding(.bottom)
                }.frame(height: 550)
                
            }
        }
    }
}
/*
#Preview {
    Recherche(name: "
")
}
*/

