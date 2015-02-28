//
//  ViewController.m
//  ImplementKVO
//
//  Created by Peng Gu on 2/26/15.
//  Copyright (c) 2015 Peng Gu. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+KVO.h"

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;

@end

@implementation Message

@end



@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextField *textfield;
@property (nonatomic, weak) IBOutlet UIButton *button;

@property (nonatomic, strong) Message *message;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.message = [[Message alloc] init];
    [self.message PG_addObserver:self forKey:NSStringFromSelector(@selector(text))
                       withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
                           NSLog(@"%@.%@ is now: %@", observedObject, observedKey, newValue);
                           dispatch_async(dispatch_get_main_queue(), ^{
                               self.textfield.text = newValue;
                           });

    }];
    
    [self changeMessage:nil];
}


- (IBAction)changeMessage:(id)sender
{
    NSArray *msgs = @[@"Hello World!", @"Objective C", @"Swift", @"Peng Gu", @"peng.gu@me.com", @"www.gupeng.me", @"glowing.com"];
    NSUInteger index = arc4random_uniform((u_int32_t)msgs.count);
    self.message.text = msgs[index];
}




@end
