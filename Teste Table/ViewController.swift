import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        URLUtils.requestUrl("http://jsonplaceholder.typicode.com/photos", onFinish: {
            result in
            let table = TableController(albuns: Mapper.mapJsonResponse(result))
            self.present(table, animated: true, completion: nil)
        })
    }
}
