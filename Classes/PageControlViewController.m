#import "PageControlViewController.h"

@implementation PageControlViewController

- (void)loadView {
    [super loadView];
    
    /* ページ表示のデモ用画像のロードする */
    pages = [[NSMutableArray alloc] init];
    CGRect frame = self.view.frame;
    NSLog([NSString stringWithFormat:@"self.view.frame\norigin.x:%f\norigin.y:%f\nsize.height:%f\nsize.width%f", frame.origin.x, frame.origin.y, frame.size.height, frame.size.width]);
    for(int i = 0; i < 5; i++) {
        UIView *subview = [[UIView alloc] initWithFrame:self.view.frame];
        // UIView *subview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        subview.backgroundColor = [UIColor grayColor];
        // Set title for each slide
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width * 0.3)];
        title.text = [NSString stringWithFormat:@"%d", i];
        title.backgroundColor = [UIColor redColor];
        // set contents for each slide
        UILabel *contents = [[UILabel alloc] initWithFrame:CGRectMake(100, 400, 600, 300)];
        contents.text = @"contents";
        contents.backgroundColor = [UIColor blueColor];

        [subview addSubview:title];
        [subview addSubview:contents];
        [pages addObject:subview];    
    }
    
    scrollView = [[PageScrollView alloc] initWithFrame:self.view.frame];
    scrollView.pages = pages;
    scrollView.delegate = self;
    self.view = scrollView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [scrollView release];
    [super dealloc];
}

-(void) pageScrollViewDidChangeCurrentPage:(PageScrollView *)pageScrollView currentPage:(int)currentPage {
    NSLog(@"Displaying %d\n", currentPage);
}

@end
