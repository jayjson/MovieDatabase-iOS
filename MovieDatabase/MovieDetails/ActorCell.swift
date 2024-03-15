//
//  ActorCell.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-14.
//

import Kingfisher
import SwiftUI

struct ActorCell: View {
    let castMember: CastMember
    let tapHandler: () -> Void
    
    var body: some View {
        VStack {
            profileImageView
            nameLabel
            Spacer()
        }
        .frame(width: Constant.width)
        .onTapGesture(perform: tapHandler)
    }
        
    private var profileImageView: some View {
        ZStack {
            KFImage(castMember.profileImageUrl)
                .cacheOriginalImage()
                .cancelOnDisappear(true)
                .onFailureImage(fallbackImage)
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                .clipShape(Circle())
        }
        .frame(width: Constant.width, height: Constant.profileImageHeight)
    }
    
    private var fallbackImage: UIImage? {
        guard let image = UIImage(systemName: "person", withConfiguration: UIImage.SymbolConfiguration(pointSize: Constant.fallbackIconHeight, weight: .light)) else { return nil }
        return image.imageWithInsets(insets: .init(top: 40, left: 40, bottom: 40, right: 40))
    }

    private var nameLabel: some View {
        Text(castMember.name)
            .font(.caption)
            .lineLimit(2)
            .multilineTextAlignment(.center)
    }
    
    enum Constant {
        static let width: CGFloat = 90
        static let profileImageHeight: CGFloat = width
        static let fallbackIconHeight: CGFloat = 32
    }
}

//#Preview {
//    ActorCell()
//}
