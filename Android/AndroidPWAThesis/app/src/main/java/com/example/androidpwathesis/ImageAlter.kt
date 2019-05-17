package com.example.androidpwathesis

import android.graphics.ColorMatrixColorFilter
import android.graphics.drawable.Drawable

val NEGATIVE = floatArrayOf(
    -1.0f, 0f, 0f, 0f, 255f, // red
    0f, -1.0f, 0f, 0f, 255f, // green
    0f, 0f, -1.0f, 0f, 255f, // blue
    0f, 0f, 0f, 1.0f, 0f  // alpha
)

class ImageAlter {

    fun invertColors(drawable: Drawable){
        drawable.colorFilter = ColorMatrixColorFilter(NEGATIVE)
    }

    fun applyContrast(drawable: Drawable, contrast: Float){
        val colorFilter = ColorMatrixColorFilter(
            floatArrayOf(
                contrast, 0f, 0f, 0f, 1f, // red
                0f, contrast, 0f, 0f, 1f, // green
                0f, 0f, contrast, 0f, 1f, // blue
                0f, 0f, 0f, 1f, 0f // alpha
            ))
        drawable.colorFilter = colorFilter
    }
}