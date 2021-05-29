#import <UIKit/UIKit.h>

static NSString *plistPath = @"/var/mobile/Library/Preferences/xyz.henryli17.alwayslandscape.plist";

%group Tweak
	%hook UIDevice
	-(void)setOrientation:(long long)arg1 {
		%orig(UIInterfaceOrientationLandscapeRight);
	}

	-(void)setOrientation:(long long)arg1 animated:(BOOL)arg2 {
		%orig(UIInterfaceOrientationLandscapeRight, arg2);
	}
	%end
%end

%ctor {
	NSString *identifier = [NSBundle mainBundle].bundleIdentifier;
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];

	if ([[plistDict objectForKey:[@"Settings-" stringByAppendingString:identifier]] boolValue]) {
		%init(Tweak);
	};
}