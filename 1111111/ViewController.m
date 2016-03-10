//
//  ViewController.m
//  1111111
//
//  Created by yangyue on 16/2/29.
//  Copyright © 2016年 com.yy.www. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>
@interface ViewController ()<SKStoreProductViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self evaluate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClicked:(id)sender {
    [self showStoreProductInApp:@"452703031"];

}
- (void)showStoreProductInApp:(NSString *)appID{
    
    Class isAllow = NSClassFromString(@"SKStoreProductViewController");
    
    if (isAllow != nil) {
           //初始化控制器
        SKStoreProductViewController *sKStoreProductViewController = [[SKStoreProductViewController alloc] init];
//        [sKStoreProductViewController.view setFrame:CGRectMake(0, 0, 320, 200)];
          //设置代理请求为当前控制器本身
        [sKStoreProductViewController setDelegate:self];
          //加载一个新的视图展示
        [sKStoreProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier: appID}
                                                completionBlock:^(BOOL result, NSError *error) {
                                                         //block回调
                                                    if (result) {
                                                           //模态弹出AppStore应用界面
                                                        [self presentViewController:sKStoreProductViewController
                                                                           animated:YES
                                                                         completion:nil];
//                                                        [self removeNotice];
                                                        
                                                    }else{
                                                        NSLog(@"error:%@",error);
                                                    }
                                                }];
    }else{
        //低于iOS6的系统版本没有这个类,不支持这个功能
        NSString *string = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/xxxxxxx/app/id%@?mt=8",appID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    }  
}

//取消按钮监听方法
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"关闭了评论页");
    }];
}
@end
