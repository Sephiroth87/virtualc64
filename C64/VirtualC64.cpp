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

#include "VirtualC64.h"
#include "C64.h"

extern "C" {

    // -----------------------------------------------------------------------------------------------
    //                                             C64
    // -----------------------------------------------------------------------------------------------

    VC64* c64_new() { return reinterpret_cast<VC64*>(new C64()); }
    void c64_delete(VC64* c64) { assert (c64 != NULL); delete reinterpret_cast<C64*>(c64); }
    
    void c64_reset(VC64 *c64) { reinterpret_cast<C64*>(c64)->reset(); }
    void c64_ping(VC64 *c64) { reinterpret_cast<C64*>(c64)->ping(); }
    void c64_dumpState(VC64 *c64) { reinterpret_cast<C64*>(c64)->dumpState(); }

    bool c64_isPAL(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isPAL(); }
    void c64_setPAL(VC64 *c64) { reinterpret_cast<C64*>(c64)->setPAL(); }
    bool c64_isNTSC(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isNTSC(); }
    void c64_setNTSC(VC64 *c64) { reinterpret_cast<C64*>(c64)->setNTSC(); }
    bool c64_getAudioFilter(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getAudioFilter(); }
    void c64_setAudioFilter(VC64 *c64, bool value) { reinterpret_cast<C64*>(c64)->setAudioFilter(value); }
    bool c64_getReSID(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getReSID(); }
    void c64_setReSID(VC64 *c64, bool value) { reinterpret_cast<C64*>(c64)->setReSID(value); }
    sampling_method c64_getSamplingMethod(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getSamplingMethod(); }
    void c64_setSamplingMethod(VC64 *c64, sampling_method value) { reinterpret_cast<C64*>(c64)->setSamplingMethod(value); }
    chip_model c64_getChipModel(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getChipModel(); }
    void c64_setChipModel(VC64 *c64, chip_model value) { reinterpret_cast<C64*>(c64)->setChipModel(value); }
    void c64_run(VC64 *c64) { reinterpret_cast<C64*>(c64)->run(); }
    void c64_threadCleanup(VC64 *c64) { reinterpret_cast<C64*>(c64)->threadCleanup(); } // TODO: MAKE PRIVATE
    bool c64_isRunnable(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isRunnable(); }
    bool c64_isRunning(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isRunning(); }
    void c64_halt(VC64 *c64) { reinterpret_cast<C64*>(c64)->halt(); }
    bool c64_isHalted(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isHalted(); }
    void c64_step(VC64 *c64) { reinterpret_cast<C64*>(c64)->step(); }
    bool c64_executeOneLine(VC64 *c64) { return reinterpret_cast<C64*>(c64)->executeOneLine(); }
    
    bool c64_getWarp(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getWarp(); }
    void c64_setWarp(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->setWarp(b); }
    bool c64_getAlwaysWarp(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getAlwaysWarp(); }
    void c64_setAlwaysWarp(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->setAlwaysWarp(b); }
    bool c64_getWarpLoad(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getWarpLoad(); }
    void c64_setWarpLoad(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->setWarpLoad(b); }
    void c64_restartTimer(VC64 *c64) { reinterpret_cast<C64*>(c64)->restartTimer(); }
    void c64_synchronizeTiming(VC64 *c64) { reinterpret_cast<C64*>(c64)->synchronizeTiming(); }
    uint64_t c64_getCycles(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getCycles(); }
    uint64_t c64_getFrame(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getFrame(); }
    uint16_t c64_getRasterline(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getRasterline(); }
    uint8_t c64_getRasterlineCycle(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getRasterlineCycle(); }
    uint8_t c64_getMissingRoms(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getMissingRoms(); }
    bool c64_loadRom(VC64 *c64, const char *filename) { return reinterpret_cast<C64*>(c64)->loadRom(filename); }
    void c64_loadFromSnapshot(VC64 *c64, VC64_Snapshot *snapshot) {
        reinterpret_cast<C64*>(c64)->loadFromSnapshot(reinterpret_cast<Snapshot*>(snapshot)); }
    void c64_saveToSnapshot(VC64 *c64, VC64_Snapshot *snapshot) {
        reinterpret_cast<C64*>(c64)->saveToSnapshot(reinterpret_cast<Snapshot*>(snapshot)); }
    void c64_takeSnapshot(VC64 *c64) { reinterpret_cast<C64*>(c64)->takeSnapshot(); }
    unsigned c64_numHistoricSnapshots(VC64 *c64) { return reinterpret_cast<C64*>(c64)->numHistoricSnapshots(); }
    VC64_Snapshot *c64_getHistoricSnapshot(VC64 *c64, int nr) {
        return reinterpret_cast<VC64_Snapshot*>(reinterpret_cast<C64*>(c64)->getHistoricSnapshot(nr)); }
    bool c64_flushArchive(VC64 *c64, VC64_Archive *a, int item) {
        return reinterpret_cast<C64*>(c64)->flushArchive(reinterpret_cast<Archive*>(a), item); }
    bool c64_mountArchive(VC64 *c64, VC64_Archive *a) {
        return reinterpret_cast<C64*>(c64)->mountArchive(reinterpret_cast<Archive*>(a)); }
    bool c64_insertTape(VC64 *c64, VC64_TAPArchive *a) {
        return reinterpret_cast<C64*>(c64)->insertTape(reinterpret_cast<TAPArchive*>(a)); }
    bool c64_attachCartridge(VC64 *c64, VC64_Cartridge *c) {
        return reinterpret_cast<C64*>(c64)->attachCartridge(reinterpret_cast<Cartridge*>(c)); }
    void c64_detachCartridge(VC64 *c64) { reinterpret_cast<C64*>(c64)->detachCartridge(); }
    bool c64_isCartridgeAttached(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isCartridgeAttached(); }
    VC64_Message *c64_getMessage(VC64 *c64) {
        return reinterpret_cast<VC64_Message*>(reinterpret_cast<C64*>(c64)->getMessage()); }
    void c64_putMessage(VC64 *c64, int id, int i, void *p, const char *c) {
        reinterpret_cast<C64*>(c64)->putMessage(id, i, p, c); }

    
    
}
