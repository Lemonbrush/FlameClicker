//
//  GameScene.m
//  tup-tup
//
//  Created by Александр on 10.02.16.
//  Copyright (c) 2016 Александр. All rights reserved.
//

#import "PassiveSkillCell.h"
#import "SkillCell.h"
#import "GameScene.h"
@interface GameScene(){
    
    SKSpriteNode *musicButton;      //кнопка отключения музыки
    SKSpriteNode *soundFXButton;    //кнопка отключения звуков
    SKSpriteNode *topBorder;        //верхняя меню
    SKSpriteNode *botomBorder;      //нижняя меню
    SKSpriteNode *player;           //персонаж
    SKSpriteNode *skillsMenu;       //меню для выбора скилов
    SKSpriteNode *treeMenu;         //меню для эволюции
    SKSpriteNode *levelBar;         //индикатор уровня игрока
    SKSpriteNode *levelNumber;      //звездочка для обозначения уровня
    SKSpriteNode *fonForNumEvelebleSkills;
    
    SKSpriteNode *menuNumberOne;    //меню для выбора скилов, к которому крепятся кнопки
    SKNode *menuNumberTwo;          //меню для выбора эволюции, к которому крепятся кнопки
    
    SKSpriteNode *back;             //задний фон
    
    double scores;                  //всего денег
    double tupNum;                  //урон за один тап
    double autoTupNum;              //автотап
    
    bool menuUpFlag;                //флажки для определения поднятия меню
    bool numMenu;                   //номер поднятой меню
    
    NSInteger level;                //здесь хранится уровень персонажа
    double levelProgress;        //здесь хранится число очков накопленных для повышения уровня
    double maxLevelProgress;     //количество очков нужное для перехода на новый уровень
    double timeAutoclick;
    double petIterator;
    double plusXPValue;
    
    SKLabelNode *scoreLabel;        //показывает сколько всего валюты
    SKLabelNode *DPSLabel;          //показывает кол-во валюты в секунду
    SKLabelNode *levelLabel;        //показывает уровень перса
    SKLabelNode *test;              //временная хрень ~
    SKLabelNode *numAvelebleSkills;
    
    SKAction *menuUp;               //действие поднятия меню
    SKAction *menuDown;             // действие опускания меню
    SKAction *upDown;               //сменя одного меню на другое
    
    SKSpriteNode *evolve_1;         //кнопка эволюции 1
    SKSpriteNode *evolve_2;         //кнопка эволюции 2
    SKSpriteNode *evolveCell_1;     //кнопка истории эволюции 1
    SKSpriteNode *evolveCell_2;     //кнока истории эволюции 2
    SKSpriteNode *evolveCell_3;     //кнопка истории эволюции 3
    
    SKLabelNode *save;              //временный показатель значений дерева
    
    SKSpriteNode *selectedNode;     //выбранный предмет
    NSString *nameForMove;          //шаблон для удобного пользования scroll menu
    
    SKSpriteNode *XPMaskCrop;       //нод для нарезки полосы уровня *конфетки*
    
    NSMutableArray *skillCells;     //здесь хранятся все ячейки со скилами
    NSMutableArray *Passive_skillCells;
}

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    nameForMove = @"movable";       //задаем шаблон
    
    self.size = CGSizeMake(640, 1132);//размер сцены
    
    //------------------------------
    //загрузка из юзердефолтс
    numMenu = 0;
    menuUpFlag = 0;
    scores = 0;
    tupNum = 1;
    autoTupNum = 0;
    levelProgress = 0;
    maxLevelProgress = 5;
    timeAutoclick = 10;
    petIterator = 0;
    plusXPValue = 1;
    //------------------------------
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //задний фон и все, что с ним связано
    
    back = [SKSpriteNode spriteNodeWithImageNamed:@"задний фон.png"];                                           //задний фон
    back.position = CGPointMake(640/2, 1132/2);
    back.size = CGSizeMake(640, 1132);
    back.zPosition = -3;
    [self addChild:back];
    
    player = [SKSpriteNode spriteNodeWithImageNamed:@"персонаж.png"];                                           //персонаж
    player.size = CGSizeMake(209, 344);
    player.position = CGPointMake(0,-60);
    player.zPosition = 2;
    [back addChild:player];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //верхнее меню и все, что с ним связано
    
    //topBorder = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(640, 500)];
    topBorder = [SKSpriteNode spriteNodeWithImageNamed:@"test.png"];                                    //верхняя меню
    topBorder.position = CGPointMake(640/2,1132 - topBorder.size.height/2 + 70);
    topBorder.zPosition = 111;
    [self addChild:topBorder];
    
    scoreLabel = [SKLabelNode labelNodeWithText:@"0"];                                                          //показатель имеющейся валюты
    scoreLabel.fontName = @"KomikaAxis";
    scoreLabel.fontColor = [UIColor colorWithRed:(8/255.0) green:(188/255.0) blue:(195/255.0) alpha:1];
    scoreLabel.colorBlendFactor = 1;
    scoreLabel.position = CGPointMake(0, 15);
    scoreLabel.zPosition = 11;
    [topBorder addChild:scoreLabel];
    
    /*
    SKLabelNode *shadow = [SKLabelNode labelNodeWithText:@"0"];                                                          //показатель имеющейся валюты
    shadow.fontName = @"KomikaAxis";
    shadow.fontColor = [UIColor blackColor];
    shadow.colorBlendFactor = 1;
    shadow.position = CGPointMake(5, 75);
    shadow.zPosition = 10;
    [topBorder addChild:shadow];
    */
    
    DPSLabel = [SKLabelNode labelNodeWithText:@"DPS: 0"];                                                            //показатель валюты в секунду
    DPSLabel.fontName = @"KomikaAxis";
    DPSLabel.fontColor = [UIColor colorWithRed:(8/255.0) green:(188/255.0) blue:(195/255.0) alpha:1];
    DPSLabel.colorBlendFactor = 1;
    DPSLabel.position = CGPointMake(scoreLabel.position.x, scoreLabel.position.y - 50);
    DPSLabel.zPosition = 20;
    [topBorder addChild:DPSLabel];
    
    /*
    SKLabelNode *shadow2 = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%@ %i",@"DPS: ",(int)(autoTupNum * 10)]];                                                          //показатель имеющейся валюты
    shadow2.fontName = @"KomikaAxis";
    shadow2.fontColor = [UIColor blackColor];
    shadow2.colorBlendFactor = 1;
    shadow2.position = CGPointMake(scoreLabel.position.x+5, scoreLabel.position.y - 55);
    shadow2.zPosition = 10;
    [topBorder addChild:shadow2];
    */
    
    save = [SKLabelNode labelNodeWithText:@"0 - 0 - 0"];                                                            //показатель валюты в секунду
    save.fontColor = [UIColor colorWithRed:(8/255.0) green:(188/255.0) blue:(195/255.0) alpha:1];
    save.colorBlendFactor = 1;
    save.fontName = @"KomikaAxis";
    save.position = CGPointMake(DPSLabel.position.x, DPSLabel.position.y - 50);
    save.zPosition = 20;
    //[topBorder addChild:save];
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //нижнее меню и все, что с ним связано
    
    //botomBorder = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(640, 1132)];          //нижнее меню
    botomBorder = [SKSpriteNode spriteNodeWithImageNamed:@"нижняя менюшка.png"];
    //botomBorder.size = CGSizeMake(640, 1132);
    botomBorder.position = CGPointMake(640/2, -366);
    botomBorder.zPosition = 4;
    [self addChild:botomBorder];
    
    //levelNumber = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(80, 80)];               //звездочка
    levelNumber = [SKSpriteNode spriteNodeWithImageNamed:@"star"];
    //levelNumber.size = CGSizeMake(640, levelNumber.size.height);
    levelNumber.zPosition = -1;
    levelNumber.position = CGPointMake(0, 591);
    [botomBorder addChild:levelNumber];
    
    //-------------------------------------------------
    levelLabel = [SKLabelNode labelNodeWithText:@"0"];                                                          //показатель уровня
    levelLabel.fontName = @"KomikaAxis";
    //levelLabel.fontColor = [UIColor colorWithRed:(8/255.0) green:(188/255.0) blue:(195/255.0) alpha:1];
    //levelLabel.colorBlendFactor = 1;
    levelLabel.zPosition = 10;
    levelLabel.position = CGPointMake(-244, 16);
    [levelNumber addChild:levelLabel];
    //-------------------------------------------------
    
    //levelBar = [SKSpriteNode spriteNodeWithColor:[UIColor magentaColor] size:CGSizeMake(0, 50)];              //индикатор текущего уровня *вставить в размер переменную при загрузке
    levelBar = [SKSpriteNode spriteNodeWithImageNamed:@"конфетка"];
    levelBar.size = CGSizeMake(450, levelBar.size.height);
    //levelBar.position = CGPointMake(-160, 578);
    levelBar.zPosition = -2;
    levelBar.anchorPoint = CGPointMake(0.0, 0.0);
    //[botomBorder addChild:levelBar];
    
    XPMaskCrop = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size: CGSizeMake(0, 100)];                   //маска для обрезания полосы опыта
    SKCropNode *XPCropNode = [SKCropNode node];
    [XPCropNode addChild: levelBar];
    [XPCropNode setMaskNode: XPMaskCrop];
    [botomBorder addChild: XPCropNode];
    XPCropNode.position = CGPointMake(-160,571);
    XPCropNode.zPosition = 100;
    
    //soundFXButton = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(70, 70)];           //кнопка отключения звуковых эффектов
    soundFXButton = [SKSpriteNode spriteNodeWithImageNamed:@"звук.png"];
    soundFXButton.size = CGSizeMake(115, 115);
    soundFXButton.position = CGPointMake(72, 461);
    soundFXButton.zPosition = 31;
    soundFXButton.name = @"menuButton";
    [botomBorder addChild:soundFXButton];
    
    //skillsMenu = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(70,70)];               //меню скилов
    skillsMenu = [SKSpriteNode spriteNodeWithImageNamed:@"скилы.png"];
    skillsMenu.size = CGSizeMake(115, 115);
    skillsMenu.position = CGPointMake(-210,461);
    skillsMenu.zPosition = 31;
    skillsMenu.name = @"menuButton";
    [botomBorder addChild:skillsMenu];
    
    //fonForNumEvelebleSkills = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(50, 50)];
    fonForNumEvelebleSkills = [SKSpriteNode spriteNodeWithImageNamed:@"stone"];
    fonForNumEvelebleSkills.size = CGSizeMake(50, 50);
    fonForNumEvelebleSkills.zPosition = 32;
    fonForNumEvelebleSkills.position = CGPointMake(115/2, -115/2);
    [skillsMenu addChild:fonForNumEvelebleSkills];
    
    numAvelebleSkills = [SKLabelNode labelNodeWithText:@"0"];
    numAvelebleSkills.fontName = @"KomikaAxis";
    numAvelebleSkills.zPosition = 31;
    numAvelebleSkills.position = CGPointMake(0, -12);
    [fonForNumEvelebleSkills addChild:numAvelebleSkills];
    
    //treeMenu = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(70,70)];                 //меню эволюции
    treeMenu = [SKSpriteNode spriteNodeWithImageNamed:@"дерево.png"];
    treeMenu.size = CGSizeMake(115, 115);
    treeMenu.position = CGPointMake(-70,461);
    treeMenu.zPosition = 31;
    treeMenu.name = @"menuButton";
    [botomBorder addChild:treeMenu];
    
    //musicButton = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(70, 70)];             //кнопка отключения музыки
    musicButton = [SKSpriteNode spriteNodeWithImageNamed:@"музыка.png"];
    musicButton.size = CGSizeMake(115, 115);
    musicButton.position = CGPointMake(214, 461);
    musicButton.zPosition = 31;
    musicButton.name = @"menuButton";
    [botomBorder addChild:musicButton];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //кнопки скилов
    
    menuNumberOne = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0] size:CGSizeMake(500, 1132)];       //соединим все кнопочки в одном месте
    menuNumberOne.zPosition = 5;
    menuNumberOne.name = nameForMove;
    
    menuNumberOne.position = CGPointMake(0,-150);
    //[botomBorder addChild:menuNumberOne];
    
    //маска для двигающегося меню скилов
    SKSpriteNode *mask = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size: CGSizeMake(10000, 720)];  //100 by 100 is the size of the mask
    SKCropNode *cropNode = [SKCropNode node];
    [cropNode addChild: menuNumberOne];
    [cropNode setMaskNode: mask];
    [botomBorder addChild: cropNode];
    cropNode.position = CGPointMake(0,0);
    cropNode.zPosition = 5;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////
    //ячейки для пассивных умений
    
     menuNumberTwo = [SKNode node];                                                                              //соединим все кнопочки в одном месте
     menuNumberTwo.position = CGPointMake(0,0);
     menuNumberTwo.zPosition = 8;
     [botomBorder addChild:menuNumberTwo];
     
     PassiveSkillCell *PS_N_1 = [[PassiveSkillCell alloc] initWithName:@"percent to CPS" MaxLevels:1 candies:0 andIcon:@"passiveCell"];
     PassiveSkillCell *PS_N_2 = [[PassiveSkillCell alloc] initWithName:@"percen fast pet" MaxLevels:1 candies:0 andIcon:nil];
     PassiveSkillCell *PS_N_3 = [[PassiveSkillCell alloc] initWithName:@"to XP" MaxLevels:1 candies:0 andIcon:nil];
    
     //PassiveSkillCell *PS_N_4 = [[PassiveSkillCell alloc] initWithName:@"X2 click" MaxLevels:5 price:0];
     
     Passive_skillCells = [NSMutableArray arrayWithObjects:PS_N_1,PS_N_2,PS_N_3, nil];
     
     for (int i = 0; i<Passive_skillCells.count; i++){
     
     //CGPoint positionCell = CGPointMake(0,menuNumberOne.position.y + menuNumberOne.size.height/2 - i * 125);
         
     PassiveSkillCell *abstract = [Passive_skillCells objectAtIndex:i];
     
     abstract.cellNumber = i;
         
     abstract.fon = [SKSpriteNode spriteNodeWithImageNamed:@"PSKill"];
     abstract.fon.size = CGSizeMake(500, 150);
     abstract.fon.position = CGPointMake(5,250 - i * 200);
         //175
     abstract.fon.zPosition = 5;
     abstract.fon.name = @"button";
     [menuNumberTwo addChild:abstract.fon];
     
     abstract.icon.position = CGPointMake( -170, 0);
     abstract.icon.size = CGSizeMake(130, 130);
     abstract.icon.zPosition = 6;
     [abstract.fon addChild:abstract.icon];
         
         
         for(int i = 0; i<abstract.stones.count; i++)
         {
             SKSpriteNode *thisBubble = [abstract.stones objectAtIndex:i];
             thisBubble.size = CGSizeMake(50, 50);
             thisBubble.position = CGPointMake(-64 + (i * (thisBubble.size.width + 18)), -27);
             thisBubble.zPosition = 6;
             
             [abstract.fon addChild:thisBubble];
         }
         
         
         
     
     abstract.nameCell.position = CGPointMake(70, 28);
     abstract.nameCell.fontName = @"KomikaAxis";
         abstract.nameCell.zPosition = 6;
     
     while (abstract.nameCell.frame.size.width > 320) {
         
     abstract.nameCell.fontSize--;
         
     }
     
     [abstract.fon addChild:abstract.nameCell];
         
     
         abstract.upCellPushing.position = abstract.fon.position;
         [menuNumberTwo addChild:abstract.upCellPushing ];
         
     }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////
    //ячейки для SkrollMenu
    
    SkillCell *skill_N_1    = [[SkillCell alloc] initName:@"Strong eye"     withLevel:@"0" andStaff:0.1 andInitCash:5 andNameImage:@"icon"];
    SkillCell *skill_N_2    = [[SkillCell alloc] initName:@"cover"        withLevel:@"0" andStaff:0.5 andInitCash: 50 andNameImage:@"jaws"];
    SkillCell *skill_N_3    = [[SkillCell alloc] initName:@"Slap ass :O"    withLevel:@"0" andStaff:1.5 andInitCash:100 andNameImage:@"cover"];
    SkillCell *skill_N_4    = [[SkillCell alloc] initName:@"Easy walking"   withLevel:@"0" andStaff:2   andInitCash:150 andNameImage:@"hand"];
    SkillCell *skill_N_5    = [[SkillCell alloc] initName:@"Snail hand"     withLevel:@"0" andStaff:3   andInitCash:200 andNameImage:@"brain"];
    SkillCell *skill_N_6    = [[SkillCell alloc] initName:@"Big mind"       withLevel:@"0" andStaff:5   andInitCash:250 andNameImage:nil];
    SkillCell *skill_N_7    = [[SkillCell alloc] initName:@"Fast peeing"    withLevel:@"0" andStaff:10  andInitCash:360 andNameImage:nil];
    SkillCell *skill_N_8    = [[SkillCell alloc] initName:@"Creep teeth"    withLevel:@"0" andStaff:50  andInitCash:500 andNameImage:nil];
    SkillCell *skill_N_9    = [[SkillCell alloc] initName:@"Angry poops"    withLevel:@"0" andStaff:100 andInitCash:1000 andNameImage:nil];
    SkillCell *skill_N_10   = [[SkillCell alloc] initName:@"Small afraid"   withLevel:@"0" andStaff:500 andInitCash:1500 andNameImage:nil];
    
    skillCells = [NSMutableArray arrayWithObjects:
                  skill_N_1,
                  skill_N_2,
                  skill_N_3,
                  skill_N_4,
                  skill_N_5,
                  skill_N_6,
                  skill_N_7,
                  skill_N_8,
                  skill_N_9,
                  skill_N_10,
                  nil];
    
    //рисуем ячейки ScrollMenu
    for (int i = 0; i<skillCells.count; i++){
        
        //CGPoint positionCell = CGPointMake(0,menuNumberOne.position.y + menuNumberOne.size.height/2 - i * 125);
        
        SkillCell *abstract = [skillCells objectAtIndex:i];
        
        //abstract.fon = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(500, 120)];
        abstract.fon = [SKSpriteNode spriteNodeWithImageNamed:@"cell"];
        abstract.fon.size = CGSizeMake(500, 120);
        abstract.fon.position = CGPointMake(0,menuNumberOne.position.y + menuNumberOne.size.height/2 - i * 130);
        abstract.fon.zPosition = 2;
        abstract.fon.name = @"button";
        [menuNumberOne addChild:abstract.fon];
        
        //abstract.icon = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(120, 120)];
        abstract.icon.size = CGSizeMake(94, 94);
        abstract.icon.position = CGPointMake(abstract.fon.position.x - abstract.fon.size.width/2 + abstract.icon.size.width/2 + 10, 0);
        abstract.icon.zPosition = 5;
        [abstract.fon addChild:abstract.icon];
        
        abstract.nameCell.position = CGPointMake(0, 7);
        abstract.nameCell.fontName = @"KomikaAxis";
        abstract.nameCell.zPosition = 3;
        //abstract.nameCell.fontColor = [UIColor colorWithRed:(8/255.0) green:(188/255.0) blue:(195/255.0) alpha:1];
        //abstract.nameCell.colorBlendFactor = 1;
        
        while (abstract.nameCell.frame.size.width > 250) {
            abstract.nameCell.fontSize--;
        }
        
        [abstract.fon addChild:abstract.nameCell];
        
        //abstract.subName.text = [NSString stringWithFormat:@"%f(%f/sec)",abstract.maxCash ,abstract.staff * 10];
        abstract.subName.position = CGPointMake(0, -25);
        abstract.subName.fontName = @"KomikaAxis";
        abstract.subName.zPosition = 3;
        //abstract.subName.fontColor = [UIColor colorWithRed:(8/255.0) green:(188/255.0) blue:(195/255.0) alpha:1];
        //abstract.subName.colorBlendFactor = 1;
        
        while (abstract.subName.frame.size.width > 250) {
            abstract.subName.fontSize--;
        }
        
        [abstract.fon addChild:abstract.subName];
        
        abstract.levelLabel.position = CGPointMake(200, -20);
        abstract.levelLabel.fontSize = 60;
        abstract.levelLabel.fontName = @"KomikaAxis";
        abstract.levelLabel.zPosition = 3;
        //abstract.levelLabel.fontColor = [UIColor colorWithRed:(8/255.0) green:(188/255.0) blue:(195/255.0) alpha:1];
        //abstract.levelLabel.colorBlendFactor = 1;
        
        while (abstract.levelLabel.frame.size.width > 80) {
            abstract.levelLabel.fontSize--;
        }
        
        [abstract.fon addChild:abstract.levelLabel];
        
        abstract.upCellPushing.position = abstract.fon.position;
        [menuNumberOne addChild:abstract.upCellPushing ];
        
    }
    
    /////////////////////////////////////////////////////////////////////////
    //действия для сворачивания, разворачивания и всего вместе
    
    SKAction * block = [SKAction runBlock:^(){
                            if(numMenu)
                            {
                                SKAction *hidden = [SKAction hide];
                                SKAction *unHidden = [SKAction unhide];
                                [menuNumberOne runAction:unHidden];
                                [menuNumberTwo runAction:hidden];
                                
                                numMenu = 0;
                                
                                menuNumberOne.position = CGPointMake(0,-150); //ставим меню в изначальную позицию
                            }else {
                                
                                SKAction *hidden = [SKAction hide];
                                SKAction *unHidden = [SKAction unhide];
                                [menuNumberOne runAction:hidden];
                                [menuNumberTwo runAction:unHidden];
                                
                                numMenu = 1;
                                
                                menuNumberOne.position = CGPointMake(0,-150); //ставим меню в изначальную позицию
                            }
                            
                        }];
    
    menuUp = [SKAction moveTo:CGPointMake(640/2, 360) duration:0.3];            //поднять меню
    menuDown = [SKAction moveTo:CGPointMake(640/2, -366) duration:0.3];         //опустить меню
    upDown = [SKAction sequence:@[menuDown,block,menuUp]];                      //опустить, сменить вкладку и поднять
    /////////////////////////////////////////////////////////////////////////
    
    //-----------------------------------------------------------------------
    //игровой таймер
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval: 0
                                                  target: self
                                                selector:@selector(onTick)
                                                userInfo: nil repeats:YES];
    //-----------------------------------------------------------------------
    
    [self textureLevelUpdate];
}

//таймер вызывает эту функцию
- (void)onTick{
    scores+=autoTupNum;
    
    scoreLabel.text = @((int)scores).stringValue;
    DPSLabel.text = [NSString stringWithFormat:@"%@ %i",@"DPS: ",(int)(autoTupNum * 10)];
    
    petIterator+= 0.1;
    
    if(petIterator >= timeAutoclick){
        
        petIterator = 0;
        
        scores+= tupNum;
    }
    
    if(scores >= 1000 && scores < 10000){scoreLabel.text = [NSString stringWithFormat:@"%d K",(int)scores / 1000];}
    
    /////////////////////////////////////////////////////////////////////////
    //обновляем ячейки и при необходимости информируем об их активности
    
    int a = 0;
    for(int i = 0; i<skillCells.count;i++)
    {
        SkillCell *abstract = [skillCells objectAtIndex:i];
        if(scores >= abstract.maxCash)a++;
        
        [abstract update:scores];
    }
    
    if(a && (a > numAvelebleSkills.text.intValue || a < numAvelebleSkills.text.intValue)){
        
        SKAction *actionOne = [SKAction scaleTo:1.5 duration:0.1];
        SKAction *actionTwo = [SKAction runBlock:^(){
            
            numAvelebleSkills.text = [NSString stringWithFormat:@"%i",a];
            fonForNumEvelebleSkills.hidden = 0;
            
        }];
        SKAction *actionTree = [SKAction scaleTo:1 duration:0.1];
        
        [fonForNumEvelebleSkills runAction:[SKAction sequence:@[actionTwo,actionOne,actionTree]]];
        
        
    }
    
    if(!a){fonForNumEvelebleSkills.hidden = 1; numAvelebleSkills.text = [NSString stringWithFormat:@"%i",a];}
    
    /////////////////////////////////////////////////////////////////////////
}

-(void)textureLevelUpdate
{
    NSMutableArray *bearWalkingFrames = [NSMutableArray array];
    SKTextureAtlas *bearAnimatedAtlas = [SKTextureAtlas atlasNamed:[NSString stringWithFormat:@"BearImages_%li",(long)level]]; //имя атласа
    NSUInteger numImages = bearAnimatedAtlas.textureNames.count;
    
    //изменить /2 на норм
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"bear%d", i]; //названия картинок
        SKTexture *temp = [bearAnimatedAtlas textureNamed:textureName];
        [bearWalkingFrames addObject:temp];
    }
    
    SKTexture *temp = bearWalkingFrames[0];
    
    [player runAction:[SKAction repeatActionForever:
                     [SKAction animateWithTextures:bearWalkingFrames
                                      timePerFrame:0.07f
                                            resize:YES
                                           restore:YES]] withKey:@"anim"];
}

//вызываем селект
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];
}

//селектим нод и отнимаем динамику
-(void)selectNodeForTouch:(CGPoint)touchLocation{
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    if(![selectedNode isEqual:touchedNode]) //чтобы не повторять выбор одного и того же предмета
    {
        selectedNode = touchedNode; //выбираем предмет
        
        if([[selectedNode name] isEqualToString:@"menuButton"])
        {
            SKAction *down = [SKAction scaleTo:0.9 duration:0.1];
            //[selectedNode setTexture:[SKTexture textureWithImageNamed:<#(nonnull NSString *)#>]];
            selectedNode.color = [UIColor yellowColor];
            selectedNode.colorBlendFactor = 1;
            [selectedNode runAction:down];
        }
    }
}

//задаем позицию ноду при перемещении
- (void)panForTranslation:(CGPoint)translation{
    CGPoint position = [selectedNode position];
    if([[selectedNode name] isEqualToString:nameForMove]) {
        
            [selectedNode setPosition:CGPointMake(selectedNode.position.x, position.y + translation.y)];
       
        if(selectedNode.position.y - selectedNode.size.height/2 > -100 )
        {
            selectedNode.position = CGPointMake(selectedNode.position.x, -100 + selectedNode.size.height/2);
        }
        
        if(selectedNode.position.y + selectedNode.size.height/2 < 417 )
        {
            selectedNode.position = CGPointMake(selectedNode.position.x, 417 - selectedNode.size.height/2);
        }
    }
    
}

//метод вызывается при движении предметов
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {  //вызываем постоянное уточнение позиции нода при перемещении
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    CGPoint previousPosition = [touch previousLocationInNode:self];
    
    //если мы двигаем кнопку, значит управление переходит к меню
    if([[selectedNode name] isEqualToString:@"cell-button"] && positionInScene.y != previousPosition.y)
    {
        selectedNode = menuNumberOne;
    }
    
    CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
    [self panForTranslation:translation];
}

//метод вызывается при окончании нажатия
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if([selectedNode.name isEqualToString:@"cell-button"]){
        
        for(int i = 0; i<skillCells.count;i++)
        {
            SkillCell *abstract = [skillCells objectAtIndex:i];
            
            if(abstract.fon.position.y == selectedNode.position.y)
            {
                [abstract push:&scores andDPS:&autoTupNum];
            }
        }
    }
    
    if([selectedNode.name isEqualToString:@"passiveCell-button"]){
        
        for(int i = 0; i<Passive_skillCells.count;i++)
        {
            PassiveSkillCell *abstract = [Passive_skillCells objectAtIndex:i];
            
            if(abstract.fon.position.y == selectedNode.position.y)
            {
                
                if(abstract.cellNumber == 0){[abstract DPSClick:&tupNum];}
                if(abstract.cellNumber == 1){[abstract petUp:&timeAutoclick];}
                if(abstract.cellNumber == 2){[abstract plusXPValueUp:&plusXPValue];}
                
            }
        }
    }
    
    //при нажатии на игрока повышается уровень
    if([selectedNode isEqual:player]){
        
        //умножаем на 10 ибо dps сделан на каждую милисекунду
        scores+= ((autoTupNum * 10)/100) * tupNum;

        if(autoTupNum < 1)scores++;
        
        levelProgress+=plusXPValue;
        
        if(levelProgress > maxLevelProgress){
            
            level++;

            levelProgress = levelProgress - maxLevelProgress;
            
            maxLevelProgress+=maxLevelProgress;
        
            levelLabel.text = [NSString stringWithFormat:@"%li",(long)level];
            
            [self textureLevelUpdate];
        }
        
        //mask1.size = CGSizeMake(100, 100);
        XPMaskCrop.size = CGSizeMake((900/maxLevelProgress)*levelProgress, XPMaskCrop.size.height);
        
    }
    
    //при нажатии на кнопку меню скилов, она открывается
    if([selectedNode isEqual:skillsMenu]){
        
        if(menuUpFlag && numMenu == 0)
        {
            [botomBorder runAction:menuDown];
            menuNumberOne.position = CGPointMake(0,- 150);
            menuUpFlag = 0;
        }
        else if(!menuUpFlag)
        {
            SKAction *hidden = [SKAction hide];
            SKAction *unHidden = [SKAction unhide];
            [menuNumberOne runAction:unHidden];
            [menuNumberTwo runAction:hidden];
            
            [botomBorder runAction:menuUp];
            menuUpFlag = 1;
            numMenu = 0;
        }else if(menuUpFlag && numMenu == 1)
        {
            
            [botomBorder runAction:upDown ];
            
        }
        
        
    }
    
    //при нажатии на дерево скилов, открывается дерево
    if([selectedNode isEqual:treeMenu]){
        if(menuUpFlag && numMenu == 1)
        {
            [botomBorder runAction:menuDown];
            menuUpFlag = 0;
        }
        else if(!menuUpFlag)
        {
            SKAction *hidden = [SKAction hide];
            SKAction *unHidden = [SKAction unhide];
            [menuNumberOne runAction:hidden];
            [menuNumberTwo runAction:unHidden];
            
            [botomBorder runAction:menuUp];
            menuUpFlag = 1;
            numMenu =1;
        } else if(menuUpFlag && numMenu == 0)
        {
            
            [botomBorder runAction:upDown ];
            
        }
    }
    
    if([[selectedNode name] isEqualToString:@"menuButton"]){
        SKAction *down = [SKAction scaleTo:1 duration:0.1];
        selectedNode.colorBlendFactor = 0;
        [selectedNode runAction:down];
    }

    selectedNode = nil;
}

-(void)update:(CFTimeInterval)currentTime {}

@end
