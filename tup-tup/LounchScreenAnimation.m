//
//  LounchScreenAnimation.m
//  tup-tup
//
//  Created by Александр on 23.02.16.
//  Copyright © 2016 Александр. All rights reserved.
//

#import "LounchScreenAnimation.h"

@interface LounchScreenAnimation ()

@end

@implementation LounchScreenAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[AnimationImageView setFrame:self.view.frame];
    
    
    
    [self performSelector:@selector(showNawController) withObject:nil afterDelay:0];
    
    /*
    AnimationImageView.animationImages = [NSArray arrayWithObjects:
                                          [UIImage imageNamed:@"1.png" ],
                                          [UIImage imageNamed:@"2.png" ],
                                          [UIImage imageNamed:@"3.png" ],
                                          nil];
     
    
    [AnimationImageView setAnimationRepeatCount:1];
    AnimationImageView.animationDuration = 3;
    [AnimationImageView startAnimating];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showNawController
{
    //performSegue
    [self performSegueWithIdentifier:@"showGame" sender:self];
}

-(void)delay1
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
