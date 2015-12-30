//******************************************************************************
//
// Copyright (c) 2015 Microsoft Corporation. All rights reserved.
//
// This code is licensed under the MIT License (MIT).
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//******************************************************************************

#include "Starboard.h"
#include "Logging.h"

#include <Foundation/NSString.h>
#include <Windows.h>

/**
 @Status Interoperable
*/
void NSLogv(NSString* fmt, va_list list) {
    auto str = [[NSString alloc] initWithFormat:fmt arguments:list];
    INT len = [str length];
    LPWSTR terminatedBuf = (LPWSTR)calloc(len + 1, sizeof(WCHAR));
    memcpy(terminatedBuf, [str rawCharacters], len * sizeof(WCHAR));
    TraceVerbose(L"NSLog", L"%s", terminatedBuf);
    free(terminatedBuf);
    printf("%s\n", [str UTF8String]);
    [str release];
}

/**
 @Status Interoperable
*/
void NSLog(NSString* fmt, ...) {
    va_list list;
    va_start(list, fmt);
    NSLogv(fmt, list);
    va_end(list);
}
