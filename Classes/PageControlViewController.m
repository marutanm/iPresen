#import "PageControlViewController.h"

@implementation PageControlViewController

- (void)viewWillAppear:(BOOL)animated {
// 	// CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
//  // 	transform = CGAffineTransformTranslate(transform, 80, 80);
// 	// self.view.transform = transform;
    // self.view.transform = CGAffineTransformConcat(self.view.transform, CGAffineTransformMakeRotation((M_PI * 90 / 180.0)));
}

- (void)loadView {
    [super loadView];

    CGRect frame = self.view.frame;
    NSLog([NSString stringWithFormat:@"self.view.frame\norigin.x:%f\norigin.y:%f\nsize.width:%f\nsize.height%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height]);

    pages = [[NSMutableArray alloc] init];
    for(int i = 0; i < 5; i++) {
        // UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width)];
        UIView *subview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        subview.backgroundColor = [UIColor grayColor];
        // Set title for each slide
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.9, frame.size.height * 0.3)];
        title.text = [NSString stringWithFormat:@"%d", i];
        title.backgroundColor = [UIColor redColor];
        // set contents for each slide
        UILabel *contents = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, frame.size.width * 0.9, 360)];
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
    // return YES;
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
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
