package com.w3conext.jailbreak_root_detection.frida

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.system.Os
import com.w3conext.jailbreak_root_detection.IRemoteService

class RemoteService : Service() {

    private val mBinder: IRemoteService.Stub = object : IRemoteService.Stub() {
        override fun haveSu(): Boolean {
            return NativeLoader.isSu() == 0
        }
    }

    override fun onBind(intent: Intent): IBinder? {
        val appId = Os.getuid() % 100000
        return if (appId >= 90000) mBinder else null
    }
}
