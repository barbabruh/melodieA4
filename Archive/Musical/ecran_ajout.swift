//
//  ecran ajout.swift
//  Exercice1
//
//  Created by Apprenant75 on 05/03/2024.
//

import SwiftUI
import PDFKit

struct Ecran_ajout: View {
    @Environment(\.openURL) var openURL
//    let file
    
    let saffron: Color = Color(red: 0.9137254901960784, green: 0.7686274509803922, blue: 0.41568627450980394)
    let sandyBrown: Color = Color(red: 0.9568627450980393, green: 0.6352941176470588, blue: 0.3803921568627451)
    let cream: Color = Color(red: 1, green: 1, blue: 1, opacity: 0.9)
    
    let curYear = Int(Calendar(identifier: .gregorian).component(.year, from: Date()))
    
    /*
    struct Profile {
        var pseudo: String
        var avatarPic: String
        var mail: String
        var instruJoué: Set<Instruments>
        var partiSaved: Set<UUID>
    }
    
    struct PartitionFyshe: Hashable, Identifiable {
        var id: UUID
        var ajoutéPar: String //mail du profil
        var titre: String
        var auteur: String
        var année: Int
        var instruments: Set<Instruments>
        var imageParti: PDFDocument // ou Image
        var lstCommentaire: [Commentary]
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(titre + auteur)
        }
    }
    
    struct Commentary: Hashable, Identifiable {
        var id: Int
        var photo: String
        var phoText: String
        var comm: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(phoText)
        }
    }*/
    
    //ici sont les instrus
//    enum Instruments: String, CaseIterable{
//        case none = "Ajouter un instrument...",
//             piano = "Piano",
//             guitare = "Guitare",
//             violon = "Violon",
//             basse = "Basse",
//             clarinette = "Clarinette"
//    }
    
    @Binding var bdd: Array<PartitionFyshe>
    
     var prof: Profile
    
    @State private var tempfyshe = PartitionFyshe(id: UUID(), ajoutéPar: "", titre: "", auteur: "", année: 0, instruments: [], imageParti: PDFDocument(), lstCommentaire: [])
    @State private var temptitre: String = ""
    @State private var tempauteur: String = ""
    @State private var tempannéestring: String = ""
    @State private var tempinstruments: [Instruments] = []
    @State private var tempinstrumentselect: Instruments = .none
    @State private var tempinstrumentselect2: Instruments = .none
    @State private var tempimage: PDFDocument = PDFDocument()
    
    @State private var alerte: Bool = false
    @State private var aled: Bool = false
    @State private var droits: Bool = false
    @State private var importing = false
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [saffron, sandyBrown], startPoint: .top, endPoint: .bottom)//.ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                Text("Ajouter une partition à la bibliothèque...")
                    .font(.title)
                    .bold()
                    .padding()
                Spacer()
                
                Button(action: {
                    importing = true
                    print("nik")
                }, label: {
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .foregroundStyle(.white)
                        .overlay {
                            Text("+  Sélectionner une partition en format .pdf")
                                .font(.subheadline)
                                .padding()
                        }
                        .frame(height: 50)
                        .padding(.horizontal)
                }).fileImporter(
                    isPresented: $importing,
                    allowedContentTypes: [.pdf]
                ) { result in
                    switch result {
                    case .success(let file):
                        print(file.absoluteString)
                        print("uwu")
                        tempfyshe.imageParti = PDFDocument(url: file) ?? PDFDocument()
//                        tempimage = PDFDocument(file.absoluteString) ?? PDFDocument()
                    case .failure(let error):
                        print(error.localizedDescription)
                        print(":)")
                    }
                }.padding(.bottom, 77)
                    .onSubmit {
                        droits = true
                    }
                
                
                
                
                
                Spacer()
//                reference moi cette partoche, moussaillon
                HStack {
                    VStack(alignment: .leading) {
                    Text("Réferencez la partition:")
                    Text("*Champs obligatoires")
                            .font(.caption2).foregroundStyle(.black)
                        
                    }
                    Spacer()
                    
                    Button {
                        aled = true
                    } label: {
                        VStack(alignment:.trailing) {
                            Image(systemName: "questionmark.circle")
                            Text("Aide")
                                .font(.caption2)
                        }
                    }.alert("Le titre et le compositeur se trouvent en haut de la partition.\rLes noms des instruments sont écrits à gauche des clés, en début de partition.", isPresented: $aled) {
                        Button("OK") { }
                    }
                }.padding(.horizontal)
                
                
                List {
                    TextField("Titre*", text: $temptitre)
                        .font(.subheadline)
                        .onSubmit {
                            if temptitre != "" {
                                tempfyshe.titre = temptitre
                                print(tempfyshe.titre)
                            }
                        }
                    TextField("Compositeur*", text: $tempauteur)
                        .font(.subheadline)
                        .onSubmit {
                            if tempauteur != "" {
                                tempfyshe.auteur = tempauteur
                                print(tempfyshe.auteur)
                            }
                        }
                    
                    TextField("Année", text: $tempannéestring)
                        .font(.subheadline)
                        .onSubmit {
                            if tempannéestring != "" {
                                tempfyshe.année = Int(tempannéestring) ?? curYear
                                print("year en string = \(tempannéestring)")
                                print("year en int = \(tempfyshe.année)")
                            }
                        }

                    
                    
                    Picker("*Ajouter un instrument...", selection: $tempinstrumentselect) {
                        ForEach(Instruments.allCases.sorted(by: {$0.rawValue > $1.rawValue}), id: \.self) { i in
                                Button(i.rawValue){
                                    print("pressed")
                                    tempfyshe.instruments.insert(i)
                                    print(tempfyshe.instruments.count)
                                }
                            }
                        }.onChange(of: tempinstrumentselect, { _, newValue in
                            if tempinstrumentselect != .none {
                                tempfyshe.instruments.insert(newValue)
                            }
                        }).padding(.top)
                    
                    //ici c la liste des instrus selectionnés. mostly un copié collé de l'ecran monprofil
                    ForEach(tempfyshe.instruments.shuffled(), id: \.self) { inst in
                        Button{
                            tempfyshe.instruments.remove(inst)
                        }label:{
                            Text(inst.rawValue)
                        }
                    }
                    
//                    Picker("Supprimer un instrument...", selection: $tempinstrumentselect2) {
//                        ForEach(tempfyshe.instruments.sorted(by: {$0.rawValue > $1.rawValue}), id: \.self) { i in
//                            Button(i.rawValue){
//                                print("pressed")
//                                tempfyshe.instruments.remove(i)
//                                print(tempfyshe.instruments.count)
//                            }
//                        }
//                    }.foregroundStyle(.red).onChange(of: tempinstrumentselect2, { _, newValue in
//                        if tempinstrumentselect2 != .none {
//                            tempfyshe.instruments.remove(newValue)
//                        }
//                    }).padding(.top)
            
                    
                }.scrollContentBackground(.hidden)
                    
                
                Button("Valider") {
                    print("pressed")
                    print(tempfyshe.titre)
                    print(tempfyshe.auteur)
                    print(tempfyshe.instruments)
                    tempfyshe.titre = temptitre
                    tempfyshe.auteur = tempauteur
                    //tempfyshe.année = Int(tempannéestring) ?? curYear
                    if !temptitre.isEmpty && !tempauteur.isEmpty && tempfyshe.imageParti.pageCount != 0 && !tempfyshe.instruments.isEmpty && Int(tempannéestring) != nil{
                        if bdd.filter({ pa in
                            pa.auteur == tempfyshe.auteur && pa.titre == tempfyshe.titre
                        }).isEmpty{
                            droits = true
                            tempfyshe.ajoutéPar = prof.mail
                            print("oui :)")
                            
                        }else{
                            alerte = true
                        }
                        
                    } else {
                        alerte = true
                        print("non et j'appelle l'alerte")
                    }
                        
                       
                }
                .padding()
                .background(.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.black)
                .alert("Assurez vous que la partition soit bien libre de droits !\r Pour plus d'informations sur les droits d'auteur en Europe:", isPresented: $droits) {
                    Button("Plus d'infos") {openURL(URL(string: "https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000006278937")!)}
                    
                    Button("OK") {
                        let newpart: PartitionFyshe = tempfyshe
                        //                        newpart.ajoutéPar = profillocal.mail
                        //                        newpart.imageParti = tempimage
                        bdd.append(newpart)
                        tempfyshe = PartitionFyshe(id: UUID(), ajoutéPar: "", titre: "", auteur: "", année: curYear, instruments: [], imageParti: PDFDocument(), lstCommentaire: [])
                        temptitre = ""
                        tempauteur = ""
                        tempannéestring = ""
                    }
                }
                
                .alert("Veuillez renseigner au moins un titre, un nom de compositeur, et les instruments de la partition", isPresented: $alerte) {Button("OK") {}}
                .padding()
            }.padding()
            
        }//fin du zstack avec le fond gradient + le reste par dessus
    }
}

//#Preview {
//    Ecran_ajout()
//}
