---
title: "An update on helm 3 and JXL"
date: 2020-05-15
draft: false
description: >
  Explaining the next steps regarding helm 3 and the Jenkins X Labs work for Jenkins X.
categories: [blog]
keywords: [Community, 2020]
slug: "helm3"
aliases: []
author: Ethan Jones
---

## What’s next for JXL and Helm 3?

A few months back, we unveiled JXL to the Jenkins X community and framed it as a new thing, Jenkins X Labs, that would build out experimental features and test potential new things. Some would stick and go upstream into Jenkins X, others would be killed off as interesting but unsuccessful experiments.

This was a new thing for Jenkins X, trying to better separate the experimentation loop from the increasingly stable and relied-upon upstream. And, to a degree it worked great - the JXL workaround helm 3 was awesome, and got a lot of excitement.

Where it didn’t work so great, though, was on what happened next. While this may be a bit forgivable since the whole thing was itself a new experiment for our community, it’s pretty clear we’ve dropped the ball a bit and that’s informing our next steps now.

## What did we learn from jxl?

A few weeks back, we made it known that the JXL experiment was over. Specifically, the current jxl binary was over - not the idea of labs or any experiments, but the specific helm 3 experiment packaged into the current version of jxl had gotten us the info we needed to make some decisions about how we wanted to steer Jenkins X going forward.

There were two main things we learned as a result of the jxl work:

- First, it was mostly a success. The direction was exciting, and helmfile is a huge help.

- Second, the scope of the change was enormous. Getting the change to be production-ready, to the increasing quality standards being established by the CloudBees Jenkins X Distribution, was even larger.

It’s important to note here that regressing in terms of quality and reliability is not an option - we’ve heard loud and clear from the community that Jenkins X needs to be more stable and more dependable, and even exciting changes can’t compose the progress we’re making on those fronts.

So, with those takeaways in mind, we declared the helm 3 JXL experiment complete and got to work.

## So, what’s next for helm 3 and Jenkins X?

To be clear upfront: Jenkins X will get helm 3. We are working on that now internally at CloudBees. And, specifically, we are working on a way to introduce this large change iteratively, over time, with safe upgrade paths and no sudden breaking changes. For bleeding-edge people, maybe that’s slower than you might prefer - but after the volume of feedback around stability, we’re playing it safe on this one.

Now, you might ask next where you can find that work. And the answer, to be honest, is that right now you can’t. With the work we do on Jenkins X at CloudBees, we aspire to be as consistently open and upstream as possible, but there are times when keeping our heads down to workshop things is the right path. The UI so far is one example of this, and for the time being helm 3 is another.

## Can you get involved in helm 3 at all?

If you are interested in the work going on regarding Jenkins X and helm 3, we are looking for pilot users who want to test drive what’s in progress and give feedback once it's ready. It’s not all of JXL, like I said it’s iterative and this is phase 1. Please get in touch if you’d like to discuss it more, either by email ([jx-feedback@cloudbees.com](mailto:jx-feedback@cloudbees.com)) or just in the community Slack (ping *vfarcic* and he’ll get you on the list for feedback.)

## Why isn’t this all more open?

One thing we learned as part of doing JXL is that Jenkins X is not yet built well for safe experimentation. We want to fix that long term, and if we were doing it over again we’d likely handle jxl differently because of the unfortunate silence you’re now hearing from us after such exciting work, but like all corporate sponsors of open source projects, we have to balance priorities and one of the major ones is making Jenkins X high quality enough for large companies to use at scale.

Long term, as things continue to improve, we hope all experimentation can be done upstream without major issues - but we’re not there yet. And, continuing to build out on JXL risked a forking situation where the path back to upstream becomes harder and harder - we didn’t want that to happen. So, our solution for now, suboptimal as it is, is to build the next chapter out a little more privately, figure out what makes sense in upstream from day 1 and what we might want to first offer through the Distribution as an enterprise capability (similar to the UI) and then get the community back on track with a single direction.

We’re not saying this is great - it’s a learning process for us too, and while we’re excited about the path to the future JXL has given us, we also have to make the best of it with the limitations that exist today and the large companies trying to count on Jenkins X more and more.

## Feedback and questions

We’d love to hear from you on this and discuss it more, so please ping us in the community Slack, join office hours and get involved. The Jenkins X community is critical to all of us and, even with some setbacks and missteps, we’re excited to keep learning and improving together.
