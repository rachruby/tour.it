//
//  OnboardingViewController.swift
//  Tour.it
//
//  Created by Swift Admin on 2022-07-27.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] =   []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage

            if currentPage == slides.count - 1 {
                nextBtn.setTitle ("Get Started",for:.normal)
            }
            else{
                nextBtn.setTitle("Next",for:.normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = [
                    OnboardingSlide(title: "AR Virtual Tour", description: "Experience a variety of amazing Augmented Reality 360-view tours with ease just from your own couch while being COVID-19 free", image: #imageLiteral(resourceName: "artour")),
                    OnboardingSlide(title: "AR Tour Guide on the Spot", description: "Experience with the finest virtual tour guide who will assist you through your visit in the chosen location.", image: #imageLiteral(resourceName: "guide")),
                    OnboardingSlide(title: "Connect With Friends", description: "Team up as travel mates through our messaging tool.", image: #imageLiteral(resourceName: "friends")),
                    OnboardingSlide(title: "Customize Profile", description: "Be creative, shape your interest and hobbies through our Account Profile page.", image: #imageLiteral(resourceName: "profile")),
                    OnboardingSlide(title: "Get Help", description: "Need help? Go on to our Help Page for Immediate Support.", image: #imageLiteral(resourceName: "help"))
                    
                ]
                pageControl.numberOfPages = slides.count
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller =
                storyboard?
                .instantiateViewController(identifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present (controller, animated: true, completion:nil)
            
        } else{
            currentPage += 1
            let indexPath = IndexPath(item:currentPage, section: 0)
            collectionView.scrollToItem(at:indexPath,at:.centeredHorizontally, animated:true)
            nextBtn.setTitle("Next", for:.normal)
        }
        
        
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath)
            as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
