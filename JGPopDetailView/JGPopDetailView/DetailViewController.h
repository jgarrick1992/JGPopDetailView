//
//  DetailViewController.h
//  JGPopDetailView
//
//  Created by Ji Fu on 7/31/16.
//  Copyright © 2016 Ji Fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

