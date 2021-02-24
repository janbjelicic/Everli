//
//  PostCell.swift
//  PostsLoader
//
//  Created by Jan Bjelicic on 24/02/2021.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPublished: UILabel!
    
    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    private var onReuse: () -> Void = {}
    private var post: Post?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        imageViewPhoto.image = nil
        post = nil
    }
    
    func update(with data: Post) {
        post = data
        lblTitle.text = data.title
        lblDescription.text = data.description
        // Could format the display of the date differently but nothing was specified. DateFormatter
        lblPublished.text = data.publishedAt
        loadImage(from: data.imageUrl, identifier: data.identifier)
    }
    
    func reloadImage() {
        guard let imageUrl = post?.imageUrl, let identifier = post?.identifier else { return }
        loadImage(from: imageUrl, identifier: identifier)
    }
    
    func loadImage(from imageUrl: String, identifier: Int) {
        let token = AppManager.shared.imageManager.loadImage(from: imageUrl, id: identifier) { [weak self] result in
            guard let self = self else { return }
            do {
                let image = try result.get()
                // Always change UI on the main thread.
                DispatchQueue.main.async {
                    self.imageViewPhoto.image = image
                }
            } catch {
                // If error, show placeholder image.
                DispatchQueue.main.async {
                    // Would found a better image for a placeholder if more time.
                    self.imageViewPhoto.image = UIImage(named: "Placeholder")
                }
            }
        }
        // Needs to be triggered so that request isn't running for the image that is not showing anymore.
        self.onReuse = {
            if let token = token {
                AppManager.shared.imageManager.cancelImageLoad(token)
            }
        }
    }
    
}
