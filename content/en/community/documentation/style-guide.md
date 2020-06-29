# Documentation writer style guide

The Jenkins X Documentation Special Interest Group (SIG) has established some guidelines for docs contribution. 
The following are not meant to be exhaustive, but are simple style and technical tips to help conform to the existing voice and technical writing techniques used in our existing docs content.


## Writer voice and tone

* Pages should have titles, and should be descriptive enough on its own that readers (and web search crawlers) can pick up the title without too much missing context. 
Proper nouns should be capitalized in titles but nothing else (for example, write "Jenkins X tips and tricks" instead of "Jenkins X Tips And Tricks")

* Do not use commands as verbs. 
For example write "Change to a new directory with `cd`" instead of "cd to the new directory"

* Use active voice wherever possible instead of passive voice to make explanations and procedures clearer and more direct. 
For example, write "Click the `TLS/SSL` checkbox if you want to enable a secure connection" instead of "If you want a secure connection to be enabled, make sure the `TLS/SSL` checkbox is clicked."
  
* When introducing a new acronym to your content, write the full term first before using the acronym (for example, “User Interface (UI)”). 
Then you can use the acronym in subsequent mentions.

* Keep content focus as narrow and prescriptive as possible; no long explanations for actions or drawn out introductions unless describing it in detail for an `/about` page.

## Technical guidelines

* Write in one sentence per line, even if you are writing a multi-sentence paragraph. 
That way when you or other writers are making changes to the content, it will be easier for reviewers to find what has changed in one sentence rather than finding it in a long paragraph.

* Use multiples of 10 when assigning the `weight` of a new page of content, as it will be easier to prioritize pages within a navigation menu. 

 Let's say you have 3 existing pages with a `weight` of `10`, `20`, and `30`, respectively.  
 Using this method, a writer can create a page with a weight of `11` that will appear between the page weighted `10` and `20` in the navigation menu.

* Use backticks when describing commands, directory paths, or filenames.
For example: "Open a terminal and type \`cd /usr/local/bin\` to find the \`jx\` command."

* Code blocks should use triple backticks plus the supported code descriptor for proper syntax highlights  (for example, `\`\`\`bash` for a command run at terminal shell prompt).

* Commands to be typed out by the user should not use prompts like `$` or `>` as they can introduce unintended errors when used with the command.

* Use absolute paths when cross-linking content. For example, use `/docs/install-setup/installing/boot/foo.md` instead of `../../install-setup/installing/boot/foo.md`.

* Place the title of your content in the header/metadata of the page under `Title:`. Subsequent sections created in the content begin with section 2 header designation (`##`) or more.