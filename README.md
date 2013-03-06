#Introduction
This is an implementation of a residence based authentication on iOS for the iPhone.
Residence based authentication is an alternative user authentication, predominantly done by a password.
A related [public talk][2] was given at [NSConference][3] by [qnoid][18] in Leicester on Wednesday, 06 March 2013.

#Problem
**The plethora of passwords** across apps, services and devices and the overhead their usage adds.

#Motivation
To provide a simple way for users to login.
To provide a simple way for developers to implement.

#Implementation
Upon registering, the user client - in this case the iPhone - is assigned a residence. 
Once the residence is authorised, the user can use that residence to login.
The residence has no expiry date but can be deleted by the user on demand to prevent further access from that client.

The server implementation is deployed on heroku and uses email authorisation for the residence. The source code is available [on github.][4]
A [high level overview of the client/server implementation][1]) is also available.

#Other work on user authentication
Marco Arment, [@marcoarment][15] has ["implemented a crazy passwordless login system"][5] for [The Magazine][6] on the web.
Haven't come across any written public posts by Marco with details on the implementation. 
It appears that no token (e.g. a password or a residence) is used for user authorisation. The user is asked for his email and a [link is sent, with an expiry date][9].
The link is effectively an authorised login that sets a cookie for the client.

Ben Brown, [@xoxco][16] tweeted ["(we) implement passwordless login in all new software as a rule"][7] and also written a post on [passwordless login][8] and an [aftermath][10] since his [hacker news post][11].

Wired recently (November 2012) wrote an article on [passwords and identity theft.][12]

Arstechnica in 2009 wrote ["30 years of failure: the username/password combination".][13]

#Considerations
There is a chance that the user loses access to both his email and any client with an authorised residence. How does the user regain access to her data?
Email is not really designed for user authentication. Might worth considering a protocol for user authentication.

#Discussion
There is a [Google+ topic already on the subject][14], so please focus your efforts there.

[1]: https://speakerdeck.com/qnoid/user-identity
[2]: https://speakerdeck.com/qnoid/user-identity-nsconf
[3]: http://nsconference.com
[4]: https://github.com/qnoid/user_identity
[5]: http://www.marco.org/2013/02/24/the-magazine-sharing
[6]: http://the-magazine.org
[7]: https://twitter.com/xoxco/status/308607506387714048
[8]: http://notes.xoxco.com/post/27999787765/is-it-time-for-password-less-login
[9]: http://ge.tt/9jpk8Ca/v/0
[10]: http://notes.xoxco.com/post/28288684632/more-on-password-less-login
[11]: http://news.ycombinator.com/item?id=4308190
[12]: http://www.wired.com/gadgetlab/2012/11/ff-mat-honan-password-hacker/all/
[13]: http://arstechnica.com/business/2009/10/30-years-of-failure-the-user-namepassword-combination/
[14]: https://plus.google.com/116431322187209993066/posts/XWbTmuxr921
[15]: https://twitter.com/marcoarment
[16]: https://twitter.com/xoxco
[18]: http://www.qnoid.com
