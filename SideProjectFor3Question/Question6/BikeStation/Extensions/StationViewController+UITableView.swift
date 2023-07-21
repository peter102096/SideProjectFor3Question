import UIKit

extension StationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == bikeTableView {
            return model.result.count
        }
        if tableView == dropDownMenu {
            return model.sareas.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == bikeTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikeTableViewCell", for: indexPath) as! BikeTableViewCell
            cell.setup(model: model.result[indexPath.row])
            return cell
        }
        if tableView == dropDownMenu {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.selectionStyle = .none
            cell.setBackgroundColor(.clear)
            var content = cell.defaultContentConfiguration()
            content.text = model.sareas[indexPath.row]
            content.textProperties.color = .black
            content.textProperties.font = .boldSystemFont(ofSize: 21)
            cell.contentConfiguration = content
            return cell
        }
        return UITableViewCell()
    }
}

extension StationViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == bikeTableView {
            showDialog(model.result[indexPath.row])
        }
        if tableView == dropDownMenu {
            if menuLastSelectedIndex != nil {
                let previousCell = tableView.cellForRow(at: menuLastSelectedIndex!)
                var previousContent = previousCell?.contentConfiguration as? UIListContentConfiguration
                previousContent?.textProperties.color = .black
                previousCell?.contentConfiguration = previousContent
            }
            menuLastSelectedIndex = indexPath
            let cell = tableView.cellForRow(at: indexPath)
            var content = cell?.contentConfiguration as? UIListContentConfiguration
            content?.textProperties.color = .mainColor ?? .darkGray
            cell?.contentConfiguration = content
            menuDidSelected(model.sareas[indexPath.row])
        }
        dismissMenu()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == bikeTableView {
            let headerView = SectionHeaderView(reuseIdentifier: "SectionHeaderView")
            return headerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == bikeTableView {
            return sectionHeaderHeight
        }
        if tableView == dropDownMenu {
            return 0
        }
        return 0
    }
}
