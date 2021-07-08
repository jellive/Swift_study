//
//  FCLuppyView.swift
//  SwiftStudy
//
//  Created by yoohg on 2021/07/08.
//  Copyright © 2021 Jell PD. All rights reserved.
//

import SwiftUI

struct FCLuffyView: View {
    @State var price = 100000
    
    var body: some View {
        if #available(iOS 14.0, *) {
        
            VStack {
                Spacer()
                Text("Wanted").font(.system(size: 50))
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("₩\(price)").font(.system(size: 50))
                Spacer()
                Button(action: {
                    self.price = 2000000
                }, label: {
                    Text("reload")
                })
                
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct FCLuffyView_Previews: PreviewProvider {
    static var previews: some View {
        FCLuffyView()
    }
}
