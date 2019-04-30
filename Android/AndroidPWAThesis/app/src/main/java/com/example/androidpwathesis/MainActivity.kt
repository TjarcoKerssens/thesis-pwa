package com.example.androidpwathesis

import android.Manifest
import android.content.pm.PackageManager
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.Looper
import android.support.v4.app.ActivityCompat
import android.util.Log
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.location.*
import kotlin.io.print as print1

const val FETCH_INTERVAL : Long = 5000

class MainActivity : AppCompatActivity() {

    private val locationWatcher = LocationWatcher(this)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setTheme(R.style.AppTheme)
        setContentView(R.layout.activity_main)

        startFetchingRandomImages()

        locationWatcher.requestPermissions{
            locationWatcher.startWatching { longitude: Double, latitude: Double ->
                onLocationUpdate(longitude, latitude)
            }
        }
    }

    private fun startFetchingRandomImages(){
        val imageView = findViewById<ImageView>(R.id.randomImageView)
        val alteredImageView = findViewById<ImageView>(R.id.alterationsImageView)
        val fetcher = ImageFetcher()

        fetcher.startFetching(imageView, FETCH_INTERVAL)
        fetcher.setAlterationsView(alteredImageView)
    }

    private fun onLocationUpdate(longitude: Double, latitude: Double){
        Log.d("LocationUpdate","Received location update. longitude: $longitude latitude: $latitude")
        val locationView = findViewById<TextView>(R.id.locationTextView)
        locationView.text = resources.getString(R.string.location, longitude, latitude)
    }

    /**
     * This method will be called when it has been established that the user does indeed provide permission to
     * use the location. If permission is granted, the location watcher will be started. If not granted, it won't show
     * the current location
     */
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == LOCATION_PERMISSION_RC){
            locationWatcher.startWatching { longitude: Double, latitude: Double ->
                onLocationUpdate(longitude, latitude)
            }
        }
    }

}
