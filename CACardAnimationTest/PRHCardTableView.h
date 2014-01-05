//
//  PRHCardTableView.h
//  CACardAnimationTest
//
//  Created by Peter Hosey on 2014-01-04.
//  Copyright (c) 2014 Peter Hosey. All rights reserved.
//

@interface PRHCardTableView : NSView

@property(nonatomic, copy) NSArray *cards;

@property(nonatomic, strong) IBOutlet id layoutManager;

- (IBAction) deal:sender;
- (IBAction) undeal:sender;

@end
