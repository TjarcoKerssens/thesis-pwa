package com.example.androidpwathesis
import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import com.google.android.gms.location.*

const val LOCATION_PERMISSION_RC = 1

class LocationWatcher(private val context: Activity){

    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var locationCallback: LocationCallback

    fun startWatching(callback: (longitude: Double, latitude: Double) -> Unit){
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(context)

        initLocationCallback(callback)

        createLocationRequest { locationRequest ->
            startLocationUpdates(locationRequest)
        }
    }


    private fun initLocationCallback(callback: (longitude: Double, latitude: Double) -> Unit) {
        locationCallback = object : LocationCallback() {
            override fun onLocationResult(locationResult: LocationResult?) {
                locationResult ?: return
                val location = locationResult.locations.last()
                callback(location.longitude, location.latitude)
            }
        }
    }

    private fun startLocationUpdates(locationRequest: LocationRequest){
        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) !=
                PackageManager.PERMISSION_GRANTED) {
            return
        }
       fusedLocationClient.requestLocationUpdates(locationRequest, locationCallback, null)
    }

    /**
     * Starts the process of checking permissions and requesting permissions if the user did not provide them.
     *
     * If the user did already provide them execute the callback
     */
    fun requestPermissions(permissionsAlreadyProvided: ()->Unit){
        if ( ContextCompat.checkSelfPermission( context, Manifest.permission.ACCESS_FINE_LOCATION ) != PackageManager.PERMISSION_GRANTED ) {
            ActivityCompat.requestPermissions(context, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), LOCATION_PERMISSION_RC)
        }else{
            permissionsAlreadyProvided()
        }
    }


    private fun createLocationRequest(callback: (LocationRequest)->Unit) {
        val locationRequest = LocationRequest.create()
            .setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY)
            .setFastestInterval(1000)
            .setInterval(2000)

        if (locationRequest != null){
            callback(locationRequest)
        }
    }

}