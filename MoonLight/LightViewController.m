//
//  LightViewController.m
//  MoonLight
//
//  Created by chen Jaykie on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LightViewController.h"

@implementation LightViewController
@synthesize isLightOn;
@synthesize btnOnOff;
@synthesize btnSetting;
@synthesize btnShine;
@synthesize labelFreq;
@synthesize sliderFreq;
@synthesize switchShine;

#define MIN_FREQ   1
#define MAX_FREQ   10

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"light";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   isLightOn = YES;
    shineFreq = MIN_FREQ;
    labelFreq.text = [NSString stringWithFormat:@"%dhz",shineFreq];
    sliderFreq.value = shineFreq*1.0/(MAX_FREQ-MIN_FREQ);
    
    switchShine.on = enableShine;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];  
    if (![device hasTorch]) {  
        //没有闪光灯
        
#if 1
        
        //NSString *strAlert = NSLocalizedString(@"add_joke_to_love",nil);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"闪光灯" message:@"抱歉，该设备没有闪光灯而无法使用手电筒功能！" delegate:nil 
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        
        [alert show];
        //[self performSelector:@selector(dimissAddAlert:) withObject:alert afterDelay:1.0];
        [alert release];
#endif
        
    } 
    
    
    
   [self turnOnLed:YES];
/*#if 1
    adView = [AdMoGoView requestAdMoGoViewWithDelegate:self AndAdType:AdViewTypeNormalBanner];
    [adView setFrame:CGRectZero];
    [self.view addSubview:adView];	
#endif */ 
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
   // adView.delegate = nil;
   // adView = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) turnOnLed:(bool)update
{  

    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];  
    if ([device hasTorch]) {  
        [device lockForConfiguration:nil];  
        [device setTorchMode: AVCaptureTorchModeOn];  
        [device unlockForConfiguration];  
    }  
    if (update) 
    {
        [btnOnOff setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
    }
    
 
}  
-(void) turnOffLed:(bool)update 
{  
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];  
    if ([device hasTorch]) {  
        [device lockForConfiguration:nil];  
        [device setTorchMode: AVCaptureTorchModeOff];  
        [device unlockForConfiguration];  
    }  
     if (update) 
     {
         [btnOnOff setImage:[UIImage imageNamed:@"BtnOff.png"] forState:UIControlStateNormal];
     }
} 

-(IBAction)onBtnOnOff:(id)sender
{
    

    if (isShineOn) {
        [self onBtnShine:nil];
    }else{
    isLightOn = 1-isLightOn;
    if (isLightOn) {
        [self turnOnLed:YES];
    }else{
        [self turnOffLed:YES];
    }
    }

}

-(IBAction)onBtnSetting:(id)sender
{
    SettingViewController *settingViewController = [[SettingViewController alloc]init];
    [self presentModalViewController:settingViewController animated:YES];
    [settingViewController release];
    
}


-(IBAction)onBtnOnOffDown:(id)sender
{


}

-(IBAction)onBtnSettingDown:(id)sender
{


}

-(IBAction)onSwitch:(id)sender
{
    UISwitch *uiSwitch = (UISwitch *)sender;
  
    enableShine = uiSwitch.on;
     
    {
       
        if (!enableShine) 
        {
            
            if (sender) 
            {
                if (isLightOn) {
                    [self turnOnLed:YES];
                }else{
                    [self turnOffLed:YES];
                }
                isShineOn = NO;
            }else{
                isLightOn = NO;
                [self turnOffLed:YES];
                [btnOnOff setImage:[UIImage imageNamed:@"BtnOff.png"] forState:UIControlStateNormal];
            }
            
        }else{
            //闪锁
            if (sender) 
            {
                isShineOn = YES;
            }
            else{
                [btnOnOff setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
            }
            isLightOn = YES;
            [self turnOnLed:YES];
        }
        
        if (enableShine) {
            [btnShine setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
        }else{
            [btnShine setImage:[UIImage imageNamed:@"BtnOff.png"] forState:UIControlStateNormal];
            
        }
        [self SliderProgressUp:nil];
        
    }
    
}


-(IBAction)onBtnShine:(id)sender
{
    enableShine = 1-enableShine;
    if (!enableShine) 
    {

        if (sender) 
        {
            if (isLightOn) {
                [self turnOnLed:YES];
            }else{
                [self turnOffLed:YES];
            }
            isShineOn = NO;
        }else{
            isLightOn = NO;
            [self turnOffLed:YES];
           [btnOnOff setImage:[UIImage imageNamed:@"BtnOff.png"] forState:UIControlStateNormal];
            switchShine.on = enableShine;
        }
        
    }else{
        //闪锁
         if (sender) 
         {
        isShineOn = YES;
         }
         else{
        [btnOnOff setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
             switchShine.on = enableShine;
         }
        isLightOn = YES;
     [self turnOnLed:YES];
    }
    
    if (enableShine) {
        [btnShine setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
    }else{
        [btnShine setImage:[UIImage imageNamed:@"BtnOff.png"] forState:UIControlStateNormal];
        
    }
    [self SliderProgressUp:nil];
    
}


- (IBAction) SliderProgressUp:(id)sender
{
    
    //shineFreq = 10;//hz
    double time = 1.0/shineFreq;
    
    if (!enableShine) {
        return;
    }
    
    if (timerShine) {
        // [timerShine release];
        
        [timerShine invalidate];
        timerShine = nil;
        
        
    }
    timerShine= [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(onTimerShine) userInfo:nil repeats:YES];
    
    
    
    
}


- (void) SliderProgressChanged:(id)sender
{
    UISlider *slider=(UISlider *)sender;
	//將slider的值加上0.5後轉為整數
   int percent=(int)(slider.value*100);
    shineFreq = MIN_FREQ+(MAX_FREQ-MIN_FREQ)*percent/100.0;
    labelFreq.text = [NSString stringWithFormat:@"%dhz",shineFreq];
    
}


-(void) onTimerShine
{
    static int count=0;
    
    if (!enableShine) {
        return;
    }
    
    if (count%2) {
        [self turnOnLed:NO];
    }else{
        [self turnOffLed:NO];
    }
    count ++;
    
}


#pragma mark mogo ad Delegate methods

- (NSString *)adMoGoApplicationKey {
    return @"92a797b7dced49b598b40a49114a049e";
             
	//return @"bb0bf739cd8f4bbabb74bbaa9d2768bf"; //测试用ID
    //此字符串为您的App在芒果上的唯一标识
}

- (UIViewController *)viewControllerForPresentingModalView {
	return self;//返回的对象为adView的父视图控制器
}

/*- (void)adjustAdSize {	
	[UIView beginAnimations:@"AdResize" context:nil];
	[UIView setAnimationDuration:0.7];
	CGSize adSize = [adView actualAdSize];
	CGRect newFrame = adView.frame;
	newFrame.size.height = adSize.height;
	newFrame.size.width = adSize.width;
	newFrame.origin.x = (self.view.bounds.size.width - adSize.width)/2;
    newFrame.origin.y = 0;//self.view.frame.size.height - 140;
	adView.frame = newFrame;
	
	[UIView commitAnimations];
} */

/*- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView {
	//广告成功展示时调用
    [self adjustAdSize];
    printf("get ad ok\n");
}

- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView 
                     usingBackup:(BOOL)yesOrNo {
    //请求广告失败
    printf("get ad fail\n");
}

- (void)adMoGoWillPresentFullScreenModal {
    //点击广告后打开内置浏览器时调用
}

- (void)adMoGoDidDismissFullScreenModal {
    //关闭广告内置浏览器时调用 
}*/








@end
