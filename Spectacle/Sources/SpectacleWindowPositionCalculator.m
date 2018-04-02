#import "SpectacleWindowPositionCalculator.h"

#import <JavaScriptCore/JavaScriptCore.h>

#import "SpectacleJavaScriptEnvironment.h"
#import "SpectacleWindowPositionCalculationRegistry.h"
#import "SpectacleWindowPositionCalculationResult.h"

@implementation SpectacleWindowPositionCalculator
{
  SpectacleWindowPositionCalculationRegistry *_windowPositionCalculationRegistry;
  SpectacleJavaScriptEnvironment *_javaScriptEnvironment;
}

- (instancetype)initWithErrorHandler:(void(^)(NSString *message))errorHandler
{
  if (self = [super init]) {
    _windowPositionCalculationRegistry = [SpectacleWindowPositionCalculationRegistry new];
    _javaScriptEnvironment = [[SpectacleJavaScriptEnvironment alloc] initWithContextBuilder:^(JSContext *context) {
      context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSString *errorName = [exception[@"name"] toString];
        NSString *errorMessage = [exception[@"message"] toString];
        errorHandler([NSString stringWithFormat:@"%@\n%@", errorName, errorMessage]);
      };
      context[@"windowPositionCalculationRegistry"] = _windowPositionCalculationRegistry;
      context[@"CGRectContainsRect"] = ^BOOL(CGRect rect1, CGRect rect2) {
        return CGRectContainsRect(rect1, rect2);
      };
      context[@"CGRectEqualToRect"] = ^BOOL(CGRect rect1, CGRect rect2) {
        return CGRectEqualToRect(rect1, rect2);
      };
      context[@"CGRectGetMinX"] = ^CGFloat(CGRect rect) {
        return CGRectGetMinX(rect) + 7.5;
      };
      context[@"CGRectGetMinY"] = ^CGFloat(CGRect rect) {
        return CGRectGetMinY(rect) + 7.5;
      };
      context[@"CGRectGetMidX"] = ^CGFloat(CGRect rect) {
        return CGRectGetMidX(rect) + 7.5;
      };
      context[@"CGRectGetMidY"] = ^CGFloat(CGRect rect) {
        return CGRectGetMidY(rect)  + 7.5;
      };
      context[@"CGRectGetMaxX"] = ^CGFloat(CGRect rect) {
        return CGRectGetMaxX(rect) + 7.5;
      };
      context[@"CGRectGetMaxY"] = ^CGFloat(CGRect rect) {
        return CGRectGetMaxY(rect) + 7.5;
      };
    }];
  }
  return self;
}

- (SpectacleWindowPositionCalculationResult *)calculateWindowRect:(CGRect)windowRect
                                       visibleFrameOfSourceScreen:(CGRect)visibleFrameOfSourceScreen
                                  visibleFrameOfDestinationScreen:(CGRect)visibleFrameOfDestinationScreen
                                                           action:(SpectacleWindowAction *)action
{
  JSValue *windowPositionCalculation = [_windowPositionCalculationRegistry windowPositionCalculationWithAction:action];
  if (!windowPositionCalculation) {
    return nil;
  }
  JSValue *result = [windowPositionCalculation callWithArguments:@[
                                                                   [_javaScriptEnvironment valueWithRect:windowRect],
                                                                   [_javaScriptEnvironment valueWithRect:visibleFrameOfSourceScreen],
                                                                   [_javaScriptEnvironment valueWithRect:visibleFrameOfDestinationScreen],
                                                                   ]];
  return [SpectacleWindowPositionCalculationResult resultWithAction:action windowRect:[result toRect]];
}

@end
