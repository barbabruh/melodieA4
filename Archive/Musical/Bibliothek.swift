//
//  Bibliothèque.swift
//  musique
//
//  Created by Apprenant61 on 05/03/2024.
//

import SwiftUI
import PDFKit

struct Bibliothek: View {
    
    func Filtrerer(lst: Array<PartitionFyshe>,si: Set<Instruments>, ys: Int, ye: Int, gj: Set<Styles>) -> Array<PartitionFyshe>{
        
        var ll = lst
        
        if !si.isEmpty{
            ll = ll.filter { p in
                p.instruments.contains { i in
                    si.contains(i)
                }
            }
        }
        
        if ys != Int(Calendar(identifier: .gregorian).component(.year, from: Date())) + 1 && ye != Int(Calendar(identifier: .gregorian).component(.year, from: Date())) + 1{
            ll = ll.filter { p in
                (ys...ye).contains(p.année)
            }
        }
        
        //        if !gj.isEmpty{
        //            lst.filter { p in
        //                gj.contains(p.style)
        //            }
        //        }
        
        
        return ll == lst ? [] : ll
    }
    
    @Binding var bdd: Array<PartitionFyshe>
    
    @Binding var prof: Profile
    
    //couleurs du fond d'écran
    let saffron = Color(red: 0.9137254901960784, green: 0.7686274509803922, blue: 0.41568627450980394)
    
    let sandyBrown = Color(red: 0.9568627450980393, green: 0.6352941176470588, blue: 0.3803921568627451)
    
    //couleurs du boutton "mes partitions"
    let colorGBox1 = Color(red: 0.6313725490196078, green: 0.6588235294117647, blue: 0.9098039215686274)
    
    let colorDBox1 = Color(red: 0.2549019607843137, green: 0.3333333333333333, blue: 0.47843137254901963)
    
    //couleurs du boutton "mes contributions"
    let colorGBox2 = Color.white
    
    let colorDBox2 = Color(red: 0.24313725490196078, green: 0.4, blue: 0.43529411764705883)
    
    //nb de partibtions sauvegardées
    var partiSaved: Int = 666
    
    @State private var selectedSortingOption: String = ""
    
    @State var bibtab = 0
    
    //filtres
    @State var fifi = false
    @State var jor = Set<Styles>()
    @State var yearStart = Int(Calendar(identifier: .gregorian).component(.year, from: Date())) + 1
    @State var yearEnd = Int(Calendar(identifier: .gregorian).component(.year, from: Date())) + 1
    @State var selectedInstru = Set<Instruments>()
    
    var body: some View {
        NavigationView{
            ZStack{
                //fond d'écran
                LinearGradient(colors: [saffron, sandyBrown], startPoint: .top, endPoint: .bottom)
                
                VStack{
                    //titre bibliothèque
                    HStack{
                        Text("Bibliothèque").font(.system(size: 45))
                            .bold()
                        //.padding(.bottom)
                        Spacer()
                        
                        /*
                         Button{
                         
                         }label:{
                         VStack{
                         Image(systemName: "person.circle").resizable().frame(width: 30, height: 30)
                         .foregroundStyle(.black)
                         Text("invité").foregroundStyle(.black)
                         }
                         }*/
                    }.padding(.horizontal, 30).padding(.top, 20)
                    
                    //les boutons "mes partitions" et "mes contributions"
                    HStack{
                        
                        //C'est le bouton partition. C'est écrit en dessous
                        
                        Picker("ummm", selection: $bibtab) {
                            Text("Mes partitions").tag(0)
                            Text("Mes contributions").tag(1)
                        }.pickerStyle(.segmented)
                            .padding()
                    }
                        //Button("Mes partitions"){
                        /*
                         bdd.insert(PartitionFyshe(pdf: PDFDocument(), ajoutéPar: "porké", titre: "Jypep", auteur: "idkbro", année: 2012, instruments: [.basse,.guitare], imageParti: "50bouf", lstCommentaire: []))
                         
                         bdd.insert(PartitionFyshe(pdf: PDFDocument(), ajoutéPar: "porké", titre: "JypepEn10", auteur: "who?", année: 2022, instruments: [.basse,.violon], imageParti: "50bouf2", lstCommentaire: []))
                         
                         bdd.insert(PartitionFyshe(pdf: PDFDocument(), ajoutéPar: "porké", titre: "Jpp", auteur: "idkbro", année: 2014, instruments: [.clarinette,.guitare], imageParti: "50bouf3", lstCommentaire: []))
                         
                         bdd.insert(PartitionFyshe(pdf: PDFDocument(), ajoutéPar: "porké", titre: "Jeanne", auteur: "Oskour", année: 2015, instruments: [.clarinette,.piano,.violon], imageParti: "EPiaf", lstCommentaire: []))
                         
                         bdd.insert(PartitionFyshe(pdf: PDFDocument(), ajoutéPar: "porké", titre: "Aled", auteur: "Maped", année: 1, instruments: [.basse,.violon], imageParti: "50bouf2", lstCommentaire: []))
                         
                         bdd.insert(PartitionFyshe(pdf: PDFDocument(), ajoutéPar: "porké", titre: "ptdr t ki", auteur: "wesh", année: 2024, instruments: [.guitare], imageParti: "50bouf3", lstCommentaire: []))
                         
                         bdd.insert(PartitionFyshe(pdf: PDFDocument(), ajoutéPar: "porké", titre: "The table", auteur: "it's broken", année: 1989, instruments: [.piano,.violon], imageParti: "50bouf", lstCommentaire: []))
                         
                         lstBib = bdd.shuffled()
                         
                         prof.partiSaved.insert(lstBib[0].id)
                         prof.partiSaved.insert(lstBib[1].id)
                         prof.partiSaved.insert(lstBib[2].id)
                         prof.partiSaved.insert(lstBib[3].id)*/
                        //mettre l'action!!!!!!!!!!!!!!!!!!!
                        //                        }
                        //                        .frame(width: 175, height: 50)
                        //                        .background(LinearGradient(colors: [colorGBox1, colorDBox1], startPoint: .leading, endPoint: .trailing).opacity(0.94).blendMode(.luminosity))
                        //                        .foregroundStyle(.black)
                        //                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        //                        
                        //                        
                        //                        
                        //                        /*Si tu as pu lire le commentaire du bouton précédent, suis son conseil
                        //                         */
                        //                        Button("Mes contributions"){
                        //                            //mettre l'action !!!!!!!!!!!!!!!!!!!
                        //                        }
                        //                        .frame(width: 175, height: 50)
                        //                        .background(LinearGradient(colors: [colorGBox2, colorDBox2], startPoint: .leading, endPoint: .trailing).opacity(0.5))
                        //                        .foregroundStyle(.black)
                        //                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        //                        
                        //                    }
                        
                        HStack{
                            /*
                             nombre de partitions sauvegardées, bouton pour trier, bouton pour
                             filtrer
                             */
                            Text("\(prof.partiSaved.count) partitions sauvegardées")
                                .frame(width: 150)
                                .font(.subheadline)
                            
                            //le bouton trie
                            
                            Menu{
                                Button("titre (croissant)"){
                                    bdd.sort { p, m in
                                        p.titre < m.titre
                                    }
                                }
                                Button("titre (décroissant)"){
                                    bdd.sort { p, m in
                                        p.titre > m.titre
                                    }
                                }
                                Button("auteur (croissant)"){
                                    bdd.sort { p, m in
                                        p.auteur < m.auteur
                                    }
                                }
                                Button("auteur  (décroissant)"){
                                    bdd.sort { p, m in
                                        p.auteur > m.auteur
                                    }
                                }
                                
                                Button ("date (croissant)"){
                                    bdd.sort { p, m in
                                        p.année < m.année
                                    }
                                }
                                Button("date  (décroissant)"){
                                    bdd.sort { p, m in
                                        p.année > m.année
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
                            }
                            /*
                             Picker("Trier par", selection: $selectedSortingOption) {
                             Text("Titre").onSubmit {
                             
                             } // Option de tri par titre
                             Text("Artiste").tag("artist") // Option de tri par artiste
                             // Ajoutez d'autres options de tri si nécessaire
                             }
                             */
                            /*
                             Button{
                             
                             }label: {
                             Image(systemName: "arrow.down")
                             .resizable()
                             .frame(width: 20, height: 30)
                             
                             Text("Trier par...")
                             }.foregroundStyle(.black)
                             */
                            
                            
                            //le bouton filtre
                            NavigationLink(destination: Filtre(jor2: $jor, yearStart2: $yearStart, yearEnd2: $yearEnd, selectedInstr2: $selectedInstru, fifi: $fifi),
                                           label: {
                                Image(systemName: "slider.horizontal.3")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                
                                Text("Filtres")
                                    .font(.subheadline)
                            }).padding()
                                .foregroundStyle(.black)
                            
                        }.padding(.bottom,20)
                        
                        
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.fixed(150)),
                                                GridItem(.fixed(150))], spacing: 20){
                                
                                let lstMus = bdd.filter({ f in
                                    prof.partiSaved.contains(f.id)
                                })
                                
                                let ll = Filtrerer(lst: lstMus, si: selectedInstru, ys: yearStart, ye: yearEnd, gj: jor)
                                
                                switch bibtab {
                                case 1:
                                    
                                    if !fifi{
                                        ForEach($bdd.filter({ f in
                                            f.wrappedValue.ajoutéPar == prof.mail
                                        })){ fish in
                                            ExtractedView(par: fish, prof: $prof)
                                        }
                                    }else{
                                        ForEach($bdd.filter({ f in
                                            f.wrappedValue.ajoutéPar == prof.mail && ll.contains(where: { p in
                                                p.id == f.id
                                            })
                                        })){ fish in
                                            ExtractedView(par: fish, prof: $prof)
                                        }
                                    }
                                    
                                default:
                                    if !fifi{  //if fifi = false
                                        ForEach($bdd.filter({ f in
                                            prof.partiSaved.contains(f.id) 
                                        })){ fish in
                                            ExtractedView(par: fish, prof: $prof)
                                        }
                                    }else{ //if fifi = true
                                        ForEach($bdd.filter({ f in
                                            prof.partiSaved.contains(f.id) && ll.contains(where: { p in
                                                p.id == f.id
                                            })
                                        })){ fish in
                                            ExtractedView(par: fish, prof: $prof)
                                        }
                                    }
                                }
                                
                                
                                
                            }
                            /*
                             HStack{
                             
                             /*
                              2 boutons comprenant chacun une image et un titre
                              */
                             
                             //1er bouton
                             BibliView()
                             
                             
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
                             //.scaledToFit()
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
                             
                             Spacer()
                             */
                        }
                        
                    }
                }
            }
        }
    }

//#Preview {
//    Bibliothek()
//}

/*
struct Tmp: View{
    @State private var selectedSortingOption: String = ""
    
    var body: some View {
        VStack {
            // Autre contenu de votre vue
            
            //<Text, <#SelectionValue: Hashable#>, TupleView<(some View, some View)>>
            
            // Menu déroulant pour l'option de tri
            Picker("Trier par", selection: $selectedSortingOption) {
                Text("Titre").tag("title") // Option de tri par titre
                Text("Artiste").tag("artist") // Option de tri par artiste
                // Ajoutez d'autres options de tri si nécessaire
            }
            .pickerStyle(MenuPickerStyle())
            
            // Autre contenu de votre vue
        }
        
        ScrollView {
            VStack(spacing: 20) {
                PartitionView(imageName: "nom_de_votre_image", title: "Titre de votre partition")
                PartitionView(imageName: "nom_de_votre_image", title: "Titre de votre partition")
                // Ajoutez d'autres PartitionViews en fonction de vos données
            }
            .padding(.horizontal, 20)
        }
    }
}

struct PartitionView: View {
    let imageName: String
    let title: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100) // Ajustez la taille selon vos besoins
            
            Text(title)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

*/

struct BibliView: View {
    var partition: PartitionFyshe
    
    var body: some View {
        Button{
            
        }label:{
            VStack{
                PDFKitView(page: 0, pdfDocument: partition.imageParti)
                
                Text("\(partition.titre)\n\(partition.auteur)_\(partition.année)")
                    .foregroundStyle(.black)
                    .italic()
            }
            
        }
    }
}
