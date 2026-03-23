# Contributing Rich Event Data

To make upcoming Jenkins X events show up more prominently in Google search and map results, we mark up our event information in structured data.

More information here: https://developers.google.com/search/docs/data-types/event

## Sample Event Data

Here is a multi-day event for DevOps World - Jenkins World with an offers URL for the registration page:

```
<div class="event-wrapper" itemscope itemtype="http://schema.org/Event">
  <meta itemprop="image" content="https://jenkins-x.io/images/community/events/2019-DWJW-JAM_banner-600x338.jpg" />
  <meta itemprop="description" content="DevOps World - Jenkins World is the largest gathering of Jenkins users in the world, including Jenkins experts, continuous delivery practitioners, and companies offering complementary technologies to Jenkins." />
  <meta class="event-date" itemprop="startDate" content="2019-12-03" />
  <meta class="event-date" itemprop="endDate" content="2019-12-05" />
  <meta class="event-title" itemprop="name" content="DevOps World - Jenkins World" />
  <div class="event-venue" itemprop="location" itemscope itemtype="http://schema.org/Place">
      <meta itemprop="name" content="Lisbon Congress Center" />
      <div class="address" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
          <meta itemprop="streetAddress" content="Praça das Indústrias 1" />
          <meta itemprop="postalCode" content="1300-307" />
          <meta itemprop="addressLocality" content="Lisboa" />
          <meta itemprop="addressCountry" content="Portugal" />
      </div>
  </div>
  <div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
    <meta itemprop="priceCurrency" content="EUR" />
    <meta itemprop="url" content="https://www.cloudbees.com/devops-world" />
  </div>
</div>
```

Here is a one-day event with start and end times. Google assumes the timezone of the provided location, so if the event is online be sure to add timezone info like `2020-02-02T09:00:00+02:00` (for Brussels UTC+2) if no location is specified. Here we use `isAccessibleForFree` to denote a free event.

```
<div class="event-wrapper" itemscope itemtype="http://schema.org/Event">
  <link itemprop="image" content="https://jenkins-x.io/images/community/events/2020-fosdem.png" />
  <meta itemprop="description" content="For the first time, there will be a Continuous Integration and Continuous 
  Deployment (CI/CD) devroom at FOSDEM! The CI/CD devroom will take place on 2nd of February 2020 in Brussels, Belgium." />
  <meta class="event-date" itemprop="startDate" content="2020-02-02T09:00:00" />
  <meta class="event-date" itemprop="endDate" content="2020-02-02T17:00:00" />
  <meta itemprop="isAccessibleForFree" content=true />
  <meta itemprop="audience" content="IT professionals" />
  <meta class="event-title" itemprop="name" content="CI/CD Devroom at FOSDEM 2020" />
  <div class="event-venue" itemprop="location" itemscope itemtype="http://schema.org/Place">
      <meta itemprop="name" content="Université libre de Bruxelles" />
      <div class="address" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
          <meta itemprop="streetAddress" content="Avenue Franklin D. Roosevelt 50" />
          <meta itemprop="postalCode" content="1050" />
          <meta itemprop="addressLocality" content="Brussels" />
          <meta itemprop="addressCountry" content="BE" />
          <meta itemprop="latitude" content=50.812375 />
          <meta itemprop="longitude" content=4.380734 />
      </div>
  </div>
  <div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
    <link itemprop="url" content="https://fosdem.org/2020/" />
  </div>
</div>
```