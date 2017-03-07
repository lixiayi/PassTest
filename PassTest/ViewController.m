//
//  ViewController.m
//  PassTest
//
//  Created by xiaoyi li on 17/3/6.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>

@interface ViewController ()<PKAddPassesViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PKAddPassButton *pkAddBtn = [[PKAddPassButton alloc] initWithAddPassButtonStyle:PKAddPassButtonStyleBlack];
    pkAddBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    pkAddBtn.frame = CGRectMake(100, 100, 220, 40);
    [self.view addSubview:pkAddBtn];
    
    
    [pkAddBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnClick:(PKAddPassButton *)button {
    NSString *passPath=[[NSBundle mainBundle] pathForResource:@"mywallet" ofType:@"pkpass"];
    NSData *passData = [[NSData alloc] initWithContentsOfFile:passPath];
    NSError *error = nil;
    PKPass *pass = [[PKPass alloc] initWithData:passData error:&error];
    if (error) {
        NSLog(@"创建Pass过程中发生错误，错误信息：%@",error.localizedDescription);
    };
    PKAddPassesViewController *vc = [[PKAddPassesViewController alloc] initWithPass:pass];
    vc.delegate = self;
    
    [self presentViewController:vc animated:true completion:nil];
    
}

-(void)addPassesViewControllerDidFinish:(PKAddPassesViewController *)controller{
    NSLog(@"add pass finished.");
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
