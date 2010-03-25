#import "PageControlViewController.h"

@implementation PageControlViewController

- (void)loadView {
    [super loadView];
    
    /* ページ表示のデモ用画像のロードする */
    pages = [[NSMutableArray alloc] init];
    for(int i = 0; i < 5; i++) {
        UIView *subview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        // subview.backgroundColor = [UIColor blackColor];
        // subview.backgroundColor = [UIColor colorWithRed:i*30 green:i*30 blue:i*30 alpha:0];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
        label.text = [NSString stringWithFormat:@"%d", i];
        // subview.backgroundColor = [UIColor colorWithRed:i*30 green:i*30 blue:i*30 alpha:0];
        // label.textColor = [UIColor whiteColor];

        [subview addSubview:label];
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
