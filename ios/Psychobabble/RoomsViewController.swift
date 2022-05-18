import UIKit

private let reuseIdentifier = "Cell"
let kRoomCellScaling: CGFloat = 0.6

class RoomsViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // This method sets up the collection view
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: 250, height: 250)
        layout.scrollDirection = .horizontal

        layout.sideItemAlpha = 1
        layout.sideItemScale = 0.8
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 60)

        collectionView?.setCollectionViewLayout(layout, animated: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_:UICollectionView, numberOfItemsInSection: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }

    override func collectionView(_:UICollectionView, cellForItemAt: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: cellForItemAt)



        // Configure the cell
        switch cellForItemAt.row % 3 {

        case 0:
            cell.backgroundColor = UIColor.red
        case 1:
            cell.backgroundColor = UIColor.black
        case 2:
            cell.backgroundColor = UIColor.blue

        default:
            break

        }

        return cell
    }


}
