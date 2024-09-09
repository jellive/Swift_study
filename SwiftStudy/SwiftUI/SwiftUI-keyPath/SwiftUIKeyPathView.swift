//
//  SwiftUIKeyPathView.swift
//  SwiftStudy
//
//  Created by Jell PD on 9/9/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import SwiftUI

public struct SwiftUIKeyPathView: View {
    let arr = [1, 2, 3, 4, 5]
    public var body: some View {
        VStack {
            ForEach(arr, id: \.self) { count in
            Text("\(count)")
            }
        }
    }
}

#Preview {
    SwiftUIKeyPathView()
}
