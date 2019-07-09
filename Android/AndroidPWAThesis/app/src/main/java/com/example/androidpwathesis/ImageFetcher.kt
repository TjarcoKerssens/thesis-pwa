package com.example.androidpwathesis

import android.os.Handler
import android.util.Log
import android.widget.ImageView
import com.squareup.picasso.Callback
import com.squareup.picasso.MemoryPolicy
import com.squareup.picasso.Picasso

const val IMAGE_URL = "https://picsum.photos/200"

class ImageFetcher {
    private var handler: Handler = Handler()
    private lateinit var runable: Runnable

    private lateinit var imageView: ImageView
    private lateinit var alteredImageView: ImageView

    private val imageAlter = ImageAlter()

    /**
     *  Starts fetching a new, random image over an interval
     *
     *  @param imageView The ImageView to render the image to
     *  @param interval The time in milliseconds between fetching
     */
    fun startFetching(imageView: ImageView, interval: Long){
        this.imageView = imageView
        runable = Runnable {
            fetch()
            handler.postDelayed(runable, interval)
        }
        runable.run()
    }

    /**
     *  Register an ImageView to show a copy of the fetched image with alterations
     */
    fun setAlterationsView(imageView: ImageView){
        alteredImageView = imageView
    }

    /**
     * Fetches a random image and renders it to the ImageView. This method won't cache the result.
     */
    private fun fetch(){
        Picasso.get()
            .load(url())
            .memoryPolicy(MemoryPolicy.NO_CACHE, MemoryPolicy.NO_STORE)
            .placeholder(imageView.drawable)
            .into(imageView, object : Callback {
                override fun onSuccess() {
                    setAlteredImage()
                }
                override fun onError(e: Exception) {
                    Log.e("Image Loading Error", e.localizedMessage)
                }
            })
    }

    /**
     * If an ImageView is registered to show the altered image, copy the Drawable and apply the alterations
     */
    private fun setAlteredImage(){
        if (::alteredImageView.isInitialized){
            val copy = imageView.drawable.constantState?.newDrawable()?.mutate()
            if (copy != null) {
                imageAlter.invertColors(copy)
                imageAlter.applyContrast(copy, 2f)
                alteredImageView.setImageDrawable(copy)
            }

        }
    }

    /**
     * Generate a URL String from the base IMAGE_URL with cache prevention
     */
    private fun url(): String{
        val charPool : List<Char> = ('a'..'z') + ('A'..'Z') + ('0'..'9')
        val randomString = (1..6)
            .map { kotlin.random.Random.nextInt(0, charPool.size) }
            .map(charPool::get)
            .joinToString("")
        return "$IMAGE_URL?cache_prev=$randomString"
    }
}