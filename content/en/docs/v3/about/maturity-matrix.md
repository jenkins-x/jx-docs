---
title: Maturity Level Matrix
linktitle: Maturity Level Matrix 
description: Jenkins X 3.x features maturity assessment on different cloud providers
weight: 170
---

<style>
    .medium-zoom-image {
  cursor: zoom-in;
  transition: all 300ms;
}
</style>

<script src="node_modules/medium-zoom/dist/medium-zoom.min.js">
const mediumZoom = (selector, options = {}) => {
  // ...

  const isSupported = (elem) => elem.tagName === 'IMG'
  const isScaled = (img) => img.naturalWidth !== img.width

  const images =
    [...document.querySelectorAll(selector)].filter(isSupported) ||
    [...document.querySelectorAll('img')].filter(isScaled)

  // ...
}
</script>

This maturity matrix descibes the status of the Jenkins X 3.x __Alpha__ release.  This will continue to evolve as we progress towards Beta.

<img src="/images/v3/jx-v3alpha-maturity-matrix.png">

<img src="/images/v3/jx-v3alpha-color-rep.png">

<br />

This maturity matrix describes the tentative plan post Jenkins X v3.0 __GA__ release. This matrix will continue to evolve as we progress further.

<img src="/images/v3/jx-v3ga-maturity-matrix.png">
