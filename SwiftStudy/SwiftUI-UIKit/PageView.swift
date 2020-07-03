//
//  PageView.swift
//  SwiftStudy
//
//  Created by YooHG on 7/3/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    
    init(views: [Page]) {
        self.viewControllers = views.map{ UIHostingController(rootView: $0) }
    }
    
    var body: some View {
//        VStack {
//            PageViewController(controllers: viewControllers, currentPage: $currentPage)
//            Text("Current page: \(currentPage)")
//        }
        ZStack(alignment: .bottomTrailing) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(views: features.map {FeatureCard(landmark: $0)})
            .aspectRatio(3/2, contentMode: .fit)
    }
}
