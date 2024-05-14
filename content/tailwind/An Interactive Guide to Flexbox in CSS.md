> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.joshwcomeau.com](https://www.joshwcomeau.com/css/interactive-guide-to-flexbox/)

> When we truly learn the secrets of the Flexbox layout mode, we can build absolutely incredible things......

Introduction
------------

Flexbox is a remarkably powerful layout mode. When we _truly_ understand how it works, we can build dynamic layouts that respond automatically, rearranging themselves as-needed.

For example, check this out:

This demo is heavily inspired by Adam Argyle’s incredible [“4 layouts for the price of 1”](https://codepen.io/argyleink/pen/LYEegOO) codepen. _It uses no media/container queries._ Instead of setting arbitrary breakpoints, it uses _fluid principles_ to create a layout that flows seamlessly.

Here's the relevant CSS:

```
css

form {

  display: flex;

  align-items: flex-end;

  flex-wrap: wrap;

  gap: 16px;

}

.name {

  flex-grow: 1;

  flex-basis: 160px;

}

.email {

  flex-grow: 3;

  flex-basis: 200px;

}

button {

  flex-grow: 1;

  flex-basis: 80px;

}
```

I remember running into demos like this and being completely baffled. I knew the basics of Flexbox, but this seemed like absolute wizardry!

**In this blog post, I want to refine your mental model for Flexbox.** We'll build an intuition for how the Flexbox algorithm works, by learning about each of these properties. Whether you're a CSS beginner, or you've been using Flexbox for years, I bet you'll learn quite a bit!

Let's do this!

CSS is comprised of many different layout algorithms, known officially as “layout modes”. Each layout mode is its own little sub-language within CSS. The default layout mode is _Flow layout_, but we can opt in to Flexbox by changing the `display` property on the parent container:

**This is the fundamental difference between the primary/cross axis.** When we're talking about alignment in the _cross_ axis, each item can do whatever it wants. In the _primary_ axis, though, we can only think about how to distribute the _group_.

**That's why there's no** `justify-self`**.** What would it mean for that middle piece to set `justify-self: flex-start`? There's already another piece there!

With all of this context in mind, let's give a proper definition to all 4 terms we've been talking about:

*   `justify` — to position something along the _primary axis_.
    
*   `align` — to position something along the _cross axis_.
    
*   `content` — a group of “stuff” that can be distributed.
    
*   `items` — single items that can be positioned individually.
    

**And so:** we have `justify-content` to control the distribution of the group along the primary axis, and we have `align-items` to position each item individually along the cross axis. These are the two main properties we use to manage layout with Flexbox.

There's no `justify-items` for the same reason that there's no `justify-self`; when it comes to the primary axis, _we have to think of the items as a group,_ as content that can be distributed.

What about `align-content`? Actually, this _does_ exist within Flexbox! We'll cover it a little later on, when we talk about the `flex-wrap` property.

Let's talk about one of the most eye-opening realizations I've had about Flexbox.

Suppose I have the following CSS:

A reasonable person might look at this and say: “alright, so we'll get an item that is 2000 pixels wide”. _But will that always be true?_

Let's test it:

### Code Playground

<style> .flex-wrapper { display: flex; } .item { width: 2000px; } </style> <div></div> <div> <div></div> </div>

This is interesting, isn't it?

**Both items have the exact same CSS applied.** They each have `width: 2000px`. And yet, the first item is much wider than the second!

The difference is the _layout mode_. The first item is being rendered using Flow layout, and in Flow layout, `width` is a _hard constraint_. When we set `width: 2000px`, we'll get a 2000-pixel wide element, even if it has to burst through the side of the viewport like the Kool-Aid guy?.

In _Flexbox_, however, the `width` property is implemented differently. It's more of a suggestion than a hard constraint.

The specification has a name for this: the _hypothetical size_. It's the size an element _would_ be, in a perfect utopian world, with nothing getting in the way.

Alas, things are rarely so simple. In this case, the limiting factor is that the parent _doesn't have room_ for a 2000px-wide child. And so, the child's size is reduced so that it fits.

This is a core part of the Flexbox philosophy. Things are fluid and flexible and can adjust to the constraints of the world.

So, we've seen that the Flexbox algorithm has some built-in flexibility, with _hypothetical sizes_. But to _really_ see how fluid Flexbox can be, we need to talk about 3 properties: `flex-grow`, `flex-shrink`, and `flex-basis`.

Let's look at each property.

I admit it: for a long time, I didn't really understand what the _deal_ was with `flex-basis`. 😅

**To put it simply:** In a Flex row, `flex-basis` does the same thing as `width`. In a Flex column, `flex-basis` does the same thing as `height`.

As we've learned, everything in Flexbox is _pegged to the primary/cross axis_. For example, `justify-content` will distribute the children along the primary axis, and it works exactly the same way whether the primary axis runs horizontally or vertically.

`width` and `height` don't follow this rule, though! `width` will always affect the horizontal size. It doesn't suddenly become `height` when we flip `flex-direction` from `row` to `column`.

**And so, the Flexbox authors created a generic “size” property called `flex-basis`.** It's like `width` or `height`, but pegged to the _primary axis_, like everything else. It allows us to set the _hypothetical size_ of an element in the primary-axis direction, regardless of whether that's horizontal or vertical.

Give it a shot here. Each child has been given `flex-basis: 50px`, but you can tweak the first child:

When we set `flex-shrink` to 0, **we essentially “opt out” of the shrinking process altogether.** The Flexbox algorithm will treat `flex-basis` (or `width`) as a hard minimum limit.

Here's the full code for this demo, if you're curious:

### Flex Shrink ball demo

<style> .item.ball { flex-shrink: 0; } </style> <div> <div></div> <div></div> <div></div> </div>

There's _one more thing_ we need to talk about here, and it's super important. It may be the single most helpful thing in this entire article!

Let's suppose we're building a fluid search form for an e-commerce store:

Earlier, we saw how the `flex-grow` property can gobble up any extra space, applying it to a child.

Auto margins will **gobble up the extra space, and apply it to the element's margin.** It gives us precise control over where to distribute the extra space.

A common header layout features the logo on one side, and some navigation links on the other side. Here's how we can build this layout using auto margins:

### Code Playground

<style> ul { display: flex; gap: 12px; } li.logo { margin-right: auto; } </style> <nav> <ul> <li> <a href="/"> Corpatech </a> </li> <li> <a href=""> Mission </a> </li> <li> <a href=""> Contact </a> </li> </ul> </nav>

The **Corpatech** logo is the first list item in the list. By giving it `margin-right: auto`, we gather up all of the extra space, and force it between the 1st and 2nd item.

We can see what's going on here using the browser devtools:

![](data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27386%27%20height=%27284%27/%3e)![](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)

There are lots of other ways we could have solved this problem: we could have grouped the navigation links in their own Flex container, or we could have grown the first list item with `flex-grow`. But personally, I love the auto-margins solution. We're treating the extra space _as a resource_, and deciding exactly where it should go.

Phew! We've covered _a lot_ of stuff so far. There's just one more big takeaway I want to share.

So far, all of our items have sat side-by-side, in a single row/column. The `flex-wrap` property allows us to change that.

Check it out:

Now that we've learned all about the Flexbox algorithm, can you figure out how this works? Feel free to experiment with the code here:

### Code Playground

<style> form { display: flex; align-items: flex-end; flex-wrap: wrap; gap: 8px; } .name { flex-grow: 1; flex-basis: 120px; } .email { flex-grow: 3; flex-basis: 170px; } button { flex-grow: 1; flex-basis: 70px; } </style> <form> <label for="name-field"> Name: <input /> </label> <label for="email-field"> Email: <input type="email" /> </label> <button> Submit </button> </form>

Let's walk through how this works:

Thanks so much for reading! This blog post was _a ton_ of work, and I'm thrilled to have it out in the world! I hope you found it useful. 💖

### Last Updated

June 27th, 2023