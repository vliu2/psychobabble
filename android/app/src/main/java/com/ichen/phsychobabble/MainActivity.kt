package com.ichen.phsychobabble

import android.graphics.Color
import android.graphics.Typeface
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.ActionBarDrawerToggle
import androidx.appcompat.app.AppCompatActivity
import androidx.constraintlayout.helper.widget.Carousel
import androidx.constraintlayout.motion.widget.MotionLayout
import androidx.core.os.bundleOf
import androidx.core.view.children
import androidx.drawerlayout.widget.DrawerLayout
import androidx.fragment.app.FragmentTransaction
import androidx.fragment.app.add
import androidx.fragment.app.commit


private val categories: List<Category> = listOf(
    Category("Changing the Tone of a Disagreement", "CTD"),
    Category("Getting Out of a Power Struggle", "GOPS"),
    Category("Setting Healthy Boundaries", "SHB"),
    Category("Making Amends", "MA"),
    Category("Invitation to Connect", "I2C"),
    Category("Asking for Understanding", "AFU"),
    Category("Giving Understanding", "GU"),
    Category("Owning My Part in the Problem", "OMPP")
)

private val cMap: Map<String, Category> =
    categories.associateBy { category -> category.abbreviation }

private val cards: List<Card> = listOf(
    Card("Help me understand.", listOf(cMap["CTD"], cMap["I2C"], cMap["GOPS"])),
    Card("What just happened?", listOf(cMap["CTD"], cMap["GU"], cMap["GOPS"])),
    Card("I have a request.", listOf(cMap["GOPS"])),
    Card("Can you give me a few minutes to calm down?", listOf(cMap["CTD"])),
    Card("Please know my intentions are good.", listOf(cMap["MA"], cMap["I2C"])),
    Card("I don't understand but I want to.", listOf(cMap["CTD"], cMap["I2C"], cMap["GU"])),
)

class MainActivity : AppCompatActivity() {

    fun openCard(card: Card) {
        val bundle = bundleOf("message" to card.message)
        supportFragmentManager.commit {
            setReorderingAllowed(true)
            add<CardFragment>(R.id.fragment_container, args = bundle)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // setup carousel
        val motionLayout = findViewById<MotionLayout>(R.id.motion_layout)
        val carousel = findViewById<Carousel>(R.id.carousel)
        carousel.setAdapter(object : Carousel.Adapter {
            override fun count(): Int = cards.size
            override fun populate(view: View?, index: Int) {
                val image: ImageView? =
                    ((view as ViewGroup).children.toList().filter { child -> child is ImageView }
                        .getOrNull(0) as ImageView?)
                val text: TextView? =
                    ((view as ViewGroup).children.toList().filter { child -> child is TextView }
                        .getOrNull(0) as TextView?)
                (view as CardView).initialize(cards[index]) { card -> openCard(card) }
            }
            override fun onNewItem(index: Int) {

            }
        })

        // setup drawer layout
        val content = findViewById<LinearLayout>(R.id.content)
        val drawerLayout = findViewById<DrawerLayout>(R.id.drawer_layout)
        drawerLayout.setScrimColor(Color.TRANSPARENT)
        drawerLayout.addDrawerListener(object :
            ActionBarDrawerToggle(this, drawerLayout, R.string.open, R.string.close) {
            override fun onDrawerSlide(drawerView: View, slideOffset: Float) {
                super.onDrawerSlide(drawerView, slideOffset)
                val slideX = drawerView.width * slideOffset
                content.translationX = slideX
            }
        })

        // setup hamburger button
        val hamburgerButton = findViewById<ImageView>(R.id.hamburger_button)
        hamburgerButton.setOnClickListener {
            if (drawerLayout.isOpen) drawerLayout.close() else drawerLayout.open()
        }

        // setup sidebar
        val sidebar = findViewById<LinearLayout>(R.id.sidebar)
        categories.forEach { category ->
            val textView = TextView(this).apply {
                layoutParams = LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT
                ).apply {
                    setMargins(0, 0, 0, 32)
                }
                text = category.abbreviation
                setTextColor(Color.BLACK)
                textSize = 32.0f
                typeface = Typeface.defaultFromStyle(Typeface.BOLD)
            }
            sidebar.addView(textView)
        }
    }

    fun click(view: View?) {
        Log.d("IDC", "Clicked")
    }
}