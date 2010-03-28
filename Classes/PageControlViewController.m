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


    NSArray *contents = [NSArray arrayWithObjects:@"cont1", @"cont2 if content was too long...aaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaa", @"cont3", nil];
    NSArray *keys = [NSArray arrayWithObjects:@"title", @"contents", nil]; 
    NSArray *values = [NSArray arrayWithObjects:@"this is title", contents, nil];
    NSDictionary *page = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSMutableArray *slides = [NSMutableArray array];
    [slides addObject:page];
    [slides addObject:page];
    [slides addObject:page];
    [slides addObject:page];
    // NSDictionary *dic = [slides objectAtIndex:1];
    // NSLog(@"%@", [dic objectForKey:@"title"]);



    for(int i = 0; i < slides.count; i++) {
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview = [self prepareSlide:subview dict:[slides objectAtIndex:i]];

        // UILabel *title = [self title:frame dict:[slides objectAtIndex:i]];
        // UILabel *contents = [self contents:frame];

        [pages addObject:subview];    
    }


    NSURL *url;
    NSBundle *bundle = [NSBundle mainBundle];
    if (bundle) {
        NSString *localFilePath = [bundle pathForResource:@"sobe2" ofType:@"xml"];
        if (localFilePath) {
            url = [NSURL fileURLWithPath:localFilePath];
        }
    }
    NSError *parseError = nil;
    // [self parseXMLFileAtURL:url parseError:&parseError];
    XMLParser *doc = [[XMLParser alloc] initWithXMLString:url];
    

    scrollView = [[PageScrollView alloc] initWithFrame:self.view.frame];
    scrollView.pages = pages;
    scrollView.delegate = self;
    self.view = scrollView;
}

- (id) prepareSlide:(UIView *)view dict:(NSDictionary *)dict{
    view.backgroundColor = [UIColor darkGrayColor];
    UILabel *title = [self title:view.frame text:[dict objectForKey:@"title"]];
    // title.text = [dict objectForKey:@"title"];
    UILabel *contents = [self contents:view.frame array:[dict objectForKey:@"contents"]];

    [view addSubview:title];
    [view addSubview:contents];
    return view;
}

- (id) title:(CGRect)frame text:(NSString *)text{
    float margin = 10;
    // Set title for each slide
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, frame.size.width - margin * 2, frame.size.height * 0.3)];
    title.backgroundColor = [UIColor clearColor];
    title.opaque = YES;
    title.textColor = [UIColor whiteColor];
    title.textAlignment = UITextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:frame.size.height * 0.3];
    title.adjustsFontSizeToFitWidth = YES;
    title.minimumFontSize = frame.size.height * 0.3 / 10;
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
        contents.minimumFontSize = height / 2;
        // contents.numberOfLines = 2;
        contents.lineBreakMode = UILineBreakModeWordWrap;
        // contents.lineBreakMode = UILineBreakModeClip;
        contents.text = [array objectAtIndex:i];
        [view addSubview:contents];
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
