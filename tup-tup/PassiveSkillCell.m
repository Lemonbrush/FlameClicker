//
//  PassiveSkillCell.m
//  tup-tup
//
//  Created by Александр on 27.02.16.
//  Copyright © 2016 Александр. All rights reserved.
//

#import "PassiveSkillCell.h"

@implementation PassiveSkillCell

- (id)initWithName:(NSString *) name_cell MaxLevels:(NSUInteger )level_of_cell candies:(NSUInteger )init_candyes andIcon:(NSString *)nameIcon
{
    self = [super init];
    if (self) {
        
        _upCellPushing = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0] size:CGSizeMake(500, 150)];
        _upCellPushing .zPosition = 12;
        _upCellPushing .name = @"passiveCell-button";
        
        _levelCell = level_of_cell; //какой уровень ячейки
        _price_this_turn = init_candyes; //сколько камешков в ячейке
        
        _celIndic = name_cell;
        _nameCell = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"+ %li %@",_levelCell,_celIndic]];
        
        _stones = [NSMutableArray array];
        
        _icon = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@_%li",_celIndic,(long)_levelCell]];
        
        for(int i = 1; i<6; i++)
        {
            SKSpriteNode *babble = [SKSpriteNode spriteNodeWithImageNamed:@"stone"];
            
            if(_price_this_turn >= i){babble.hidden = NO;}else{babble.hidden = YES;}
            
            [_stones addObject:babble];
            
        }
        
    }
    return self;
}

//280 - 60

- (void)DPSClick:(double *)myClick{
    
    *myClick+= _levelCell;
    
    _price_this_turn++;
    
    [self update];
}

- (void)petUp:(double *)petValue{
    
    *petValue-= 0.1 * _levelCell;
    
    _price_this_turn++;
    
    [self update];
}

- (void)plusXPValueUp:(double *)myXPUp{
    
    *myXPUp+=  _levelCell;
    
    _price_this_turn++;
    
    [self update];
}

- (void)push{
    _price_this_turn++;
    
    [self update];
}

- (void)update{
    for(int i = 0; i<_stones.count; i++)
    {
        SKSpriteNode *thisBubble = [_stones objectAtIndex:i];
        if(_price_this_turn-1 >= i){thisBubble.hidden = NO;}else{thisBubble.hidden = YES;}
        
        if(i == _price_this_turn-1)
        {
            SKAction *down = [SKAction scaleTo:1 duration:0.1 ];
            SKAction *UP = [SKAction scaleTo:1.5 duration:0.1];
            [thisBubble runAction:[SKAction sequence:@[UP,down]]];
        }
    }
    
    if(_price_this_turn == 5)
    {
        _levelCell++;
        _price_this_turn = _price_this_turn - 5;
        
        for(int i = 0; i<5;i++)
        {
            SKAction *last = [SKAction scaleTo:2 duration:0.1];
            SKAction *down = [SKAction scaleTo:0.1 duration:0.1 * i];
            SKAction *UP = [SKAction scaleTo:1 duration:0];
            SKAction *hid = [SKAction hide];
            
            SKSpriteNode *thisBubble = [_stones objectAtIndex:i];
            
            if(i == 4){ [thisBubble runAction:[SKAction sequence:@[last,down,hid,UP]]]; }else
            {
            [thisBubble runAction:[SKAction sequence:@[down,hid,UP]]];
            }
        }
        
        _icon.texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@_%li",_celIndic,(long)_levelCell]];
                         
    }
    
    _nameCell.text = [NSString stringWithFormat:@"+ %li %@",_levelCell,_celIndic];
    
    while (_nameCell.frame.size.width > 320) {_nameCell.fontSize--;}
    
}

@end
