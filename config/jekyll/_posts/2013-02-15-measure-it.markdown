---
layout: post
published: true
title: Measure it on the JVM, Yammer Metrics + Graphite = Winning
---

You're application/service should have an SLA, goal setting is important in all walks of life. A good example SLA is "My service will send a response within 300ms for 99.9% of requests for a peak client load of 500 requests per second." Amazon's Dynamo paper makes a good argument for defining SLAs that cover the entire bell curve, rather than the mean. Basically, you want all of your customer's to have a good experience, not some of them

Now that you have you're SLA, how do you know if you're delivering on you're agreement? You have to measure, and track those measurements. You can not performance tune without measuring, other wise that's just called guessing. Now that you are convinced you need it. How do you do it?

For metrics gathering on the JVM, I recommend you use Yammer Metrics. It's really simple to use, and it's well described [here](http://metrics.codahale.com/getting-started/)

Why I like it:

* It has Histograms!!
* It has everything I ever needed: counters, gauges, histograms, and timers.
* It automatically integrates with jvisualvm using JMX
* It easy to ship your metrics to logs or graphite on a timer. For the latter there is basically a timer thread pumping metrics via UDP to the Graphite daemon
* If you use DropWizard, you can get metrics with a quick annotation of your endpoint: @Timed

What I don't like: 

* zip, zero, & nada. It's frigg'n awesome!

For tracking your metrics, I like Graphite. It's basically a time series db for numerical values with a view layer. More info [here](http://graphite.wikidot.com/). Graphite doesn't care who sends it data, so the metrics don't have to come from Yammer Metrics or the JVM. Basically anything that can open a socket can get data to into graphite, you just need to send the data in a structured format. This makes it very useful for tracking anything. 

Why I like it:

* You can track your historical data and create pretty pictures
* You can feed it from many sources
* It's scalable
* It's extremely useful
* You can create dashboards, and go nuts with D3/Cubism.

What I don't like:

* It's not easy to get installed, especially if you want Python3. If you don't wan't to host it your self, it exists as a [service](https://www.hostedgraphite.com/)
* It's more infra to maintain & support 
* The web UX experience leaves a bit to be desired



