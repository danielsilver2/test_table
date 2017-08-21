import Foundation
import UIKit

class ModalView: UIViewController, UIGestureRecognizerDelegate {
    var image: UIImage

    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
        
        setImageToScreen()
        modalPresentationStyle = .overFullScreen
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setImageToScreen() {
        let imageView = UIImageView(frame: .zero)
        
        view.addSubview(imageView)
        
        imageView.image = image
        
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0,bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeModal(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }

    func closeModal(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
