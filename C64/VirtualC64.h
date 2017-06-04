/*!
 * @header      VirtualC64.h
 * @author      Dirk W. Hoffmann, www.dirkwhoffmann.de
 * @copyright   2017 Dirk W. Hoffmann
 */
/*              This program is free software; you can redistribute it and/or modify
 *              it under the terms of the GNU General Public License as published by
 *              the Free Software Foundation; either version 2 of the License, or
 *              (at your option) any later version.
 *
 *              This program is distributed in the hope that it will be useful,
 *              but WITHOUT ANY WARRANTY; without even the implied warranty of
 *              MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *              GNU General Public License for more details.
 *
 *              You should have received a copy of the GNU General Public License
 *              along with this program; if not, write to the Free Software
 *              Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

// -----------------------------------------------------------------------------------------------
//                                  C level API for VirtualC64
// -----------------------------------------------------------------------------------------------

#ifndef VirtualC64_h
#define VirtualC64_h

#include <stdlib.h>

// From ReSID
// enum chip_model { MOS6581, MOS8580 };
// enum sampling_method { SAMPLE_FAST, SAMPLE_INTERPOLATE, SAMPLE_RESAMPLE_INTERPOLATE, SAMPLE_RESAMPLE_FAST };


// -----------------------------------------------------------------------------------------------
//                                 Opaque types used as handles
// -----------------------------------------------------------------------------------------------

struct VC64; typedef struct VC64 VC64;
struct VC64_Snapshot; typedef struct VC64_Snapshot VC64_Snapshot;
struct VC64_Message; typedef struct VC64_Message VC64_Message;
struct VC64_Archive; typedef struct VC64_Archive VC64_Archive;
struct VC64_TAPArchive; typedef struct VC64_TAPArchive VC64_TAPArchive;
struct VC64_Cartridge; typedef struct VC64_Cartridge VC64_Cartridge;



// -----------------------------------------------------------------------------------------------
//                                             C64
// -----------------------------------------------------------------------------------------------

#ifdef __cplusplus
extern "C" {
#endif

    VC64* c64_new();
    void c64_delete(VC64* c64);

    void c64_reset(VC64 *c64);
    void c64_ping(VC64 *c64);
    void c64_dumpState(VC64 *c64);

    bool c64_isPAL(VC64 *c64);
    void c64_setPAL(VC64 *c64);
    bool c64_isNTSC(VC64 *c64);
    void c64_setNTSC(VC64 *c64);
    bool c64_getAudioFilter(VC64 *c64);
    void c64_setAudioFilter(VC64 *c64, bool value);
    bool c64_getReSID(VC64 *c64);
    void c64_setReSID(VC64 *c64, bool value);
    // sampling_method c64_getSamplingMethod(VC64 *c64);
    // void c64_setSamplingMethod(VC64 *c64, sampling_method value);
    // chip_model c64_getChipModel(VC64 *c64);
    // void c64_setChipModel(VC64 *c64, chip_model value);
    void c64_run(VC64 *c64);
    void c64_threadCleanup(VC64 *c64);
    bool c64_isRunnable(VC64 *c64);
    bool c64_isRunning(VC64 *c64);
    void c64_halt(VC64 *c64);
    bool c64_isHalted(VC64 *c64);
    void c64_step(VC64 *c64);
    bool c64_executeOneLine(VC64 *c64);
    
    bool c64_getWarp(VC64 *c64);
    void c64_setWarp(VC64 *c64, bool b);
    bool c64_getAlwaysWarp(VC64 *c64);
    void c64_setAlwaysWarp(VC64 *c64, bool b);
    bool c64_getWarpLoad(VC64 *c64);
    void c64_setWarpLoad(VC64 *c64, bool b);
    void c64_restartTimer(VC64 *c64);
    void c64_synchronizeTiming(VC64 *c64);
    uint64_t c64_getCycles(VC64 *c64);
    uint64_t c64_getFrame(VC64 *c64);
    uint16_t c64_getRasterline(VC64 *c64);
    uint8_t c64_getRasterlineCycle(VC64 *c64);
    uint8_t c64_getMissingRoms(VC64 *c64);
    bool c64_loadRom(VC64 *c64, const char *filename);
    bool c64_loadBasicRom(VC64 *c64, const char *filename);
    bool c64_loadCharRom(VC64 *c64, const char *filename);
    bool c64_loadKernelRom(VC64 *c64, const char *filename);
    bool c64_loadVC1541Rom(VC64 *c64, const char *filename);
    void c64_loadFromSnapshot(VC64 *c64, VC64_Snapshot *snapshot);
    void c64_saveToSnapshot(VC64 *c64, VC64_Snapshot *snapshot);
    void c64_takeSnapshot(VC64 *c64);
    unsigned c64_numHistoricSnapshots(VC64 *c64);
    VC64_Snapshot *c64_getHistoricSnapshot(VC64 *c64, int nr);
    bool c64_flushArchive(VC64 *c64, VC64_Archive *a, int item);
    bool c64_mountArchive(VC64 *c64, VC64_Archive *a);
    bool c64_insertTape(VC64 *c64, VC64_TAPArchive *a);
    bool c64_attachCartridge(VC64 *c64, VC64_Cartridge *c);
    void c64_detachCartridge(VC64 *c64);
    bool c64_isCartridgeAttached(VC64 *c64);
    VC64_Message *c64_getMessage(VC64 *c64);
    void c64_putMessage(VC64 *c64, int id);
    void c64_putCustomMessage(VC64 *c64, int id, int i, void *p, const char *c);

    
// -----------------------------------------------------------------------------------------------
//                                             Message
// -----------------------------------------------------------------------------------------------

int message_id(VC64_Message *msg);
char *message_c(VC64_Message *msg);
int message_i(VC64_Message *msg);
void *message_p(VC64_Message *msg);


// To be continued

#ifdef __cplusplus
}
#endif



#endif
