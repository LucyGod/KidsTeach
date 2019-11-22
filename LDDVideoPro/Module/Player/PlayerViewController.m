//
//  PlayerViewController.m
//  LDDVideoPro
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "PlayerViewController.h"
#import <MobileVLCKit/MobileVLCKit.h>
#import "Masonry.h"
#import <MediaPlayer/MediaPlayer.h>
#import "JKAlertDialog.h"
#define BrightnessStep 0.06f

@interface PlayerViewController ()<VLCMediaPlayerDelegate,UIGestureRecognizerDelegate>

//播放器视图
@property (strong, nonatomic)  UIView *mediaView;

//播放器
@property (nonatomic, strong) VLCMediaPlayer *player;


@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *rateBtn;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *fullBtn;
@property (nonatomic, strong) UIButton *lockBtn;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *totalTimeLabel;
@property (nonatomic, strong) UISlider *progressView;
@property (nonatomic, strong) UISlider *videoSlider;
@property (nonatomic, strong) CAGradientLayer *bottomGradientLayer;
@property (nonatomic, strong) CAGradientLayer *topGradientLayer;
@property (nonatomic ,strong) JKAlertDialog *alert ;

// 手势
@property(nonatomic, strong) UIPanGestureRecognizer *pan;
@property(nonatomic, strong) UITapGestureRecognizer *sliderTap;
@property(nonatomic, strong) UITapGestureRecognizer *tap;

//加载
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIImageView *loadingImage;

//进度条
@property (nonatomic ,assign)NSInteger totalTime;
@property (nonatomic ,assign) int touchEndValue;
@property (nonatomic, assign)CGPoint beginPoint;
@property (assign)NSInteger positionWhenTouched;
@property (assign)NSInteger positionWhenTouchEnd;
@property (nonatomic, assign)BOOL isQuickPlay;
@property (nonatomic, assign) BOOL isWiFi;

@property (nonatomic ,assign) BOOL isFullScreen;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil]; //监听是否重新进入程序程序.
}

- (void)applicationWillResignActive:(NSNotification *)notification

{
    [self.player stop];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    
}
#pragma Mark 添加视图
-(UIView *)mediaView
{
    if (!_mediaView) {
        _mediaView = [[UIView alloc] init];
        _mediaView.backgroundColor = [UIColor blackColor];
        //       _playerMaskView.isWiFi = YES; // 是否允许自动加载，
        //       _playerMaskView.titleLab.text = @"标题";
        [self.view addSubview:self.mediaView];
        [self.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).with.offset(0);
            make.height.equalTo(self->_mediaView.mas_width).multipliedBy(0.56);
        }];
        
        _isWiFi = YES;
        _isFullScreen = NO;
        [self setUI];
        [self initCAGradientLayer];
        
        [self cofigGestureRecognizer];
    }
    return _mediaView;
}
- (void)layoutSubviews {
    _topGradientLayer.frame = self.topView.bounds;
    _bottomGradientLayer.frame = self.bottomView.bounds;
}
#pragma mark -布局 mas
- (void)setUI {
    
    [self.mediaView.superview addSubview:self.backgroundImage];
    [self.backgroundImage addSubview:self.topView];
    [self.backgroundImage addSubview:self.bottomView];
    [self.backgroundImage addSubview:self.lockBtn];
    
    
    [_topView addSubview:self.titleLab];
    [_topView addSubview:self.backBtn];
    [_topView addSubview:self.rateBtn];
    [_bottomView addSubview:self.playBtn];
    [_bottomView addSubview:self.currentTimeLabel];
    [_bottomView addSubview:self.fullBtn];
    [_bottomView addSubview:self.videoSlider];
    [_bottomView addSubview:self.totalTimeLabel];
    [self.backgroundImage addSubview:self.loadingView];
    
    [_backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mediaView);
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.mediaView);
        make.top.equalTo(self.mediaView).with.offset(Status_H);
        make.height.mas_equalTo(30);
    }];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).with.offset(5);
        make.top.equalTo(self.topView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_rateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView).with.offset(-10);
        make.top.equalTo(self.topView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    [_lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mediaView).with.offset(15);
        make.centerY.equalTo(self.mediaView);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.topView);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.mediaView);
        make.height.mas_equalTo(40);
    }];
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).with.offset(20);
        make.bottom.equalTo(self.bottomView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [_currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playBtn.mas_right).with.offset(10);
        make.centerY.equalTo(self.playBtn);
        make.width.mas_equalTo(38);
    }];
    
    [_fullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView).with.offset(-20);
        make.centerY.equalTo(self.playBtn);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.fullBtn.mas_left).with.offset(-10);
        make.centerY.equalTo(self.playBtn);
    }];
    //    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.currentTimeLabel.mas_right).with.offset(10);
    //        make.right.equalTo(self.totalTimeLabel.mas_left).with.offset(-10);
    //        make.centerY.equalTo(self.playBtn);
    //    }];
    [_videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentTimeLabel.mas_right).with.offset(10);
        make.right.equalTo(self.totalTimeLabel.mas_left).with.offset(-10);
        make.centerY.equalTo(self.playBtn).with.offset(-1);
    }];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mediaView);
        make.centerY.equalTo(self.mediaView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 70));
    }];
}

- (void)cofigGestureRecognizer {
    
    _tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showOrHidden:)];
    _tap.delegate = self;
    [self.backgroundImage addGestureRecognizer:_tap];
    
    _sliderTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSlider:)];
    _sliderTap.delegate = self;
    [_videoSlider addGestureRecognizer:_sliderTap];
}

#pragma mark 屏幕添加手势 亮度 音量 加减
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.lockBtn.selected) {
        UITouch *touch = [touches anyObject];
        _beginPoint = [touch  locationInView:self.backgroundImage];
        _positionWhenTouched = _player.time.numberValue.integerValue;
        _isQuickPlay = NO;
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.lockBtn.selected)
    {
        UITouch *touch = [touches anyObject];
        CGPoint currPoint = [touch  locationInView:self.backgroundImage];
        [self startLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stopLoading];
        });
        CGFloat horizontal = currPoint.x - _beginPoint.x;
        CGFloat vertical = currPoint.y - _beginPoint.y;
        CGFloat l = sqrt(horizontal*horizontal+vertical*vertical);
        if (l<10) {
            [self stopLoading];
            return;
        }
        if(fabs(vertical) < 30 && fabs(horizontal) < 30){
            
        }else if (fabs(vertical) < 30 && fabs(horizontal) > 30) {
            //水平滑动
            _isQuickPlay = YES;
            CGFloat subVolumeValue = (currPoint.x - _beginPoint.x) / 10.0;
            _positionWhenTouchEnd = _positionWhenTouched + subVolumeValue * 1000;
            if (_positionWhenTouchEnd < 0) {
                _positionWhenTouchEnd = 0;
            }
            VLCTime *vlcTime = [VLCTime timeWithInt:(int)_positionWhenTouchEnd];
            VLCTime *vlcTotalTime = [VLCTime timeWithInt:(int)self.totalTime];
            _currentTimeLabel.text = vlcTime.stringValue;
            _totalTimeLabel.text = vlcTotalTime.stringValue;
            return;
        } else if (fabs(horizontal) < 30 && fabs(vertical) > 30){
            if ((currPoint.x > self.backgroundImage.size.width*0.5)) {
                //        竖直滑动，调节音量
                MPMusicPlayerController *volumeControl = [MPMusicPlayerController applicationMusicPlayer];
                CGPoint previousPoint = [touch previousLocationInView:self.backgroundImage];
                CGFloat subVolumeValue = (previousPoint.y - currPoint.y) / 100.0;
                static CGFloat volumeValue = 0;
                
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
                volumeValue = volumeControl.volume;
                volumeValue += subVolumeValue;
                if (volumeValue > 1) {
                    volumeValue = 1.0;
                }
                
                if (volumeValue < 0) {
                    volumeValue = 0.0;
                }
                volumeControl.volume = volumeValue;
#pragma clang diagnostic pop
                _isQuickPlay = NO;
                return;
            }
            else
            {
                if (horizontal < 0) {
                    [self brightnessAdd:-BrightnessStep];
                }else{
                    [self brightnessAdd:BrightnessStep];
                }
            }
            
        }else {
            _isQuickPlay = NO;
        }
    }
    
}
- (void)brightnessAdd:(CGFloat)step{
    [UIScreen mainScreen].brightness += step;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(_isQuickPlay && !self.lockBtn.selected) {
        [self stopLoading];
        VLCTime *time = [VLCTime timeWithInt:(int)_positionWhenTouchEnd];
        _player.time = time;
    }
}


#pragma mark - public method

#pragma 外界播放
- (void)playWithVideoUrl:(NSString *)videoUrl {
    _player = [[VLCMediaPlayer alloc] initWithOptions:nil];
    _player.drawable = self.mediaView;
    _player.delegate = self;
    [_player stop];
    VLCMedia *media = [VLCMedia mediaWithURL:[NSURL URLWithString:videoUrl]];
    [_player setMedia:media];
    if (videoUrl && videoUrl.length > 0) {
        self.videoSlider.value = 0;
        _currentTimeLabel.text = @"00:00";
    }
    _totalTimeLabel.text = @"00:00";
    [self startLoading];
    [_player play];
}
-(void)playWithVideoFilePath:(NSString *)FilePath
{
    _player = [[VLCMediaPlayer alloc] initWithOptions:nil];
    _player.drawable = self.mediaView;
    _player.delegate = self;
    [_player stop];
    
    VLCMedia *media = [VLCMedia mediaWithPath:FilePath];
    [_player setMedia:media];
    _totalTimeLabel.text = @"00:00";
    [self startLoading];
    [_player play];
}
- (NSArray*)compareFilePath:(NSString*)filePath
{
    NSArray *arr = [filePath componentsSeparatedByString:@"."];
    return arr;
}
#pragma mark - private method
- (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName {
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"PlayerImage.bundle"];
    NSString *img_path = [bundlePath stringByAppendingPathComponent:imgName];
    return [UIImage imageWithContentsOfFile:img_path];
}
- (void)playWithJudgeNet {
    if (_isWiFi) {
        [_player play];
    }else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示"
                                                                        message:@"您正处于移动网络环境下，是否要使用流量播放"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.isWiFi = YES;
            [self.player play];
        }]];
        [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self.playBtn.selected = NO;
        }]];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertC animated:YES completion:nil];
    }
}
#pragma mark - -- KVO监听
- (void)addObserver
{
    [_player addObserver:self forKeyPath:@"remainingTime" options:0 context:nil];
    [_player addObserver:self forKeyPath:@"isPlaying" options:0 context:nil];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addObserver];
}

- (void)removeObserver
{
    [_player removeObserver:self forKeyPath:@"remainingTime"];
    [_player removeObserver:self forKeyPath:@"isPlaying"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    [self updateTime];
}
#pragma  mark - -- vlcPlayerView时间和进度刷新
- (void)updateTime
{
    VLCTime *vlcTotalTime = [VLCTime timeWithInt:(int)self.totalTime];
    if (![[[_player time] stringValue] isEqualToString:@"--:--"]) {
        self.currentTimeLabel.text = [[_player time] stringValue];
    }
    else
    {
        self.currentTimeLabel.text = @"00:00";
    }
    self.totalTimeLabel.text = vlcTotalTime.stringValue;
    self.videoSlider.value = [_player position];
}
- (NSInteger)totalTime{
    if (_totalTime <= 0) {
        _totalTime =  _player.media.length.numberValue.integerValue;
    }
    return _totalTime;
}
#pragma mark - slider事件
- (void)progressSliderTouchBegan:(UISlider *)slider {
    if (slider == self.progressView) {
        return;
    }
    [_player pause];
    [self startLoading];
    [self showOrHideWith:YES];
}
- (void)progressSliderValueChanged:(UISlider *)slider {
    if (slider == self.progressView) {
        CGFloat progressValue = _progressView.value;
        [self fastForwardAtRate:progressValue];
        _alert.labelTitle.text = [NSString stringWithFormat:@"当前速率：%.1f",progressValue];
          return;
      }
    if (!_player.isPlaying) {
        [_player play];
    }
    CGFloat progressValue = _videoSlider.value;
    _touchEndValue = self.totalTime * progressValue;
    VLCTime *vlcTime = [VLCTime timeWithInt:(int)_touchEndValue];
    VLCTime *vlcTotalTime = [VLCTime timeWithInt:(int)self.totalTime];
    if (![vlcTime.stringValue isEqualToString:@"--:--"]) {
        self.currentTimeLabel.text = vlcTime.stringValue;
    }
    else
    {
        self.currentTimeLabel.text = @"00:00";
    }
    _totalTimeLabel.text = vlcTotalTime.stringValue;
    
}
- (void)progressSliderTouchEnded:(UISlider *)slider {
    if (slider == self.progressView) {
          
          return;
      }
    if (!self.lockBtn.selected) {
        if (_player.state != VLCMediaPlayerStatePlaying) {
            return;
        }
        //
        VLCTime *vlcTime = [VLCTime timeWithInt:_touchEndValue];
        _player.time = vlcTime;
        [self stopLoading];
        [self hidePlayerSubviewWithTimer];
    }
    
}

- (void)tapSlider:(UITapGestureRecognizer *)tap {
    if (!self.lockBtn.selected)
    {
        [self progressSliderTouchBegan:self.videoSlider];
        CGPoint point = [tap locationInView:tap.view];
        CGFloat value = point.x/ tap.view.frame.size.width;
        self.videoSlider.value = value;
        [self progressSliderValueChanged:self.videoSlider];
        [self progressSliderTouchEnded:self.videoSlider];
    }
    
}
#pragma mark - VLCMediaPlayerDelegate

#pragma mark 播放状态改变的回调
- (void)mediaPlayerStateChanged:(NSNotification *)aNotification{
    NSLog(@"状态：%ld",(long)_player.state);
    VLCMediaPlayerState currentState = _player.state;
    switch (currentState) {
        case VLCMediaPlayerStateEnded://3
        {
            [self stopLoading];
            _playBtn.selected = NO;
            _currentTimeLabel.text = @"00:00";
            [_videoSlider setValue:0 animated:YES];
        }
            break;
        case VLCMediaPlayerStateBuffering://2
        {
            _playBtn.selected = YES;
            [self showPlayerSubview];
            if (_player.playing) {
                [self stopLoading];
            }
        }
            break;
        case VLCMediaPlayerStatePaused://6
        {
            _playBtn.selected = NO;
            
            [self stopLoading];
        }
            break;
        case VLCMediaPlayerStatePlaying://5
        {
            _playBtn.selected = YES;
            self.loadingView.hidden = YES;
        }
            break;
        case VLCMediaPlayerStateError://4
        {
            [self stopLoading];
            _playBtn.selected = NO;
            _currentTimeLabel.text = @"00:00";
            [_videoSlider setValue:0 animated:YES];
            [self showPlayerSubview];
        }
            break;
        case VLCMediaPlayerStateStopped://0
        {
            [self.player stop];
            _playBtn.selected = NO;
            _currentTimeLabel.text = @"00:00";
            [_videoSlider setValue:0 animated:YES];
            VLCTime *time = [VLCTime timeWithInt:0];
            _player.time = time;
        }
            break;
        case VLCMediaPlayerStateOpening: {//1
            
            break;
        }
        case VLCMediaPlayerStateESAdded: {//7
            
            {
                _playBtn.selected = YES;
                //                [self stopLoading];
                [self hidePlayerSubviewWithTimer];
            }
            break;
        }
    }
}

//播放时间改变的回调
- (void)mediaPlayerTimeChanged:(NSNotification *)aNotification{
    _currentTimeLabel.text = _player.time.stringValue;
    [_videoSlider setValue:_player.position animated:YES];
}
#pragma mark - Events
// 是否显示控件
- (void)showOrHideWith:(BOOL)isShow {
    if (!self.lockBtn.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomView.hidden = !isShow;
            self.topView.hidden = !isShow;
        }];
    }
    else
    {
        self.bottomView.hidden = YES;
        self.topView.hidden = YES;
    }
}

// 开始加载
- (void)startLoading {
    if (_player.isPlaying) {
        [self stopLoading];
    }
    self.loadingView.hidden = NO;
    self.loadingImage.hidden = NO;
    self.loadingImage.image = [self imagesNamedFromCustomBundle:@"icon_video_loading"];
    if (![self.loadingImage.layer animationForKey:@"loading"]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: M_PI *2];
        animation.duration = 3;
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT;
        [self.loadingImage.layer addAnimation:animation forKey:@"loading"];
    }
}
- (void)stopLoading {
    self.loadingView.hidden = YES;
    self.loadingImage.hidden = YES;
    [self.loadingImage.layer removeAnimationForKey:@"loading"];
}

- (void)hidePlayerSubviewWithTimer {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showOrHideWith:NO];
    });
    
}
#pragma mark 隐藏底部试图
- (void) hidePlayerSubview {
    if (!_player.isPlaying) {
        return;
    }
    [self showOrHideWith:NO];
}
#pragma mark 显示底部试图
- (void)showPlayerSubview {
    [self showOrHideWith:YES];
    if (_player.isPlaying) {
    }
}

#pragma mark - 手势 和按钮事件
- (void)showOrHidden:(UITapGestureRecognizer *)gr {
    if (_player.isPlaying) {
        if (_bottomView.hidden) {
            [self showPlayerSubview];
        }else {
            [self hidePlayerSubview];
        }
    }
}
#pragma mark - 按钮事件
#pragma mark 播放按钮事件
- (void)startAndPause:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [self playWithJudgeNet];
    }else {
        [_player pause];
    }
}
#pragma mark lodingView上的View点击手势 暂停后，点击播放
- (void)play {
    if (!_player.isPlaying) {
        [self playWithJudgeNet];
    }
}

- (void)stopVideo
{
    if (_player) {
        [_player stop];
        _player = nil;
    }
}
- (void)fastForwardAtRate:(float)rate
{
    [_player fastForwardAtRate:rate];
}
-(void)rateDown
{
    _alert = [[JKAlertDialog alloc]initWithTitle:[NSString stringWithFormat:@"当前速率：%.1f",_player.rate] message:@""];
    _alert.contentView =  self.progressView;
    [_alert addButton:Button_OTHER withTitle:@"恢复默认" handler:^(JKAlertDialogItem *item) {
        self.progressView.value = 0;
        [self fastForwardAtRate:1.0];
        self->_alert.labelTitle.text = [NSString stringWithFormat:@"当前速率：1.0"];
    }];
    
    [_alert addButton:Button_OTHER withTitle:@"确定" handler:^(JKAlertDialogItem *item) {
        
    }];
    
    [_alert show];
}
#pragma mark/** 全屏 和退出全屏 */
- (void)backDown
{
    if (_isFullScreen == NO) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self stopVideo];
        }];
    }else {
        UIDeviceOrientation orientation;
        _fullBtn.selected  = !_fullBtn.selected;
        if (_fullBtn.selected == YES) {
            orientation = UIDeviceOrientationLandscapeLeft;
            NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
            [[UIDevice currentDevice]setValue:value forKey:@"orientation"];
            _isFullScreen = YES;
        }else {
            orientation = UIDeviceOrientationPortrait;
            NSNumber *value = [NSNumber numberWithInt:UIDeviceOrientationPortrait];
            [[UIDevice currentDevice]setValue:value forKey:@"orientation"];
            _isFullScreen = NO;
        }
    }
}
- (void)videoFullAction {
    
    UIDeviceOrientation orientation;
    _fullBtn.selected  = !_fullBtn.selected;
    if (_fullBtn.selected == YES) {
        orientation = UIDeviceOrientationLandscapeLeft;
        _isFullScreen = YES;
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice]setValue:value forKey:@"orientation"];
    }else {
        orientation = UIDeviceOrientationPortrait;
        NSNumber *value = [NSNumber numberWithInt:UIDeviceOrientationPortrait];
        [[UIDevice currentDevice]setValue:value forKey:@"orientation"];
        _isFullScreen = NO;
    }
}

#pragma mark - Getter & Setter SetUI

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
    }
    return _topView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"";
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}
- (UIButton *)rateBtn {
    if (!_rateBtn) {
        _rateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rateBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_rateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rateBtn setTitle:@"倍速" forState:UIControlStateNormal];
        _rateBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
        _rateBtn.layer.masksToBounds = YES;
        _rateBtn.layer.cornerRadius = 5;
        [_rateBtn addTarget:self action:@selector(rateDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rateBtn;
}
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_backBtn setImage:[self imagesNamedFromCustomBundle:@"icon_back_white"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.frame = CGRectMake(0, 0, 21, 21);
        [_playBtn setImage:[self imagesNamedFromCustomBundle:@"icon_video_play"] forState:UIControlStateNormal];
        [_playBtn setImage:[self imagesNamedFromCustomBundle:@"icon_video_stop"] forState:UIControlStateSelected];
        [_playBtn addTarget:self action:@selector(startAndPause:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
- (UIButton *)lockBtn {
    if (!_lockBtn) {
        _lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lockBtn setImage:[self imagesNamedFromCustomBundle:@"ic_sp_bf"] forState:UIControlStateNormal];
        [_lockBtn setImage:[self imagesNamedFromCustomBundle:@"ic_ks_bf"] forState:UIControlStateSelected];
        [_lockBtn addTarget:self action:@selector(lockClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lockBtn;
}
- (void)lockClick
{
    self.lockBtn.selected = !self.lockBtn.selected;
    if (self.lockBtn.selected) {
        self.loadingImage.userInteractionEnabled = NO;
        [self showOrHideWith:NO];
        
    } else {
        self.loadingImage.userInteractionEnabled = YES;
        [self showOrHideWith:YES];
    }
}
- (UIButton *)fullBtn {
    if (!_fullBtn) {
        _fullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fullBtn.frame = CGRectMake(0, 0, 21, 21);
        [_fullBtn setImage:[self imagesNamedFromCustomBundle:@"icon_video_fullscreen"] forState:UIControlStateNormal];
        [_fullBtn setImage:[self imagesNamedFromCustomBundle:@"line_normal"] forState:UIControlStateSelected];
        [_fullBtn addTarget:self action:@selector(videoFullAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullBtn;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}
- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc]init];
        _currentTimeLabel.text = @"00:00";
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
        _currentTimeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _currentTimeLabel;
}
- (UILabel *)totalTimeLabel {
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc]init];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        _totalTimeLabel.font = [UIFont systemFontOfSize:11];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.text = @"00:00";
    }
    return _totalTimeLabel;
}
- (UISlider *)progressView {
    if (!_progressView) {
        _progressView = [[UISlider alloc]initWithFrame:CGRectMake(0, 20, 270, 10)];
        [_progressView setThumbImage:[self imagesNamedFromCustomBundle:@"spot"] forState:UIControlStateNormal];
        _progressView.minimumTrackTintColor = [UIColor systemBlueColor];
        _progressView.maximumTrackTintColor = [UIColor colorWithWhite:0.5 alpha:0.6];;
        _progressView.minimumValue = 1.0;
        _progressView.maximumValue = 4.0;
        // slider开始滑动事件
        [_progressView addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_progressView addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventTouchDragInside];
        // slider结束滑动事件
        [_progressView addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
    }
    return _progressView;
}
- (UISlider *)videoSlider {
    if (!_videoSlider) {
        _videoSlider = [[UISlider alloc]init];
        [_videoSlider setThumbImage:[self imagesNamedFromCustomBundle:@"icon_video_spot"] forState:UIControlStateNormal];
        _videoSlider.minimumTrackTintColor = [UIColor colorWithWhite:1 alpha:0.6];
        _videoSlider.maximumTrackTintColor = [UIColor colorWithWhite:0.5 alpha:0.6];
        // slider开始滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_videoSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventTouchDragInside];
        // slider结束滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
    }
    return _videoSlider;
}
- (UIView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        _loadingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _loadingView.layer.cornerRadius = 7;
        
        [_loadingView addSubview:self.loadingImage];
        [_loadingImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self->_loadingView);
            make.size.mas_equalTo(CGSizeMake(31, 31));
        }];
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(play)];
        //        [_loadingView addGestureRecognizer:tap];
    }
    return _loadingView;
}
- (void)initCAGradientLayer {
    //初始化Bottom渐变层
    self.bottomGradientLayer            = [CAGradientLayer layer];
    [self.bottomView.layer insertSublayer:self.bottomGradientLayer atIndex:0];
    //设置渐变颜色方向
    self.bottomGradientLayer.startPoint = CGPointMake(0, 0);
    self.bottomGradientLayer.endPoint   = CGPointMake(0, 1);
    //设定颜色组
    self.bottomGradientLayer.colors     = @[(__bridge id)[UIColor colorWithWhite:0 alpha:0.0].CGColor,
                                            (__bridge id)[UIColor colorWithWhite:0 alpha:0.5].CGColor];
    //设定颜色分割点
    self.bottomGradientLayer.locations  = @[@(0.0f) ,@(1.0f)];
    
    
    //初始Top化渐变层
    self.topGradientLayer               = [CAGradientLayer layer];
    [self.topView.layer insertSublayer:self.topGradientLayer atIndex:0];
    //设置渐变颜色方向
    self.topGradientLayer.startPoint    = CGPointMake(1, 0);
    self.topGradientLayer.endPoint      = CGPointMake(1, 1);
    //设定颜色组
    self.topGradientLayer.colors        = @[ (__bridge id)[UIColor colorWithWhite:0 alpha:0.5].CGColor,
                                             (__bridge id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
    //设定颜色分割点
    self.topGradientLayer.locations     = @[@(0.0f) ,@(1.0f)];
    
}

- (UIImageView *)loadingImage {
    if (!_loadingImage ){
        _loadingImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 31)];
        _loadingImage.image = [self imagesNamedFromCustomBundle:@"icon_video_play"];
        _loadingImage.userInteractionEnabled = YES;
    }
    return _loadingImage;
}
- (UIImageView *)backgroundImage {
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] initWithFrame:self.mediaView.bounds];
        _backgroundImage.userInteractionEnabled = YES;
        _backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImage;
}

#pragma mark - 屏幕旋转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator  {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationPortrait || orientation
        == UIDeviceOrientationPortraitUpsideDown) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [_mediaView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).with.offset(0);;
            make.height.equalTo(self->_mediaView.mas_width).multipliedBy(0.56);
        }];
    }else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [_mediaView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}
- (void)dealloc {
    NSLog(@"pppppppppppppppppppppppp");
    [self removeObserver];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_player stop];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.allowRotation = NO;
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.allowRotation = YES;
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
