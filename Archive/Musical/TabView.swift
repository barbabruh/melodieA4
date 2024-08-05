//
//  TabView.swift
//  Musical
//
//  Created by Apprenant61 on 18/03/2024.
//

import SwiftUI
import PDFKit

struct Profile {
    var pseudo: String
    var avatarPic: Image?
    var mail: String
    var instruJoué: Set<Instruments>
    var partiSaved: [UUID]
}

enum Styles: String, CaseIterable {
    case none = "Selectionner un style...",
    classique = "Classique",
    jazz = "Jazz",
    blues = "Blues",
    pop = "Pop",
    rock = "Rock"
}


struct PartitionFyshe: Hashable, Identifiable {
    var id = UUID()
    var ajoutéPar: String //mail du profil
    var titre: String
    var auteur: String
    var année: Int
    var instruments: Set<Instruments>
    var imageParti: PDFDocument
    var lstCommentaire: [Commentary]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(titre + auteur)
    }
}

struct Commentary: Hashable, Identifiable {
    var id = UUID()
    var photo: Image?
    var phoText: String
    var comm: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(phoText)
    }
}

//ici sont les instrus
enum Instruments: String, CaseIterable{
    case piano = "Piano",
    guitare = "Guitare",
    basse = "Basse",
    violon = "Violon",
    alto = "Alto",
    violoncelle = "Violoncelle",
    clarinette = "Clarinette",
    none = "Ajouter un instrument"
}

func loadPdf(_ txt: String) -> PDFDocument{
    print("coucou")
    print(Bundle.main.bundlePath)
    guard let url = Bundle.main.url(forResource: txt, withExtension: "pdf")else{
        print("no valid url")
        return PDFDocument()
    }
    //Image()
    guard let doc = PDFDocument(url: url)else {
        print("nope")
        return PDFDocument()
        
    }
        print("yay")
        return doc
}

func loadingDoc(pathe: String) -> PDFDocument{
    guard let path = NSData(contentsOfFile: pathe) else {
        print("Could not find PDF document")
        return PDFDocument()
    }
    do {
        if let theDoc = PDFDocument(data: Data(referencing: path)) {
            return theDoc
        }
    }
    return PDFDocument()
}


//mmmm datums yumby delicious
//bach suites cello
var bwv1007 = PartitionFyshe(ajoutéPar: "taco", titre: "Suite 1 pour violoncelle, BWV 1007", auteur: "Johann Sebastian Bach", année: 1723, instruments: ([.violoncelle]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/bwv1007.imageset/IMSLP70851-PMLP04291-Bach_-_Cello_Suite_No1_in_G_(Becker_Peters).pdf"), lstCommentaire: [])


var bwv1008 = PartitionFyshe(ajoutéPar: "taco", titre: "Suite 2 pour violoncelle, BWV 1008", auteur: "Johann Sebastian Bach", année: 1723, instruments: ([.violoncelle]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/IMSLP01299-BWV1008.imageset/IMSLP01299-BWV1008.pdf"), lstCommentaire: [])

var bwv1009 = PartitionFyshe(ajoutéPar: "taco", titre: "Suite 3 pour violoncelle, BWV 1009", auteur: "Johann Sebastian Bach", année: 1723, instruments: ([.violoncelle]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/IMSLP01300-BWV1009.imageset/IMSLP01300-BWV1009.pdf"), lstCommentaire: [])
//wolfy quartet

var k155 = PartitionFyshe(ajoutéPar: "taco", titre: "Quatuor 2 en ré majeur, K155", auteur: "Wolfgang Amadeus Mozart", année: 1772, instruments: ([.violon, .alto, .violoncelle]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/IMSLP481944-PMLP5209-Mozart,_Wofgang_Amadeus-NMA_08_20_1_1_02_KV_155_scan.imageset/IMSLP481944-PMLP5209-Mozart,_Wofgang_Amadeus-NMA_08_20_1_1_02_KV_155_scan.pdf"), lstCommentaire: [])

var k575 = PartitionFyshe(ajoutéPar: "taco", titre: "Quatuor prussien 1 ré majeur, K575", auteur: "Wolfgang Amadeus Mozart", année: 1772, instruments: ([.violon, .alto, .violoncelle]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/IMSLP64145-PMLP05230-Mozart_Werke_Breitkopf_Serie_14_KV575.imageset/IMSLP64145-PMLP05230-Mozart_Werke_Breitkopf_Serie_14_KV575.pdf"), lstCommentaire: [])

var k589 = PartitionFyshe(ajoutéPar: "tact", titre: "Quatuor prussien 2 en si-bémol majeur, K589", auteur: "Wolfgang Amadeus Mozart", année: 1790, instruments: ([.violon, .alto, .violoncelle]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/IMSLP64148-PMLP05231-Mozart_Werke_Breitkopf_Serie_14_KV589.imageset/IMSLP64148-PMLP05231-Mozart_Werke_Breitkopf_Serie_14_KV589.pdf"), lstCommentaire: [])

var k590 = PartitionFyshe(ajoutéPar: "taco", titre: "Quatuor prussien 3 en fa majeur", auteur: "Wolfgang Amadeus Mozart", année: 1790, instruments: ([.violon, .alto, .violoncelle]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/IMSLP64149-PMLP05232-Mozart_Werke_Breitkopf_Serie_14_KV590.imageset/IMSLP64149-PMLP05232-Mozart_Werke_Breitkopf_Serie_14_KV590.pdf"), lstCommentaire: [])
//schub le sang

var schubtrio = PartitionFyshe(ajoutéPar: "taco", titre: "Trio 2 en mi-bémol majeur, opus 100", auteur: "Franz Schubert", année: 1828, instruments: ([.piano, .violon, .violoncelle]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/imslp schubert trio.imageset/imslp schubert trio.pdf"), lstCommentaire: [])

//MAURICE<3
var tombeau = PartitionFyshe(ajoutéPar: "taco", titre: "Le Tombeau de Couperin", auteur: "Maurice Ravel", année: 1917, instruments: ([.piano]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/IMSLP46605-PMLP04975-Ravel_Le_tombeau_de_couperin_Durand_9569_reissue.imageset/IMSLP46605-PMLP04975-Ravel_Le_tombeau_de_couperin_Durand_9569_reissue.pdf"), lstCommentaire: [])

var ravel4 = PartitionFyshe(ajoutéPar: "taco", titre: "Quatuor en fa", auteur: "Maurice Ravel", année: 1903, instruments: ([.violon, .alto, .violoncelle]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/iR4Nez-IMSLP01617-Ravel_-_String_Quartet_(Score).imageset/iR4Nez-IMSLP01617-Ravel_-_String_Quartet_(Score).pdf"), lstCommentaire: [])

//beethov

var op13 = PartitionFyshe(ajoutéPar: "taco", titre: "Sonate 8 pour piano, opus 13", auteur: "Ludwig Van Beethoven", année: 1799, instruments: ([.piano]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/IMSLP243128-PMLP01410-Beethoven,_Ludwig_van-Werke_Breitkopf_Kalmus_Band_20_B131_Op_13_scan.imageset/IMSLP243128-PMLP01410-Beethoven,_Ludwig_van-Werke_Breitkopf_Kalmus_Band_20_B131_Op_13_scan.pdf"), lstCommentaire: [])

var op14p1 = PartitionFyshe(ajoutéPar: "taco", titre: "Sonate 9 pour piano, opus 14", auteur: "Ludwig Van Beethoven", année: 1799, instruments: ([.piano]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/IMSLP243295-PMLP01411-Beethoven,_Ludwig_van-Werke_Breitkopf_Kalmus_Band_20_B132_Op_14_No_1_scan.imageset/IMSLP243295-PMLP01411-Beethoven,_Ludwig_van-Werke_Breitkopf_Kalmus_Band_20_B132_Op_14_No_1_scan.pdf"), lstCommentaire: [])

var op14p2 = PartitionFyshe(ajoutéPar: "taco", titre: "Sonate 10 pour piano, opus 14", auteur: "Ludwig Van Beethoven", année: 1799, instruments: ([.piano]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/IMSLP243296-PMLP01412-Beethoven,_Ludwig_van-Werke_Breitkopf_Kalmus_Band_20_B133_Op_14_No_2_scan.imageset/IMSLP243296-PMLP01412-Beethoven,_Ludwig_van-Werke_Breitkopf_Kalmus_Band_20_B133_Op_14_No_2_scan.pdf"), lstCommentaire: [])

var op22 = PartitionFyshe(ajoutéPar: "taco", titre: "Sonate 11 pour piano, opus 22", auteur: "Ludwig Van Beethoven", année: 1802, instruments: ([.piano]), imageParti: loadingDoc(pathe: "/Users/apprenant75/Downloads/Archive/Musical/Assets.xcassets/IMSLP243297-PMLP01425-Beethoven,_Ludwig_van-Werke_Breitkopf_Kalmus_Band_20_B134_Op_22_scan.imageset/IMSLP243297-PMLP01425-Beethoven,_Ludwig_van-Werke_Breitkopf_Kalmus_Band_20_B134_Op_22_scan.pdf"), lstCommentaire: [])



struct RootNavigation: View {
    
//   @State private var baseDeDonnée: Array<PartitionFyshe> = [bwv1007,bwv1008,bwv1009,k155,k575,k589,k590,schubtrio,tombeau,op13,op22,op14p1,op14p2]
    
//    @State var baseDeDonnée: Array<PartitionFyshe> = [PartitionFyshe(ajoutéPar: "osef@gmail.com", titre: "Dragon", auteur: "lsp", année: 2022, instruments: [.piano], imageParti: "/Users/apprenant61/Downloads/Dragon.pdf", lstCommentaire: []),
//        PartitionFyshe(ajoutéPar: "osef@gmail.com", titre: "pluie", auteur: "je sais encore moins", année: 2012, instruments: [.piano,.clarinette], imageParti: loadingDoc(pathe: "/Users/apprenant61/Downloads/pluie.pdf"), lstCommentaire: [])]
    
    @State var baseDeDonnée = [bwv1007, bwv1008, bwv1009, k155, k575, k589, k590, schubtrio, tombeau, ravel4, op13, op14p1, op14p2, op22]
    
    @State private var prof: Profile = Profile(pseudo: "jypep", mail: "aself@gmail.com", instruJoué: [.basse,.guitare], partiSaved: [])
    
    
    var body: some View {
//        Button("whut?"){
//            print("bruh")
//            print(Bundle.main.bundlePath.isEmpty)
//        }
        TabView{
            Accueil(bibi: $baseDeDonnée, prof: $prof)
                .tabItem { 
                    Label("Rechercher", systemImage: "magnifyingglass.circle")
                }
            Bibliothek(bdd: $baseDeDonnée, prof: $prof)
                .tabItem {
                    Label("Bibliotheque", systemImage: "books.vertical")
                }
            Ecran_ajout(bdd: $baseDeDonnée, prof: prof)
                .tabItem {
                    Label("Contribuer", systemImage: "plus.circle")
                }
            ecranProfil(profillocal: $prof)
                .tabItem {
                    Label("Profil", systemImage: "person.crop.circle")
                }
        }
    }
    
    
    
}

#Preview {
    RootNavigation()
}
