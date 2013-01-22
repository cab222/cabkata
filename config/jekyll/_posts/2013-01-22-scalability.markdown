---
layout: post
published: true
title: On Scalability
---
<h1><a href="http://blog.tech.renttherunway.com/?attachment_id=280" rel="attachment wp-att-280"><img class="wp-image-280 alignleft" alt="Carlo Barbara" src="http://blog.tech.renttherunway.com/wp-content/uploads/2013/01/CAB_bio_pic.jpg" width="130" height="112" /></a>Intro</h1>
We use Java and we like it! When I say this to some people, they cringe. They look at me like I'm a dinosaur who doesn't realize his extinction is coming. I usually smirk, I get it. These are folks that or so in love with Ruby/Rails or Python/Django that they forget it's just a tool for solving a certain kind of problem. I can understand why, they are both great tools! I built my personal site in Rails and it was a lot of fun. It's easy to iterate, and the community makes adding value very simple. The problem is you when you fall in love with your hammer, everything looks like a nail. In this post, I'll tell you some of the problems we faced, and why that made a pure 100% Rails app a bad choice for us. Then we will talk about how we are thinking about leveraging Ruby in our stack. But first, a little history is required.
<h1>Our Old Stack</h1>
Over three years ago our founders hired some consultants to build an MVP for their vision. They came back with PHP/Drupal and MySQL, a monolithic architecture. It was functional, allowing the founders to start growing the business. Customers were trying it out, and loving the service. The business had legs and traffic was steadily rising. Fast forward to last year, and our infrastructure was handling the flow, but it was creaking loudly. This architecture was fragile, and it didn't scale well in any direction.

Some of the issues we had with the codebase included:
<ul>
	<li>Monolithic code base. How do you make changes to one part without releasing everything else? How do you this with 20 devs? 100?</li>
	<li>How do you improve performance in this architecture? Caching will help some if your data is mostly static. Scaling horizontally at this level may not be not enough to increase throughput, it's too coarse and it requires logical separation to avoid DB concurrency issues.</li>
	<li>Concerns weren't separated, so one component going down risks taking down the whole site. Ideally you have "swim lanes", basically silos where if any component in the tech stack goes down, only that silo is affected. The product detail page can go down without taking down checkout, the homepage can be unavailable but those on product pages don't notice.</li>
	<li>How do you support multiple platforms? We don't want to write the same database logic in many different places, and the monolithic code base won't support apps for iphone, android, or ipad.</li>
	<li>The Drupal Code was spaghetti code. There was SQL in the views and controllers, which meant even making simple view changes was complex and risky. Adding insult to injury, the test coverage was non-existent. This made iterating a dangerous task.</li>
</ul>
<h1>Making it Scale</h1>
We like to think of Scalability in terms of the AFK Scalability Cube[1]. There are three axes for scaling you application
<ol>
	<li>The Y - axis (Splitting architecture out by service or function)</li>
	<li>The X - axis (Creating N instances of a component, all replicas. Excluding 1 designated for writes. Fronted by a load balancer)</li>
	<li>The Z - axis (Splitting resources by user characteristics. i.e The West coast on 1 pool, the East on another)</li>
</ol>
The further along these axes you get, the better your application scales. We know we needed a highly availability and concurrency, so we needed to scale in multiple directions.

Here is how we made this happen in practice, some of which we are still iterating on:
<ul>
	<li>(Y axis) We started dismantling the monolithic beast and migrating to a Service Oriented Architecture (SOA), based on Java backend web services.
<ul>
	<li>RESTful web services delivering JSON</li>
	<li>The concerns are well separated, a service has a specific job and does that job well</li>
	<li>Easier for development teams to own a full stack of components. This allows us to create small teams which act on goals without spelling out direction, fostering innovation.</li>
	<li>Allows for more frequent releases</li>
	<li>Creates disaster isolation: if only that service goes down, the rest of the site should remain available where you don't have cross swim lane dependencies.</li>
	<li>Why Java? It is easy to test, easier to scale, and more powerful than most high-level languages.</li>
</ul>
</li>
	<li>(X axis) We have pools of service instances fronted by load balancers.
<ul>
	<li>For a service that is slower or more popular, throw more instances in the pool</li>
	<li>Since the services themselves are smaller than one big app, you can better leverage hardware resources</li>
</ul>
</li>
	<li>(Y axis) The view is thin, and renders whatever the services provide.
<ul>
	<li>Create different view layers for different platforms</li>
	<li>Services don't care who the client is, they just respond to requests!</li>
</ul>
</li>
	<li>(All) Metrics gathering. You can't make it better if you can't measure it!</li>
</ul>
<h1>Ruby usage at RTR</h1>
When I think about SOA and scalability, I think about the JVM. It's stable, proven, and optimized. When you factor in the size of the community and tools available, it makes a great choice for writing your services. I couldn't see myself writing highly concurrent services in Ruby or Python, but maybe it's because I'm not as familiar with those languages. With that said, I haven't heard of many companies with similar performance requirements going down that route either. Going with Java comes with some overhead. It's verbose, and isn't as convention driven. This means it takes devs longer to write/read code and understand APIs. It also means you need strong leadership pushing solid practices, otherwise you can end up with multiple approaches. This is actually where I think Rails excels, convention over configuration speeds up development. So if you don't require high scalability or have a big dev team, Rails might be the way to go. It's definitely faster time to market, and a better tool for building an MVP.

As we continue to dismantle our monolithic beast and move away from PHP, we want something light and simple that we can control. For that reason, we are moving to Sinatra/Ruby. Stay tuned for more info on how that goes...

-@CarloBarbara

<a href="http://www.amazon.com/Scalability-Rules-Principles-Scaling-Sites/dp/0321753887/ref=sr_1_1?ie=UTF8&amp;qid=1354635203&amp;sr=8-1&amp;keywords=fisher+scalability">[1] AKF Cube</a>