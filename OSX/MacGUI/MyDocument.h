/*
 * (C) 2006 - 2011 Dirk W. Hoffmann. All rights reserved.
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

#import <Cocoa/Cocoa.h>

@class C64Proxy;
class Archive;
class TAPArchive;
class Cartridge;
class Snapshot;

@interface MyDocument : NSDocument
{
	// Bridge to VirtualC64
	C64Proxy *__strong c64; // DEPRECATED
    VC64 *vc64;
    
    //! Reference to an attached VC64 snapshot
    /*! When a new documents opens and this variable is not NULL, the snapshot is automatically flashed */
    Snapshot *snapshot; // TODO: Replace by SnapshotProxy

	//! Reference to an attached D64, G64, or NIB archive
	/*! When a new documents opens and this variable is not NULL, the archive is automatically inserted into the virtual floopy drive */
    ArchiveProxy *attachedArchive;
    
    //! Reference to an attached tape image
    /*! When a new documents opens and this variable is not NULL, the tape is automatically inserted into the virtual datasette */
    TAPContainerProxy *attachedTape; 

	//! Reference to an attached cartridge 
    /*! When a new documents opens and this variable is not NULL, the cartridge is automatically plugged into the virtual expansion port */
	Cartridge *cartridge; // TODO: Replace by CartridgeProxy
}

@property (strong) C64Proxy *c64;
@property (assign) VC64 *vc64;
@property (assign) Snapshot *snapshot;
@property ArchiveProxy *attachedArchive;
@property TAPContainerProxy *attachedTape;
@property (assign) Cartridge *cartridge;

- (BOOL)setSnapshotWithName:(NSString *)path;
- (BOOL)setG64ArchiveWithName:(NSString *)path;
- (BOOL)setNIBArchiveWithName:(NSString *)path;
- (BOOL)setArchiveWithName:(NSString *)path;
- (BOOL)setTAPArchiveWithName:(NSString *)path;
- (BOOL)setCartridgeWithName:(NSString *)path;
- (BOOL)detachCartridge;

// Loading and saving
- (BOOL)loadRom:(NSString *)filename;
- (void)showVersionNumberAlert;

@end

