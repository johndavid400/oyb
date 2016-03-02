# One Year Bible plugin

This is for testing only

## Setup

Step 1: Add an empty div with a class named "oyb" on a page of your website, like so:

    <div class="oyb"></div>

Step 2: Then add links to the javascript and css file (and jquery if you don't already have it), like so:

    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="http://oyb.prototyperobotics.com/oyb.js"></script>
    <link href="http://oyb.prototyperobotics.com/oyb.css" media="screen" rel="stylesheet" />

note: if you already have Jquery loaded, then you can omit the first script tag.

Step 3: There is no step 3, you are done. Well, I suppose you could refresh the page to see the content.

## Devotional

There is no devotional content yet. I have yet to work out permissions for that.

## OYB reading plan

The reading plan is a standard one year plan from the internets... an old testament, new testament, Psalm, and Proverb for each day.

## Bible verses

Bible content is pulled in via the Bibles.org passage API. We are only using KJV for now (still testing) but should have a translation switcher soon.

## Styling - CSS

You can either include the oyb.css stylesheet from above and override any of the styles in it, or you can not even include the provided stylesheet and write your own css to suit your needs.

Nearly all html elements are individually wrapped in a div with a corresponding class so you can customize everything.

The content you get from this api is injected into the div with class "oyb". Everything inside of that is prefixed with 'oyb-' to keep from conflicting with any of your existing styles.

Below is a general outline of the CSS classes you have to work with:

        .oyb
          .oyb-header
            .oyb-title
            .oyb-date
          %hr.oyb-hr
          .oyb-nav-links
            .oyb-prev.oyb-nav-button.oyb-update
            .oyb-nav-button.oyb-nav-switcher.active
            .oyb-next.oyb-nav-button.oyb-update
          .oyb-passage
            .oyb-devotional-title
            .oyb-devotional-author
            .oyb-devotional
          .oyb-passage
            .oyb-passage-title
            .oyb-passage-text

Some of the above classes are used multiple times in the response (ie. .oyb-nav-switcher and .oyb-passage) when there are multiple items that use the same class.

Descriptions for each piece of content:

        header:
          title: the title of the page - "One Year Bible"
          date: the day that you are reading
        nav-links:
          prev: link to previous day
          nav-switcher: switch between the different sections of content (Devotional, Old Testament, New Testament, Psalm, Proverb), there are 5 of these links.
          next: link to next day
        passage: the section for the devotional
          devotional-title: title of the devotional for the given day
          devotional-author: author name
          devotional: content of devotional
        passage: section of scripture - there are 4 of these: OT, NT, Psalm, Proverb
          passage-title: range of scriptures for section (ie. Mark 10:32-52)
          passage-text: the scripture text returned from Bibles.org


This layout makes it easy to override any element that might be in your way by simply setting a css attribute 'display:none' to hide it. It should be fairly easy to customize or build a stylesheet to match you website layout.

