//
//  Accueil.swift
//  musique
//
//  Created by Apprenant61 on 07/03/2024.
//

import SwiftUI

struct Accueil: View {
    //couleurs du fond
    @Binding var bibi: Array<PartitionFyshe>
    
    @Binding var prof: Profile
    
    @State private var txt = ""
    @State private var name = ""
    let saffron = Color(red: 0.9137254901960784, green: 0.7686274509803922, blue: 0.41568627450980394)
    
    let sandyBrown = Color(red: 0.9568627450980393, green: 0.6352941176470588, blue: 0.3803921568627451)
    
    @State private var lstBib = [PartitionFyshe]()
    @State private var initLB = false
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(colors: [saffron,sandyBrown], startPoint: .top, endPoint: .bottom)
                
                VStack{
                    TextField("Rechercher...", text: $txt)
                        .padding()
                        .frame(width: 300)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                        .onSubmit {
                            if !initLB{
                                lstBib = bibi.shuffled()
                                initLB.toggle()
                            }
                            name = txt
                        }
                    
                    if name == "" {
                        
                        
                        
                        Text("Dernières partitions ajoutées")
                            .font(.title2)
                            .bold()
                            .underline()
                            .padding(.top, 50)
                        
                        
                        LazyVGrid(columns: [GridItem(.fixed(150)),GridItem(.fixed(150))], content: {
                            if prof.partiSaved.count <= 4{
                                ForEach($bibi.filter({ f in
                                    prof.partiSaved.contains(f.id)
                                })){ p in

                                    ExtractedView(par: p, prof: $prof)
                                }
                            }
                            else{
                                let limit = prof.partiSaved.count
                                ForEach($bibi.filter({ f in
                                    prof.partiSaved[limit-4...limit-1].contains(f.id)
                                })){ p in
                                    ExtractedView(par: p, prof: $prof)
                                }
                            }
                            
                        })
                    }else{
                        
                        Menu{
                            Button("titre (croissant)"){
                                bibi.sort { p0, p1 in
                                    p0.titre < p1.titre
                                }
                                //tri = "titre (croissant)"
                            }
                            Button("titre (décroissant)"){
                                bibi.sort { p0, p1 in
                                    p0.titre > p1.titre
                                }
                            }
                            Button("auteur (croissant)"){
                                bibi.sort{ p0, p1 in
                                    p0.auteur < p1.auteur
                                }
                            }
                            Button("auteur (décroissant)"){
                                bibi.sort { p0, p1 in
                                    p0.auteur > p1.auteur
                                }
                            }
                            Button("date (croissant)"){
                                bibi.sort { p0, p1 in
                                    p0.année < p1.année
                                }
                            }
                            Button("date (décroissant)"){
                                bibi.sort { p0, p1 in
                                    p0.année > p1.année
                                }
                            }
                        }label: {
                            Image(systemName: "arrow.down")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.black)
                                .frame(width: 22, height: 22)
                            
                            Text("Trier par...")
                                .font(.subheadline)
                                .foregroundStyle(.black)
                                //.padding(.bottom)
                        }.padding()
                        
                        
                        
                        ScrollView{
                            LazyVGrid(columns: [GridItem(.fixed(150)), GridItem(.fixed(150))], spacing: 30
                            ){
        //                        if lstBib.isEmpty {
        //                            lstBib = bib.shuffled()
        //                        }
                                ForEach($bibi.filter({ bi in
                                    if name == ""{
                                        return true
                                    }
                                    let t: String =  bi.wrappedValue.titre
                                    let a: String = bi.wrappedValue.auteur
                                    return t.uppercased().contains(txt.uppercased()) || a.uppercased().contains(txt.uppercased())
                                })){b in
                                    ExtractedView(par: b, prof: $prof)
                                    
                                }
                            }
                        }.frame(height: 550)
                        
                    }
                    /*
                     HStack{
                     
                     /*
                      2 boutons comprenant chacun une image et un titre
                      */
                     
                     //1er bouton
                     Button{
                     
                     }label:{
                     VStack{
                     Image("WOz")
                     
                     Text("Over the rainbow Judy\n(Garland_1939)")
                     .foregroundStyle(.black)
                     }
                     
                     }
                     
                     
                     //2e bouton
                     Button{
                     
                     }label:{
                     VStack{
                     Image("EPiaf")
                     
                     Text("L'hymne à l'amour\n(Edith Piaf_1950)")
                     .foregroundStyle(.black)
                     }
                     }
                     
                     }
                     
                     /*
                      image de planche pour séparer. C bo
                      */
                     
                     Image("planche")
                     .resizable()
                     .frame(width: 400,height: 50)
                     
                     
                     /*
                      et on recommence les 2 boutons
                      */
                     HStack{
                     //C'est un bouton
                     Button{
                     
                     }label:{
                     VStack{
                     Image("EPiaf")
                     
                     Text("Sous le Ciel de Paris\n(Edith Piaf_1951)")
                     .foregroundStyle(.black)
                     }
                     }
                     
                     //Ceci en est un autre
                     Button{
                     
                     }label:{
                     VStack{
                     Image("Mills")
                     
                     Text("Some of These Days\n(The Millis Brothers...)")
                     .foregroundStyle(.black)
                     }
                     }
                     }
                     
                     
                     //et, tu l'a deviné, une planche
                     Image("planche")
                     .resizable()
                     .frame(width: 400,height: 50)
                     
                     //Spacer()*/
                }
            }
        }
    }
}
/*
#Preview {
    Accueil()
}*/
struct ExtractedView: View {
    @Binding var par: PartitionFyshe
    @Binding var prof: Profile
    var body: some View {
        //var img: String
        
        NavigationLink(destination: Partition(parti: $par, prof: $prof), label:{
            VStack{
                PDFKitView(page: 0,pdfDocument: par.imageParti)
                    .scaledToFit()
                
                Text(par.titre + "-\r" + par.auteur)
                    .foregroundStyle(.black)
                    .bold()
                    .italic()
                    .frame(width: 150)
            }
            
        })
    }
}
