//
//  MovieCell.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-14.
//

import Kingfisher
import SwiftUI

struct MovieCell: View {
    let movie: MovieProtocol
    let cellWidth: CGFloat
    let tapHandler: () -> Void

    
    init(movie: MovieProtocol, width: CGFloat? = nil, tapHandler: @escaping () -> Void) {
        self.movie = movie
        self.cellWidth = width ?? Constant.defaultWidth
        self.tapHandler = tapHandler
    }
    
    var body: some View {
        VStack {
            posterImageView
            titleLabel
            Spacer()
        }
        .frame(width: cellWidth)
        .onTapGesture(perform: tapHandler)
    }
    
    private var posterImageView: some View {
        KFImage(movie.posterImageUrl)
            .cacheOriginalImage()
            .cancelOnDisappear(true)
            .onFailureImage(fallbackImage)
            .placeholder {
                ProgressView()
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: cellWidth, height: cellWidth * 1.5)
    }
    
    private var fallbackImage: UIImage? {
        guard let image = UIImage(systemName: "popcorn", withConfiguration: UIImage.SymbolConfiguration(pointSize: Constant.fallbackIconHeight, weight: .light)) else { return nil }
        return image.imageWithInsets(insets: .init(top: 40, left: 40, bottom: 40, right: 40))
    }
    
    private var titleLabel: some View {
        Text(movie.title)
            .font(.caption)
            .lineLimit(3)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    enum Constant {
        static let defaultWidth: CGFloat = 120
        static let fallbackIconHeight: CGFloat = 24
    }
}

#Preview {
    HStack {
        MovieCell(movie: PopularMovie.withPoster, tapHandler: {})
            .padding()
            .previewLayout(.sizeThatFits)

        MovieCell(movie: PopularMovie.withoutPoster, tapHandler: {})
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
