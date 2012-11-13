---
layout: post
published: true
title: Maven Dependencies
---

I've been using Maven and never truely understood how dependencies were resolved. Today I took the time to figure it out, so I'm going to document it here for my future reference. First off, pom files are declarative. That means the pom says I reference this jar, but not how to go about referencing the jar (though you provide some hints, i.e. remote repositories).

Maven uses a waterfall methodology for looking up dependencies defined in the pom file. It looks in these places, in this order:

* local repository (~/.m2/repository)
* http://repo.maven.apache.org/maven2/
* Remote Repositories listed in your pom

There is a bit more magic, if you depend on a snaphot. A snapshot means that version is actively in development and hasn't been released. In that case, maven will check for a new version remotely even if it already exists in the local repo. You can override this behaviour with the following: 

	<snapshots>
		<enabled>true</enabled>
		<updatepolicy>{always,daily,interval:XXX,never}</updatepolicy>
	</snapshots>