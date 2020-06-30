//
//  SwiftUITutorialView.swift
//  SwiftStudy
//
//  Created by YooHG on 6/30/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI

struct SwiftUITutorialView: View {
    var body: some View {
        VStack {
            MapView(coordinate: landmarkData[0].locationCoordinate)
                .frame(height: 300)
            
            CircleImage(image: landmarkData[0].image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("Turtle Rock")
                    .font(.title)
//                    .foregroundColor(Color.green)
                HStack(alignment: .top) {
                    Text("Joshua Tree National Park")
                        .font(.subheadline)
                    Spacer()
                    Text("California")
                        .font(.subheadline)
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct SwiftUITutorialView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITutorialView()
    }
}
