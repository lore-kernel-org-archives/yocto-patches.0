Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292D4C02187
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 02:06:49 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.28657.1737338803484151880
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 19 Jan 2025 18:06:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D2A7/kX+;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so4061521e87.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 19 Jan 2025 18:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737338800; x=1737943600; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MYAw7UtUsXAtLzOQRbXJm7w7mdwDMx9lWtM46IQMVsQ=;
        b=D2A7/kX+BtiqtaaQ7R6yUZWgCUOmtPOe6/6qhJKg/jJJ6SORF4s64WJafqtBsjT2xA
         Vp+Gn/7kvCiR6EeZhly4oulAG24eh6KzYrzOCQgBt76VNsUDrYjB3vpOhhoL5GgJCRwq
         cK7KvByEFTKNVHIfrR/RrVMRUgBdUYjSyh33yYliFT6xENg4xawbWo8fQZ2Bp6EW2PV7
         cDlDl4D+Ag+w6xUoyu4awseZps4DmUKMtmtf62by1ODkBQxCGl/ptUTs81ZstkU1kb25
         1dWHUraSANDP9suX7OmKOzPP4zHp+yNdsvW4uUxMQcAjD3m8UvRjEfvzvpxThw9CGbIl
         D8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737338801; x=1737943601;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYAw7UtUsXAtLzOQRbXJm7w7mdwDMx9lWtM46IQMVsQ=;
        b=VsV47y8ZegO6M7ZtPv7BeZcMdhA+B1pCiutO4mRnsb4HEih/alJdTKdTqvvJmIkzeX
         O3tLESnlTy/QY3KHrANQeEO+2ygeHe61AST3DLnQpl6nYWySWhMwc74TYvJvktf8RYUu
         b9HNh5+20LRRNyCEufMRqoxm8djpRwP1cS0vlj8GwwtAMTQ/rdIUaCziqB2fNEPJIFKR
         4gyQazu0hX0zKrA20aXF/+KqQGmVg6qzf5CUf5gSZE5iL5osEvf9Pm6idmyvskzI4MIo
         0+T722/rUsBC5tg4tnyiRmDl+vieSWAK2WIo+XAx5bgiKlSUezXnXek3083zFj4WkNCA
         xM6w==
X-Gm-Message-State: AOJu0Yw/pKftByb8zxnoszd6aFy63AWHDL5s2vEN0umdmQssDeAm5d4x
	hnkbMQGFq0VD/+Auv1/tECBWm3dpulrPUw0w8qHNx5rLJjglfULiB93sEwPdztp8P4jl9k3Y+0J
	1r892RdIfw4EMcb/r/kMISVujxsIdo3qu
X-Gm-Gg: ASbGncu4do8ThyKkmoNMTVXmF1pm3IJ1ShsidpUbxpVQFJCo8cehiqgqjq7IhKrFnrg
	sGmledij/8cj7Z6dVJWJQZVr2W8OU2zQqtNFN2fAtbbYiEbvZqN0=
X-Google-Smtp-Source: AGHT+IFV8LGkx7YXrokioBuUfD0Wh6o4f8TRN1EefmwDtriqx1HhcSTmYyJVWctr65q4Zw1SSk529p+qiEIpTJ/yKxo=
X-Received: by 2002:a05:6512:3b09:b0:542:2f0f:66d9 with SMTP id
 2adb3069b0e04-5439c246297mr4720946e87.16.1737338799767; Sun, 19 Jan 2025
 18:06:39 -0800 (PST)
MIME-Version: 1.0
From: Tim Orling <ticotimo@gmail.com>
Date: Sun, 19 Jan 2025 18:06:28 -0800
X-Gm-Features: AbW1kvYgfK-EyFw5099wiR1Lqvs8e9qacg4SK6t8vZRZISZZZ0zkGZOdRuIWiZk
Message-ID: <CANx9H-DLgXKwQFe=nb39udFVACKRb_6g0L5OGsL4n2kLLdfsiQ@mail.gmail.com>
Subject: [meta-java] State of meta-java
To: yocto-patches@lists.yoctoproject.org, 
	"openembedded-devel@lists.openembedded.org" <Openembedded-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000003c8d4062c19b6df"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 02:06:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/986

--00000000000003c8d4062c19b6df
Content-Type: text/plain; charset="UTF-8"

I would like to let everyone know that meta-java is mostly on life support
at this point. The original founders and maintainers are long in-active and
have not responded to emails in years. I am one of the only folks left that
has push rights to the various repositories (Yocto Project, GitHub,
Gitlab). After a decade or more of burning myself out trying to maintain
multiple projects where I am the last person standing, I have had to take a
step back. The last decade has taken its toll literally on my health. I
only work 40 hours a week, for my paying customers, as a consultant (
https://www.konsulko.com). Anything more than that, such as this weekend,
is my OWN TIME. My precious time away from friends and family and real
life. Please respect that when you send patches.

My requirements for the current state of meta-java are that any
patches MUST apply to "master" (meaning the development "walnascar" 5.2
release at this time, but we've been in this state since scarthgap at least
and probably more like since kirkstone). If patches apply cleanly,
including building and run-time testing, then I am willing to apply them.
After patches are merged to "master", they are eligible to be backported to
stable branches currently supported, such as kirkstone and scarthgap. I
will likely completely skip styhead at this point and will branch for the
walnascar release, if we achieve a functional layer. Otherwise, the major
focus would be on "master" and the LTS releases (currently kirkstone and
scarthgap). Non-LTS releases will not be a priority.

I have a branch with continuous integration somewhat working, running on my
own hardware on my own time at my own cost for the electricity and
maintenance. If anyone is willing to provide long-term funds (think in
multiple years or a decade) for an organization-wide Gitlab runner (or
Github Actions runner), it would be much appreciated. My current staging
branch is
https://gitlab.com/moto-timo/meta-java/-/tree/gitlab-ci?ref_type=heads.

I happened to have both the itch to scratch (desiring continuous
integration and responding to recent patch submissions) and the energy and
motivation to work on it over the weekend. At this point I am approaching
16 hours of my free time in the last two days that you should respect and
value at a reasonable hourly rate. It has been about 9 months since I was
last willing to do that. I cannot promise any energy or effort in the next
9 months.

If you look at the recent jobs, you will see that for all platforms
(qemuarm, qemuarm64, qemux86-64) the jobs had to be canceled because
openjdk-8 (target) is either timing out or causing a segfault. For qemuarm
(32-bit), there is a problem with fuzzing for a patch for hotspot which I
am currently at a loss to fix. My attempt to refresh the patches broke ALL
builds, not just qemuarm. There is also a significant problem with fetching
from hg.openjdk.net.

We need to upgrade many components in the layer. The old approach of
fetching multiple tarballs for jdk, hotspot, corba etc. from the mercurial
openjdk repository is VERY brittle. Most of the time I am unable to fetch
from that source. Modern openjdk is using other sites for providing sources
and is bundling them together in on tarball (usually .xz compressed),
instead of the madness of tracking several separate changesets. Many other
components have newer versions, but we need to refactor the code base and
move forward. Then we also have to decide what gets backported and how far
back. We've been essentially at a stand-still since at least kirkstone
timeframe.

I do not see much future in supporting openjdk-7, so it is a strong
candidate for being dropped.

We need to support newer jdk releases (11, 17, 21+). As I mentioned in my
Yocto mini-summit talk (https://www.youtube.com/watch?v=rwkAVxFTVw8), the
requirements for building from source are that an N-1 release builds the N
release. If you do the math, it is absolute insanity to build ecj ->
intermediate -> icedtea-7 -> openjdk-8 -> 9 -> 11 -> ... -> 17 -> 21. HARD
NO. We need to use a binary native approach (similar to go in oe-core) to
bootstrap a build. I have some work-in-progress staged, but this requires
at least a week (more likely two) full time to complete. I WILL NOT do that
on my own time. See my statements about literal health impact above.

Until I am able to completely build at least openjdk-8-test-image and
openjre-8-test-image for qemuarm, qemuarm64 and qemux86-64 (and really we
should be also building for musl), I cannot CONFIDENTLY merge most patches.
When openjdk-8 and openjre-8 are stalling/segfaulting my Debian 12 build
machine (even with kas-container), there is no path forward.

If you depend upon meta-java for your product, please consider joining with
others to fund my time (https://www.konsulko.com) so that I can focus on
the layer during working hours. Alternatively, set up your own Gitlab CI
runner with my gitlab-ci branch and send patches to fix the segfault/stall
in openjdk-8/openjre-8. There are also some lingering issues with building
icedtea7-native on Debian 12/Ubuntu 22.04+, but at least for now that has
succeeded with a kas 4.6 containerized build.

If you depend on meta-java, please contribute in a constructive way to the
community. But until a COMPLETE test image can be built on the current
"master" (poky "walnascar" 5.2 development), there will not be much merging
happening. If you cannot show PROOF of a COMPLETE openjdk-8-test-image and
openjre-8-test-image for a minimum of qemuarm, qemuarm64 and qemux86-64,
then I will reserve the right to ignore your patches. Be prepared to then
answer problems with musl builds, as there are a separate set of patches on
problems there.

In the future, I would like to enable testimage and run-time testing of
images, and possibly even real on-target hardware testing (such as
raspberrypi or beagleplay targets). We can see an approach to reporting
such results in the meta-arm layer that is very promising. I have the
beginnings of some labgrid testing infrastructure that could run those
tests on real hardware and publically share those results. This takes time,
money, energy and motivation.

You only get out of Open Source what you support in it.

We can do this.

Cheers,

Tim

--00000000000003c8d4062c19b6df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I would like to let everyone know that meta-java is mostly=
 on life support at this point. The original founders and maintainers are l=
ong in-active and have not responded to emails in years. I am one of the on=
ly folks left that has push rights to the various repositories (Yocto Proje=
ct, GitHub, Gitlab). After a decade or more of burning myself out trying to=
 maintain multiple projects=C2=A0where I am the last person standing, I hav=
e had to take a step back. The last decade has taken its toll literally on =
my health. I only work 40 hours a week, for my paying customers, as a consu=
ltant (<a href=3D"https://www.konsulko.com">https://www.konsulko.com</a>). =
Anything more than that, such as this weekend, is my OWN TIME. My precious =
time away from friends and family and real life. Please respect that when y=
ou send patches.<br><br><div>My requirements for the current state of meta-=
java are that any patches=C2=A0MUST apply to &quot;master&quot; (meaning th=
e development &quot;walnascar&quot; 5.2 release at this time, but we&#39;ve=
 been in this state since scarthgap at least and probably more like since k=
irkstone). If patches apply cleanly, including building and run-time testin=
g, then I am willing to apply them. After patches are merged to &quot;maste=
r&quot;, they are eligible to be backported to stable branches currently su=
pported, such as kirkstone and scarthgap. I will likely completely skip sty=
head at this point and will branch for the walnascar release, if we achieve=
 a functional layer. Otherwise, the major focus would be on &quot;master&qu=
ot; and the LTS releases (currently kirkstone and scarthgap). Non-LTS relea=
ses will not be a priority.</div><div><br></div><div>I have a branch with c=
ontinuous integration somewhat working, running on my own hardware on my ow=
n time at my own cost for the electricity and maintenance. If anyone is wil=
ling to provide long-term funds (think in multiple years or a decade) for a=
n organization-wide Gitlab runner (or Github Actions runner), it would be m=
uch appreciated. My current staging branch is=C2=A0<a href=3D"https://gitla=
b.com/moto-timo/meta-java/-/tree/gitlab-ci?ref_type=3Dheads">https://gitlab=
.com/moto-timo/meta-java/-/tree/gitlab-ci?ref_type=3Dheads</a>.</div><div><=
br></div><div>I happened to have both the itch to scratch (desiring continu=
ous integration and responding to recent patch submissions) and the energy =
and motivation to work on it over the weekend. At this point I am approachi=
ng 16 hours of my free time in the last two days that you should respect an=
d value at a reasonable hourly rate. It has been about 9 months since I was=
 last willing to do that. I cannot promise any energy or effort in the next=
 9 months.</div><div><br></div><div>If you look at the recent jobs, you wil=
l see that for all platforms (qemuarm, qemuarm64, qemux86-64) the jobs had =
to be canceled because openjdk-8 (target) is either timing out or causing a=
 segfault. For qemuarm (32-bit), there is a problem with fuzzing for a patc=
h for hotspot which I am currently at a loss to fix. My attempt to refresh =
the patches broke ALL builds, not just qemuarm. There is also a significant=
 problem with fetching from <a href=3D"http://hg.openjdk.net">hg.openjdk.ne=
t</a>.<br><br>We need to upgrade many components in the layer. The old appr=
oach of fetching multiple tarballs for jdk, hotspot, corba etc. from the me=
rcurial openjdk repository is VERY brittle. Most of the time I am unable to=
 fetch from that source. Modern openjdk is using other sites for providing =
sources and is bundling them together in on tarball (usually .xz compressed=
), instead of the madness of tracking several separate changesets. Many oth=
er components have newer versions, but we need to refactor the code base an=
d move forward. Then we also have to decide what gets backported and how fa=
r back. We&#39;ve been essentially at a stand-still since at least kirkston=
e timeframe.<br><br>I do not see much future in supporting openjdk-7, so it=
 is a strong candidate for being dropped.<br><br>We need to support newer j=
dk releases (11, 17, 21+). As I mentioned in my Yocto mini-summit talk (<a =
href=3D"https://www.youtube.com/watch?v=3DrwkAVxFTVw8">https://www.youtube.=
com/watch?v=3DrwkAVxFTVw8</a>), the requirements for building from source a=
re that an N-1 release builds the N release. If you do the math, it is abso=
lute insanity to build ecj -&gt; intermediate -&gt; icedtea-7 -&gt; openjdk=
-8 -&gt; 9 -&gt; 11 -&gt; ... -&gt; 17 -&gt; 21. HARD NO. We need to use a =
binary native approach (similar to go in oe-core) to bootstrap a build. I h=
ave some work-in-progress staged, but this requires at least a week (more l=
ikely two) full time to complete. I WILL NOT do that on my own time. See my=
 statements about literal health impact above.</div><div><br></div><div>Unt=
il I am able to completely build at least openjdk-8-test-image and openjre-=
8-test-image for qemuarm, qemuarm64 and qemux86-64 (and really we should be=
 also building for musl), I cannot CONFIDENTLY merge most patches. When ope=
njdk-8 and openjre-8 are stalling/segfaulting my Debian 12 build machine (e=
ven with kas-container), there is no path forward.<br><br>If you depend upo=
n meta-java for your product, please consider joining with others to fund m=
y time (<a href=3D"https://www.konsulko.com">https://www.konsulko.com</a>) =
so that I can focus on the layer during working hours. Alternatively, set u=
p your own Gitlab CI runner with my gitlab-ci branch and send patches to fi=
x the segfault/stall in openjdk-8/openjre-8. There are also some lingering =
issues with building icedtea7-native on Debian 12/Ubuntu 22.04+, but at lea=
st for now that has succeeded with a kas 4.6 containerized build.</div><div=
><br></div><div>If you depend on meta-java, please contribute in a construc=
tive way to the community. But until a COMPLETE test image can be built on =
the current &quot;master&quot; (poky &quot;walnascar&quot; 5.2 development)=
, there will not be much merging happening. If you cannot show PROOF=C2=A0o=
f a COMPLETE openjdk-8-test-image and openjre-8-test-image for a minimum of=
 qemuarm, qemuarm64 and qemux86-64, then I will reserve the right to ignore=
 your patches. Be prepared to then answer problems with musl builds, as the=
re are a separate set of patches on problems there.</div><div><br></div><di=
v>In the future, I would like to enable testimage and run-time testing of i=
mages, and possibly even real on-target hardware testing (such as raspberry=
pi=C2=A0or beagleplay=C2=A0targets). We can see an approach to reporting su=
ch results in the meta-arm layer that is very promising. I have the beginni=
ngs of some labgrid testing infrastructure that could run those tests on re=
al hardware and publically share those results. This takes time, money, ene=
rgy and motivation.</div><div><br></div><div>You only get out of Open Sourc=
e what you support in it.<br><br>We can do this.</div><div><br></div><div>C=
heers,</div><div><br></div><div>Tim<br></div></div>

--00000000000003c8d4062c19b6df--

