#import "PageControlViewController.h"
#import "XMLParser.h"

@implementation PageControlViewController

- (void)loadView {
    [super loadView];

    // rotate view to fit screen
    CGAffineTransform transform = self.view.transform;
    transform = CGAffineTransformRotate(transform, (M_PI * 90 / 180.0));
    self.view.transform = transform;

    CGRect frame = self.view.frame;
    pages = [[NSMutableArray alloc] init];

    // load XML file
    NSError *parseError = nil;
    NSMutableArray *slidesData = [[XMLParser alloc] parseXMLFileByName:@"sobe2" parseError:&parseError];

    for(int i = 0; i < slides.count; i++) {
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        [pages addObject:[self prepareSlide:subview dict:[slides objectAtIndex:i]]];
        [subview release];
    }
    scrollView = [[PageScrollView alloc] initWithFrame:self.view.frame];
    scrollView.pages = pages;
    scrollView.delegate = self;
    self.view = scrollView;
    [pages release];
}

- (id) prepareSlide:(UIView *)view dict:(NSDictionary *)dict{
    view.backgroundColor = [UIColor darkGrayColor];
    UILabel *title = [self title:view.frame text:[dict objectForKey:@"title"]];
    // title.text = [dict objectForKey:@"title"];
    UILabel *contents = [self contents:view.frame array:[dict objectForKey:@"contents"]];

    [view addSubview:title];
    [view addSubview:contents];
    [title release];
    [contents release];
    return view;
}

- (id) title:(CGRect)frame text:(NSString *)text{
    float margin = 10;
    float height = frame.size.height * 0.3;
    // Set title for each slide
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, frame.size.width - margin * 2, height)];
    title.backgroundColor = [UIColor clearColor];
    title.opaque = YES;
    title.textColor = [UIColor whiteColor];
    title.textAlignment = UITextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:height];
    title.adjustsFontSizeToFitWidth = YES;
    title.minimumFontSize = height / 4;
    title.text = text;
    return title;
}

- (id) contents:(CGRect)frame array:(NSArray *)array{
    float margin = 50;
    float height = (frame.size.height * 0.6 - margin) / [array count];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, frame.size.height * 0.4, frame.size.width - margin * 2, frame.size.height * 0.6 - margin)];
    for (int i = 0; i < [array count]; i++) {
    // set contents for each slide
        UILabel *contents = [[UILabel alloc] initWithFrame:CGRectMake(0, i * height, frame.size.width - margin * 2, height)];
        contents.backgroundColor = [UIColor clearColor];
        contents.textColor = [UIColor whiteColor];
        contents.font = [UIFont systemFontOfSize:height];
        contents.adjustsFontSizeToFitWidth = YES;
        contents.minimumFontSize = height / 4;
        contents.lineBreakMode = UILineBreakModeWordWrap;
        // contents.lineBreakMode = UILineBreakModeClip;
        // contents.numberOfLines = 2;
        contents.text = [array objectAtIndex:i];
        [view addSubview:contents];
        [contents release];
    }
    return view;
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
