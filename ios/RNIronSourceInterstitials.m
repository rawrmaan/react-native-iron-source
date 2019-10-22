#import <Foundation/Foundation.h>
#import "RNIronSourceInterstitials.h"
#import "RCTUtils.h"

@implementation RNIronSourceInterstitials

RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents {
    return @[@"interstitialDidLoad",
             @"interstitialDidShow",
             @"interstitialDidFailToShowWithError",
             @"didClickInterstitial",
             @"interstitialDidClose",
             @"interstitialDidOpen",
             @"interstitialDidFailToLoadWithError"
             ];
}

RCT_EXPORT_METHOD(loadInterstitial)
{
    [IronSource setInterstitialDelegate:self];
    [IronSource loadInterstitial];
}

RCT_EXPORT_METHOD(hasInterstitial:(id)unused
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    resolve(@([IronSource hasInterstitial]));
}

RCT_EXPORT_METHOD(showInterstitial:(NSString*) placementName)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [IronSource showInterstitialWithViewController:RCTPresentedViewController() placement:placementName];
    });
}

#pragma mark - ISInterstitialDelegate
//Invoked when Interstitial Ad is ready to be shown after load function was //called.
-(void)interstitialDidLoad {
    [self sendEventWithName:@"interstitialDidLoad" body:nil];
}
//Called each time the Interstitial window has opened successfully.
-(void)interstitialDidShow {
    [self sendEventWithName:@"interstitialDidShow" body:nil];
}
// Called if showing the Interstitial for the user has failed.
//You can learn about the reason by examining the ‘error’ value
-(void)interstitialDidFailToShowWithError:(NSError *)error {
    [self sendEventWithName:@"interstitialDidFailToShowWithError" body:error.userInfo[@"NSLocalizedDescription"]];
}
//Called each time the end user has clicked on the Interstitial ad.
-(void)didClickInterstitial {
    [self sendEventWithName:@"didClickInterstitial" body:nil];
}
//Called each time the Interstitial window is about to close
-(void)interstitialDidClose {
    [self sendEventWithName:@"interstitialDidClose" body:nil];
}
//Called each time the Interstitial window is about to open
-(void)interstitialDidOpen {
    [self sendEventWithName:@"interstitialDidOpen" body:nil];
}
//Invoked when there is no Interstitial Ad available after calling load //function. @param error - will contain the failure code and description.
-(void)interstitialDidFailToLoadWithError:(NSError *)error {
    [self sendEventWithName:@"interstitialDidFailToLoadWithError" body:error.userInfo[@"NSLocalizedDescription"]];
}
@end
