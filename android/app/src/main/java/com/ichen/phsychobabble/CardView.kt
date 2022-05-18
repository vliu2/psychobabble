package com.ichen.phsychobabble

import android.content.Context
import android.graphics.Color
import android.graphics.Typeface
import android.os.Bundle
import android.util.AttributeSet
import android.util.Log
import android.view.*
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.constraintlayout.motion.widget.MotionLayout
import androidx.fragment.app.Fragment

class CardView(context: Context, attrs: AttributeSet): LinearLayout(context, attrs) {
    lateinit var card: Card
    lateinit var openCard: (Card) -> Unit
    private var flipped = false
    private val image = ImageView(context, attrs)
    private val text = TextView(context, attrs)

    init {
        image.layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT)
        image.setBackgroundResource(R.drawable.logo)
        addView(image)
//        text.layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT)
//        text.text = "default"
//        text.setTextColor(Color.BLACK)
//        text.textSize = 32f
//        text.setTypeface(text.typeface, Typeface.BOLD)
//        text.setBackgroundColor(Color.TRANSPARENT)
//        text.visibility = View.GONE
//        addView(text)
    }

    fun initialize(card: Card, openCard: (Card) -> Unit) {
        this.card = card
        text.text = card.message
        this.openCard = openCard
    }
//
//    fun flip() {
//        flipped = !flipped
//        if(flipped) {
//            image.visibility = View.GONE
//            text.visibility = View.VISIBLE
//        } else {
//            text.visibility = View.GONE
//            image.visibility = View.VISIBLE
//        }
//    }

}

class CustomMotionLayout(context: Context, attrs: AttributeSet): MotionLayout(context, attrs) {

    private var isBeingClicked = false

    override fun onDragEvent(event: DragEvent?): Boolean {
        return super.onDragEvent(event)
    }

    override fun onTouchEvent(event: MotionEvent?): Boolean {
        val a = super.onTouchEvent(event)
        isBeingClicked = when(event?.action) {
            MotionEvent.ACTION_DOWN -> currentState != -1
            MotionEvent.ACTION_UP -> {
                if(isBeingClicked) {
                    val cardView = findViewById<CardView>(R.id.v2)
                    cardView.openCard(cardView.card)
                    // flip card
                }
                false
            }
            else -> false
        }
        return a
    }

    fun flipAllCards() {

    }
}

class CardFragment: Fragment(R.layout.card_fragment) {

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.card_fragment, container, false)
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val message = requireArguments().getString("message")
        val messageText = view.findViewById<TextView>(R.id.message)
        messageText.text = message
        val closeText = view.findViewById<TextView>(R.id.close)
        closeText.setOnClickListener {
            finish()
        }
        super.onViewCreated(view, savedInstanceState)
    }

    private fun finish() {
        activity?.supportFragmentManager?.beginTransaction()?.remove(this)?.commit();
    }
}