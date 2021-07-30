//
//  SkillCell.h
//  tup-tup
//
//  Created by Александр on 24.02.16.
//  Copyright © 2016 Александр. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

@interface SkillCell : NSObject

@property double staff;
@property double maxCash;
@property NSInteger levelCell;
@property NSString *name;

@property SKSpriteNode *fon;
@property SKSpriteNode *icon;

@property SKLabelNode *nameCell;
@property SKLabelNode *subName;
@property SKLabelNode *levelLabel;
@property SKSpriteNode *upCellPushing;
@property bool hidden;

- (id)initName:(NSString *)name withLevel:(NSString *)level andStaff:(double )staffValue andInitCash:(NSInteger )initCash andNameImage:(NSString *)nameImage;
- (void)push:(double *)money andDPS:(double *)myDPS;
-(void)update:(double )money;

@end
