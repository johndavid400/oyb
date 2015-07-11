# One Year Bible plugin

This is for testing only

## Setup

Step 1: Add an empty div with a class named "oyb" on a page of your website, like so:

    <div class="oyb"></div>

Step 2: Then add a link to the javascript file (and jquery if you don't already have it), like so:

    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="http://oyb.herokuapp.com/oyb.js"></script>

note: if you already have Jquery loaded, then you can omit the first script tag.

Step 3: There is no step 3, you are done. Well, I suppose you could refresh the page to see the content.

## Devotional

There is no devotional content yet. I have yet to work out permissions for that.

## OYB reading plan

The reading plan is a standard one year plan from the internets... an old testament, new testament, Psalm, and Proverb for each day.

## Bible verses

Bible content is pulled in via the Bibles.org passage API. We are only using KJV for now (still testing) but should have a translation switcher soon.

## CSS

There are no required styles, but there are currently 2 links that you can style however you want. I styled them to look like buttons and floated them right, here is my css:

    .oyb-prev, .oyb-next {
      border: 1px solid gray;
      padding: 5px 10px;
      border-radius: 4px;
      text-decoration: none;
      margin-left: 10px;
    }

    .oyb-nav-links {
      float: right;
      margin-top: 20px;
    }


