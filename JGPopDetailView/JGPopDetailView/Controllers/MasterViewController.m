//
//  MasterViewController.m
//  JGPopDetailView
//
//  Created by Ji Fu on 7/31/16.
//  Copyright © 2016 Ji Fu. All rights reserved.
//

#import "MasterViewController.h"
#import "MacroUtility.h"
#import "JGPopDetailView.h"


@interface MasterViewController ()

// *********************************************************************************************************************
#pragma mark - Property
@property (strong, nonatomic) UIImageView *imageV;
@property (strong, nonatomic) JGPopDetailView *popDetailView;

@end

@implementation MasterViewController

// *********************************************************************************************************************
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// *********************************************************************************************************************
#pragma mark - Action
- (void)onImageTapped:(id)sender {
    [self.popDetailView show:YES];
}

// *********************************************************************************************************************
#pragma mark - Private
- (void)initUI {
    
    self.imageV = ({
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight / 6, kScreenWidth, kScreenHeight / 3)];
        imageV.image = [UIImage imageNamed:@"autumn.jpg"];
        imageV.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onImageTapped:)];
        tap.numberOfTapsRequired = 1;
        [imageV addGestureRecognizer:tap];
        imageV;
    });
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageV];
}

- (JGPopDetailView *)popDetailView {
    if (nil == _popDetailView) {
        _popDetailView = [[JGPopDetailView alloc] initWithView:self.view];
    }
    return _popDetailView;
}

@end
