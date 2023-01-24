package com.w3conext.jailbreak_root_detection.frida

import androidx.annotation.Keep

@Keep
class NativeLoader {

    companion object {

        external fun detectFrida(): Boolean
        external fun isSu(): Int

        init {
            try {
                System.loadLibrary("native-lib")
            } catch (e: Exception) {
                print("Error $e")
            }
        }
    }
}