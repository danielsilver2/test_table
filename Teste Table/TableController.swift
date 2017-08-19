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
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let cell = AlbumCell(identifier: "reuseIdentifier", tableView: view)

        return cell
    }
}

class AlbumCell: UITableViewCell {
    init(identifier id: String, tableView: UIView) {
        super.init(style: .default, reuseIdentifier: id)
        
        setView(tableView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView(_ superView: UIView) {
        self.contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        self.contentView.backgroundColor = .red
    }
}
