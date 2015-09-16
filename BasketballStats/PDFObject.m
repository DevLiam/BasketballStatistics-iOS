//
//  PDFObject.m
//  BasketballStats
//
//  Created by Liam Andrew on 1/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "PDFObject.h"
#import <CoreText/CoreText.h>

const int kPeriodStatRowHeight = 20;
const int kPeriodStatColWidth = 34;
const int kNumberOfColsInStatTable = 15;
const int kNumberOfExtraRowsInStatTable = 3;
const int kPercentageColDistance = 4;
const int kTotalsColIndex = 3;
const int kNameColsIndexMin = 1;
const int kNameColsIndexMax = 2;
const int kPercentageColsIndexMin = 4;
const int kPercentageColsIndexMax = 7;
const int kPaddingX = 40;
const int kPaddingY = 5;
const int kPadding = 5;

@implementation PDFObject {
    CGPoint homeTeamTitleLabelPoint;
    CGPoint awayTeamTitleLabelPoint;
    CGPoint homeTeamTableLabelPoint;
    CGPoint awayTeamTableLabelPoint;
    CGSize pageSize;
    float yPos;
}

- (id) initWithGameObject:(Game *)game andFileName:(NSString *)fileName{
    if (self = [super init]) {
        
        self.game = game;
        self.homeTeam = [game.teams firstObject];
        self.awayTeam = [game.teams lastObject];
        self.fileName = fileName;
        
        pageSize = CGSizeMake(612, 792);
        
        [self createPDFFile];
        
    }
    return self;
}

- (void) createPDFFile {
   
    
    UIGraphicsBeginPDFContextToFile(self.fileName, CGRectZero, nil);
    
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
//    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 1654, 2339), nil);
    
    [self drawBackground];
    
    [self drawFileHeader];
    
    yPos = kPeriodStatRowHeight/2;
    
    if ([self.game.recordHomeTeamStats boolValue]) {
        [self drawFullTeamTableAtPoint:CGPointMake(50, 120) forTeam:self.homeTeam];
    }

    if ([self.game.recordAwayTeamStats boolValue]) {
        [self drawFullTeamTableAtPoint:CGPointMake(50, yPos + 120) forTeam:self.awayTeam];
    }
    
    UIGraphicsEndPDFContext();
}

- (void)drawFileHeader {
    
    PDFGameStatsView *view = [[[NSBundle mainBundle] loadNibNamed:@"PDFGameStatsView" owner:nil options:nil]lastObject];

    [self drawText:self.homeTeam.teamName inFrame:view.homeTeamNameLabel.frame];
    [self drawText:self.awayTeam.teamName inFrame:view.awayTeamNameLabel.frame];
    [self drawText: [NSString stringWithFormat:@"%d", [[self.homeTeam getTeamTotalPoints] intValue]] inFrame: view.homeTeamScoreLabel.frame];
    [self drawText: [NSString stringWithFormat:@"%d", [[self.awayTeam getTeamTotalPoints] intValue]] inFrame: view.awayTeamScoreLabel.frame];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm"];
    
    [self drawText: [dateFormatter stringFromDate:self.game.date]  inFrame:CGRectMake(view.gameDateLabel.frame.origin.x, view.gameDateLabel.frame.origin.y, view.gameDateLabel.frame.size.width + 100, view.gameDateLabel.frame.size.height)];
    [self drawText: [timeFormatter stringFromDate:self.game.date] inFrame:view.gameTimeLabel.frame];
    
    UIImage *image = [UIImage imageNamed:@"Logo.png"];
    [self drawImage:image inRect:view.logoImageView.frame];
    
}

- (void)drawFullTeamTableAtPoint: (CGPoint) point forTeam: (Team*) team {
    
    CGRect frame = CGRectMake(point.x, point.y, kPeriodStatColWidth + 300, kPeriodStatRowHeight);
    
    [self drawText: [NSString stringWithFormat:@"%@ Statistics", team.teamName] inFrame:frame];
    
    [self drawPeriodStatisticsTableAtPoint:point forTeam:team];
    [self drawPeriodStatisticsTableDataAtPoint:point forTeam:team];
}

- (void)drawPeriodStatisticsTableAtPoint: (CGPoint)point forTeam:(Team *) team {
    
    // Draw the rows of the table
    for (int i = 0; i <= [team.players count] + kNumberOfExtraRowsInStatTable; i++) {
        
        yPos += kPeriodStatRowHeight;
        int newYPoint = point.y + i * kPeriodStatRowHeight;
        
        CGPoint fromPoint;
        CGPoint toPoint;
        
        if (i == [team.players count] + kNumberOfExtraRowsInStatTable) {
            
            fromPoint = CGPointMake(point.x + kPercentageColDistance * kPeriodStatColWidth, newYPoint);
            toPoint = CGPointMake(fromPoint.x + 3 * kPeriodStatColWidth, newYPoint);
        } else {
            
            fromPoint = CGPointMake(point.x, newYPoint);
            toPoint = CGPointMake(point.x + kNumberOfColsInStatTable * kPeriodStatColWidth, newYPoint);
            
        }
        
        [self drawLineFromPoint:fromPoint toPoint:toPoint];
    }
    
    // Draw the cols of the table
    for (int i = 0; i <= kNumberOfColsInStatTable; i++) {
        
        int newXPoint = point.x + i * kPeriodStatColWidth;
        
        CGPoint fromPoint = CGPointMake(newXPoint, point.y);
        CGPoint toPoint;
        
        if (i < kTotalsColIndex && i != 0) {
            // Cols are only drawn to the top of the Totals row
            
            toPoint = CGPointMake(newXPoint, point.y + ( [team.players count] + kNumberOfExtraRowsInStatTable - 2 ) * kPeriodStatRowHeight);
            
            if (i >= kNameColsIndexMin && i <= kNameColsIndexMax) {
                // Cols are not drawn at all since these indexes represent the name col
                toPoint = fromPoint;
            }
        } else if (i >= kPercentageColsIndexMin && i <= kPercentageColsIndexMax) {
            // Cols are drawn down to the percentage rows
            
            toPoint = CGPointMake(newXPoint, point.y + ( [team.players count] + kNumberOfExtraRowsInStatTable + 0 ) * kPeriodStatRowHeight);
            
        } else {
            // Otherwise cols are standard length
            
            toPoint = CGPointMake(newXPoint, point.y + ( [team.players count] + kNumberOfExtraRowsInStatTable - 1) * kPeriodStatRowHeight);
        }
        
        [self drawLineFromPoint:fromPoint toPoint:toPoint];
        
    }
    
}

- (void)drawPeriodStatisticsTableDataAtPoint: (CGPoint)point forTeam:(Team *)team {
    
    NSArray *headings = @[@"Player", @"PTS", @"FG", @"3P", @"FT", @"OR", @"DR", @"TR", @"AST", @"STL", @"BLK", @"TO", @"PF"];
    NSArray *totals = @[ @"Total",
                         [NSString stringWithFormat:@"%d", [[team getTeamTotalPoints] intValue]],
                         [NSString stringWithFormat:@"%d-%d", [[team getTeamTotalFieldGoalsMade] intValue], [[team getTeamTotalFieldGoalsAttempted] intValue]],
                         [NSString stringWithFormat:@"%d-%d", [[team getTeamTotalThreeGoalsMade] intValue], [[team getTeamTotalThreeGoalsAttempted] intValue]],
                         [NSString stringWithFormat:@"%d-%d", [[team getTeamTotalFreeThrowsMade] intValue], [[team getTeamTotalFreeThrowsAttempted] intValue]],
                         [NSString stringWithFormat:@"%d", [[team getTeamTotalOffensiveRebounds] intValue]],
                         [NSString stringWithFormat:@"%d", [[team getTeamTotalDefensiveRebounds] intValue]],
                         [NSString stringWithFormat:@"%d", [[team getTeamTotalTotalRebounds] intValue]],
                         [NSString stringWithFormat:@"%d", [[team getTeamTotalAssists] intValue]],
                         [NSString stringWithFormat:@"%d", [[team getTeamTotalSteals] intValue]],
                         [NSString stringWithFormat:@"%d", [[team getTeamTotalBlocks] intValue]],
                         [NSString stringWithFormat:@"%d", [[team getTeamTotalTurnovers] intValue]],
                         [NSString stringWithFormat:@"%d", [[team getTeamTotalFouls] intValue]] ];
    
    
    NSMutableArray *allTableData = [[NSMutableArray alloc] init];
    [allTableData addObject:headings];
    
    for (Player *player in team.players) {
        NSArray *playerData = @[ [NSString stringWithFormat:@"%@. %@", [player.firstName substringToIndex:1], player.lastName],
                                 [NSString stringWithFormat:@"%d", [[player getTotalPlayerPoints] intValue]],
                                 [NSString stringWithFormat:@"%d-%d", [[player getTotalPlayerFieldGoalsMade] intValue], [[player getTotalPlayerFieldGoalsAttempted] intValue]],
                                 [NSString stringWithFormat:@"%d-%d", [[player getTotalPlayerThreeGoalsMade] intValue], [[player getTotalPlayerThreeGoalsAttempted] intValue]],
                                 [NSString stringWithFormat:@"%d-%d", [[player getTotalPlayerFreeThrowsMade] intValue], [[player getTotalPlayerFreeThrowsAttempted] intValue]],
                                 [NSString stringWithFormat:@"%d", [[player getTotalPlayerOffensiveRebounds] intValue]],
                                 [NSString stringWithFormat:@"%d", [[player getTotalPlayerDefensiveRebounds] intValue]],
                                 [NSString stringWithFormat:@"%d", [[player getTotalPlayerTotalRebounds] intValue]],
                                 [NSString stringWithFormat:@"%d", [[player getTotalPlayerAssists] intValue]],
                                 [NSString stringWithFormat:@"%d", [[player getTotalPlayerSteals] intValue]],
                                 [NSString stringWithFormat:@"%d", [[player getTotalPlayerBlocks] intValue]],
                                 [NSString stringWithFormat:@"%d", [[player getTotalPlayerTurnovers] intValue]],
                                 [NSString stringWithFormat:@"%d", [[player getTotalPlayerFouls] intValue]] ];
        [allTableData addObject:playerData];
    }
    [allTableData addObject:totals];
    
    // Percentage Data
    NSNumber *fgPer = [NSNumber numberWithFloat:[team getTeamFGPerc]];
    NSNumber *TpPer = [NSNumber numberWithFloat:[team getTeamTPPerc]];
    NSNumber *FtPer = [NSNumber numberWithFloat:[team getTeamFTPerc]];
    
    NSArray *percentageData = @[ [NSString stringWithFormat: @"%.2f", [fgPer floatValue]],
                                 [NSString stringWithFormat: @"%.2f", [TpPer floatValue]],
                                 [NSString stringWithFormat: @"%.2f", [FtPer floatValue]] ];
    [allTableData addObject:percentageData];
    
    for (int i = 0; i < [allTableData count]; i++) {
        
        NSArray *rowData = [allTableData objectAtIndex:i];
        
        if (i != ( [allTableData count]-1) ) {
            // Normal Statistics
        
            for (int j = 0; j < kNumberOfColsInStatTable; j++) {
    
                int index;
            
                int newPointX = point.x + ( j * kPeriodStatColWidth);
                int newPointY = point.y + ( (i + 1) * kPeriodStatRowHeight);
                CGRect frame = CGRectMake(newPointX + kPadding, newPointY + kPadding, kPeriodStatColWidth + 100, kPeriodStatRowHeight);
            
                if (j == 0) {
                
                    // Index is the first element "player" or "name"
                    index = j;
                    [self drawText:[rowData objectAtIndex:index] inFrame:frame];
                
                } else if (j >= 3) {
                
                    // Skip elements 1 and 2 since name col is extra wide
                    index = j - 2;
                    [self drawText:[rowData objectAtIndex:index] inFrame:frame];
                }
            
            }
        } else {
            // Add the Percentages
            for (int j = 0; j < [rowData count]; j++) {
              
                int newPointX = point.x + (4 + j) * kPeriodStatColWidth;
                int newPointY = point.y + ( (i + 1) * kPeriodStatRowHeight);
                CGRect frame = CGRectMake(newPointX + 2, newPointY + kPadding, kPeriodStatColWidth, kPeriodStatRowHeight);
                
                [self drawText:[rowData objectAtIndex:j] inFrame:frame];
                
            }
            
        }
        
    }

    
    
}

- (void)drawBackground {
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, pageSize.width, pageSize.height);
    CGContextSetFillColorWithColor(currentContext, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(currentContext, rect);
}

- (void)drawText:(NSString *)textToDraw inFrame:(CGRect)frameRect {
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    // Prepare the text using a Core Text Framesetter
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, frameRect.origin.y*2);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    CGContextTranslateCTM(currentContext, 0, (-1)*frameRect.origin.y*2);
    
    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
}

- (void)drawImage:(UIImage*)image inRect:(CGRect)rect
{
    
    [image drawInRect:rect];
    
}

- (void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to
{

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {0.2, 0.2, 0.2, 0.3};
    
    CGColorRef color = CGColorCreate(colorspace, components);
    
    CGContextSetStrokeColorWithColor(context, color);
    
    
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
}





@end
