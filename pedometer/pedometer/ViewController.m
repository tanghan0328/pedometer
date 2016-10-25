//
//  ViewController.m
//  pedometer
//
//  Created by tang on 16/10/25.
//  Copyright © 2016年 tang. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#define OneDayTime 60*60*24



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic, strong)CMPedometer *pedometer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _pedometer= [[CMPedometer alloc]init];
    
    if([CMPedometer isStepCountingAvailable]){
        
        [_pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            if(error){
                
                NSLog(@"测试的信息==》%@",error);
                return;
            }
            
            NSLog(@"实时更新每米所需要的时间（秒）===%@",pedometerData.currentPace);
            NSLog(@"实时更新每秒走的步数===%@",pedometerData.currentCadence);
            NSLog(@"步数===%@",pedometerData.numberOfSteps);
            _textLabel.text = [NSString stringWithFormat:@"现在走了多少步：%@",pedometerData.numberOfSteps];
            _textLabel.textColor = [UIColor redColor];
        }];
        
        [_pedometer queryPedometerDataFromDate:[NSDate dateWithTimeIntervalSinceNow:-OneDayTime] toDate:[NSDate dateWithTimeIntervalSinceNow:0] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            
            if(error){
                NSLog(@"测试的信心报错==》%@",error);
                return ;
            }
            
            NSLog(@"步数===%@",pedometerData.numberOfSteps);
            NSLog(@"距离===%@",pedometerData.distance);
            NSLog(@"上的楼梯层数===%@",pedometerData.floorsAscended);
            NSLog(@"下的楼梯层数===%@",pedometerData.floorsDescended);
            
        }];
    
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
