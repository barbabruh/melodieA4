//
//  Partition.swift
//  musique
//
//  Created by Apprenant61 on 06/03/2024.
//

import SwiftUI
import AVKit
import PDFKit

struct BaseDeDonnee{
    var biblio: Set<PartitionFyshe>
}

/*
struct Profile {
    var pseudo: String
    var avatarPic: String
    var mail: String
    var instruJoué: Set<Instruments>
    var partiSaved: Set<UUID>
    //var partiContrib: Set<PartitionFyshe>
}

enum Instruments: String, CaseIterable{
    case piano = "Piano",
    guitare = "Guitare",
    violon = "Violon",
    basse = "Basse",
    clarinette = "Clarinette",
    none = "Ajouter un instrument"
    
}

/*
enum Genres: String, CaseIterable{
    case rock = "Rock", pop = "Pop",
         classique = "Classique", metal = "Metal"
}
*/

struct PartitionFyshe: Hashable, Identifiable{
    var pdf: PDFDocument
    var id = UUID()
    var ajoutéPar: String //mail du profil
    var titre: String
    var auteur: String
    var année: Int
    //var genre: String
    //var albumImg: String
    var instruments: Set<Instruments>
    var imageParti: String // ou Image
    var lstCommentaire: [Commentary]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(titre + auteur)
    }
    
}


//commence ici
struct Commentary: Hashable, Identifiable{
    var id = UUID()
    var photo: String
    var phoText: String
    var comm: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(phoText)
    }
}
*/

struct Partition: View {
    
    //couleurs du fond
    let saffron = Color(red: 0.9137254901960784, green: 0.7686274509803922, blue: 0.41568627450980394)
    
    let sandyBrown = Color(red: 0.9568627450980393, green: 0.6352941176470588, blue: 0.3803921568627451)
    
    //couleur pour bouton
    let lightGray = Color(red: 0.8509803921568627, green: 0.8509803921568627, blue: 0.8509803921568627)
    
    
//    var compositeur = "compositeur"
//    var year = "année"
    
    var instruments = Instruments.allCases
    //,"guitare","clarinette"
    
    
    /*
     !!!!!!
     
     bdd =============++++++========= navigation
     
     !!!!!!!
     */
    @Binding var parti: PartitionFyshe
    
//    @Binding var bdd: Set<PartitionFyshe>
    
    @Binding var prof: Profile
    
//    var bdd = [PartitionFyshe( ajoutéPar: "porké", titre: "Jypep", auteur: "idkbro", année: 2012, instruments: [.basse,.guitare], imageParti: PDFDocument(), lstCommentaire: []), PartitionFyshe( ajoutéPar: "porké", titre: "Jpp", auteur: "idkbro", année: 2014, instruments: [.clarinette,.guitare], imageParti: PDFDocument(), lstCommentaire: []), PartitionFyshe( ajoutéPar: "porké", titre: "Aled", auteur: "Maped", année: 1, instruments: [.basse,.violon], imageParti: PDFDocument(), lstCommentaire: [])]
    
    //profile osef avec 3 partoche enregistrées
    
    /*
     !!!!!!!!
     
     parti =============== navigation
     
     !!!!!!!!
     */
    /*@State private var parti = PartitionFyshe( ajoutéPar: "porké", titre: "Jypep", auteur: "idkbro", année: 2012, instruments: [.basse,.guitare], imageParti: PDFDocument(), lstCommentaire: [])*/
    
     //j'essaie de mettre les commentaires dans une structure
     
    @State private var comment = ""
    
    //var img = Image("Ang")
    
    //@State private var id = 0
    
    //@State private var lstComm: [Commentary] = []
    
    /*
     [Commentary(id: 0,photo: "Ang", phoText: "John Appleseed", comm: "aaaaaaasdwfghjklfefccehfbehbfebfcedkjhceg brfiedc gecch fgrehdjc efgejd ge ghj deg cefede"), Commentary(id: 1,photo: "Ang", phoText: "John Appleseed", comm: "second one")]
     */
    
    
    func ajoutComm(photo: Image?, textPho: String, commentaire: String){
        parti.lstCommentaire.append(Commentary( photo: photo, phoText: textPho, comm: commentaire))
        //id += 1
    }
    
    
    
    
    
    
    var body: some View {
        /*
         prof ============= navigation
         */
        
//        var prof = Profile(pseudo: "Janoskour",  mail: "aupif@orange.fr", instruJoué: [.guitare,.piano,.violon], partiSaved: [bdd[0].id])
        
        ZStack{
            //fond d'écran
            LinearGradient(colors: [saffron, sandyBrown], startPoint: .top, endPoint: .bottom)
            
            
            VStack{
                //"Est-ce que tu aimes le bip?"
                Text(parti.titre)
                    .padding(.top)
                    .padding(.horizontal)
                    .font(.title2)
                    .bold()
                
                //"Beyonce"
                Text(parti.auteur)
                    .font(.title3)
                    .bold()
                    .italic()
                    .padding(.horizontal)
                
                
                /*
                 à changer parce que le design de ce Hstack est caca
                 */
                HStack{
                    
                    
                    //Spacer()
                    
                    //"parti"
                    PDFKitView(page: 0, pdfDocument: parti.imageParti)
                        //.resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding(.top)
                        
                }.padding(.horizontal, 75)
                
                HStack{
                    ScrollView{
                        ForEach(parti.instruments.sorted(by: { i, j in
                            i.rawValue < j.rawValue
                        }), id: \.self){
                            inst in
                            if inst != .none{
                                Text(inst.rawValue)
                                    .font(.callout)
                            }
                        }
                    }.frame(width: 120, height: 35)
                        .padding(.trailing)
                    
                    NavigationLink(destination: PDFUIView(doc: parti.imageParti), label: {
                        VStack{
                            Image(systemName: "arrow.up.doc.fill")
                                .resizable()
                                .frame(width: 30, height: 35)
                                .foregroundStyle(.black)
                                .padding(.bottom, 5)
                            
                            Text("Ouvrir")
                                .font(.footnote)
                                .foregroundStyle(.black)
                                .bold()
                        }
                    })
                    .padding(.horizontal)
                    
                    Button(action: {
                        if !prof.partiSaved.contains(parti.id){
                            prof.partiSaved.append(parti.id)
                        }
                    }, label: {
                        VStack{
                            Image(systemName: "square.and.arrow.down.fill")
                                .resizable()
                                .frame(width: 30, height: 35)
                                .foregroundStyle(.black)
                                .padding(.bottom, 2)
                            
                            //mettre les partiSaved en Set<String>
                            /*
                            if prof.partiSaved.contains( parti.titre + "-\r" + parti.auteur){
                                Text("déjà sauvegardé")
                                 .font(.footnote)
                                 .frame(width: 120)
                                 .foregroundStyle(.black)
                                 .bold()
                            }
                             */
                            Text("Sauvegarder")
                                .font(.footnote)
                                .frame(width: 100)
                                .foregroundStyle(.black)
                                .bold()
                        }
                    })
                    
//                    Button(action: {
//                        /*
//                         faire action du bouton extrait
//                         ?-_-?
//                         */
//                    }, label: {
//                        Image(systemName: "play.fill")
//                            .foregroundStyle(.black)
//                        Text("Extrait")
//                            .foregroundStyle(.black)
//                    }).padding(10)
//                        .background(lightGray)
//                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
//                        .padding(.top)
                    
                }
                
                /*
                HStack{
                    Image("parti")
                        .padding(.top)
                    
                    VStack(alignment: .leading){
                        Text("Nom de la partition")
                            .font(.title2)
                            .bold()
                            .frame(width: 150, height: 75)
                            
                        
                        Text("\(compositeur),  \(year)")
                            .font(.footnote)
                            .padding(.bottom)
                        
                        /*
                         voir si on garde le scrollview ou non, je pense que oui c joli
                         */
                        ScrollView{
                            ForEach(instruments, id: \.self){
                                inst in Text(inst).font(.footnote)
                            }
                        }.frame(height: 65)
                        
                        Button(action: {
                            /*
                             faire action du bouton extrait
                             ?-_-?
                             */
                        }, label: {
                            Image(systemName: "play.fill")
                                .foregroundStyle(.black)
                            Text("Extrait")
                                .foregroundStyle(.black)
                        }).padding(10)
                            .background(lightGray)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                            .padding(.top)
                        
                    }
                }
                
                HStack{
                    
                    Text("Potentiellement le nom de l'individu<3")
                        .font(.footnote)
                        .frame(width: 150)
                        .padding(.leading, 45)
                    
                    Spacer()
                    
                    //bouton download
                    Button {
                        //faire le téléchargement
                    } label: {
                        Image(systemName: "square.and.arrow.down.fill")
                            .resizable()
                            .frame(width: 30, height: 35)
                            .foregroundStyle(.black)
                    }
                    
                    
                    /*
                     
                     
                     à enlever? commentaire déjà en bas
                     !!!!!!!!!!!!!!!!!!!!!!!!!
                     !!!!!!!!!!!!!!!!!!!!!!!!!
                     
                     
                     */
                    Button(action: {
                        //ouvrir la saisie de texte pour laisser un commentaire
                    }, label: {
                        Image(systemName: "bubble.left.and.text.bubble.right.fill")
                            .resizable()
                            .frame(width: 40, height: 35)
                            .foregroundStyle(.black)
                            .padding(.horizontal)

                    })

                }*/
                
                /*
                 La séparation :D
                 */
                Image("planche")
                    .resizable()
                    .scaledToFit()
                
                /*
                 on entre dans la partie commentaire
                 */
                HStack{
                    /*
                     c le titre
                     */
                    Text("Commentaire")
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    Spacer()
                }
                /*
                 les commentaires que l'ont peux scroll
                 */
                ScrollView {
                    
                    ForEach(parti.lstCommentaire, id: \.self){
                        comm in
                        HStack{
                            
                            VStack(alignment: .center){
                                /*
                                 photo + nom
                                 */
                                if prof.avatarPic != nil {
                                    prof.avatarPic?
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 60,height: 60)
                                } else {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                }
                                
                                Text(comm.phoText)
                                    .font(.footnote)
                                    .frame(width: 75, alignment: .center)
                                    .padding(.bottom)
                                    
                            }
                            
                            Text(comm.comm)
                                .font(.footnote)
                                .background(.white)
                                .frame(alignment: .top)
                                .padding(.bottom)
                            
                            Spacer()
                        }.padding(.horizontal)
                    }
                    /*
                    HStack{
                        
                        VStack(alignment: .center){
                            /*
                             photo + nom
                             */
                            Image("Ang")
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            
                            Text("John Appleseed")
                                .font(.footnote)
                                .frame(width: 75, alignment: .center)
                            
                        }
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, ")
                            .font(.footnote)
                            .background(.white)
                            .frame(alignment: .top)
                        
                        Spacer()
                    }.padding(.horizontal)
                    
                    
                    HStack{
                        
                        VStack(alignment: .center){
                            /*
                             photo + nom
                             */
                            Image("Ang")
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            
                            Text("John Appleseed")
                                .font(.footnote)
                                .frame(width: 75, alignment: .center)
                            
                        }
                        
                        Text("Yes lorem ipsum commentaire court :)")
                            .font(.footnote)
                            .background(.white)
                        
                        Spacer()
                    }.padding(.horizontal)
                     */
                }
                
                //entrer du texte (mettre dans la liste?)
                TextField("Commentaire...", text: $comment)
                    .padding(.horizontal)
                    .frame(width: 300,height: 40)
                    .background(lightGray)
                    .clipShape(RoundedRectangle(cornerRadius: 50.0))
                    .onSubmit {
                        ajoutComm(photo: prof.avatarPic, textPho: prof.pseudo, commentaire: comment)
                        
                        comment = ""
                    }
                Spacer()
            }
            
        }
    }
}

//#Preview {
//    Partition()
//}
