---
title: "Serverless Jenkins"
date: 2018-10-20T07:36:00+02:00
description: >
    How to get an elastic serverless Jenkins cloud
categories: [blog]
keywords: []
slug: "serverless-jenkins"
aliases: []
author: jstrachan
---

## Serverless Jenkins

[James Rawlings](https://medium.com/@jdrawlings/) has just published an excellent article on [Serverless Jenkins with Jenkins X](https://medium.com/@jdrawlings/serverless-jenkins-with-jenkins-x-9134cbfe6870) that is well worth a read.

It describes how you can use it via the `--prow` feature flag when using either [jx create cluster](/commands/jx_create_cluster/) 

    jx create cluster gke --prow
    
or [jx install](/commands/deprecation/)

    jx install --prow 
    
For more details see the [blog](https://medium.com/@jdrawlings/serverless-jenkins-with-jenkins-x-9134cbfe6870) or check out the video:
         
<iframe width="800" height="500" src="https://www.youtube.com/embed/DmhDvr8fExA" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>    
