import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {

    func downloaded(
        from path: String?,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        queue: DispatchQueue = DispatchQueue.main,
        completion: Action<Bool>? = nil
    ) {
        guard let path = path else {
            completion?(false)
            return
        }
        self.contentMode = contentMode
        if let cachedImage = imageCache.object(forKey: path as NSString) {
            image = cachedImage
            completion?(true)
        } else {

            API.request(path: path, isImage: true).response { result in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        completion?(false)
                        return
                    }
                    queue.async {
                        imageCache.setObject(image, forKey: path as NSString)
                        self.image = image
                        completion?(true)
                    }
                case .failure:
                    completion?(false)
                }
            }
        }
    }
}
