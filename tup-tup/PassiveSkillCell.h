//
//  PassiveSkillCell.h
//  tup-tup
//
//  Created by Александр on 27.02.16.
//  Copyright © 2016 Александр. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

@interface PassiveSkillCell : NSObject

@property NSUInteger cellNumber;             //то, что получится в итоге
@property double price_this_turn;           //цена
@property NSInteger levelCell;      //уровень прокачки ячейки

@property SKSpriteNode *fon;        //фон - основание ячейки
@property SKSpriteNode *icon;       //иконка ячейки
@property SKSpriteNode *candyLevel; //показатель уровня ячейки
@property NSMutableArray *stones;
@property SKSpriteNode *upCellPushing;

@property NSString *celIndic;

@property SKLabelNode *nameCell;    //имя ячейки

@property SKSpriteNode *mask;

- (id)initWithName:(NSString *) name_cell MaxLevels:(NSUInteger )level_of_cell candies:(NSUInteger )init_candyes andIcon:(NSString *)nameIcon;
- (void)update;
- (void)DPSClick:(double *)myClick;
- (void)petUp:(double *)petValue;
- (void)plusXPValueUp:(double *)myXPUp;
- (void)push;
@end
