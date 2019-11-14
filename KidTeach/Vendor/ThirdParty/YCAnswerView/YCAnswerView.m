//
//  YCAnswerView.m
//  计算器
//
//  Created by 王月超 on 2018/2/7.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "YCAnswerView.h"
#import "SDAutoLayout.h"
#define PhoneScreen_WIDTH ([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width:[UIScreen mainScreen].bounds.size.height)
#define WidthRate  PhoneScreen_WIDTH/375
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
@interface YCAnswerView (){
    NSInteger _firstNumber; //第一次选择的数字
    NSInteger _secondNumber;//第二次选择的数字
    NSInteger _indexCount;  //表示第几次选择数字
}

@property (nonatomic,strong)UIImageView *bgView;
@property (nonatomic,strong)UILabel *textLB;
@property (nonatomic,strong)UILabel *number1;
@property (nonatomic,strong)UILabel *xLB;
@property (nonatomic,strong)UILabel *DLB;
@property (nonatomic,strong)UILabel *number2;
@property (nonatomic,strong)UIButton *resultNumber;
@property (nonatomic,strong)UIView *numberBg;
@property (nonatomic,strong)UIButton *backBtn;


@end


@implementation YCAnswerView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _indexCount = 0;
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        self.userInteractionEnabled = YES;
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.textLB];
        [self.bgView addSubview:self.number1];
        [self.bgView addSubview:self.xLB];
        [self.bgView addSubview:self.number2];
        [self.bgView addSubview:self.DLB];
        [self.bgView addSubview:self.resultNumber];
        [self.bgView addSubview:self.numberBg];
        [self setBtnUI];
        [self getRandomNumber];
    }
    return self;
}
- (void)setBtnUI{
    //i是行 j是列
    static NSInteger index;
    for (int i = 0; i<3; i++) {
        for (int j = 0; j<4; j++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            index = j+i*4;
            btn.tag = j+i*4+10016;
            [btn addTarget:self action:@selector(selectedNumber:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer_number"] forState:UIControlStateNormal];
            if (index <= 2) {
                [btn setTitle:[NSString stringWithFormat:@"%ld",index+1] forState:UIControlStateNormal];
            }else if (index == 3){
                [btn setTitle:@"0" forState:UIControlStateNormal];
            }else if (index <= 7){
                [btn setTitle:[NSString stringWithFormat:@"%ld",index] forState:UIControlStateNormal];
            }else{
                [btn setTitle:[NSString stringWithFormat:@"%ld",index-1] forState:UIControlStateNormal];
            }
            if (index == 7||index == 11) {
                btn.hidden = YES;
            }
            [self.numberBg addSubview:btn];
        }
    }
    [self.numberBg addSubview:self.backBtn];
}
- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark ==========Function==========
- (void)backBtnClick{
    self.hidden = YES;
}
- (void)selectedNumber:(UIButton *)sender{
    NSInteger tag = sender.tag - 10016;
    NSInteger index;
    _indexCount ++;
    index = tag;
    if (tag <= 2) {
        index = tag+1;
    }else if (tag == 3){
        index = 0;
    }else if (tag <= 7){
        index = tag;
    }else{
        index = tag - 1;
    }
    if (_indexCount == 1) {
        _firstNumber = index*10;
        [self.resultNumber setTitle:[NSString stringWithFormat:@"%ld",index] forState:UIControlStateNormal];
    }
    if (_indexCount == 2) {
        _secondNumber = index;
        if ([self.number1.text integerValue]*[self.number2.text integerValue] == _firstNumber+_secondNumber) {
            [self changeAnswerState];
            if (self.resultBlock) {
                self.resultBlock();
            }
            [self backBtnClick];
        }else{
            [self changeAnswerState];
        }
    }
    
}
- (void)getRandomNumber{
    NSInteger number1 = (arc4random() % 6) + 4;
    NSInteger number2 = (arc4random() % 6) + 4;
    self.number1.text = [NSString stringWithFormat:@"%ld",number1];
    self.number2.text = [NSString stringWithFormat:@"%ld",number2];
}
- (void)changeAnswerState{
    _indexCount = 0;
    [self.resultNumber setTitle:@"" forState:UIControlStateNormal];
    [self getRandomNumber];
}
#pragma mark ==========SetUI==========
- (void)layoutSubviews{
    [super layoutSubviews];
    self.bgView.center = self.center;
    self.bgView.bounds = CGRectMake(0, 0, self.bgView.image.size.width*WidthRate, self.bgView.image.size.height*WidthRate);
    
    self.textLB.sd_layout
    .leftSpaceToView(self.bgView, 17*WidthRate)
    .topSpaceToView(self.bgView, 14*WidthRate)
    .heightIs(12*WidthRate);
    [self.textLB setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    self.number1.sd_layout
    .leftSpaceToView(self.bgView, 65*WidthRate)
    .topSpaceToView(self.bgView, 48*WidthRate)
    .heightIs(15*WidthRate)
    .widthIs(15*WidthRate);
    self.xLB.sd_layout
    .leftSpaceToView(self.number1, 0)
    .centerYEqualToView(self.number1)
    .heightIs(15*WidthRate)
    .widthIs(10*WidthRate);
    self.number2.sd_layout
    .leftSpaceToView(self.xLB, 0)
    .centerYEqualToView(self.xLB)
    .heightIs(15*WidthRate)
    .widthIs(15*WidthRate);
    self.DLB.sd_layout
    .leftSpaceToView(self.number2, 0)
    .centerYEqualToView(self.number2)
    .heightIs(15*WidthRate)
    .widthIs(10*WidthRate);
    
    self.resultNumber.sd_layout
    .leftSpaceToView(self.DLB, 5*WidthRate)
    .centerYEqualToView(self.DLB)
    .heightIs(self.resultNumber.currentBackgroundImage.size.height*WidthRate)
    .widthIs(self.resultNumber.currentBackgroundImage.size.width*WidthRate);
    
    
    self.numberBg.sd_layout
    .leftSpaceToView(self.bgView, 15*WidthRate)
    .rightSpaceToView(self.bgView, 15*WidthRate)
    .bottomSpaceToView(self.bgView, 17*WidthRate)
    .topSpaceToView(self.bgView, 84*WidthRate);
    
    CGFloat btnHeight = 44*WidthRate;
    CGFloat btnWidth = 44*WidthRate;
    CGFloat btnHmargin = 2.5*WidthRate;
    CGFloat btnVmargin = 2.5*WidthRate;
    static NSInteger index;
    for (int i = 0; i<3; i++) {
        for (int j = 0; j<4; j++) {
            index = j+i*4+10016;
            UIButton *btn =(UIButton *) [self.numberBg viewWithTag:index];
            btn.frame = CGRectMake(1*WidthRate+(btnWidth+btnHmargin)*j, 1*WidthRate+(btnHeight+btnVmargin)*i, btnWidth, btnHeight);
        }
    }
    
    self.backBtn.sd_layout
    .rightSpaceToView(self.numberBg, 1*WidthRate)
    .bottomSpaceToView(self.numberBg, 1*WidthRate)
    .heightIs(self.backBtn.currentBackgroundImage.size.height*WidthRate)
    .widthIs(self.backBtn.currentBackgroundImage.size.width*WidthRate);
}
#pragma mark ==========Lazy==========
- (UIImageView *)bgView{
    if(!_bgView){
        _bgView = [[UIImageView alloc]init];
        _bgView.image = [UIImage imageNamed:@"area_answer"];
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}
- (UILabel *)textLB{
    if(!_textLB){
        _textLB = [[UILabel alloc]init];
        _textLB.text = @"请确认你是家长:";
        _textLB.textColor = RGBA(116, 103, 34, 1);
        _textLB.font = [UIFont systemFontOfSize:10*WidthRate];
    }
    return _textLB;
}
- (UILabel *)number1{
    if(!_number1){
        _number1 = [[UILabel alloc]init];
        _number1.text = @"4";
        _number1.textAlignment = NSTextAlignmentCenter;
        _number1.textColor = RGBA(150, 99, 21, 1);
        _number1.font = [UIFont systemFontOfSize:16*WidthRate];
        
    }
    return _number1;
}
- (UILabel *)number2{
    if(!_number2){
        _number2 = [[UILabel alloc]init];
        _number2.text = @"4";
        _number2.textAlignment = NSTextAlignmentCenter;
        _number2.textColor = RGBA(150, 99, 21, 1);
        _number2.font = [UIFont systemFontOfSize:16*WidthRate];
        
    }
    return _number2;
}
- (UIButton *)resultNumber{
    if(!_resultNumber){
        _resultNumber = [UIButton buttonWithType:UIButtonTypeCustom];
        _resultNumber.userInteractionEnabled = NO;
        [_resultNumber setTitleColor:RGBA(150, 99, 21, 1) forState:UIControlStateNormal];
        _resultNumber.titleLabel.font = [UIFont systemFontOfSize:16*WidthRate];
        [_resultNumber setBackgroundImage:[UIImage imageNamed:@"result_answer"] forState:UIControlStateNormal];
    }
    return _resultNumber;
}
- (UILabel *)xLB{
    if(!_xLB){
        _xLB = [[UILabel alloc]init];
        _xLB.text = @"×";
        _xLB.textAlignment = NSTextAlignmentCenter;
        _xLB.textColor = RGBA(150, 99, 21, 1);
        _xLB.font = [UIFont fontWithName:@"Arial" size:16*WidthRate];
    }
    return _xLB ;
}
- (UILabel *)DLB{
    if(!_DLB){
        _DLB = [[UILabel alloc]init];
        _DLB.text = @"=";
        _DLB.textAlignment = NSTextAlignmentCenter;
        _DLB.textColor = RGBA(150, 99, 21, 1);
        _DLB.font =  [UIFont fontWithName:@"Arial" size:16*WidthRate];
    }
    return _DLB;
}
- (UIView *)numberBg{
    if(!_numberBg){
        _numberBg = [[UIView alloc]init];
        _numberBg.backgroundColor = [UIColor clearColor];
        _numberBg.userInteractionEnabled = YES;
    }
    return _numberBg;
}
- (UIButton *)backBtn{
    if(!_backBtn){
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer_quit"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setTitle:@"退\n出" forState:UIControlStateNormal];
        [_backBtn setTitleColor:RGBA(91, 81, 27, 1) forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:12*WidthRate];
        _backBtn.titleLabel.numberOfLines = 0;
    }
    return _backBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
