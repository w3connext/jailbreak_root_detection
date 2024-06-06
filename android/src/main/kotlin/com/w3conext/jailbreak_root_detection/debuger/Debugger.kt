package com.w3conext.jailbreak_root_detection.debuger

import android.os.Debug

object Debugger {
    fun isDebugged(): Boolean = Debug.isDebuggerConnected() || Debug.waitingForDebugger()
}