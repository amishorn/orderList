/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Matt Vogt <matthew.vogt@jollamobile.com>
** All rights reserved.
** 
** This file is part of Sailfish Silica UI component package.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the Jolla Ltd nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
** 
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0

// TODO: Investigate using one quarter of the image mirrored in two directions
// TODO: Investigate using a scaled down version of the image

Item {
    id: quantSelector

    // number of sections per one full turn
    property int nCoasInt: 10
    property int nFineInt: 10

    property int coarse: 0
    property int cdelta: 0
    property int fine: 0
    property int fdelta: 0

    // setting if only natural numbers (only positive and 0) should be shown
    property bool onlyNatNumbers: true

    property real _fineWidth: Theme.itemSizeExtraSmall

    width: screen.sizeCategory > Screen.Medium ? Theme.itemSizeLarge*4 : Theme.itemSizeMedium*4
    height: width

    // updates the coarse selector if coarse is set from outside of this file
    onCoarseChanged: {
        coarse = ((coarse < 0 && onlyNatNumbers) ? 0 : coarse)

        if (mouse.changingProperty == 0) {
            var delta = (coarse - coarseIndicator.value) % nCoasInt
            if ((delta > nCoasInt) || (delta < -nCoasInt)) {
                // We don't want to animate for more than a full cycle
                coarseIndicator.animationEnabled = false

                coarseIndicator.value += (delta > 0 ? nCoasInt : -nCoasInt)
                delta = (coarse - coarseIndicator.value) % nCoasInt

                coarseIndicator.animationEnabled = true
            }

            coarseIndicator.value += delta
        }
    }

    // updates the fine selector if fine is set from outside of this file
    onFineChanged: {
        fine = ((fine < 0 && onlyNatNumbers) ? 0 : fine)

        if (mouse.changingProperty == 0) {
            var delta = (fine - fineIndicator.value)
            fineIndicator.value += (delta % nFineInt)
        }
    }

    function _xTranslation(value, bound) {
        // Use sine to map range of 0-bound to the X translation of a circular locus (-1 to 1)
        return Math.sin((value % bound) / bound * Math.PI * 2)
    }

    function _yTranslation(value, bound) {
        // Use cosine to map range of 0-bound to the Y translation of a circular locus (-1 to 1)
        return Math.cos((value % bound) / bound * Math.PI * 2)
    }

    ShaderEffect {
        anchors.fill: parent
        property size size: Qt.size(width, height)
        property real border: _fineWidth / width
        fragmentShader: "
            uniform lowp vec2 size;
            uniform lowp float border;
            varying highp vec2 qt_TexCoord0;
            uniform lowp float qt_Opacity;
            void main() {
                highp float dist = length(qt_TexCoord0 - vec2(0.5));
                gl_FragColor = vec4(0.1, 0.1, 0.1, 0.1) * (smoothstep(0.5-border,0.505-border, dist) - smoothstep(0.5-0.005, 0.5, dist)) * qt_Opacity;
            }"
    }

    GlassItem {
        id: coarseIndicator
        falloffRadius: 0.22
        radius: 0.25
        anchors.centerIn: parent
        color: mouse.changingProperty == 1 ? Theme.highlightColor : Theme.primaryColor

        property real value
        property bool animationEnabled: true

        transform: Translate { 
            // The coarses circle ends at 132px from the center
            x: (width - 3*_fineWidth)/2 * _xTranslation(coarseIndicator.value, nCoasInt)
            y: -(height - 3*_fineWidth)/2 * _yTranslation(coarseIndicator.value, nCoasInt)
        }

        Behavior on value {
            id: coarseAnimation
            SmoothedAnimation { velocity: 30 }
            enabled: coarseIndicator.animationEnabled && (!mouse.isMoving || mouse.isLagging)
        }
    }

    GlassItem {
        id: fineIndicator
        falloffRadius: 0.22
        radius: 0.25
        anchors.centerIn: parent
        color: mouse.changingProperty == 2 ? Theme.highlightColor : Theme.primaryColor

        property real value

        transform: Translate { 
            // The fines band is 72px wide, ending at 204px from the center
            x: (width - _fineWidth)/2 * _xTranslation(fineIndicator.value, nFineInt)
            y: -(height - _fineWidth)/2 * _yTranslation(fineIndicator.value, nFineInt)
        }

        Behavior on value {
            id: fineAnimation
            SmoothedAnimation { velocity: 80 }
            enabled: !mouse.isMoving || mouse.isLagging
        }
    }

    MouseArea {
        id: mouse

        property int changingProperty
        property bool isMoving
        property bool isLagging

        anchors.fill: parent
        preventStealing: true

        function radiusForCoord(x, y) {
            // Return the distance from the mouse position to the center
            return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2))
        }

        function angleForCoord(x, y) {
            // Return the angular position in degrees, rising anticlockwise from the positive X-axis
            var result = Math.atan(y / x) / (Math.PI * 2) * 360

            // Adjust for various quadrants
            if (x < 0)  {
                result += 180
            } else if (y < 0) {
                result += 360
            }
            return result
        }

        function remapAngle(angle, bound) {
            // Return the angle in steps mapped to the adjusted range 0 - bound and
            // translated to the clockwise from positive Y-axis orientation
            return Math.round(bound - (((angle - 90) / 360) * bound)) % bound
        }

        function remapMouse(mouseX, mouseY) {
            // Return the mouse coordinates in cartesian coords relative to the circle center
            return { x: mouseX - (width / 2), y: 0 - (mouseY - (height / 2)) }
        }

        function propertyForRadius(radius) {
            // Return the property associated with clicking at radius distance from the center
            if (radius < width/2 - _fineWidth) {
                return 1 // Coarse
            } else if (radius < width/2) {
                return 2 // Fine
            }
            return 0
        }

        function updateForAngle(angle) {
            // Update the selected property for the specified angular position
            if (changingProperty == 1) { // Coarse
                // Map angular position to 1 - nCoasInt
                var c = remapAngle(angle, nCoasInt)
                var delta = (c - coarseIndicator.value) % nCoasInt

                // It is not possible to make jumps of more than the half of #sections per full circle -> reverse the direction
                if (delta > (nCoasInt/2)) {
                    delta -= nCoasInt
                } else if (delta < -(nCoasInt/2)) {
                    delta += nCoasInt
                }
                if (isMoving && isLagging) {
                    if (Math.abs(delta) < (nCoasInt / 20)) {
                        isLagging = false
                    }
                }

                if(onlyNatNumbers)
                    delta = (coarseIndicator.value + delta) < 0 ? coarseIndicator.value : delta

                coarseIndicator.value += delta

                quantSelector.cdelta = delta
                quantSelector.coarse = c
            } else { // Fine
                // Map angular position to 1 - nFineInt
                var f = remapAngle(angle, nFineInt)

                // Round single touch to the nearest 5 min mark
//                if (!isMoving) m = (Math.round(m/5) * 5) % 60

                var delta = (f - fineIndicator.value) % nFineInt

                // It is not possible to make jumps of more than the half of #sections per full circle -> reverse the direction
                if (delta > (nFineInt/2)) {
                    delta -= nFineInt
                } else if (delta < -(nFineInt/2)) {
                    delta += nFineInt
                }
                if (isMoving && isLagging) {
                    if (Math.abs(delta) < (nCoasInt / 20)) {
                        isLagging = false
                    }
                }

                if(onlyNatNumbers)
                    delta = (fineIndicator.value + delta) < 0 ? fineIndicator.value : delta

                fineIndicator.value += delta

                quantSelector.fdelta = delta
                quantSelector.fine = f
            }
        }

        onPressed: {
            var coords = remapMouse(mouseX, mouseY)
            var radius = radiusForCoord(coords.x, coords.y)

            changingProperty = propertyForRadius(radius)
            if (changingProperty != 0) {
                preventStealing = true
                var angle = angleForCoord(coords.x, coords.y)

                isLagging = true
                updateForAngle(angle)
            } else {
                // Outside the fines band - allow pass through to underlying component
                preventStealing = false
            }
        }
        onPositionChanged: {
            if (changingProperty > 0) {
                var coords = remapMouse(mouseX, mouseY)
                var angle = angleForCoord(coords.x, coords.y)

                isMoving = true
                updateForAngle(angle)
            }
        }
        onReleased: {
            changingProperty = 0
            isMoving = false
            isLagging = false
        }
    }
}
