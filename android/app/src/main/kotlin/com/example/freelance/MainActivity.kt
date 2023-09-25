package com.example.freelance

import android.annotation.SuppressLint
import android.graphics.Bitmap
import android.graphics.BitmapFactory

import com.imin.library.SystemPropManager
import com.imin.printerlib.IminPrintUtils
import com.imin.printerlib.IminPrintUtils.PrintConnectType

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.ByteArrayInputStream
import java.io.IOException
import java.io.InputStream
import java.lang.Exception
import java.lang.ref.SoftReference
import java.util.ArrayList

class MainActivity: FlutterActivity() {
    private val whichChannel = "com.i_min.printer_sdk"
    private var connectType = PrintConnectType.USB

    @SuppressLint("DefaultLocale")
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, whichChannel)
        channel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            when (call.method) {
                "sdkInit" -> {
                    val deviceModel = SystemPropManager.getModel()
                    connectType =
                        if (deviceModel.contains("M2-203") || deviceModel.contains("M2-202") || deviceModel.contains(
                                "M2 Pro"
                            )
                        ) {
                            PrintConnectType.SPI
                        } else {
                            PrintConnectType.USB
                        }
                    IminPrintUtils.getInstance(this@MainActivity).initPrinter(connectType)
                    result.success("init")
                }
                "printText" -> {
                        if (call.arguments<Any?>() == null) return@setMethodCallHandler
                        val arg = (call.arguments<Map<String,Any>>())!!
                        val text = arg["text"] as String
                        val bold = arg["bold"] as Boolean
                        val alignment = arg["alignment"] as Int
                        val size = arg["size"] as Int
                        val underline = arg["underline"] as Boolean
                        val underLineHeight = (arg["underLineHeight"] as Double).toFloat()
                        val textLineSpacing = (arg["textLineSpacing"] as Double).toFloat()
                        IminPrintUtils.getInstance(this@MainActivity)
                            .setAlignment(alignment)
                            .setTextLineSpacing(textLineSpacing)
                            .setHaveLineHeight(underLineHeight)
                            .setUnderline(underline)
                            .setTextSize(size)
                            .sethaveBold(bold)
                            .printText("$text\n")
                        result.success("printed successfully $text \n")
                }
                "cutPaper" -> {
                    IminPrintUtils.getInstance(this@MainActivity).partialCut()
                    result.success("paper cut successfully")
                }
                "createRow" -> {
                    if (call.arguments<Any?>() == null) return@setMethodCallHandler
                    val arg = (call.arguments<Map<String,Any>>())!!
                        val texts:Array<String> =  (arg["texts"] as ArrayList<String>).toTypedArray()
                        val colWidthArr =  (arg["widths"] as ArrayList<Int>).toIntArray()
                        val colAlign =  (arg["aligns"] as ArrayList<Int>).toIntArray()
                        val size =  (arg["sizes"] as ArrayList<Int>).toIntArray()
                        IminPrintUtils.getInstance(this@MainActivity).printColumnsText(texts,colWidthArr,colAlign,size)
                        result.success("created row ${texts}")
                }
                "blankSpacePrint" -> {
                    if (call.arguments<Any?>() == null) return@setMethodCallHandler
                    val size = (call.arguments<Int>())!!
                    IminPrintUtils.getInstance(this@MainActivity).printAndFeedPaper(size)
                    result.success("print blank space successfully")
                }
                "printBitmap" -> {
                    val image = call.argument<ByteArray>("image")
                    var bitmap: Bitmap? = null
                    bitmap = byteToBitmap(image)
                    val mIminPrintUtils = IminPrintUtils.getInstance(this@MainActivity)
                    mIminPrintUtils.printSingleBitmap(bitmap)
                    result.success("printBitmap")
                }
            }
        }
    }

    fun byteToBitmap(imgByte: ByteArray?): Bitmap? {
        var imgByte = imgByte
        var input: InputStream? = null
        var bitmap: Bitmap? = null
        val options = BitmapFactory.Options()
        options.inSampleSize = 1
        input = ByteArrayInputStream(imgByte)
        val softRef: SoftReference<*> = SoftReference<Any?>(
            BitmapFactory.decodeStream(
                input, null, options
            )
        ) //�����÷�ֹOOM
        bitmap = softRef.get() as Bitmap?
        if (imgByte != null) {
            imgByte = null
        }
        try {
            if (input != null) {
                input.close()
            }
        } catch (e: IOException) {
            // �쳣����
            e.printStackTrace()
        }
        return bitmap
    }
}