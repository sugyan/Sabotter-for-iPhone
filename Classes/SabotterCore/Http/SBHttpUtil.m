#import "SBHttpUtil.h"


@implementation SBHttpUtil

+ (NSString *)encodedStringWithBase64:(NSString *)arg {
    static const char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    const char *c = [arg UTF8String];
    int length = [arg lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    char *result = malloc((((length * 8 + 23) / 24) + 1) * 4);

    int index = 0;
    while (*c != '\0') {
        int flg = 0;
        char byte[3];

        byte[0] = *(c++);
        if (*c == '\0') {
            flg++;
        }
        byte[1] = *c != '\0' ? *(c++) : *c;
        if (*c == '\0') {
            flg++;
        }
        byte[2] = *c != '\0' ? *(c++) : *c;

        result[index + 0] = table[byte[0] >> 2];
        result[index + 1] = table[((byte[0] << 4) + (byte[1] >> 4)) & 0x3f];
        result[index + 2] = table[((byte[1] << 2) + (byte[2] >> 6)) & 0x3f];
        result[index + 3] = table[byte[2] & 0x3f];
        if (flg > 0) {
            result[index + 3] = '=';
        }
        if (flg > 1) {
            result[index + 2] = '=';
        }

        index += 4;
    }
    result[index] = '\0';

    NSString *ret = [NSString stringWithCString:result encoding:NSASCIIStringEncoding];
    free(result);

    return ret;
}

+ (NSString *)unescapedStringWithHtml:(NSString *)arg {
    NSMutableString *str = [NSMutableString stringWithString:arg];
    [str replaceOccurrencesOfString:@"&gt;" withString:@">" options:0 range:NSMakeRange(0, [str length])];
    [str replaceOccurrencesOfString:@"&lt;" withString:@"<" options:0 range:NSMakeRange(0, [str length])];
    [str replaceOccurrencesOfString:@"&amp;" withString:@"&" options:0 range:NSMakeRange(0, [str length])];

    return str;
}

@end
