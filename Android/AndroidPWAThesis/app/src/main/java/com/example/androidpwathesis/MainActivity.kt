package com.example.androidpwathesis

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView

const val FETCH_INTERVAL : Long = 5000

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setTheme(R.style.AppTheme)
        setContentView(R.layout.activity_main)

        startFetchingRandomImages()
    }

    private fun startFetchingRandomImages(){
        val imageView = findViewById<ImageView>(R.id.randomImageView)
        val alteredImageView = findViewById<ImageView>(R.id.alterationsImageView)
        val fetcher = ImageFetcher()

        fetcher.startFetching(imageView, FETCH_INTERVAL)
        fetcher.setAlterationsView(alteredImageView)
    }
}
