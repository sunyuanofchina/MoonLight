//
//  LightViewController.h
//  MoonLight
//
//  Created by chen Jaykie on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
//#import "AdMoGoView.h"
#import "SettingViewController.h"
@interface LightViewController : UIViewController //<AdMoGoDelegate>
{
    int shineFreq;
    NSTimer *timerShine;
    bool enableShine;
    bool isShineOn;
    //AdMoGoView *adView;
}
@property  bool isLightOn;
@property (nonatomic,retain) IBOutlet UIButton *btnOnOff;
@property (nonatomic,retain) IBOutlet UIButton *btnSetting;
@property (nonatomic,retain) IBOutlet UIButton *btnShine;
@property (nonatomic,retain) IBOutlet UILabel *labelFreq;
@property (nonatomic,retain) IBOutlet UISlider *sliderFreq;
@property (nonatomic,retain) IBOutlet UISwitch  *switchShine;

-(void) turnOnLed:(bool)update;
-(void) turnOffLed:(bool)update;
-(IBAction)onBtnOnOff:(id)sender;
-(IBAction)onBtnOnOffDown:(id)sender;
-(IBAction)onBtnSetting:(id)sender;
-(IBAction)onBtnSettingDown:(id)sender;
-(IBAction)onBtnShine:(id)sender;
- (IBAction) SliderProgressChanged:(id)sender;
- (IBAction) SliderProgressUp:(id)sender;
-(IBAction)onSwitch:(id)sender;
@end
