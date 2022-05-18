package com.ichen.phsychobabble

data class Card(val message: String, val categories: List<Category?>, val flipped: Boolean = false)