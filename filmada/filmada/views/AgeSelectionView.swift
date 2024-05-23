//
//  AgeSelectionView.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 18/05/24.
//

import Foundation
import SwiftUI

struct AgeSelectionView: View {
    @Binding var searchLanguage: Language
    
    var body: some View {
        VStack{
            
            Text("Selecione o idioma original do filme que você quer assistir")
                .font(.header2)
                .padding([.top, .leading, .trailing], 27.0)
            
            Spacer()
            
            Text("Uma dica: permita-se experimentar o cinema de outras partes do mundo")
                .font(.body1)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 27.0)
            
            Spacer()
            
            Picker("Language", selection: $searchLanguage) {
                ForEach(Language.allCases, id: \.self) { searchLanguage in
                    Text("\(searchLanguage.rawValue)")
                        .tag(searchLanguage as Language?)
                }
            }
            .frame(width: 292, height: 61)
            .background(.altGray)
            .accentColor(.white)
            .cornerRadius(16)
            .padding(.bottom, 110)
        }
        .frame(width: 345, height: 398)
        .background(.boxGray)
        .cornerRadius(16.0)
        .shadow(color: .black, radius: 8, x: 0, y: 4)
        .padding(.top, 12)
    }
}
