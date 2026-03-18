Return-Path: <ukleinek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C2C103E18F
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 14:22:50 +0000 (UTC)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15267.1773843768305923617
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 07:22:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=D5E8JlzE;
 spf=pass (domain: baylibre.com, ip: 209.85.128.68, mailfrom: ukleinek@baylibre.com)
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so27212415e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773843766; x=1774448566; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEfnA2ba+zXEwbThRXQFkoKIIFVYelwRrvLPWLQWFxg=;
        b=D5E8JlzEK+hFOP+0fsftMYCCqCr7XOWFhPH9bzxJlRY3JuR2arEnYQPV55WFputKKq
         zcP9XSfobsfe6JgR5QXHpebsVqX7gkFsH1tdbfOxOfelQm3CqvHH7qFmjlgAv+Q7+vEP
         G2mrG7yrbmrK35EujVtEpuizs5mgJBg3TusUnLNZ/cz+7YQ68Y7LcpdYFvwPfr6ba/h+
         qxPCTOhbMHh7nCBvqubek1GC+b7Etwa2gCPUqhYMTBKxqlpvEetFPGPi9H7yw4Fo7dXC
         0pt212quG8jQZp6yY7JYYYECQ4FlzCPRsDHFpfO5/ZmyuDzDmhNpYtBqrsl60068Vj0F
         CocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773843766; x=1774448566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEfnA2ba+zXEwbThRXQFkoKIIFVYelwRrvLPWLQWFxg=;
        b=YwioNmi/BPJyWROdE3jYcJeaYIopO74Qip4SB7cwkOPALJV9CMkJ7iCDhUovdEp3im
         ynbnhLn18mJVntL2SoW9GNHvlQz8P+pVgOxKQZcr7tB8zyBhw2Spd+adrR8aMQaOzu5s
         gWLvCU4Z58wJjB2Mjk6oEiMaV2O32LAB8F5pRQXDlCxtj7kdEDhpXb4ueAqypWW9aN6Z
         QpihpvWdRroVqPijAn8NqFKkVXWoKlhttiOW5ixUlMjoO66VnHyvsPY4wW8KAlsNRt7F
         +jmLhcXUamYny3mlJhzAGsGeJDgopknO8+KqLQq0/na4f4sJ4noqCXUUMMiS/JFH4FHv
         kjGg==
X-Forwarded-Encrypted: i=1; AJvYcCUu9WwJgygZPoYPEWTQleyOqrqSQdZK7ZOjLXgrkQugYd2GdXzKwzqaAwED2hRPHnhtE+P3+xBXgSXzNLN5@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxhtuoEotTq2ZSSPreDf5jMJn+vaMZmp1a2+GJGO8eRqWXN9o8X
	MseFoZN3FQRkJIMqhj6F5O7cKqsjXiHwUpf4H2s9D8D+vCgUFaSQ8h8+KvkRC6Qccjk=
X-Gm-Gg: ATEYQzy2thKsO9wcYfW3C+rqqxE8mC2vLeA3kzQ9QqLZGCiBono0RaiUNASMJ9HTFP8
	vKoxGp8L3Td3iLwNxghsQ5G3eBiSNL4bx8LNNh/O76Wcnya8T8CLCl2+FJTGIrSpllKv8AsIus0
	SnoFFKTC8ngEhRlxQHrvUCS2FkC2Ogv4ZCA10owriTHdSpFAXb8ABjqskkT9DSh0WJGQOyffB6t
	vqeC970wk0x9RYkDyHJ7Q7zlm1v06D8qu5VcRnaft8D8WoYVDn36hKqoXgIktJxVdQIUlLBn3+0
	9b2dtR2PzerGxKjIHpO8P8aUhhozb0vuMk6om5v+fjUQVwik59eyovZzVisEEQBGVggP30zQ1ih
	oz4VrExHSSCZhjfPMk7uh2+Pm2bEcvQEckMLuVf1r1eHnH2ngnA0pzYBtijv4D5SzgvYKVu2dfq
	d60doKXaEb7BjDOJ1ARKNmPxlvk71SKfttEKoCnJT1lMQyAGcCujpUipbTI7z9/3EqpSUilx7jB
	d7pgPFxu3NY0yq98DO+4DtUBQ==
X-Received: by 2002:a05:600c:4712:b0:485:3aa1:a7f0 with SMTP id 5b1f17b1804b1-486f442e6damr60206535e9.4.1773843766219;
        Wed, 18 Mar 2026 07:22:46 -0700 (PDT)
Received: from localhost (p200300f65f20eb0420fbc0befea5de02.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:20fb:c0be:fea5:de02])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4856ea8fad1sm261958135e9.1.2026.03.18.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:22:45 -0700 (PDT)
Date: Wed, 18 Mar 2026 15:22:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Yoann Congal <yoann.congal@smile.fr>, 
	yocto-patches@lists.yoctoproject.org, Yi Zhao <yi.zhao@windriver.com>, 
	Hiago De Franco <hfranco@baylibre.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
Message-ID: <abqvgTxKOJxWCxAB@monoceros>
References: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
 <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
 <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
 <pfqfrlcduuigcvfdvn5ljjmjomee2wwn7xxu5ikibinoz57udn@dusca2fnhwja>
 <DH59MQQ8LHWC.25HPETRJUAGLI@smile.fr>
 <abpXXjX8C23hL8RO@monoceros>
 <e5bcfc29f4ab15e0ac21e2273a679821373530c6.camel@linuxfoundation.org>
 <abqEzAjosilonVNP@monoceros>
 <d8f70ee878b8101ef7a5f1b11c1bb52aa172c89b.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opl3hzvtw6rihrfw"
Content-Disposition: inline
In-Reply-To: <d8f70ee878b8101ef7a5f1b11c1bb52aa172c89b.camel@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 14:22:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3514


--opl3hzvtw6rihrfw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
MIME-Version: 1.0

Hey Richard,

On Wed, Mar 18, 2026 at 12:37:42PM +0000, Richard Purdie wrote:
> On Wed, 2026-03-18 at 12:13 +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Mar 18, 2026 at 09:12:52AM +0000, Richard Purdie wrote:
> > > On Wed, 2026-03-18 at 08:50 +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Tue, Mar 17, 2026 at 07:23:35PM +0100, Yoann Congal wrote:
> > > > > On Tue Mar 17, 2026 at 6:40 PM CET, Hiago De Franco via lists.yoc=
toproject.org wrote:
> > > > > > On Mon, Mar 09, 2026 at 02:21:51PM +0000, Richard Purdie wrote:
> > > > > > > On Mon, 2026-03-09 at 20:23 +0800, Yi Zhao via lists.yoctopro=
ject.org wrote:
> > > > > > > >=20
> > > > > > > > On 2/13/26 23:42, "Uwe Kleine-K=F6nig wrote:
> > > > > > > > > With SELinux enabled for the target it makes sense to hav=
e SELinux
> > > > > > > > > support enabled for the native tools, too.
> > > > > > > > >=20
> > > > > > > > > Note that for native packages DISTRO_FEATURES is filtered=
, thus up to now
> > > > > > > > > it never contained "selinux". Append to DISTRO_FEATURES_F=
ILTER_NATIVE to
> > > > > > > > > make "selinux" propagate also to DISTRO_FEATURES for nati=
ve packages.
> > > > > > > > > ---
> > > > > > > > > Hello,
> > > > > > > > >=20
> > > > > > > > > I use this on scarthgap, but the patch applies fine to ma=
ster, too.
> > > > > > > > >=20
> > > > > > > > > During a debug session it took me quite a while to find o=
ut why
> > > > > > > > >=20
> > > > > > > > > 	ls -lZ "${IMAGE_ROOTFS}
> > > > > > > > >=20
> > > > > > > > > at the end of selinux_set_labels() didn't show the labels=
 added by
> > > > > > > > > setfiles.
> > > > > > > > >=20
> > > > > > > > > Best regards
> > > > > > > > > Uwe
> > > > > > > > >=20
> > > > > > > > > =A0 classes/enable-selinux.bbclass | 2 +-
> > > > > > > > > =A0 conf/layer.conf=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | 4 ++++
> > > > > > > > > =A0 2 files changed, 5 insertions(+), 1 deletion(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/classes/enable-selinux.bbclass b/classes/ena=
ble-selinux.bbclass
> > > > > > > > > index 3dc61d6931ff..0c9f52e74cec 100644
> > > > > > > > > --- a/classes/enable-selinux.bbclass
> > > > > > > > > +++ b/classes/enable-selinux.bbclass
> > > > > > > > > @@ -1,3 +1,3 @@
> > > > > > > > > =A0 inherit selinux
> > > > > > > > > =A0=20
> > > > > > > > > -PACKAGECONFIG:append =3D " ${@target_selinux(d, 'selinux=
')}"
> > > > > > > > > +PACKAGECONFIG:append =3D " ${@bb.utils.filter('DISTRO_FE=
ATURES', 'selinux', d)}"
> > > > > > > > > diff --git a/conf/layer.conf b/conf/layer.conf
> > > > > > > > > index 4e04e5cc7e6a..ca981db57019 100644
> > > > > > > > > --- a/conf/layer.conf
> > > > > > > > > +++ b/conf/layer.conf
> > > > > > > > > @@ -25,3 +25,7 @@ LAYERDEPENDS_selinux =3D " \
> > > > > > > > > =A0 "
> > > > > > > > > =A0=20
> > > > > > > > > =A0 PREFERRED_PROVIDER_virtual/refpolicy ??=3D "refpolicy=
-targeted"
> > > > > > > > > +
> > > > > > > > > +# With target support for SELinux it is very helpful dur=
ing debug when the
> > > > > > > > > +# native tools support SELinux, too.
> > > > > > > > > +DISTRO_FEATURES_FILTER_NATIVE:append =3D " selinux"
> > > > > > > >=20
> > > > > > > > Can we add this to the doc (e.g. README) instead of enablin=
g it directly=20
> > > > > > > > in layer.conf? Since we haven't directly enabled DISTRO_FEA=
TURES =3D=20
> > > > > > > > "selinux" in layer.conf either.
> > > > > > >=20
> > > > > > > I just wanted to add that putting that directly in layer.conf=
 will mean
> > > > > > > the layer isn't Yocto Project Compatible too.
> > > > > >=20
> > > > > > I am going to send a v2 and take over this work, already asked =
Uwe about
> > > > > > that.
> > > > > >=20
> > > > > > But before doing it, I was wondering why changing layer.conf wi=
ll make
> > > > > > the layer not compatible with Yocto Project anymore. Can you ex=
plain to
> > > > > > us the reason?
> > > > >=20
> > > > > I'd guess it is from this criteria of the Yocto Compatible layer[=
0]:
> > > > > > Inclusion of any layer in the submission does not change the
> > > > > > behavior/configuration of the overall system without the user
> > > > > > explicitly opting into those changes
> > > > >=20
> > > > > By putting a 'DISTRO_FEATURES +=3D "selinux"' in layer.conf, the
> > > > > configuration changes globally without explicit opt-in of the use=
r.
> > > >=20
> > > > Note that the patch didn't change DISTRO_FEATURES, it appended "sel=
inux"
> > > > to DISTRO_FEATURES_FILTER_NATIVE. If DISTRO_FEATURES doesn't already
> > > > contain "selinux", this is a noop. So I don't see how this violates=
 the
> > > > quoted critera.
> > > >=20
> > > > What am I missing?
> > >=20
> > > I guess it would depend whether any of the functions/variables in core
> > > have hard dependencies on that variable. I was assuming that they do
> > > but that might not be the case, I'm not sure without checking and you
> > > may be right.
> >=20
> > Wouldn't that be a bug if a function changes behaviour depending on
> > DISTRO_FEATURES_FILTER_NATIVE containing "selinux" or not? (Apart from
> > having "selinux" for native packages iff the global DISTRO_FEATURES has
> > "selinux".)
>=20
> It depends on how that variable is being used. Some usages would be an
> issue, some would not. I have not checked how it is being used and what
> the implications of that are.
>=20
> > I grepped for DISTRO_FEATURES_FILTER_NATIVE in oe-core, bitbake and
> > meta-openembedded, there are only matches in the first and these are
> > about default settings, appending DISTRO_FEATURES_OVERRIDES and
> > providing a filtered version of the global DISTRO_FEATURES for native
> > packages.
> >=20
> > So unless I missed something, I'd claim setting
> > DISTRO_FEATURES_FILTER_NATIVE:append in a layer doesn't result in a
> > relevant change without an explicit opt-in (by adding "selinux" to
> > DISTRO_FEATURES) and then this (implicit) v1 is better than the v2 that
> > Hiago sent.
>=20
> I'm starting to wish I'd just never said anything :/.

:-\

> It would be nice if meta-selinux passes yocto-check-layer but that
> isn't my call, I don't know if it does currently pass or not. I wanted
> to caution that changing DISTRO_FEATURES or things related to
> DISTRO_FEATURES from layer.conf is generally a bad idea. In this case
> you might get away with it, I don't know. Has anyone tested it?

I tried that:

	uwe@monoceros:~/work/ashjk/poky/build$ yocto-check-layer ../meta-selinux
	INFO: Detected layers:
	INFO: meta-selinux: LayerType.SOFTWARE, /home/uwe/work/ashjk/poky/meta-sel=
inux
	ERROR: Layer meta-selinux depends on meta-python and isn't found.
	INFO:
	INFO: Setting up for meta-selinux(LayerType.SOFTWARE), /home/uwe/work/ashj=
k/poky/meta-selinux
	ERROR: Layer meta-selinux depends on meta-python and isn't found.
	INFO: Skipping meta-selinux due to missing dependencies.
	INFO:
	INFO: Summary of results:
	INFO:
	INFO: meta-selinux ... SKIPPED (Missing dependencies)

hmm, so maybe I need to add this using --dependency:

	uwe@monoceros:~/work/ashjk/poky/build$ yocto-check-layer ../meta-selinux -=
-dependency ../meta-openembedded/meta-python --dependency ../meta-openembed=
ded
	INFO: Detected layers:
	INFO: meta-selinux: LayerType.SOFTWARE, /home/uwe/work/ashjk/poky/meta-sel=
inux
	INFO: Adding meta-python to the list of layers to test, as a dependency
	INFO: Adding meta-oe to the list of layers to test, as a dependency
	INFO:=20
	INFO: Setting up for meta-selinux(LayerType.SOFTWARE), /home/uwe/work/ashj=
k/poky/meta-selinux
	INFO: Adding layer meta-python
	INFO: meta-python is already in /home/uwe/work/ashjk/poky/build/conf/bblay=
ers.conf
	INFO: Adding layer meta-oe
	INFO: meta-oe is already in /home/uwe/work/ashjk/poky/build/conf/bblayers.=
conf
	INFO: Getting initial bitbake variables ...
	INFO: Getting initial signatures ...
	INFO: Generating signatures failed. This might be due to some parse error =
and/or general layer incompatibilities.
	Command: BB_ENV_PASSTHROUGH_ADDITIONS=3D"$BB_ENV_PASSTHROUGH_ADDITIONS BB_=
SIGNATURE_HANDLER" BB_SIGNATURE_HANDLER=3D"OEBasicHash" bitbake -S lockedsi=
gs world
	Output:
	WARNING: Host distribution "debian-13" has not been validated with this ve=
rsion of the build system; you may possibly experience unexpected failures.=
 It is recommended that you use a tested distribution.
	Loading cache...done.
	Loaded 0 entries from dependency cache.
	Parsing recipes...done.
	Parsing of 2472 .bb files complete (0 cached, 2472 parsed). 4316 targets, =
86 skipped, 0 masked, 0 errors.
	Removing 14 recipes from the core2-64 sysroot...done.
	Removing 19 recipes from the qemux86_64 sysroot...done.
	Removing 6 recipes from the x86_64 sysroot...done.
	NOTE: Resolving any missing task queue dependencies
	ERROR: Nothing PROVIDES 'libselinux' (but /home/uwe/work/ashjk/poky/meta-o=
penembedded/meta-oe/recipes-extended/hwloc/hwloc_2.9.3.bb, /home/uwe/work/a=
shjk/poky/meta-openembedded/meta-oe/recipes-devtools/squashfs-tools-ng/squa=
shfs-tools-ng_1.2.0.bb, /home/uwe/work/ashjk/poky/meta-openembedded/meta-oe=
/recipes-support/augeas/augeas_1.12.0.bb, /home/uwe/work/ashjk/poky/meta-op=
enembedded/meta-oe/recipes-support/lvm2/lvm2_2.03.22.bb, /home/uwe/work/ash=
jk/poky/meta/recipes-extended/at/at_3.2.5.bb, /home/uwe/work/ashjk/poky/met=
a-openembedded/meta-oe/recipes-extended/ostree/ostree_2024.5.bb, /home/uwe/=
work/ashjk/poky/meta-openembedded/meta-oe/recipes-extended/smartmontools/sm=
artmontools_7.4.bb, /home/uwe/work/ashjk/poky/meta/recipes-extended/logrota=
te/logrotate_3.21.0.bb, /home/uwe/work/ashjk/poky/meta/recipes-core/udev/eu=
dev_3.2.14.bb, /home/uwe/work/ashjk/poky/meta/recipes-support/vim/vim_9.1.b=
b, /home/uwe/work/ashjk/poky/meta/recipes-core/base-passwd/base-passwd_3.6.=
3.bb, /home/uwe/work/ashjk/poky/meta-openembedded/meta-oe/recipes-security/=
bubblewrap/bubblewrap_0.8.0.bb, /home/uwe/work/ashjk/poky/meta-openembedded=
/meta-oe/recipes-support/lvm2/libdevmapper_2.03.22.bb, /home/uwe/work/ashjk=
/poky/meta-openembedded/meta-oe/recipes-devtools/ltrace/ltrace_git.bb DEPEN=
DS on or otherwise requires it)
	ERROR: Required build target 'meta-world-pkgdata' has no buildable provide=
rs.
	Missing or unbuildable dependency chain was: ['meta-world-pkgdata', 'hwloc=
', 'libselinux']

	Summary: There was 1 WARNING message.
	Summary: There were 2 ERROR messages, returning a non-zero exit code.

	INFO: meta-python already in /home/uwe/work/ashjk/poky/build/conf/bblayers=
=2Econf. To capture initial signatures, layer under test should not present=
 in BBLAYERS. Please remove meta-python from BBLAYERS.
	INFO: meta-oe already in /home/uwe/work/ashjk/poky/build/conf/bblayers.con=
f. To capture initial signatures, layer under test should not present in BB=
LAYERS. Please remove meta-oe from BBLAYERS.
	INFO:=20
	INFO: Summary of results:
	INFO:=20
	INFO: meta-selinux ... FAIL (Generating world signatures)
	INFO: meta-python ... SKIPPED (Layer under test should not present in BBLA=
YERS)
	INFO: meta-oe ... SKIPPED (Layer under test should not present in BBLAYERS)

Maybe I'm holding it wrong, maybe meta-selinux just doesn't pass?!

Ah, when removing "selinux" from DISTRO_FEATURES it works better. Then
it says things like:

	...
	INFO: Traceback (most recent call last):
	  File "/home/uwe/work/ashjk/poky/scripts/lib/checklayer/cases/common.py",=
 line 99, in test_signatures
	    self.fail('Adding layer %s changed signatures.\n%s' % (self.tc.layer['=
name'], msg))
	    ~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^
	AssertionError: Adding layer meta-selinux changed signatures.
	1789 signatures changed, initial differences (first hash before, second af=
ter):
	   android-tools-conf:do_recipe_qa: 0b9fecbec98924f57499d5d53c4b08bebe50de=
ac72f025ed0f4b5b2274c57463 -> d7473d9aba93fba170cd904225f22485c12a8cbfbb909=
84d90014bc29ce47856
	      bitbake-diffsigs --task android-tools-conf do_recipe_qa --signature =
0b9fecbec98924f57499d5d53c4b08bebe50deac72f025ed0f4b5b2274c57463 d7473d9aba=
93fba170cd904225f22485c12a8cbfbb90984d90014bc29ce47856
	...

(That's without my change BTW.)

> I am generally worried about the amount of things people "load" up
> layer.conf with as whilst it seems easy, the scope of it can be
> problematic as it affects other layers, and in general you don't want
> to be doing that unless it is configurable.

I understand your motivation, adding things there (even if they are ok)
add to the things you stumble over.

There is nothing I can say to rebut that objection. Still I think the
addition we're discussing about is technically fine and reduces the
surprises when working with meta-selinux. So in my subjective opinion
it's a net win to add it.

Best regards
Uwe

--opl3hzvtw6rihrfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmm6tSkACgkQj4D7WH0S
/k4RKwf+Ii+kNzovO2zKIPinRTCkG3liO729nR9x88gkGm+FwLECpE4U34OgG9Cf
vYapp5+q6Q5UKC74JkFA1/Lva+oH1Fkf9rtwp4Nw9X/v1NzSYhqRaMrfVlZVyPAW
qs9BeSfU6MolYJ5BFq1yRM2/j1cZi/46egrpZEv/9GIoxt4zQjf9t77swU6ZXUcM
TwrytfgPM9zyqoKVPxUemF3MoCAyjLDUAHAcyAYopLqxJ031z65euamfA9/OPccw
5wZixoNbhKQ3/01WY6bcyDi5nUvq4JdfDq0pZH6F6FIXq+q06gnum8H0g1zs28Ra
pZ15MWmysS1z+RHVWEVeSv0RMsQTew==
=LoU9
-----END PGP SIGNATURE-----

--opl3hzvtw6rihrfw--

