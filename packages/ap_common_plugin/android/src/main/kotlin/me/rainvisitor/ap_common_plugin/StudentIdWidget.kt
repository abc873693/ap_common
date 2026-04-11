package me.rainvisitor.ap_common_plugin

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Color as AndroidColor
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.width
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import androidx.glance.action.actionStartActivity
import androidx.glance.action.clickable
import androidx.glance.Image
import androidx.glance.ImageProvider
import com.google.zxing.BarcodeFormat
import com.google.zxing.MultiFormatWriter

/**
 * Displays student ID with barcode for quick library access.
 *
 * Reads user info from SharedPreferences (key: "user_info").
 */
class StudentIdWidget : GlanceAppWidget() {
    companion object {
        const val KEY_USER_INFO = "user_info"

        private val headerBg = androidx.glance.color.ColorProvider(
            day = Color(0xFF2673FF),
            night = Color(0xFF1A1C2E),
        )
        private val surfaceBg = androidx.glance.color.ColorProvider(
            day = Color.White,
            night = Color(0xFF1E1E1E),
        )
        private val textPrimary = androidx.glance.color.ColorProvider(
            day = Color.Black,
            night = Color(0xFFE0E0E0),
        )
        private val textSecondary = androidx.glance.color.ColorProvider(
            day = Color(0xFF757575),
            night = Color(0xFF9E9E9E),
        )
    }

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val info = loadUserInfo(context)
        val barcodeBitmap = info?.let { generateBarcode(it.id) }
        provideContent {
            GlanceTheme {
                StudentIdContent(context, info, barcodeBitmap)
            }
        }
    }

    @Composable
    private fun StudentIdContent(
        context: Context,
        info: StudentInfo?,
        barcode: Bitmap?,
    ) {
        val launchIntent = context.packageManager
            .getLaunchIntentForPackage(context.packageName)

        Column(
            modifier = GlanceModifier.fillMaxSize()
                .cornerRadius(16.dp)
                .background(surfaceBg)
                .then(
                    if (launchIntent?.component != null) {
                        GlanceModifier.clickable(
                            actionStartActivity(launchIntent.component!!)
                        )
                    } else GlanceModifier
                ),
        ) {
            // Header
            Box(
                modifier = GlanceModifier.fillMaxWidth()
                    .height(32.dp)
                    .background(headerBg),
                contentAlignment = Alignment.Center,
            ) {
                Text(
                    text = context.getString(R.string.student_id_card),
                    style = TextStyle(
                        color = ColorProvider(Color.White),
                        fontSize = 13.sp,
                        fontWeight = FontWeight.Bold,
                    ),
                )
            }

            if (info == null) {
                Box(
                    modifier = GlanceModifier.fillMaxSize(),
                    contentAlignment = Alignment.Center,
                ) {
                    Text(
                        text = context.getString(R.string.not_login_hint),
                        style = TextStyle(
                            color = textSecondary,
                            fontSize = 13.sp,
                            textAlign = TextAlign.Center,
                        ),
                    )
                }
            } else {
                Column(
                    modifier = GlanceModifier.fillMaxSize()
                        .padding(12.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalAlignment = Alignment.CenterVertically,
                ) {
                    // Name + Department
                    Text(
                        text = info.name,
                        style = TextStyle(
                            color = textPrimary,
                            fontSize = 16.sp,
                            fontWeight = FontWeight.Bold,
                        ),
                    )
                    if (info.department.isNotEmpty()) {
                        Text(
                            text = info.department,
                            style = TextStyle(
                                color = textSecondary,
                                fontSize = 11.sp,
                            ),
                        )
                    }
                    Spacer(modifier = GlanceModifier.height(8.dp))

                    // Student ID (large monospace)
                    Text(
                        text = info.id,
                        style = TextStyle(
                            color = textPrimary,
                            fontSize = 22.sp,
                            fontWeight = FontWeight.Bold,
                            textAlign = TextAlign.Center,
                        ),
                    )
                    Spacer(modifier = GlanceModifier.height(8.dp))

                    // Barcode
                    if (barcode != null) {
                        Image(
                            provider = ImageProvider(barcode),
                            contentDescription = "Barcode",
                            modifier = GlanceModifier
                                .fillMaxWidth()
                                .height(50.dp),
                        )
                    }

                    Spacer(modifier = GlanceModifier.height(4.dp))
                    Text(
                        text = context.getString(R.string.barcode_library_hint),
                        style = TextStyle(
                            color = textSecondary,
                            fontSize = 9.sp,
                            textAlign = TextAlign.Center,
                        ),
                    )
                }
            }
        }
    }

    // --- Data ---

    @kotlinx.serialization.Serializable
    data class StudentInfo(
        val id: String = "",
        val name: String = "",
        val department: String = "",
        val className: String = "",
    )

    private fun loadUserInfo(context: Context): StudentInfo? {
        val pref = context.getSharedPreferences(
            ApCommonPlugin.PREF_NAME, Context.MODE_PRIVATE,
        )
        val raw = pref.getString(KEY_USER_INFO, "")
        if (raw.isNullOrEmpty()) return null
        return try {
            kotlinx.serialization.json.Json {
                ignoreUnknownKeys = true
            }.decodeFromString<StudentInfo>(raw)
        } catch (e: Exception) {
            null
        }
    }

    private fun generateBarcode(text: String): Bitmap? {
        if (text.isEmpty()) return null
        return try {
            val writer = MultiFormatWriter()
            val matrix = writer.encode(
                text, BarcodeFormat.CODE_39, 600, 100
            )
            val w = matrix.width
            val h = matrix.height
            val bmp = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888)
            for (x in 0 until w) {
                for (y in 0 until h) {
                    bmp.setPixel(
                        x, y,
                        if (matrix[x, y]) AndroidColor.BLACK
                        else AndroidColor.WHITE
                    )
                }
            }
            bmp
        } catch (e: Exception) {
            null
        }
    }
}
