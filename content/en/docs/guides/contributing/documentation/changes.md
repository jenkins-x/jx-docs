---
title: Suggest changes to documentation
linktitle: Suggest changes
description: How to suggest changes to the Jenkins X site and documentation
weight: 10
---

Did you spot a typo or feel something's missing from a certain page? 
You can still contribute your suggestions without having to go through setting everything up locally as explained on [Contribute to Documentation](/docs/contributing/documentation/).

The process requires only three steps:

1. Click the "Edit this page" link on the right
1. Make your suggested changes
1. Create a Pull Request

We'll go through each step here. Keep in mind though, that if you're looking to contribute larger amounts of changes, pages, or sections, it's best to test things out locally first (using the process described on [Contribute to Documentation](/docs/contributing/documentation/)) instead of using this method.

## Click the "Edit this page" link

First off, make sure you're viewing the page you want to make changes to.
The link you need to click is specific for the page, to make it easier to start making changes.

On the right hand side of the page, you'll find a column that will always have the following three links:

![Triage](/images/contribute/page_links.png)

The top one (`Edit this page`) is the one we need here, as it will allow you to suggest changes to the page you're currently on.
The second one (`Create documentation issue`) is a link to create a documentation related issue, for others to look at and hopefully fix. This could be for missing sections, or maybe larger changes you're not comfortable suggesting yourself.
The last one (`Create project issue`) is a link to create an issue for the main Jenkins X project. This is for problems related to the code and to how Jenkins X works.

## Make suggested changes

Clicking the "Edit this page" link takes you to a page on GitHub that looks something like this:

![Triage](/images/contribute/edit_page.png)

The main part of this page is the text field which includes the text for page you came from. It is using [GitHub markdown](https://guides.github.com/features/mastering-markdown/) to indicate when this should be bold, italic, etc., so if you haven't come across markdown before it might be a good idea to have a look at that if you plan on making changes to/using text formatting.
There's also a [cheat-sheet here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) with just the formatting.

You can make any changes you see fit (it's treated as a suggestion that will be reviewed by others before being applied to the live website).

Once you're finished:

1. Supply a summary of your changes (e.g. "fixed typos in documentation contribution page")
1. Select the option "Create a new branch..." and give it a meaningful name
1. Click "Propose file change"

The page should look something like this:

![Triage](/images/contribute/commit_changes.png)

## Create a Pull Request

The next screen after you clicked "Propose file changes" should be "Open Pull Request".

You can add more description if you wish, but at this point its fine to just click "Create pull request".
If there are any questions about your changes, or suggestions for improvements, they will be added to the pull request, so in case you have opted out of notifications from GitHub it would be good to check back now and then until the change is applied.
