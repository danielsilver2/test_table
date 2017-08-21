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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Album \(section)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        for album in albuns {
            if album.value.albumId == section + 1 {
                rows += 1
            }
        }
        return rows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexRow = indexPath.row + 1
        return AlbumCell(identifier: "reuseIdentifier", table: self, album: albuns[indexRow]!)
    }
}
