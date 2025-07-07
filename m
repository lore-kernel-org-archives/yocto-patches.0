Return-Path: <erik.schumacher@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CBDC8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:40:08 +0000 (UTC)
Subject: Re: [ptest-runner][RFC] Implement ptest-runner to match previous documentation and current state of run-ptest scripts
To: yocto-patches@lists.yoctoproject.org
From: "Erik Schumacher" <erik.schumacher@iris-sensing.com>
X-Originating-Location: Berlin, State of Berlin, DE (77.183.67.2)
X-Originating-Platform: Linux Firefox 140
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 07 Jul 2025 02:40:05 -0700
References: <de08503fa719068700339deb279b538fc3a54abc.camel@linuxfoundation.org>
In-Reply-To: <de08503fa719068700339deb279b538fc3a54abc.camel@linuxfoundation.org>
Message-ID: <9289.1751881205147643831@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="wov5XFw5SWmWlJtTw2vT"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 09:40:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1770

--wov5XFw5SWmWlJtTw2vT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for your responses.

On Fri, Jul 4, 2025 at 07:05 AM, Richard Purdie wrote:

>=20
> One other data point to keep in mind is that ptest-runner was written
> in C to minimise dependencies. I appreciate you've only used built in
> python libraries but it does mean always installing python onto the
> test target, so missing dependencies on python would be difficult to
> detect after that.

That's a good point. I totally agree that a minimal stand-alone binary writ=
ten in C is the best option for an embedded system, or other setups that do=
n't include python. Primarily, I wanted to see how far I could get by devel=
oping a prototype in Python. I won't be sad if it remains a prototype.

I hope to find some spare time to contribute to the existing ptest-runner. =
Most important to me is parsing and collecting the stdout of the run-ptest =
scripts, and creating more extensive junit.xml files.

All the best!
Erik

--wov5XFw5SWmWlJtTw2vT
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>&nbsp;</div>
<div>thanks for your responses.</div>
<div>&nbsp;</div>
<div>On Fri, Jul 4, 2025 at 07:05 AM, Richard Purdie wrote:</div>
<div>
<blockquote>One other data point to keep in mind is that ptest-runner was w=
ritten<br />in C to minimise dependencies. I appreciate you've only used bu=
ilt in<br />python libraries but it does mean always installing python onto=
 the<br />test target, so missing dependencies on python would be difficult=
 to<br />detect after that.</blockquote>
That's a good point. I totally agree that a minimal stand-alone binary writ=
ten in C is the best option for an embedded system, or other setups that do=
n't include python. Primarily, I wanted to see how far I could get by devel=
oping a prototype in Python. I won't be sad if it remains a prototype.<br /=
><br />I hope to find some spare time to contribute to the existing ptest-r=
unner. Most important to me is parsing and collecting the stdout of the run=
-ptest scripts, and creating more extensive junit.xml files.<br /><br />All=
 the best!<br />Erik</div>

--wov5XFw5SWmWlJtTw2vT--

