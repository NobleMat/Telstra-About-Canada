import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {

    /// Download the image using the path given and apply it to the imageView, Then cache a copy of the image locally.
    ///
    /// - Parameters:
    ///   - path: The link to the image
    ///   - contentMode: The content mode of the imageView, defaults to ScaleAspectFit
    ///   - queue: The queue used to set the image, defaults to the main Queue
    ///   - completion: A completion block that specifies if the image was downloaded successfully
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

            DispatchQueue.global(qos: .utility).async {

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
}
