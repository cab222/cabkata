---
layout: post
published: true
title: Ditching Your LB
---

Yesterday I went to a tech talk given at [AppNexus][1] by @pemerson that was focused on their experiences with Load Balancers (LBs). They went from relying heavily on LBs for routing their traffic to not relying on them at all. This talk was extremely relevant, as our team has had poor LB experiences. Specifically, our problems were caused by vendor reliability. Multiple misconfigurations have led to outages. Below I will summarize the take aways, but first I want to state my stance on owning your own LB infra. 

This is a decision not to be taking lightly, devs tend to think they can roll their own better solution. While this may be true, especially for a limited set of functionality, it's important to balance that with the cost of maintenance, SLAs, and team skills. I would recommend dealing with vendors until you really can't anymore. Where I work, I think we have the profile to take this on. For me, the question is: 'is this the right timing?' My feeling is that if our vendor fails us again, the answer will be 'Now !!!'.
<br><br>
Disadvantages of an LB (I think we know these already)
======================================================

* Vendor cost
* Provisioning time
* Vendor reliability
* AppNexus saw 5x lower performance than expected
<br><br>
How did they ditched the LB?
=============================

* They rolled their own DNS solution in perl (sounds like open source  options are available)
* The DNS acts as the LB, serving a pool of public IP addresses corresponding to the nodes in the cluster
* To determine active nodes in the cluster, DNS polls nodes for health; Nodes provide a health endpoint.
* Node failures in the cluster are resilient. Each logical node has a public ip address. That public ip is linked to multiple private IPs, corresponding to multiple physical nodes. One of these physicals is the active node, and the others are hot backups. This resiliency strategy is all managed with an open source technology called [KeepAliveD][2].
<br><br>
The Tradeoffs
=============

* SSL support requires more work ([Stunnel][3]/[NGINX][4])
* Limited to 'Round Robin.'  Advanced LB features such 'Least Used CPU' are not available without more developer work.
* You own it, no commercial support
* [KeepAliveD][2] requires multicast. So if you want EC2 hosting, it requires a slightly different approach

[1]: http://www.appnexus.com/       "AppNexus"
[2]: http://www.keepalived.org/			"KeepAliveD"
[3]: https://www.stunnel.org/index.html "Stunnel"
[4]: http://nginx.com/							"NGINX"