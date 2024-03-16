//
//  ProductsVC.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 25/02/2024.
//
import UIKit
import Kingfisher

class ProductsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var displayProductsViewModel : ProductsViewModel!
    
    var allProducts :[Product] = [Product]()
    var indicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        displayProductsViewModel = ProductsViewModel()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        indicator.startAnimating()

        displayProductsViewModel.bindResultToDisplayProducts = { [weak self] in
            DispatchQueue.main.async {
                
                self?.allProducts = self?.displayProductsViewModel.allProducts.products ?? []
                self?.collectionView.reloadData()
            }
            self?.indicator.stopAnimating()

        }
        displayProductsViewModel.getAllProducts()
    }
        
    @IBAction func addNewProduct(_ sender: Any) {
        let productVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        productVC.flagEditAdd = 0
    
        self.navigationController?.pushViewController(productVC, animated: true)
    }
    
}


extension ProductsViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allProducts.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productItem", for: indexPath) as! ProductCell
        
        cell.productTitle.text = allProducts[indexPath.row].title
        cell.productPrice.text = "EGP \(allProducts[indexPath.row].variants?.first?.price ?? "")"
        cell.productImage.kf.setImage(with: URL(string: allProducts[indexPath.row].image?.src ?? ""),placeholder: UIImage(named: "placeholder"))
        
        cell.editProduct = { [unowned self] in
            let productVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
            productVC.flagEditAdd = 1
            
            productVC.product = allProducts[indexPath.row]
        
            self.navigationController?.pushViewController(productVC, animated: true)
        }
        
        cell.deleteProduct = { [unowned self] in
        
            showAlert(indexPath: indexPath)
            
        }
        
        return cell
    }
    
    func showAlert(indexPath: IndexPath){
       
        let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion?", preferredStyle: .alert)
    
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [self] action in
       
            displayProductsViewModel.deleteProduct(productId: allProducts[indexPath.row].id ?? 0)
         
            allProducts.remove(at: indexPath.row)
           
            collectionView.deleteItems(at: [indexPath])
            
            self.collectionView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
            self.present(alert, animated: true) {
      
        }
    }
    
}

extension ProductsViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: 180, height: 244)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

}

