#import "PageControlViewController.h"

@implementation PageControlViewController

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"start parse XML");
}

- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    NSError *parseError = [parser parserError];
    if (parseError && error) {
        *error = parseError;
    }
    [parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    if ([elementName isEqualToString:@"page"]) {
        // NSLog(@"title is %@ , content is %@", [attributeDict objectForKey:@"title"], [attributeDict objectForKey:@"content"]);
    }
    NSLog(@"%@ start", elementName);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (qName) {
        elementName = qName;
    }
    NSLog(@"%@ end", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"%@", string);
}


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
        subview.backgroundColor = [UIColor darkGrayColor];

        [subview addSubview:[self title:frame]];
        [subview addSubview:[self contents:frame]];
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
    [self parseXMLFileAtURL:url parseError:&parseError];


    scrollView = [[PageScrollView alloc] initWithFrame:self.view.frame];
    scrollView.pages = pages;
    scrollView.delegate = self;
    self.view = scrollView;
}

- (id) title:(CGRect)frame {
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
    title.text = @"hoge\nfuga\nhoge";
    return title;
}

- (id) contents:(CGRect)frame {
    float margin = 50;
    // set contents for each slide
    UILabel *contents = [[UILabel alloc] initWithFrame:CGRectMake(margin, frame.size.height * 0.4, frame.size.width - margin * 2, frame.size.height * 0.6 - margin)];
    contents.backgroundColor = [UIColor clearColor];
    contents.textColor = [UIColor whiteColor];
    contents.font = [UIFont systemFontOfSize:frame.size.height * 0.1];
    contents.adjustsFontSizeToFitWidth = YES;
    contents.minimumFontSize = frame.size.height * 0.3 / 10;
    contents.lineBreakMode = UILineBreakModeWordWrap;
    contents.numberOfLines = 0;
    contents.text = @"cont\nents";
    return contents;
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
