//
//  ecran aterissage.swift
//  ecrans faits par tib
//
//  Created by Apprenant75 on 06/03/2024.
//

import Foundation
import SwiftUI
import PhotosUI


struct ecranProfil: View {
    //couleurs<3
    let saffron: Color = Color(red: 0.9137254901960784, green: 0.7686274509803922, blue: 0.41568627450980394)
    let sandyBrown: Color = Color(red: 0.9568627450980393, green: 0.6352941176470588, blue: 0.3803921568627451)
    let cream: Color = Color(red: 1, green: 1, blue: 1, opacity: 0.85)
    let fontcouleur: Color = Color(red:0,green:0,blue:0,opacity:0.85)
    
    /*
    struct Profile {
        var pseudo: String
        var avatarPic: Image?
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
        var imageParti: String // ou Image
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
    }
    
    //ici sont les instrus
    enum Instruments: String, CaseIterable{
        case none = "Ajouter un instrument...",
             piano = "Piano",
             guitare = "Guitare",
             violon = "Violon",
             basse = "Basse",
             clarinette = "Clarinette"
    }*/
    
    //MON PROFIL
    @Binding var profillocal: Profile

    //variable temporaire pour la saisie de mon pseudo
    @State private var pseudotemp = ""
    
    @State private var testoto = "" //el clasico le best
    
    //variables pour la saisie de mes instrus
    @State private var selectedintsru:Instruments = .none
    @State private var selectedinstrutemp:Instruments = .none
    
    @State private var importpfp: Bool = false
    @State private var pfpitem: PhotosPickerItem?
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [saffron, sandyBrown], startPoint: .top, endPoint: .bottom)
            
            VStack/*(alignment:.leading)*/ {
                
                Text("Votre profil")
                    .bold()
                    .font(.title)
                    .padding(.top, 20)
                    .padding(.bottom,20)
                    .padding(.horizontal,100)
                
                //affichage et modification de pseudo
                HStack {
                    
                    VStack(alignment:.center) {
                        HStack {

                            if profillocal.pseudo == "" {
                                Text("Invité").font(.title2).bold().padding(.horizontal)
                            } else {
                                Text(profillocal.pseudo).font(.title3).bold().padding(.horizontal)
                            }
                            Spacer()
                            if profillocal.avatarPic != nil {
                                profillocal.avatarPic?
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 120)
                                    .padding(.trailing, 20)
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 111)
                                    .padding(.trailing, 30)
                            }

                        }
                        HStack {
                            TextField("Modifier mon pseudo", text: $pseudotemp)
                                .font(.subheadline)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onSubmit {
                                    if pseudotemp != "" {
                                        profillocal.pseudo = pseudotemp
                                        pseudotemp = ""
                                    }
                                }
                            PhotosPicker("Modifier ma photo", selection: $pfpitem, matching: .images)
                                .padding()
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .background(.white).frame(height: 33).clipShape(RoundedRectangle(cornerRadius: 5))
                                .padding(.trailing)
                                .onChange(of: pfpitem) {
                                    Task {
                                        if let loaded = try? await pfpitem?.loadTransferable(type: Image.self) {
                                            profillocal.avatarPic = loaded
                                        } else {
                                            print("Failed")
                                        }
                                    }
                                }
                            }
                        }
                }.padding(.leading)
                
                
                //ici finit l'introduction mdr
                HStack {
                    Text("Vos instruments:").bold().padding(.leading).padding(.top, 30)
                    Spacer()
                }
                List {
                    ForEach(profillocal.instruJoué.sorted(by: {$0.rawValue > $1.rawValue}), id: \.self) { inst in
                        Text(inst.rawValue)
                    }.padding(.horizontal)
                        .frame(width: 200)
                }.scrollContentBackground(.hidden)
                    .padding(.horizontal)
                
                List {
                    //add
                    Picker("\(Instruments.none.rawValue)", selection: $selectedintsru) {
                        ForEach(Instruments.allCases.sorted(by: {$0.rawValue > $1.rawValue}), id: \.self) { i in
                                Button(i.rawValue){
                                    print("pressed")
                                    profillocal.instruJoué.insert(i)
                                    print(profillocal.instruJoué.count)
                                }
                            }
                        }.onChange(of: selectedintsru, { _, newValue in
                            if selectedintsru != .none {
                                profillocal.instruJoué.insert(newValue)
                            }
                        })
                    
                        //suppr
                    Picker("Supprimer un instrument...", selection: $selectedinstrutemp) {
                        ForEach(profillocal.instruJoué.sorted(by: {$0.rawValue > $1.rawValue}), id: \.self) { i in
                                Button(i.rawValue){
                                    profillocal.instruJoué.remove(i)
                                    print("skrgsrh")
                                }
                            }
                        }.foregroundStyle(.red).onChange(of: selectedinstrutemp, { _, newValue in
                            if selectedinstrutemp != .none {
                                profillocal.instruJoué.remove(newValue)
                            }
                        })
                }.scrollContentBackground(.hidden)
                .padding(.horizontal)
                .padding(.bottom)
                Spacer()
                
                
                
            }
        }
    }
}
//
//#Preview {
//    ecranProfil()
//}
