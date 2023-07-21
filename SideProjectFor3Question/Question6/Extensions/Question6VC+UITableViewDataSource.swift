import UIKit

extension Question6ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.setBackgroundColor(.clear)
        var content = cell.defaultContentConfiguration()
        content.text = menuData[indexPath.row].rawValue
        content.textProperties.color = .white
        content.textProperties.font = .boldSystemFont(ofSize: 21)
        cell.contentConfiguration = content
        return cell
    }
}

extension Question6ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if previousSelectedIndexPath != nil {
            let previousCell = tableView.cellForRow(at: previousSelectedIndexPath!)
            var previousContent = previousCell?.contentConfiguration as? UIListContentConfiguration
            previousContent?.textProperties.color = .white
            previousCell?.contentConfiguration = previousContent
        }
        previousSelectedIndexPath = indexPath
        let cell = tableView.cellForRow(at: indexPath)
        var content = cell?.contentConfiguration as? UIListContentConfiguration
        content?.textProperties.color = .textColor ?? .darkGray
        cell?.contentConfiguration = content
        tableView.deselectRow(at: indexPath, animated: true)
        self.switchVC(type: menuData[indexPath.row])
    }
}
