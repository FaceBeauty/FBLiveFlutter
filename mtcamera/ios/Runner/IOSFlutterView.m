
#import "IOSFlutterView.h"
#import "MTCaptureSessionManager.h"


#import <Masonry/Masonry.h>

#import <FaceBeauty/FaceBeauty.h>
#import <FaceBeauty/FaceBeautyView.h>
#import <FaceBeauty/FaceBeautyInterface.h>

#define window_width  [UIScreen mainScreen].bounds.size.width
#define window_height  [UIScreen mainScreen].bounds.size.height

@interface IOSFlutterView()<MTCaptureSessionManagerDelegate,FaceBeautyDelegate>

@property(nonatomic, strong) CIImage *outputImage;
@property(nonatomic, assign) CVPixelBufferRef outputImagePixelBuffer;

@property(nonatomic,assign)BOOL isRenderInit;
@property(nonatomic,assign)BOOL isCameraSwitched;

@property (nonatomic, strong) FaceBeautyView *fbLiveView;

@end

@implementation IOSFlutterView

- (FaceBeautyView *)fbLiveView{
    if (!_fbLiveView) {
        _fbLiveView = [[FaceBeautyView alloc] init];
        _fbLiveView.contentMode = FaceBeautyViewContentModeScaleAspectFill;
        _fbLiveView.orientation = FaceBeautyViewOrientationLandscapeLeft;
        _fbLiveView.userInteractionEnabled = YES;
    }
    return _fbLiveView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        [self initSDK];
    }
    return self;
}

- (void)initSDK{

    //todo ---facebeauty--- 初始化SDK
    BOOL isResourceCopied = NO;
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"FaceBeauty" ofType:@"bundle"];

    NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    if (libraryPaths.count > 0) {
        NSString *libraryDirectory = [libraryPaths lastObject];
        NSString *sandboxPath = [libraryDirectory stringByAppendingPathComponent:@"FaceBeauty"];
        isResourceCopied = [[FaceBeauty shareInstance] copyResourceBundle:bundlePath toSandbox:sandboxPath];
    }

    NSString *version = [[FaceBeauty shareInstance] getVersion];
    NSLog(@"当前FaceBeauty版本 %@", version ?: @"");

//    # error 需要FaceBeauty appid，与包名应用名绑定，请联系商务获取
    if (isResourceCopied) {
        [[FaceBeauty shareInstance] initFaceBeauty:@"YOUR_APP_ID" withDelegate:self];
    }

    [[MTCaptureSessionManager shareManager] startAVCaptureDelegate:self];
    
    self.userInteractionEnabled = YES;
    

}

- (void)setUI{
    
    [self addSubview:self.fbLiveView];
    CGFloat imageOnPreviewScale = MAX(window_width / AV_CAPTURE_SESSION_PRESET_WIDTH, window_height / AV_CAPTURE_SESSION_PRESET_HEIGHT);
    CGFloat previewImageWidth = AV_CAPTURE_SESSION_PRESET_WIDTH * imageOnPreviewScale;
    CGFloat previewImageHeight = AV_CAPTURE_SESSION_PRESET_HEIGHT * imageOnPreviewScale;

    [self.fbLiveView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(previewImageWidth);
        make.height.mas_equalTo(previewImageHeight);
    }];
}

// MARK: --FaceBeautyDelegate Delegate--

- (void)onInitSuccess{
    NSLog(@"FaceBeauty 加载成功");
    [self initBeautyData];
}

- (void)onInitFailure{
    NSLog(@"FaceBeauty 加载失败");
}

- (void)initBeautyData{
    //开启美颜渲染
    [[FaceBeauty shareInstance] setRenderEnable:true];
    
    [[FaceBeauty shareInstance] setBeauty:FBBeautySkinWhitening value:70];
    [[FaceBeauty shareInstance] setBeauty:FBBeautyClearSmoothing value:80];
    [[FaceBeauty shareInstance] setBeauty:FBBeautySkinRosiness value:10];
    [[FaceBeauty shareInstance] setBeauty:FBBeautyImageSharpness value:5];
    [[FaceBeauty shareInstance] setBeauty:FBBeautyImageBrightness value:0];
    
    [[FaceBeauty shareInstance] setReshape:FBReshapeEyeEnlarging value:60];
    [[FaceBeauty shareInstance] setReshape:FBReshapeCheekThinning value:30];
    [[FaceBeauty shareInstance] setReshape:FBReshapeCheekVShaping value:50];

    [[FaceBeauty shareInstance] setFilter:FBFilterBeauty name:@"ziran3"];
}

/**
 * 切换摄像头
 */
- (void)didClickSwitchCameraButton:(UIButton *)sender{
    
    sender.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
    [[MTCaptureSessionManager shareManager] didClickSwitchCameraButton];
    _isCameraSwitched = true;
    
}

// MARK: --MTCaptureSessionManager Delegate--

-(void)captureSampleBuffer:(CMSampleBufferRef)sampleBuffer Rotation:(NSInteger)rotation Mirror:(BOOL)isMirror{
    
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
       if (pixelBuffer == NULL) {
           return;
       }
      CVPixelBufferLockBaseAddress(pixelBuffer, 0);
     unsigned char *baseAddress = (unsigned char *)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
    
    // 视频帧格式
    FBFormatEnum format;
       switch (CVPixelBufferGetPixelFormatType(pixelBuffer)) {
           case kCVPixelFormatType_32BGRA:
               format = FBFormatBGRA;
               break;
           case kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange:
               format = FBFormatNV12;
               break;
           case kCVPixelFormatType_420YpCbCr8BiPlanarFullRange:
               format = FBFormatNV12;
               break;
           default:
               NSLog(@"错误的视频帧格式！");
               format = FBFormatBGRA;
               break;
       }
    int imageWidth, imageHeight;
    if (format == FBFormatBGRA) {
        imageWidth = (int)CVPixelBufferGetBytesPerRow(pixelBuffer) / 4;
        imageHeight = (int)CVPixelBufferGetHeight(pixelBuffer);
    } else {
        imageWidth = (int)CVPixelBufferGetWidthOfPlane(pixelBuffer , 0);
        imageHeight = (int)CVPixelBufferGetHeightOfPlane(pixelBuffer , 0);
    }
    if (_isCameraSwitched) {
        [[FaceBeauty shareInstance] releaseBufferRenderer];
        _isCameraSwitched = false;
        _isRenderInit = false;
    }
    //todo ---facebeauty---
    //添加渲染
    if (!_isRenderInit) {
        _isRenderInit = [[FaceBeauty shareInstance] initBufferRenderer:FBFormatBGRA width:imageWidth height:imageHeight rotation:FBRotationClockwise90 isMirror:isMirror maxFaces:5];
    }
    
    [[FaceBeauty shareInstance] processBuffer:baseAddress];
    
    [self.fbLiveView displayPixelBuffer:pixelBuffer isMirror:isMirror];
    
    self.outputImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    self.outputImagePixelBuffer = pixelBuffer;
    
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    
}

- (void)dealloc {
    [[FaceBeauty shareInstance] releaseBufferRenderer];
}


@end
