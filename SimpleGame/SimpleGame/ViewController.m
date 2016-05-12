//
//  ViewController.m
//  SimpleGame
//
//  Created by 吕家腾 on 16/4/12.
//  Copyright © 2016年 吕家腾. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *whoLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *touchButton;
@property (nonatomic) BOOL changePlayer;
@property (nonatomic, strong) NSMutableArray *saveStep;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)saveStep {
    if (!_saveStep) {
        _saveStep = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    }
    return _saveStep;
}

//下棋
- (IBAction)clickButton:(UIButton *)sender {
    if (self.changePlayer) {
        [sender setTitle:@"O" forState:UIControlStateNormal];
        
        [self.saveStep replaceObjectAtIndex:sender.tag withObject:@"O"];
        self.whoLabel.text = @"Now : X";
        self.changePlayer = NO;
    } else {
        [sender setTitle:@"X" forState:UIControlStateNormal];
        [self.saveStep replaceObjectAtIndex:sender.tag withObject:@"X"];
        self.whoLabel.text = @"Now : O";
        self.changePlayer = YES;
    }
    if ([self judge:self.saveStep]) {
        NSString *whoWin = [[NSString alloc] init];
        if (self.changePlayer) {
            whoWin = @"X";
        } else {
            whoWin = @"O";
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[whoWin stringByAppendingString:@" Win"]
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@" OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {}]];
        [self presentViewController:alert animated:true completion:nil];
        //重新初始化数组
        self.saveStep = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
        //重新初始化button.title
        for (UIButton *touchButton in self.touchButton) {
            [touchButton setTitle:@"" forState:UIControlStateNormal];
        }
    }
}

//重新开始游戏
- (IBAction)replayGame:(UIButton *)sender {
    self.saveStep = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    for (UIButton *touchButton in self.touchButton) {
        [touchButton setTitle:@"" forState:UIControlStateNormal];
    }
}

//判断是否连成线
- (BOOL)judge:(NSMutableArray *)array {
    if (([array[1] isEqualToString:array[2]] && [array[2] isEqualToString:array[3]]) ||
        ([array[4] isEqualToString:array[5]] && [array[5] isEqualToString:array[6]]) ||
        ([array[7] isEqualToString:array[8]] && [array[8] isEqualToString:array[9]]) ||
        ([array[1] isEqualToString:array[4]] && [array[4] isEqualToString:array[7]]) ||
        ([array[2] isEqualToString:array[5]] && [array[5] isEqualToString:array[8]]) ||
        ([array[3] isEqualToString:array[6]] && [array[6] isEqualToString:array[9]]) ||
        ([array[1] isEqualToString:array[5]] && [array[5] isEqualToString:array[9]]) ||
        ([array[3] isEqualToString:array[5]] && [array[5] isEqualToString:array[7]])) {
        return YES;
    }
    return NO;
}

@end
