//
//  AgeSelectionView.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 18/05/24.
//

import Foundation
import SwiftUI

struct AgeSelectionView: View {
    @Binding var rangeAge: Range?
    
    var body: some View {
        VStack{
            
            Text("Selecione sua faixa de idade")
                .font(.header2)
                .padding([.top, .leading, .trailing], 27.0)
            
            
            Spacer()
            
            Text("Essa informação será importante para que possamos recomendar filmes adequados para você")
                .font(.body1)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 27.0)
            
            Spacer()
            
            Picker("Range", selection: $rangeAge) {
                ForEach(Range.allCases, id: \.self) { range in
                    Text("\(range.rawValue)")
                        .tag(range as Range?)
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
        .padding(.top, 12)
    }
}
