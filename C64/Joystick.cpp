/*
 * Authors: Benjamin Klein (Original)
 *          Dirk W. Hoffmann (Further development) 
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
 
#include "C64.h"

Joystick::Joystick(int p) {

    assert(p == 1 || p == 2);
    
    setDescription("Joystick");
    debug(3, "    Creating game port %c at address %p...\n", p, this);
}

Joystick::~Joystick()
{
}

void
Joystick::reset()
{
    VirtualComponent::reset();

    button = false;
    axisX = 0;
    axisY = 0;
}

void
Joystick::loadFromBuffer(uint8_t **buffer)
{
    // Discard any active joystick movements
    button = false;
    axisX = 0;
    axisY = 0;
}

void
Joystick::dumpState()
{
    msg("Joystick port\n");
    msg("-------------\n");
    msg("Button:  %s AxisX: %d AxisY: %d\n", button ? "YES" : "NO", axisX, axisY);
    msg("Bitmask: %02X\n", bitmask());
}

void
Joystick::trigger(JoystickEvent event)
{
    switch (event) {
            
        case PULL_UP:
            axisY = -1;
            break;
        case PULL_DOWN:
            axisY = 1;
            break;
        case PULL_LEFT:
            axisX = -1;
            break;
        case PULL_RIGHT:
            axisX = 1;
            break;
        case PRESS_FIRE:
            button = true;
            break;
        case RELEASE_X:
            axisX = 0;
            break;
        case RELEASE_Y:
            axisY = 0;
            break;
        case RELEASE_XY:
            axisX = 0;
            axisY = 0;
            break;
        case RELEASE_FIRE:
            button = false;
            break;
        default:
            assert(0);
    }
}

uint8_t
Joystick::bitmask() {
    
    uint8_t result = 0xFF;
    
    if (axisY == -1) CLR_BIT(result, 0);
    if (axisY ==  1) CLR_BIT(result, 1);
    if (axisX == -1) CLR_BIT(result, 2);
    if (axisX ==  1) CLR_BIT(result, 3);
    if (button)      CLR_BIT(result, 4);
    
    return result;
}

