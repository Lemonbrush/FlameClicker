//
//  SkillCell.m
//  tup-tup
//
//  Created by Александр on 24.02.16.
//  Copyright © 2016 Александр. All rights reserved.
//

#import "SkillCell.h"

@implementation SkillCell


- (id)initName:(NSString *)name withLevel:(NSString *)level andStaff:(double )staffValue andInitCash:(NSInteger )initCash andNameImage:(NSString *)nameImage
{
    self = [super init];
    if (self) {
        
        _hidden = 1;
        _name = nameImage;
        _levelCell = 1;
        _icon = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@_%li",nameImage,(long)_levelCell]];
        _staff = staffValue;
        _maxCash = initCash;
        _nameCell = [SKLabelNode labelNodeWithText:name];
        _levelLabel = [SKLabelNode labelNodeWithText:level];
        _subName =[SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%d(%d/sec)",(int)_maxCash ,(int)(_staff * 10)]];
        
        _upCellPushing = [SKSpriteNode spriteNodeWithImageNamed:@"hiddenCell"];
        _upCellPushing.size = CGSizeMake(502, 122);
        _upCellPushing .zPosition = 10;
        _upCellPushing .name = @"cell-button";
        
    }
    return self;
}

-(void)push:(double *)money andDPS:(double *)myDPS
{
    if(*money>=_maxCash)
    {
        *money-=_maxCash;
        *myDPS+=_staff;
        
        _maxCash += (_maxCash/100) * 50;
        _levelCell++;
        
    }
}

-(void)update:(double )money
{
    if(_hidden && ((_maxCash/100) * 70) <= money)
    {
        _hidden = 0;
        _upCellPushing.texture = [SKTexture textureWithImageNamed:@"shadow_cell"];
    }
    
    //проверка на доступность к покупке скила
    //если нельзя купить, то он темный
    //если можно, то он светлый
    if(money >= _maxCash && !_hidden)
    {
        _upCellPushing.colorBlendFactor = 1;
        _upCellPushing.color = [UIColor colorWithRed:0 green:1 blue:0 alpha:0];
        
    }else if(!_hidden){
        
        _upCellPushing.colorBlendFactor = 0;
        _upCellPushing.color = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        
    }
    
    _icon.texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@_%li",_name,(long)_levelCell]];
    _levelLabel.text = [NSString stringWithFormat:@"%li",(long)_levelCell];
    
    while (_levelLabel.frame.size.width > 80) {
        _levelLabel.fontSize--;
    }
    
    _subName.text = [NSString stringWithFormat:@"%li(%ld/sec)",(long)_maxCash,(long)(_staff *10) ];
    
    while (_subName.frame.size.width > 250) {
        _subName.fontSize--;
    }
    
    
}

@end