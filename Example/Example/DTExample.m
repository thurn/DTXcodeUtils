#import "DTExample.h"

#import "DTXcodeHeaders.h"
#import "DTXcodeUtils.h"

static DTExample *sharedPlugin;

@interface DTExample()
@property (nonatomic) BOOL highlightingEnabled;
@property (nonatomic, strong) NSBundle *bundle;
@end

@implementation DTExample

+ (void)pluginDidLoad:(NSBundle *)plugin {
  static dispatch_once_t onceToken;
  NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
  if ([currentApplicationName isEqual:@"Xcode"]) {
    dispatch_once(&onceToken, ^{ sharedPlugin = [[self alloc] initWithBundle:plugin]; });
  }
}

- (id)initWithBundle:(NSBundle *)plugin {
  if (self = [super init]) {
    _bundle = plugin;
    _highlightingEnabled = YES;
    NSMenuItem *menuItem = [DTXcodeUtils getMainMenuItemWithTitle:@"Edit"];
    if (menuItem) {
      [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
      NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Toggle Highlighting"
                                                              action:@selector(doMenuAction)
                                                       keyEquivalent:@""];
      [actionMenuItem setTarget:self];
      [[menuItem submenu] addItem:actionMenuItem];
    }
  }
  return self;
}

- (void)doMenuAction {
  DVTTextStorage *storage = [DTXcodeUtils currentTextStorage];
  _highlightingEnabled = !_highlightingEnabled;
  storage.syntaxColoringEnabled = _highlightingEnabled;
  DVTSourceTextView *textView = [DTXcodeUtils currentSourceTextView];
  [textView setNeedsDisplay:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
