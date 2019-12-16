//
//  UpdateDetail.swift
//  Coursera
//
//  Created by Saksham Ram Khatod on 26/08/19.
//  Copyright © 2019 Saksham Ram Khatod. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    var title = "Swift UI"
    var text = "Loading..."
    var image = "Illustration1"
    
    
    var body: some View {
        VStack(spacing: 20.0) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
            Text(text)
                .lineLimit(nil)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding(30.0)
        
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
