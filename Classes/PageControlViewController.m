#import "PageControlViewController.h"

@implementation PageControlViewController

- (void)loadView {
    [super loadView];
    
    // rotate view to fit screen
    CGAffineTransform transform = self.view.transform;
    transform = CGAffineTransformRotate(transform, (M_PI * 90 / 180.0));
    self.view.transform = transform;

    CGRect frame = self.view.frame;
    pages = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 5; i++) {
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [UIColor whiteColor];

        // Set title for each slide
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 20, frame.size.height * 0.3)];
        title.text = [NSString stringWithFormat:@"%d", i];
        title.textColor = [UIColor whiteColor];
        title.backgroundColor = [UIColor darkGrayColor];

        // set contents for each slide
        UILabel *contents = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, frame.size.width * 0.9, 360)];
        contents.text = @"contents";
        contents.textColor = [UIColor redColor];
        contents.backgroundColor = [UIColor lightGrayColor];

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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
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
