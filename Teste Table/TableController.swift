import UIKit

class TableController: UITableViewController {
    private var sections = 0
    private var rows = 0
    private var albuns: [Int: Album]

    init(albuns: [Album]) {
        var albumId: Int? = nil

        var albumList: [Int: Album] = [:]

        for album in albuns {

            self.rows += 1

            if albumId != album.albumId {
                self.sections += 1
            }
            albumId = album.albumId
            
            albumList[album.id] = album
        }
        
        self.albuns = albumList

        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rows
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexRow = indexPath.row + 1
        let cell = AlbumCell(identifier: "reuseIdentifier", tableView: view, album: albuns[indexRow]!)

        return cell
    }
}

class AlbumCell: UITableViewCell {
    
    var content: Album

    init(identifier id: String, tableView: UIView, album: Album) {
        self.content = album
        super.init(style: .default, reuseIdentifier: id)
        
        setView(tableView)
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
                print("Download Finished")
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
        self.
    }
}

protocol AlbumTapDelegate {
    func showContentImage()
}
