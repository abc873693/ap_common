package me.rainvisitor.ap_common_plugin

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class CourseData(
    val courses: List<Course> = emptyList(),
    val timeCodes: List<TimeCode> = emptyList(),
)

@Serializable
data class Course(
    val code: String = "",
    val title: String = "",
    val className: String? = null,
    val group: String? = null,
    val units: String? = null,
    val hours: String? = null,
    val required: String? = null,
    val at: String? = null,
    @SerialName("sectionTimes")
    val times: List<SectionTime> = emptyList(),
    val location: Location? = null,
    val instructors: List<String> = emptyList(),
)

@Serializable
data class Location(
    val building: String? = null,
    val room: String? = null,
) {
    val displayText: String
        get() = listOf(building, room)
            .filterNot { it.isNullOrEmpty() }
            .joinToString("")
}

@Serializable
data class SectionTime(
    val weekday: Int = 0,
    val index: Int = 0,
)

@Serializable
data class TimeCode(
    val title: String = "",
    val startTime: String = "",
    val endTime: String = "",
)
