import Foundation
import UIKit

class AlbumCell: UITableViewCell {
    
    var content: Album
    var table: UITableViewController
    
    init(identifier id: String, table: UITableViewController, album: Album) {
        self.content = album
        self.table = table
        super.init(style: .default, reuseIdentifier: id)
        
        setView(table.view)
        setTap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showContentImage(_:)))
        tap.delegate = self
        contentView.addGestureRecognizer(tap)
    }
    
    private func setView(_ superView: UIView) {
        self.contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        
        URLUtils.getDataFromUrl(url: self.content.thumbnailUrl) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                let imageView = UIImageView(frame: .zero)
                let label = UILabel()
                
                self.contentView.addSubview(label)
                self.contentView.addSubview(imageView)
                
                imageView.anchor(self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 0, widthConstant: 50, heightConstant: 0)
                
                label.anchor(self.contentView.topAnchor, left: imageView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, topConstant: 0, leftConstant: 50 + 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                
                label.text = self.content.title
                
                let image = UIImage(data: data)
                imageView.image = image
            }
        }
    }
    
    public func showContentImage(_ sender: UITapGestureRecognizer) {
        URLUtils.getDataFromUrl(url: content.url, completion: { (data, response, error) in
            DispatchQueue.main.async() { () -> Void in
                if (error != nil) {
                    print("Error while getting your image")
                    return
                }
                
                let modal = ModalView(image: UIImage(data: data!)!)
                self.table.present(modal, animated: true, completion: nil)
            }
        })
    }
}
