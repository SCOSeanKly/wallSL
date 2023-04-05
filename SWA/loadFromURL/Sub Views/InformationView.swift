//
//  InformationView.swift
//  loadFromURL
//
//  Created by Sean Kelly on 03/04/2023.
//

import SwiftUI

struct InformationView: View {
    
    var informationText: String
    var informationHeader: String
    var titleColour: String
    var creatorColour: String
    
    var body: some View {
        VStack {
            
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 80, height: 5)
                .foregroundColor(Color(hex: titleColour))
                .padding(.bottom)
                .opacity(0.3)
            
            HStack {
                Text("\(informationHeader)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex: titleColour))
                
                Spacer()
            }
            .padding(.bottom, 5)
            
            HStack {
                Text("\(informationText)")
                    .font(.footnote)
                    .foregroundColor(Color(hex: creatorColour))
                
                Spacer()
            }
        }
    }
}

