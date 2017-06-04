/*
 * (C) 2006 - 2010 Dirk W. Hoffmann. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#import "C64GUI.h"

// --------------------------------------------------------------------------
//                                    CPU
// --------------------------------------------------------------------------

@implementation CPUProxy

- (instancetype) initWithCPU:(CPU *)c
{
    self = [super init];	
	cpu = c;	
	return self;
}

- (void) dump { cpu->dumpState(); }
- (bool) tracingEnabled { return cpu->tracingEnabled(); }
- (void) setTraceMode:(bool)b { cpu->setTraceMode(b); }

- (uint16_t) PC { return cpu->getPC_at_cycle_0(); }
- (void) setPC:(uint16_t)pc { cpu->setPC_at_cycle_0(pc); }
- (uint8_t) SP { return cpu->getSP(); }
- (void) setSP:(uint8_t)sp { cpu->setSP(sp); }
- (uint8_t) A { return cpu->getA(); }
- (void) setA:(uint8_t)a { cpu->setA(a); }
- (uint8_t) X { return cpu->getX(); }
- (void) setX:(uint8_t)x { cpu->setX(x); }
- (uint8_t) Y { return cpu->getY(); }
- (void) setY:(uint8_t)y { cpu->setY(y); }
- (bool) N { return cpu->getN(); }
- (void) setN:(bool)b { cpu->setN(b); }
- (bool) Z { return cpu->getZ(); }
- (void) setZ:(bool)b { cpu->setZ(b); }
- (bool) C { return cpu->getC(); }
- (void) setC:(bool)b { cpu->setC(b); }
- (bool) I { return cpu->getI(); }
- (void) setI:(bool)b { cpu->setI(b); }
- (bool) B { return cpu->getB(); }
- (void) setB:(bool)b { cpu->setB(b); }
- (bool) D { return cpu->getD(); }
- (void) setD:(bool)b { cpu->setD(b); }
- (bool) V { return cpu->getV(); }
- (void) setV:(bool)b { cpu->setV(b); }

- (uint16_t) peekPC { return cpu->mem->peek(cpu->getPC_at_cycle_0()); }
- (uint8_t) lengthOfInstruction:(uint8_t)opcode { return cpu->getLengthOfInstruction(opcode); }
- (uint8_t) lengthOfInstructionAtAddress:(uint16_t)addr { return cpu->getLengthOfInstructionAtAddress(addr); }
- (uint8_t) lengthOfCurrentInstruction { return cpu->getLengthOfCurrentInstruction(); }
- (uint16_t) addressOfNextInstruction { return cpu->getAddressOfNextInstruction(); }
- (const char *) mnemonic:(uint8_t)opcode { return cpu->getMnemonic(opcode); }
- (AddressingMode) addressingMode:(uint8_t)opcode { return cpu->getAddressingMode(opcode); }

- (int) topOfCallStack { return cpu->getTopOfCallStack(); }
- (int) breakpoint:(int)addr { return cpu->getBreakpoint(addr); }
- (void) setBreakpoint:(int)addr tag:(uint8_t)t { cpu->setBreakpoint(addr, t); }
- (void) setHardBreakpoint:(int)addr { cpu->setHardBreakpoint(addr); }
- (void) deleteHardBreakpoint:(int)addr { cpu->deleteHardBreakpoint(addr); }
- (void) toggleHardBreakpoint:(int)addr { cpu->toggleHardBreakpoint(addr); }
- (void) setSoftBreakpoint:(int)addr { cpu->setSoftBreakpoint(addr); }
- (void) deleteSoftBreakpoint:(int)addr { cpu->deleteSoftBreakpoint(addr); }
- (void) toggleSoftBreakpoint:(int)addr { cpu->toggleSoftBreakpoint(addr); }

@end

// --------------------------------------------------------------------------
//                                   Memory
// --------------------------------------------------------------------------

@implementation MemoryProxy

- (instancetype) initWithMemory:(Memory *)m
{
    self = [super init];	
	mem = m;	
	return self;
}

- (void) dump { mem->dumpState(); }

- (uint8_t) peek:(uint16_t)addr { return mem->peek(addr); }
- (uint16_t) peekWord:(uint16_t)addr { return mem->peekWord(addr); }
- (uint8_t) peekFrom:(uint16_t)addr memtype:(MemoryType)type { return mem->peekFrom(addr, type); }
- (void) poke:(uint16_t)addr value:(uint8_t)val { mem->poke(addr, val); }
- (void) pokeTo:(uint16_t)addr value:(uint8_t)val memtype:(MemoryType)type { mem->pokeTo(addr, val, type); }
- (bool) isValidAddr:(uint16_t)addr memtype:(MemoryType)type { return mem->isValidAddr(addr, type); }

@end

// --------------------------------------------------------------------------
//                                    VIC
// --------------------------------------------------------------------------

@implementation VICProxy

- (instancetype) initWithVIC:(VIC *)v
{
    self = [super init];	
	vic = v;	
	return self;
}

- (void) dump { vic->dumpState(); }

- (void *) screenBuffer { return vic->screenBuffer(); }

- (NSColor *) color:(int)nr
{
    assert (0 <= nr && nr < 16);
    
    uint32_t color = vic->getColor(nr);
    uint8_t r = color & 0xFF;
    uint8_t g = (color >> 8) & 0xFF;
    uint8_t b = (color >> 16) & 0xFF;
    
	return [NSColor colorWithCalibratedRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1.0];
}

- (uint16_t) memoryBankAddr { return vic->getMemoryBankAddr(); }
- (void) setMemoryBankAddr:(uint16_t)addr { vic->setMemoryBankAddr(addr); }
- (uint16_t) screenMemoryAddr { return vic->getScreenMemoryAddr(); }
- (void) setScreenMemoryAddr:(uint16_t)addr { vic->setScreenMemoryAddr(addr); }
- (uint16_t) characterMemoryAddr { return vic->getCharacterMemoryAddr(); }
- (void) setCharacterMemoryAddr:(uint16_t)addr { vic->setCharacterMemoryAddr(addr); }

- (int) displayMode { return vic->getDisplayMode(); }
- (void) setDisplayMode:(long)mode { vic->setDisplayMode((DisplayMode)mode); }
- (int) screenGeometry { return (int)vic->getScreenGeometry(); }
- (void) setScreenGeometry:(long)mode { vic->setScreenGeometry((ScreenGeometry)mode); }
- (int) horizontalRasterScroll { return vic->getHorizontalRasterScroll(); }
- (void) setHorizontalRasterScroll:(int)offset { vic->setHorizontalRasterScroll(offset & 0x07); }
- (int) verticalRasterScroll { return vic->getVerticalRasterScroll(); }
- (void) setVerticalRasterScroll:(int)offset { vic->setVerticalRasterScroll(offset & 0x07); }

- (bool) spriteVisibilityFlag:(NSInteger)nr { return vic->spriteIsEnabled(nr); }
- (void) setSpriteVisibilityFlag:(NSInteger)nr value:(bool)flag { vic->setSpriteEnabled(nr, flag); }
- (void) toggleSpriteVisibilityFlag:(NSInteger)nr { vic->toggleSpriteEnabled(nr); }

- (int) spriteX:(NSInteger)nr { return vic->getSpriteX(nr); }
- (void) setSpriteX:(NSInteger)nr value:(int)x { vic->setSpriteX(nr, x); }
- (int) spriteY:(NSInteger)nr { return vic->getSpriteY(nr); }
- (void) setSpriteY:(NSInteger)nr value:(int)y { vic->setSpriteY(nr, y); }

- (int) spriteColor:(NSInteger)nr { return vic->spriteColor(nr); }
- (void) setSpriteColor:(NSInteger)nr value:(int)c { vic->setSpriteColor(nr, c); }
- (bool) spriteMulticolorFlag:(NSInteger)nr { return vic->spriteIsMulticolor((unsigned)nr); }
- (void) setSpriteMulticolorFlag:(NSInteger)nr value:(bool)flag { vic->setSpriteMulticolor((unsigned)nr, flag); }
- (void) toggleSpriteMulticolorFlag:(NSInteger)nr { vic->toggleMulticolorFlag((unsigned)nr); }

- (bool) spriteStretchXFlag:(NSInteger)nr { return vic->spriteWidthIsDoubled((unsigned)nr); }
- (void) setSpriteStretchXFlag:(NSInteger)nr value:(bool)flag { vic->setSpriteStretchX((unsigned)nr, flag); }
- (void) toggleSpriteStretchXFlag:(NSInteger)nr { vic->spriteToggleStretchXFlag((unsigned)nr); }

- (bool) spriteStretchYFlag:(NSInteger)nr { return vic->spriteHeightIsDoubled((unsigned)nr); }
- (void) setSpriteStretchYFlag:(NSInteger)nr value:(bool)flag { return vic->setSpriteStretchY((unsigned)nr, flag); }
- (void) toggleSpriteStretchYFlag:(NSInteger)nr { vic->spriteToggleStretchYFlag((unsigned)nr); }

- (bool) spriteSpriteCollisionFlag { return vic->getSpriteSpriteCollisionFlag(); }
- (void) setSpriteSpriteCollisionFlag:(bool)flag { vic->setSpriteSpriteCollisionFlag(flag); }
- (void) toggleSpriteSpriteCollisionFlag { vic->toggleSpriteSpriteCollisionFlag(); }

- (bool) spriteBackgroundCollisionFlag { return vic->getSpriteBackgroundCollisionFlag(); }
- (void) setSpriteBackgroundCollisionFlag:(bool)flag { vic->setSpriteBackgroundCollisionFlag(flag); }
- (void) toggleSpriteBackgroundCollisionFlag { vic->toggleSpriteBackgroundCollisionFlag(); }

- (uint16_t) rasterline { return vic->getScanline(); }
- (void) setRasterline:(uint16_t)line { vic->setScanline(line); }
- (uint16_t) rasterInterruptLine { return vic->rasterInterruptLine(); }
- (void) setRasterInterruptLine:(uint16_t)line { vic->setRasterInterruptLine(line); }
- (bool) rasterInterruptFlag { return vic->rasterInterruptEnabled(); }
- (void) setRasterInterruptFlag:(bool)b { vic->setRasterInterruptEnable(b); }
- (void) toggleRasterInterruptFlag { vic->toggleRasterInterruptFlag(); }

- (bool) hideSprites { return vic->hideSprites(); }
- (void) setHideSprites:(bool)b { vic->setHideSprites(b); }
- (bool) showIrqLines { return vic->showIrqLines(); }
- (void) setShowIrqLines:(bool)b { vic->setShowIrqLines(b); }
- (bool) showDmaLines { return vic->showDmaLines(); }
- (void) setShowDmaLines:(bool)b { vic->setShowDmaLines(b); }

@end

// --------------------------------------------------------------------------
//                                     CIA
// --------------------------------------------------------------------------

@implementation CIAProxy

- (instancetype) initWithCIA:(CIA *)c
{
    self = [super init];	
	cia = c;	
	return self;
}

- (void) dump { cia->dumpState(); }
- (bool) tracingEnabled { return cia->tracingEnabled(); }
- (void) setTraceMode:(bool)b { cia->setTraceMode(b); }

- (uint8_t) dataPortA { return cia->getDataPortA(); }
- (void) setDataPortA:(uint8_t)v { cia->setDataPortA(v); }
- (uint8_t) dataPortDirectionA { return cia->getDataPortDirectionA(); }
- (void) setDataPortDirectionA:(uint8_t)v { cia->setDataPortDirectionA(v); }
- (uint16_t) timerA { return cia->getCounterA(); }
- (void) setTimerA:(uint16_t)v { cia->setCounterA(v); }
- (uint16_t) timerLatchA { return cia->getLatchA(); }
- (void) setTimerLatchA:(uint16_t)v { cia->setLatchA(v); }
- (bool) startFlagA { return cia->isStartedA(); }
- (void) setStartFlagA:(bool)b { cia->setStartedA(b); }
- (void) toggleStartFlagA {cia->toggleStartFlagA(); }
- (bool) oneShotFlagA { return cia->isOneShotA(); }
- (void) setOneShotFlagA:(bool)b { cia->setOneShotA(b); }
- (void) toggleOneShotFlagA { cia->toggleOneShotFlagA(); }
- (bool) underflowFlagA { return cia->willIndicateUnderflowA(); }
- (void) setUnderflowFlagA:(bool)b { return cia->setIndicateUnderflowA(b); }
- (void) toggleUnderflowFlagA { cia->toggleUnderflowFlagA(); }
- (bool) pendingSignalFlagA {return cia->isSignalPendingA(); }
- (void) setPendingSignalFlagA:(bool)b { cia->setSignalPendingA(b); }
- (void) togglePendingSignalFlagA { cia->togglePendingSignalFlagA(); }
- (bool) interruptEnableFlagA { return cia->isInterruptEnabledA(); }
- (void) setInterruptEnableFlagA:(bool)b { cia->setInterruptEnabledA(b); }
- (void) toggleInterruptEnableFlagA {cia->toggleInterruptEnableFlagA(); }

- (uint8_t) dataPortB { return cia->getDataPortB(); }
- (void) setDataPortB:(uint8_t)v { cia->setDataPortB(v); }
- (uint8_t) dataPortDirectionB { return cia->getDataPortDirectionB(); }
- (void) setDataPortDirectionB:(uint8_t)v { cia->setDataPortDirectionB(v); }
- (uint16_t) timerB { return cia->getCounterB(); }
- (void) setTimerB:(uint16_t)v { cia->setCounterB(v); }
- (uint16_t) timerLatchB { return cia->getLatchB(); }
- (void) setTimerLatchB:(uint16_t)v { cia->setLatchB(v); }
- (bool) startFlagB { return cia->isStartedB(); }
- (void) setStartFlagB:(bool)b { cia->setStartedB(b); }
- (void) toggleStartFlagB {cia->toggleStartFlagB(); }
- (bool) oneShotFlagB { return cia->isOneShotB(); }
- (void) setOneShotFlagB:(bool)b { cia->setOneShotB(b); }
- (void) toggleOneShotFlagB { cia->toggleOneShotFlagB(); }
- (bool) underflowFlagB { return cia->willIndicateUnderflowB(); }
- (void) setUnderflowFlagB:(bool)b { return cia->setIndicateUnderflowB(b); }
- (void) toggleUnderflowFlagB { cia->toggleUnderflowFlagB(); }
- (bool) pendingSignalFlagB {return cia->isSignalPendingB(); }
- (void) setPendingSignalFlagB:(bool)b { cia->setSignalPendingB(b); }
- (void) togglePendingSignalFlagB { cia->togglePendingSignalFlagB(); }
- (bool) interruptEnableFlagB { return cia->isInterruptEnabledB(); }
- (void) setInterruptEnableFlagB:(bool)b { cia->setInterruptEnabledB(b); }
- (void) toggleInterruptEnableFlagB {cia->toggleInterruptEnableFlagB(); }

- (uint8_t) todHours { return cia->tod.getTodHours(); }
- (void) setTodHours:(uint8_t)value { cia->tod.setTodHours(value); }
- (uint8_t) todMinutes { return cia->tod.getTodMinutes(); }
- (void) setTodMinutes:(uint8_t)value { cia->tod.setTodMinutes(value); }
- (uint8_t) todSeconds { return cia->tod.getTodSeconds(); }
- (void) setTodSeconds:(uint8_t)value { cia->tod.setTodSeconds(value); }
- (uint8_t) todTenth { return cia->tod.getTodTenth(); }
- (void) setTodTenth:(uint8_t)value { cia->tod.setTodTenth(value); }

- (uint8_t) alarmHours { return cia->tod.getAlarmHours(); }
- (void) setAlarmHours:(uint8_t)value { cia->tod.setAlarmHours(value); }
- (uint8_t) alarmMinutes { return cia->tod.getAlarmMinutes(); }
- (void) setAlarmMinutes:(uint8_t)value { cia->tod.setAlarmMinutes(value); }
- (uint8_t) alarmSeconds { return cia->tod.getAlarmSeconds(); }
- (void) setAlarmSeconds:(uint8_t)value { cia->tod.setAlarmSeconds(value); }
- (uint8_t) alarmTenth { return cia->tod.getAlarmTenth(); }
- (void) setAlarmTenth:(uint8_t)value { cia->tod.setAlarmTenth(value); }
- (bool) isTodInterruptEnabled { return cia->isInterruptEnabledTOD(); }
- (void) setTodInterruptEnabled:(bool)b { cia->setInterruptEnabledTOD(b); }

@end 

// --------------------------------------------------------------------------
//                                    Keyboard
// --------------------------------------------------------------------------

@implementation KeyboardProxy

- (instancetype) initWithKeyboard:(Keyboard *)kb
{
    self = [super init];	
	keyboard = kb;	
	return self;
}

- (void) dump { keyboard->dumpState(); }
- (void) pressKey:(int)c { keyboard->pressKey(c); }
- (void) releaseKey:(int)c { keyboard->releaseKey(c); }
- (void) pressRunstopKey { keyboard->pressRunstopKey(); }
- (void) releaseRunstopKey { keyboard->releaseRunstopKey(); }
- (void) pressShiftRunstopKey { keyboard->pressShiftRunstopKey(); }
- (void) releaseShiftRunstopKey { keyboard->releaseShiftRunstopKey(); }
- (void) pressRestoreKey { keyboard->pressRestoreKey(); }
- (void) releaseRestoreKey { keyboard->releaseRestoreKey(); }
- (void) pressCommodoreKey { keyboard->pressCommodoreKey(); }
- (void) releaseCommodoreKey { keyboard->releaseCommodoreKey(); }
- (void) pressClearKey { keyboard->pressClearKey(); }
- (void) releaseClearKey { keyboard->releaseClearKey(); }
- (void) pressHomeKey { keyboard->pressHomeKey(); }
- (void) releaseHomeKey { keyboard->releaseHomeKey(); }
- (void) pressInsertKey { keyboard->pressInsertKey(); }
- (void) releaseInsertKey { keyboard->releaseInsertKey(); }

- (void)typeText:(NSString *)text
{
    [self typeText:text withDelay:0];
}

- (void)typeText:(NSString *)text withDelay:(int)delay
{    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{ [self _typeText:text withDelay:delay]; });
}

- (void)_typeText:(NSString *)text withDelay:(int)delay
{
    const unsigned MAXCHARS = 256;
    const unsigned KEYDELAY = 27500;
    unsigned i;
    
    fprintf(stderr, "Typing: ");

    usleep(delay);
    for (i = 0; i < [text length] && i < MAXCHARS; i++) {
            
        unichar uc = [text characterAtIndex:i];
        char c = (char)uc;
            
        if (isupper(c))
            c = tolower(c);
            
        fprintf(stderr, "%c",c);
            
        usleep(KEYDELAY);
        [self pressKey:c];
        usleep(KEYDELAY);
        [self releaseKey:c];
    }
        
    if (i != [text length]) {
        // Abbreviate text by three dots
        for (i = 0; i < 3; i++) {
            [self pressKey:'.'];
            usleep(KEYDELAY);
            [self releaseKey:'.'];
            usleep(KEYDELAY);
        }
    }
        
    fprintf(stderr,"\n");
}


@end

// --------------------------------------------------------------------------
//                                 Joystick
// -------------------------------------------------------------------------

#if 0
@implementation JoystickManagerProxy

- (instancetype) initWithC64:(C64Proxy *)c64
{
    self = [super init];
    manager = new JoystickManager(c64);
    if (!manager->initialize()) {
        NSLog(@"WARNING: Failed to initialize joystick manager.");
        self = nil;
    }

    return self;
    return nil;
}

@end
#endif

@implementation JoystickProxy

- (instancetype) initWithJoystick:(Joystick *)joy
{
    self = [super init];
    joystick = joy;
    return self;
}

- (void) setButtonPressed:(BOOL)pressed { joystick->setButtonPressed(pressed); }
- (void) setAxisX:(JoystickDirection)state { joystick->setAxisX(state); }
- (void) setAxisY:(JoystickDirection)state {joystick->setAxisY(state); }

- (void) dump { joystick->dumpState(); }

@end

// --------------------------------------------------------------------------
//                                    SID
// --------------------------------------------------------------------------

@implementation SIDProxy

- (instancetype) initWithSID:(SIDWrapper *)s
{
    self = [super init];	
	sid = s;	
	return self;
}

- (void) dump { sid->dumpState(); }

@end

// --------------------------------------------------------------------------
//                                   IEC bus
// -------------------------------------------------------------------------

@implementation IECProxy

- (instancetype) initWithIEC:(IEC *)bus
{
    self = [super init];	
	iec = bus;	
	return self;
}

- (void) dump { iec->dumpState(); }
- (bool) tracingEnabled { return iec->tracingEnabled(); }
- (void) setTraceMode:(bool)b { iec->setTraceMode(b); }
- (void) connectDrive { iec->connectDrive(); }
- (void) disconnectDrive { iec->disconnectDrive(); }
- (bool) isDriveConnected { return iec->driveIsConnected(); }

@end

// --------------------------------------------------------------------------
//                                 Expansion port
// -------------------------------------------------------------------------

@implementation ExpansionPortProxy

- (instancetype) initWithExpansionPort:(ExpansionPort *)port
{
    self = [super init];
    expansionPort = port;
    return self;
}

- (void) dump { expansionPort->dumpState(); }
- (int) cartridgeType { return (int)expansionPort->getCartridgeType(); }
- (bool) cartridgeAttached { return expansionPort->getCartridgeAttached(); }
- (unsigned) numberOfChips { return expansionPort->numberOfChips(); }
- (unsigned) numberOfBytes { return expansionPort->numberOfBytes(); }

@end

// --------------------------------------------------------------------------
//                                     VIA
// -------------------------------------------------------------------------

@implementation VIAProxy

- (instancetype) initWithVIA:(VIA6522 *)v
{
    self = [super init];	
	via = v;
	return self;
}

- (void) dump { via->dumpState(); }
- (bool) tracingEnabled { return via->tracingEnabled(); }
- (void) setTraceMode:(bool)b { via->setTraceMode(b); }

@end

// -------------------------------------------------------------------------
//                                5,25" diskette
// -------------------------------------------------------------------------

@implementation Disk525Proxy

- (instancetype) initWithDisk525:(Disk525 *)d
{
    self = [super init];
    disk = d;
    return self;
}

- (BOOL)isWriteProtected { return disk->isWriteProtected(); }
- (void)setWriteProtection:(BOOL)b { disk->setWriteProtection(b); }
- (BOOL)isModified { return disk->isModified(); }
- (void)setModified:(BOOL)b { disk->setModified(b); }
- (NSInteger)numTracks { return (NSInteger)disk->numTracks; }


@end

// -------------------------------------------------------------------------
//                                    VC1541
// -------------------------------------------------------------------------

@implementation VC1541Proxy

@synthesize cpu, mem, via1, via2, disk;

- (instancetype) initWithVC1541:(VC1541 *)vc
{
    self = [super init];	
	vc1541 = vc;
	cpu = [[CPUProxy alloc] initWithCPU:&vc->cpu];
	mem = [[MemoryProxy alloc] initWithMemory:&vc->mem];
	via1 = [[VIAProxy alloc] initWithVIA:&vc->via1];
	via2 = [[VIAProxy alloc] initWithVIA:&vc->via2];
    disk = [[Disk525Proxy alloc] initWithDisk525:&vc->disk];
	return self;
}

- (VIAProxy *) via:(int)num {
	switch (num) {
		case 1:
			return [self via1];
		case 2:
			return [self via2];
		default:
			assert(0);
			return NULL;
	}
}

- (void) dump { vc1541->dumpState(); }
- (bool) tracingEnabled { return vc1541->tracingEnabled(); }
- (void) setTraceMode:(bool)b { vc1541->setTraceMode(b); }
- (bool) hasRedLED { return vc1541->getRedLED(); }
- (bool) hasDisk { return vc1541->hasDisk(); }
- (void) ejectDisk { vc1541->ejectDisk(); }
- (bool) writeProtection { return vc1541->disk.isWriteProtected(); }
- (void) setWriteProtection:(bool)b { vc1541->disk.setWriteProtection(b); }
- (bool) DiskModified { return vc1541->disk.isModified(); }
- (void) setDiskModified:(bool)b { vc1541->disk.setModified(b); }
- (bool) bitAccuracy { return vc1541->getBitAccuracy(); }
- (void) setBitAccuracy:(bool)b { vc1541->setBitAccuracy(b); }
- (bool) soundMessagesEnabled { return vc1541->soundMessagesEnabled(); }
- (void) setSendSoundMessages:(bool)b { vc1541->setSendSoundMessages(b); }
- (bool) exportToD64:(NSString *)path { return vc1541->exportToD64([path UTF8String]); }

- (D64ArchiveProxy *) convertToD64
{
    D64Archive *archive = vc1541->convertToD64();
    return archive ? [[D64ArchiveProxy alloc] initWithArchive:archive] : nil;
}

- (void) playSound:(NSString *)name volume:(float)v
{
    NSSound *s = [NSSound soundNamed:name];
    [s setVolume:v];
    [s play];
}

@end

// --------------------------------------------------------------------------
//                                    Datasette
// -------------------------------------------------------------------------

@implementation DatasetteProxy

- (instancetype) initWithDatasette:(Datasette *)ds
{
    self = [super init];
    datasette = ds;
    return self;
}

- (void) dump { datasette->dumpState(); }
- (bool) hasTape { return datasette->hasTape(); }
- (void) pressPlay { datasette->pressPlay(); }
- (void) pressStop { datasette->pressStop(); }
- (void) pressRewind { datasette->rewind(); }
- (void) ejectTape { datasette->ejectTape(); }
- (NSInteger) getType { return datasette->getType(); }
- (long) durationInCycles { return datasette->getDurationInCycles(); }
- (int) durationInSeconds { return datasette->getDurationInSeconds(); }
- (int) head { return datasette->getHead(); }
- (long) headInCycles { return datasette->getHeadInCycles(); }
- (int) headInSeconds { return datasette->getHeadInSeconds(); }
- (void) setHeadInCycles:(long)value { datasette->setHeadInCycles(value); }
- (BOOL) motor { return datasette->getMotor(); }
- (BOOL) playKey { return datasette->getPlayKey(); }
@end

// --------------------------------------------------------------------------
//                                     C64
// --------------------------------------------------------------------------

@implementation C64Proxy

@synthesize c64, cpu, mem, vic, cia1, cia2, sid, keyboard, iec, expansionport, vc1541, datasette;
@synthesize joystickA, joystickB; 
@synthesize iecBusIsBusy, tapeBusIsBusy;

- (instancetype) init
{
	NSLog(@"C64Proxy::init");
	
    self = [super init];
	
	// Create virtual machine and initialize references
	c64 = new C64();
	
	// Create sub proxys
	cpu = [[CPUProxy alloc] initWithCPU:&c64->cpu];
    // cpu = [[CPUProxy alloc] initWithCPU:&c64->floppy->cpu];
	mem = [[MemoryProxy alloc] initWithMemory:&c64->mem];
	vic = [[VICProxy alloc] initWithVIC:&c64->vic];
	cia1 = [[CIAProxy alloc] initWithCIA:&c64->cia1];
	cia2 = [[CIAProxy alloc] initWithCIA:&c64->cia2];
	sid = [[SIDProxy alloc] initWithSID:&c64->sid];
	keyboard = [[KeyboardProxy alloc] initWithKeyboard:&c64->keyboard];
    joystickA = [[JoystickProxy alloc] initWithJoystick:&c64->joystickA];
    joystickB = [[JoystickProxy alloc] initWithJoystick:&c64->joystickB];
    iec = [[IECProxy alloc] initWithIEC:&c64->iec];
    expansionport = [[ExpansionPortProxy alloc] initWithExpansionPort:&c64->expansionport];
	vc1541 = [[VC1541Proxy alloc] initWithVC1541:&c64->floppy];
    datasette = [[DatasetteProxy alloc] initWithDatasette:&c64->datasette];

    // Initialize Joystick HID interface
    if (!(joystickManager = new JoystickManager(self))) {
        NSLog(@"WARNING: Couldn't initialize HID interface.");
    }
    joystickManager->initialize(); 

	// Initialize CoreAudio sound interface
	if (!(audioDevice = [[AudioDevice alloc] initWithC64:c64])) {
		NSLog(@"WARNING: Couldn't initialize CoreAudio interface. Sound disabled.");
	}
		
    return self;
}

- (void) awakeFromNib
{
}

- (void) kill
{
	assert(c64 != NULL);
	NSLog(@"C64Proxy::kill");

	// Delete sound device
	[self disableAudio];
	audioDevice = nil;
	
    // Delete HDI interface
    delete joystickManager;
    joystickManager = NULL;
    
    // Delete emulator
    delete c64;
	c64 = NULL;
}

- (bool) audioFilter { return c64->getAudioFilter(); }
- (void) setAudioFilter:(bool)b { c64->setAudioFilter(b); }
- (bool) reSID { return c64->getReSID(); }
- (void) setReSID:(bool)b { c64->setReSID(b); }
- (int) samplingMethod { return (int)(c64->getSamplingMethod()); }
- (void) setSamplingMethod:(long)value { c64->setSamplingMethod((sampling_method)value); }
- (int) chipModel { return (chip_model)(c64->getChipModel()); }
- (void) setChipModel:(long)value {c64->setChipModel((chip_model)value); }
- (void) rampUp { c64->sid.rampUp(); }
- (void) rampUpFromZero { c64->sid.rampUpFromZero(); }
- (void) rampDown { c64->sid.rampDown(); }

- (void) _loadFromSnapshot:(Snapshot *)snapshot
{
    c64->suspend();
    c64->loadFromSnapshot(snapshot);
    c64->resume();
}

- (void) loadFromSnapshot:(SnapshotProxy *)snapshot
{
    [self _loadFromSnapshot:[snapshot snapshot]];
}

- (void) _saveToSnapshot:(Snapshot *)snapshot
{
    c64->suspend();
    c64->saveToSnapshot(snapshot);
    c64->resume();
}

- (void) saveToSnapshot:(SnapshotProxy *)snapshot
{
    [self _saveToSnapshot:[snapshot snapshot]];
}

- (CIAProxy *) cia:(int)num { assert(num == 1 || num == 2); return (num == 1) ? [self cia1] : [self cia2]; }

- (void) dump { c64->dumpState(); }

- (Message *)message { return c64->getMessage(); }
- (void) putMessage:(int)msg { c64->putMessage(msg); }
- (void) reset { c64->reset(); }
- (void) ping { c64->ping(); }
- (void) halt { c64->halt(); }
- (void) step { c64->step(); }
- (void) run { c64->run(); }
- (void) suspend { c64->suspend(); }
- (void) resume { c64->resume(); }
- (bool) isHalted { return c64->isHalted(); }
- (bool) isRunnable { return c64->isRunnable(); }
- (bool) isRunning { return c64->isRunning(); }
- (bool) isPAL { return c64->isPAL(); }
- (bool) isNTSC { return c64->isNTSC(); }
- (void) setPAL { c64->setPAL(); }
- (void) setNTSC { c64->setNTSC(); }

//- (int) numberOfMissingRoms { return c64->numberOfMissingRoms(); }
- (uint8_t) missingRoms { return c64->getMissingRoms(); }
- (bool) isBasicRom:(NSString *)filename { return c64->mem.isBasicRom([filename UTF8String]); }
- (bool) loadBasicRom:(NSString *)filename { return c64->loadBasicRom([filename UTF8String]); }
- (bool) isCharRom:(NSString *)filename { return c64->mem.isCharRom([filename UTF8String]); }
- (bool) loadCharRom:(NSString *)filename { return c64->loadCharRom([filename UTF8String]); }
- (bool) isKernelRom:(NSString *)filename { return c64->mem.isKernelRom([filename UTF8String]); }
- (bool) loadKernelRom:(NSString *)filename { return c64->loadKernelRom([filename UTF8String]); }
- (bool) isVC1541Rom:(NSString *)filename { return c64->floppy.mem.is1541Rom([filename UTF8String]); }
- (bool) loadVC1541Rom:(NSString *)filename { return c64->loadVC1541Rom([filename UTF8String]); }
- (bool) isRom:(NSString *)filename { return [self isBasicRom:filename] || [self isCharRom:filename] || [self isKernelRom:filename] || [self isVC1541Rom:filename]; }
- (bool) loadRom:(NSString *)filename { return [self loadBasicRom:filename] || [self loadCharRom:filename] || [self loadKernelRom:filename] || [self loadVC1541Rom:filename]; }

- (bool) attachCartridge:(Cartridge *)c { return c64->attachCartridge(c); }
- (void) detachCartridge { c64->detachCartridge(); }
- (bool) isCartridgeAttached { return c64->isCartridgeAttached(); }

- (bool) mountArchive:(ArchiveProxy *)a { return c64->mountArchive([a archive]); }
- (bool) flushArchive:(ArchiveProxy *)a item:(NSInteger)nr { return c64->flushArchive([a archive], (int)nr); }

- (bool) insertTape:(TAPContainerProxy *)c { return c64->insertTape([c container]); }

- (bool) warp { return c64->getWarp(); }
- (void) setWarp:(bool)b { c64->setWarp(b); }	
- (bool) alwaysWarp { return c64->getAlwaysWarp(); }
- (void) setAlwaysWarp:(bool)b { c64->setAlwaysWarp(b); }
- (bool) warpLoad { return c64->getWarpLoad(); }
- (void) setWarpLoad:(bool)b { c64->setWarpLoad(b); }

- (long) cycles { return (long)c64->getCycles(); }
- (long) frames { return (long)c64->getFrame(); }

// Cheatbox
- (int) historicSnapshots { return c64->numHistoricSnapshots(); }

- (int) historicSnapshotHeaderSize:(NSInteger)nr
    { Snapshot *s = c64->getHistoricSnapshot((int)nr); return s ? s->getHeaderSize() : 0; }

- (uint8_t *) historicSnapshotHeader:(NSInteger)nr
    { Snapshot *s = c64->getHistoricSnapshot((int)nr); return s ? s->getHeader() : NULL; }

- (int) historicSnapshotDataSize:(NSInteger)nr
    { Snapshot *s = c64->getHistoricSnapshot((int)nr); return s ? s->getDataSize() : 0; }

- (uint8_t *) historicSnapshotData:(NSInteger)nr
    { Snapshot *s = c64->getHistoricSnapshot((int)nr); return s ? s->getData() : NULL; }


- (unsigned char *)historicSnapshotImageData:(NSInteger)nr
    { Snapshot *s = c64->getHistoricSnapshot((int)nr); return s ? s->getImageData() : NULL; }
- (unsigned)historicSnapshotImageWidth:(NSInteger)nr
    { Snapshot *s = c64->getHistoricSnapshot((int)nr); return s ? s->getImageWidth() : 0; }
- (unsigned)historicSnapshotImageHeight:(NSInteger)nr
{ Snapshot *s = c64->getHistoricSnapshot((int)nr); return s ? s->getImageHeight() : 0; }
- (time_t)historicSnapshotTimestamp:(NSInteger)nr { Snapshot *s = c64->getHistoricSnapshot((int)nr); return s ? s->getTimestamp() : 0; }
- (bool)revertToHistoricSnapshot:(NSInteger)nr { Snapshot *s = c64->getHistoricSnapshot((int)nr); return s ? c64->loadFromSnapshot(s), true : false; }

// Joystick
- (BOOL)joystickIsPluggedIn:(int)nr { return joystickManager->joystickIsPluggedIn(nr); }
- (void)bindJoystickToPortA:(int)nr { joystickManager->bindJoystickToPortA(nr); }
- (void)bindJoystickToPortB:(int)nr { joystickManager->bindJoystickToPortB(nr); }
- (void)unbindJoysticksFromPortA { joystickManager->unbindJoysticksFromPortA(); }
- (void)unbindJoysticksFromPortB { joystickManager->unbindJoysticksFromPortB(); }

// Audio hardware
- (void) enableAudio { [self rampUpFromZero]; [audioDevice startPlayback]; }
- (void) disableAudio {	[self rampDown]; [audioDevice stopPlayback]; }

@end

// --------------------------------------------------------------------------
//                         Snapshot (needs testing)
// --------------------------------------------------------------------------

@implementation SnapshotProxy

@synthesize snapshot;

- (instancetype) init
{
	NSLog(@"V64Snapshot::init");
	
	if (!(self = [super init]))
		return nil;

	snapshot = new Snapshot;
	return self;
}

- (instancetype) initWithSnapshot:(Snapshot *)s
{
    NSLog(@"V64Snapshot::initWithSnapshot %p", s);
    
    if (s == nil)
        return nil;
    
    if (!(self = [super init]))
        return nil;
    
    snapshot = s;
    return self;
}

- (void) dealloc
{	
	NSLog(@"V64Snapshot::dealloc");

	if (snapshot)
		delete snapshot;
	
}

+ (instancetype) snapshotFromSnapshot:(Snapshot *)snapshot
{
    if (snapshot == NULL)
        return nil;
    
    SnapshotProxy *newSnapshot = [[self alloc] initWithSnapshot:snapshot];
    return newSnapshot;
}

+ (instancetype) snapshotFromFile:(NSString *)path
{
    return [self snapshotFromSnapshot:(Snapshot::snapshotFromFile([path UTF8String]))];
}

+ (instancetype) snapshotFromBuffer:(const void *)buffer length:(unsigned)length
{
    return [self snapshotFromSnapshot:(Snapshot::snapshotFromBuffer((uint8_t *)buffer, length))];
}

- (bool) readDataFromFile:(NSString *)path { return snapshot->readFromFile([path UTF8String]); }
- (bool) writeDataToFile:(NSString *)path { return snapshot->writeToFile([path UTF8String]); }

@end

// --------------------------------------------------------------------------
//                           Archive (incomplete)
// --------------------------------------------------------------------------

@implementation ArchiveProxy

@synthesize archive;

- (instancetype)initWithArchive:(Archive *)a
{
    NSLog(@"ArchiveProxy::initWithArchive %p", archive);

    if (a == nil)
        return nil;
    
    if (!(self = [super init]))
        return nil;
    
    archive = a;

    return self;
}

- (void)dealloc
{
    NSLog(@"ArchiveProxy %p deleted", archive);
    
    if (archive)
        delete archive;
}

- (NSString *)getPath { return [NSString stringWithUTF8String:archive->getPath()]; }
- (NSString *)getName { return [NSString stringWithUTF8String:archive->getName()]; }
- (NSInteger)getType { return (NSInteger)archive->getType(); }
- (NSInteger)getNumberOfItems { return (NSInteger)archive->getNumberOfItems(); }
- (BOOL)writeToFile:(NSString *)filename { return archive->writeToFile([filename UTF8String]); }

@end


@implementation T64ArchiveProxy

+ (BOOL)isT64File:(NSString *)filename
{
    return T64Archive::isT64File([filename UTF8String]);
}

+ (instancetype)archiveFromT64File:(NSString *)filename
{
    T64Archive *archive = T64Archive::archiveFromT64File([filename UTF8String]);
    return archive ? [[T64ArchiveProxy alloc] initWithArchive:archive] : nil;
}

+ (instancetype)archiveFromArchive:(ArchiveProxy *)otherArchive
{
    T64Archive *archive = T64Archive::archiveFromArchive([otherArchive archive]);
    return archive ? [[T64ArchiveProxy alloc] initWithArchive:archive] : nil;
}

@end


@implementation D64ArchiveProxy

+ (BOOL) isD64File:(NSString *)filename
{
   return D64Archive::isD64File([filename UTF8String]);
}

+ (instancetype) archiveFromD64File:(NSString *)filename
{
    D64Archive *archive = D64Archive::archiveFromD64File([filename UTF8String]);
    return archive ? [[D64ArchiveProxy alloc] initWithArchive:archive] : nil;
}

+ (instancetype) archiveFromArbitraryFile:(NSString *)filename
{
    D64Archive *archive = D64Archive::archiveFromArbitraryFile([filename UTF8String]);
    return archive ? [[D64ArchiveProxy alloc] initWithArchive:archive] : nil;
}

+ (instancetype) archiveFromD64Archive:(D64ArchiveProxy *)otherArchive
{
    D64Archive *archive = D64Archive::archiveFromD64Archive((D64Archive *)[otherArchive archive]);
    return archive ? [[D64ArchiveProxy alloc] initWithArchive:archive] : nil;
}

+ (instancetype) archiveFromArchive:(ArchiveProxy *)otherArchive
{
    D64Archive *archive = D64Archive::archiveFromArchive([otherArchive archive]);
    return archive ? [[D64ArchiveProxy alloc] initWithArchive:archive] : nil;
}

@end


@implementation PRGArchiveProxy

+ (BOOL)isPRGFile:(NSString *)filename
{
    return PRGArchive::isPRGFile([filename UTF8String]);
}

+ (instancetype)archiveFromPRGFile:(NSString *)filename
{
    PRGArchive *archive = PRGArchive::archiveFromPRGFile([filename UTF8String]);
    return archive ? [[PRGArchiveProxy alloc] initWithArchive:archive] : nil;
}

+ (instancetype)archiveFromArchive:(ArchiveProxy *)otherArchive
{
    PRGArchive *archive = PRGArchive::archiveFromArchive([otherArchive archive]);
    return archive ? [[PRGArchiveProxy alloc] initWithArchive:archive] : nil;
}

@end


@implementation P00ArchiveProxy

+ (BOOL)isP00File:(NSString *)filename
{
    return P00Archive::isP00File([filename UTF8String]);
}

+ (instancetype)archiveFromP00File:(NSString *)filename
{
    P00Archive *archive = P00Archive::archiveFromP00File([filename UTF8String]);
    return archive ? [[P00ArchiveProxy alloc] initWithArchive:archive] : nil;
}

+ (instancetype)archiveFromArchive:(ArchiveProxy *)otherArchive
{
    P00Archive *archive = P00Archive::archiveFromArchive([otherArchive archive]);
    return archive ? [[P00ArchiveProxy alloc] initWithArchive:archive] : nil;
}

@end


@implementation G64ArchiveProxy

+ (BOOL) isG64File:(NSString *)filename
{
    return G64Archive::isG64File([filename UTF8String]);
}

+ (instancetype) archiveFromG64File:(NSString *)filename
{
    G64Archive *archive = G64Archive::archiveFromG64File([filename UTF8String]);
    return archive ? [[G64ArchiveProxy alloc] initWithArchive:archive] : nil;
}

@end


@implementation NIBArchiveProxy

+ (BOOL) isNIBFile:(NSString *)filename
{
    return NIBArchive::isNIBFile([filename UTF8String]);
}

+ (instancetype) archiveFromNIBFile:(NSString *)filename
{
    NIBArchive *archive = NIBArchive::archiveFromNIBFile([filename UTF8String]);
    return archive ? [[NIBArchiveProxy alloc] initWithArchive:archive] : nil;
}

@end

@implementation TAPContainerProxy

@synthesize container;

- (instancetype) initWithTAPContainer:(TAPArchive *)c
{
    NSLog(@"TAPContainerProxy::initWithContainer");
    
    if (c == nil)
        return nil;
    
    if (!(self = [super init]))
        return nil;
    
    container = c;
    return self;
}

- (void)dealloc
{
    NSLog(@"TAPContainerProxy::dealloc");
    
    if (container)
        delete container;
}

+ (BOOL) isTAPFile:(NSString *)filename
{
    return TAPArchive::isTAPFile([filename UTF8String]);
}

+ (instancetype) containerFromTAPFile:(NSString *)filename
{
    TAPArchive *container = TAPArchive::archiveFromTAPFile([filename UTF8String]);
    return container ? [[TAPContainerProxy alloc] initWithTAPContainer:container] : nil;
}

- (NSString *)getPath { return [NSString stringWithUTF8String:container->getPath()]; }
- (NSString *)getName { return [NSString stringWithUTF8String:container->getName()]; }
- (NSInteger)getType { return (NSInteger)container->getType(); }
- (NSInteger)TAPversion { return (NSInteger)container->TAPversion(); }

@end

