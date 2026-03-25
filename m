Return-Path: <hfranco@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B6F106B521
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 12:28:33 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20974.1774441706951879549
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Mar 2026 05:28:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=gQtjc4b8;
 spf=pass (domain: baylibre.com, ip: 209.85.221.181, mailfrom: hfranco@baylibre.com)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56cde757d3dso1833842e0c.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774441706; x=1775046506; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jq8ETNI3w4t3jsiMTqi4vx7eQ4O6s+5L5g5ocThhE9k=;
        b=gQtjc4b87kP4X71w1bxFkwFIx2l+eUZPq7qWHFu/r9FExBjnTb0VMYOpOrZYUvNIIo
         BvnbTlxEmp4/Fl9J+YzeA13sSxGy+OFhEszF0GwpGzJTsIo/9HJvpIo8A5pdC1KhuCRr
         THRyN+Ec468/F6cYCXyVGpo0xxj8gEq5KwdzuC3FiqPTqnN/Jij8SMG1uZ810nfBZ/MS
         j61Qn03+Ye428djq8bdAyhsS7Foeo0VLmGuQZk3caRYjwGMBJvuXjqPoASPRQ43wPjV/
         KIse2AlocT9RyjddN1AmfNivsQUUpQcguzk/rbjWZ3lOLBycssDLXfuV3UGBDehgR//r
         XaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774441706; x=1775046506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jq8ETNI3w4t3jsiMTqi4vx7eQ4O6s+5L5g5ocThhE9k=;
        b=bqdke9AosfW0rRBkIqjoEc2X9yB97smrN0fXNAa/pjE8mIFxNDIBMYhitc77kAKJqe
         M//iw6lcE6yKPoaf4efBT1b+Jv54FLYCz4a9cGH4aZ8Qjh9cGl0KWHUE4TumTAxSQwSq
         jGewNN0GXbju3L+Fqdd69/1MVfAfWpN6b9ntdskcuQmVEfqc6fWZHeJcefoKNFJqqIjG
         YlrT4YyNLMXUWi6gOLhfLNJBWDoI/xV/PuXJt9xhFPMAze36ty3nQ+n6MEUodNgrcTOa
         ypx7sPhhCgiwI9kV2jeTspJJ2dc8BUW3ibNSKSe43tpfRRsyKN9jqSP7+VgHUKv0sDMs
         rt5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOaqwRSdPAMOY9WsbfGYyxMeAwcWoRyTVf+ca26eW0fd9rA3XNZi2LIa2s2l4b+JekDtIGz0H04WhQFItG@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yyakv114eLjNdo+hdVn/x3ZNIYYpx454JUo1E2kEydTwTgA+n8M
	MOMYObib7wYb9NQtaG84HqyBqkhqGUgGsL1vax2Nwbt4Q5gDP9aVH9hztDKXnuw3d04=
X-Gm-Gg: ATEYQzwdVkJhpZvCm+loPgmiEfggOH2w2NV0s4ZYqjHzEOgkPnzvhLVuG2XxHVsa4nE
	DOW8xKrFT0ckmwbBPFJ20e2LIqyXKkl0RuoUTj7OMJY0/n3iK8vLJ4uD2I1WCPH93zxe6DUc/WM
	LoA02gh9C8CL+obR5wKrQz9QxzuKfDa8nTfMrS2TDgCrhjsZfWGTLz+1HN0PXvlEB6U+0j6SGOi
	kifQ7DUvrJt7uVhSiyB1vcsVOdsANJr6igePxyp3nD+Tk/pLEv4CzttiDWGM5HashUHcx0HqbvT
	TX9pDio91H3ekVwDzqRlgMxonOh5uNtYNpU12NEgC7fQAMpyPEW5l/eY4CI/Dk1rMzzmYImLDC+
	RGXFzVMl4Ya39MQuFWOqbnexBUDvCSOuG1Q/qW6dDwaH7D8Sx9qqVgb0OY0ZEhCYfXIyfDtDnyq
	jT/yHVVqszuI9uAOQtjLBuaYb2Yt0PuAhB63nlNCmOGhahDEfrPCCaouKFRKMohWPa/+weUw8Rt
	wM=
X-Received: by 2002:a05:6122:3788:b0:56b:9ba4:1372 with SMTP id 71dfb90a1353d-56d220694cdmr1336137e0c.9.1774441705566;
        Wed, 25 Mar 2026 05:28:25 -0700 (PDT)
Received: from hiagonb ([2804:1b3:a7c1:6f5c:a800:78aa:29b8:c09d])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cea30c727sm18367434e0c.2.2026.03.25.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:28:24 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:28:19 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Yoann Congal <yoann.congal@smile.fr>, yocto-patches@lists.yoctoproject.org, 
	Yi Zhao <yi.zhao@windriver.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
Message-ID: <s3dvnilzp3mv6xstf7syd42ru3pgjaiebooacljibgf5zpe4ba@ezu4xnouvw26>
References: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
 <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
 <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
 <pfqfrlcduuigcvfdvn5ljjmjomee2wwn7xxu5ikibinoz57udn@dusca2fnhwja>
 <DH59MQQ8LHWC.25HPETRJUAGLI@smile.fr>
 <abpXXjX8C23hL8RO@monoceros>
 <e5bcfc29f4ab15e0ac21e2273a679821373530c6.camel@linuxfoundation.org>
 <abqEzAjosilonVNP@monoceros>
 <d8f70ee878b8101ef7a5f1b11c1bb52aa172c89b.camel@linuxfoundation.org>
 <abqvgTxKOJxWCxAB@monoceros>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <abqvgTxKOJxWCxAB@monoceros>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 12:28:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3553

Hello,

On Wed, Mar 18, 2026 at 03:22:44PM +0100, Uwe Kleine-K=F6nig wrote:
> Hey Richard,
>=20
> On Wed, Mar 18, 2026 at 12:37:42PM +0000, Richard Purdie wrote:
> > On Wed, 2026-03-18 at 12:13 +0100, Uwe Kleine-K=F6nig wrote:
> > > On Wed, Mar 18, 2026 at 09:12:52AM +0000, Richard Purdie wrote:
> > > > On Wed, 2026-03-18 at 08:50 +0100, Uwe Kleine-K=F6nig wrote:
> > > > > On Tue, Mar 17, 2026 at 07:23:35PM +0100, Yoann Congal wrote:
> > > > > > On Tue Mar 17, 2026 at 6:40 PM CET, Hiago De Franco via lists.y=
octoproject.org wrote:
> > > > > > > On Mon, Mar 09, 2026 at 02:21:51PM +0000, Richard Purdie wrot=
e:
> > > > > > > > On Mon, 2026-03-09 at 20:23 +0800, Yi Zhao via lists.yoctop=
roject.org wrote:
> > > > > > > > >=20
> > > > > > > > > On 2/13/26 23:42, "Uwe Kleine-K=F6nig wrote:
> > > > > > > > > > With SELinux enabled for the target it makes sense to h=
ave SELinux
> > > > > > > > > > support enabled for the native tools, too.
> > > > > > > > > >=20
> > > > > > > > > > Note that for native packages DISTRO_FEATURES is filter=
ed, thus up to now
> > > > > > > > > > it never contained "selinux". Append to DISTRO_FEATURES=
_FILTER_NATIVE to
> > > > > > > > > > make "selinux" propagate also to DISTRO_FEATURES for na=
tive packages.
> > > > > > > > > > ---
> > > > > > > > > > Hello,
> > > > > > > > > >=20
> > > > > > > > > > I use this on scarthgap, but the patch applies fine to =
master, too.
> > > > > > > > > >=20
> > > > > > > > > > During a debug session it took me quite a while to find=
 out why
> > > > > > > > > >=20
> > > > > > > > > > 	ls -lZ "${IMAGE_ROOTFS}
> > > > > > > > > >=20
> > > > > > > > > > at the end of selinux_set_labels() didn't show the labe=
ls added by
> > > > > > > > > > setfiles.
> > > > > > > > > >=20
> > > > > > > > > > Best regards
> > > > > > > > > > Uwe
> > > > > > > > > >=20
> > > > > > > > > > =A0 classes/enable-selinux.bbclass | 2 +-
> > > > > > > > > > =A0 conf/layer.conf=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | 4 ++++
> > > > > > > > > > =A0 2 files changed, 5 insertions(+), 1 deletion(-)
> > > > > > > > > >=20
> > > > > > > > > > diff --git a/classes/enable-selinux.bbclass b/classes/e=
nable-selinux.bbclass
> > > > > > > > > > index 3dc61d6931ff..0c9f52e74cec 100644
> > > > > > > > > > --- a/classes/enable-selinux.bbclass
> > > > > > > > > > +++ b/classes/enable-selinux.bbclass
> > > > > > > > > > @@ -1,3 +1,3 @@
> > > > > > > > > > =A0 inherit selinux
> > > > > > > > > > =A0=20
> > > > > > > > > > -PACKAGECONFIG:append =3D " ${@target_selinux(d, 'selin=
ux')}"
> > > > > > > > > > +PACKAGECONFIG:append =3D " ${@bb.utils.filter('DISTRO_=
FEATURES', 'selinux', d)}"
> > > > > > > > > > diff --git a/conf/layer.conf b/conf/layer.conf
> > > > > > > > > > index 4e04e5cc7e6a..ca981db57019 100644
> > > > > > > > > > --- a/conf/layer.conf
> > > > > > > > > > +++ b/conf/layer.conf
> > > > > > > > > > @@ -25,3 +25,7 @@ LAYERDEPENDS_selinux =3D " \
> > > > > > > > > > =A0 "
> > > > > > > > > > =A0=20
> > > > > > > > > > =A0 PREFERRED_PROVIDER_virtual/refpolicy ??=3D "refpoli=
cy-targeted"
> > > > > > > > > > +
> > > > > > > > > > +# With target support for SELinux it is very helpful d=
uring debug when the
> > > > > > > > > > +# native tools support SELinux, too.
> > > > > > > > > > +DISTRO_FEATURES_FILTER_NATIVE:append =3D " selinux"
> > > > > > > > >=20
> > > > > > > > > Can we add this to the doc (e.g. README) instead of enabl=
ing it directly=20
> > > > > > > > > in layer.conf? Since we haven't directly enabled DISTRO_F=
EATURES =3D=20
> > > > > > > > > "selinux" in layer.conf either.
> > > > > > > >=20
> > > > > > > > I just wanted to add that putting that directly in layer.co=
nf will mean
> > > > > > > > the layer isn't Yocto Project Compatible too.
> > > > > > >=20
> > > > > > > I am going to send a v2 and take over this work, already aske=
d Uwe about
> > > > > > > that.
> > > > > > >=20
> > > > > > > But before doing it, I was wondering why changing layer.conf =
will make
> > > > > > > the layer not compatible with Yocto Project anymore. Can you =
explain to
> > > > > > > us the reason?
> > > > > >=20
> > > > > > I'd guess it is from this criteria of the Yocto Compatible laye=
r[0]:
> > > > > > > Inclusion of any layer in the submission does not change the
> > > > > > > behavior/configuration of the overall system without the user
> > > > > > > explicitly opting into those changes
> > > > > >=20
> > > > > > By putting a 'DISTRO_FEATURES +=3D "selinux"' in layer.conf, the
> > > > > > configuration changes globally without explicit opt-in of the u=
ser.
> > > > >=20
> > > > > Note that the patch didn't change DISTRO_FEATURES, it appended "s=
elinux"
> > > > > to DISTRO_FEATURES_FILTER_NATIVE. If DISTRO_FEATURES doesn't alre=
ady
> > > > > contain "selinux", this is a noop. So I don't see how this violat=
es the
> > > > > quoted critera.
> > > > >=20
> > > > > What am I missing?
> > > >=20
> > > > I guess it would depend whether any of the functions/variables in c=
ore
> > > > have hard dependencies on that variable. I was assuming that they do
> > > > but that might not be the case, I'm not sure without checking and y=
ou
> > > > may be right.
> > >=20
> > > Wouldn't that be a bug if a function changes behaviour depending on
> > > DISTRO_FEATURES_FILTER_NATIVE containing "selinux" or not? (Apart from
> > > having "selinux" for native packages iff the global DISTRO_FEATURES h=
as
> > > "selinux".)
> >=20
> > It depends on how that variable is being used. Some usages would be an
> > issue, some would not. I have not checked how it is being used and what
> > the implications of that are.
> >=20
> > > I grepped for DISTRO_FEATURES_FILTER_NATIVE in oe-core, bitbake and
> > > meta-openembedded, there are only matches in the first and these are
> > > about default settings, appending DISTRO_FEATURES_OVERRIDES and
> > > providing a filtered version of the global DISTRO_FEATURES for native
> > > packages.
> > >=20
> > > So unless I missed something, I'd claim setting
> > > DISTRO_FEATURES_FILTER_NATIVE:append in a layer doesn't result in a
> > > relevant change without an explicit opt-in (by adding "selinux" to
> > > DISTRO_FEATURES) and then this (implicit) v1 is better than the v2 th=
at
> > > Hiago sent.
> >=20
> > I'm starting to wish I'd just never said anything :/.
>=20
> :-\
>=20
> > It would be nice if meta-selinux passes yocto-check-layer but that
> > isn't my call, I don't know if it does currently pass or not. I wanted
> > to caution that changing DISTRO_FEATURES or things related to
> > DISTRO_FEATURES from layer.conf is generally a bad idea. In this case
> > you might get away with it, I don't know. Has anyone tested it?
>=20
> I tried that:
>=20
> 	uwe@monoceros:~/work/ashjk/poky/build$ yocto-check-layer ../meta-selinux
> 	INFO: Detected layers:
> 	INFO: meta-selinux: LayerType.SOFTWARE, /home/uwe/work/ashjk/poky/meta-s=
elinux
> 	ERROR: Layer meta-selinux depends on meta-python and isn't found.
> 	INFO:
> 	INFO: Setting up for meta-selinux(LayerType.SOFTWARE), /home/uwe/work/as=
hjk/poky/meta-selinux
> 	ERROR: Layer meta-selinux depends on meta-python and isn't found.
> 	INFO: Skipping meta-selinux due to missing dependencies.
> 	INFO:
> 	INFO: Summary of results:
> 	INFO:
> 	INFO: meta-selinux ... SKIPPED (Missing dependencies)
>=20
> hmm, so maybe I need to add this using --dependency:
>=20
> 	uwe@monoceros:~/work/ashjk/poky/build$ yocto-check-layer ../meta-selinux=
 --dependency ../meta-openembedded/meta-python --dependency ../meta-openemb=
edded
> 	INFO: Detected layers:
> 	INFO: meta-selinux: LayerType.SOFTWARE, /home/uwe/work/ashjk/poky/meta-s=
elinux
> 	INFO: Adding meta-python to the list of layers to test, as a dependency
> 	INFO: Adding meta-oe to the list of layers to test, as a dependency
> 	INFO:=20
> 	INFO: Setting up for meta-selinux(LayerType.SOFTWARE), /home/uwe/work/as=
hjk/poky/meta-selinux
> 	INFO: Adding layer meta-python
> 	INFO: meta-python is already in /home/uwe/work/ashjk/poky/build/conf/bbl=
ayers.conf
> 	INFO: Adding layer meta-oe
> 	INFO: meta-oe is already in /home/uwe/work/ashjk/poky/build/conf/bblayer=
s.conf
> 	INFO: Getting initial bitbake variables ...
> 	INFO: Getting initial signatures ...
> 	INFO: Generating signatures failed. This might be due to some parse erro=
r and/or general layer incompatibilities.
> 	Command: BB_ENV_PASSTHROUGH_ADDITIONS=3D"$BB_ENV_PASSTHROUGH_ADDITIONS B=
B_SIGNATURE_HANDLER" BB_SIGNATURE_HANDLER=3D"OEBasicHash" bitbake -S locked=
sigs world
> 	Output:
> 	WARNING: Host distribution "debian-13" has not been validated with this =
version of the build system; you may possibly experience unexpected failure=
s. It is recommended that you use a tested distribution.
> 	Loading cache...done.
> 	Loaded 0 entries from dependency cache.
> 	Parsing recipes...done.
> 	Parsing of 2472 .bb files complete (0 cached, 2472 parsed). 4316 targets=
, 86 skipped, 0 masked, 0 errors.
> 	Removing 14 recipes from the core2-64 sysroot...done.
> 	Removing 19 recipes from the qemux86_64 sysroot...done.
> 	Removing 6 recipes from the x86_64 sysroot...done.
> 	NOTE: Resolving any missing task queue dependencies
> 	ERROR: Nothing PROVIDES 'libselinux' (but /home/uwe/work/ashjk/poky/meta=
-openembedded/meta-oe/recipes-extended/hwloc/hwloc_2.9.3.bb, /home/uwe/work=
/ashjk/poky/meta-openembedded/meta-oe/recipes-devtools/squashfs-tools-ng/sq=
uashfs-tools-ng_1.2.0.bb, /home/uwe/work/ashjk/poky/meta-openembedded/meta-=
oe/recipes-support/augeas/augeas_1.12.0.bb, /home/uwe/work/ashjk/poky/meta-=
openembedded/meta-oe/recipes-support/lvm2/lvm2_2.03.22.bb, /home/uwe/work/a=
shjk/poky/meta/recipes-extended/at/at_3.2.5.bb, /home/uwe/work/ashjk/poky/m=
eta-openembedded/meta-oe/recipes-extended/ostree/ostree_2024.5.bb, /home/uw=
e/work/ashjk/poky/meta-openembedded/meta-oe/recipes-extended/smartmontools/=
smartmontools_7.4.bb, /home/uwe/work/ashjk/poky/meta/recipes-extended/logro=
tate/logrotate_3.21.0.bb, /home/uwe/work/ashjk/poky/meta/recipes-core/udev/=
eudev_3.2.14.bb, /home/uwe/work/ashjk/poky/meta/recipes-support/vim/vim_9.1=
=2Ebb, /home/uwe/work/ashjk/poky/meta/recipes-core/base-passwd/base-passwd_=
3.6.3.bb, /home/uwe/work/ashjk/poky/meta-openembedded/meta-oe/recipes-secur=
ity/bubblewrap/bubblewrap_0.8.0.bb, /home/uwe/work/ashjk/poky/meta-openembe=
dded/meta-oe/recipes-support/lvm2/libdevmapper_2.03.22.bb, /home/uwe/work/a=
shjk/poky/meta-openembedded/meta-oe/recipes-devtools/ltrace/ltrace_git.bb D=
EPENDS on or otherwise requires it)
> 	ERROR: Required build target 'meta-world-pkgdata' has no buildable provi=
ders.
> 	Missing or unbuildable dependency chain was: ['meta-world-pkgdata', 'hwl=
oc', 'libselinux']
>=20
> 	Summary: There was 1 WARNING message.
> 	Summary: There were 2 ERROR messages, returning a non-zero exit code.
>=20
> 	INFO: meta-python already in /home/uwe/work/ashjk/poky/build/conf/bblaye=
rs.conf. To capture initial signatures, layer under test should not present=
 in BBLAYERS. Please remove meta-python from BBLAYERS.
> 	INFO: meta-oe already in /home/uwe/work/ashjk/poky/build/conf/bblayers.c=
onf. To capture initial signatures, layer under test should not present in =
BBLAYERS. Please remove meta-oe from BBLAYERS.
> 	INFO:=20
> 	INFO: Summary of results:
> 	INFO:=20
> 	INFO: meta-selinux ... FAIL (Generating world signatures)
> 	INFO: meta-python ... SKIPPED (Layer under test should not present in BB=
LAYERS)
> 	INFO: meta-oe ... SKIPPED (Layer under test should not present in BBLAYE=
RS)
>=20
> Maybe I'm holding it wrong, maybe meta-selinux just doesn't pass?!
>=20
> Ah, when removing "selinux" from DISTRO_FEATURES it works better. Then
> it says things like:
>=20
> 	...
> 	INFO: Traceback (most recent call last):
> 	  File "/home/uwe/work/ashjk/poky/scripts/lib/checklayer/cases/common.py=
", line 99, in test_signatures
> 	    self.fail('Adding layer %s changed signatures.\n%s' % (self.tc.layer=
['name'], msg))
> 	    ~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^
> 	AssertionError: Adding layer meta-selinux changed signatures.
> 	1789 signatures changed, initial differences (first hash before, second =
after):
> 	   android-tools-conf:do_recipe_qa: 0b9fecbec98924f57499d5d53c4b08bebe50=
deac72f025ed0f4b5b2274c57463 -> d7473d9aba93fba170cd904225f22485c12a8cbfbb9=
0984d90014bc29ce47856
> 	      bitbake-diffsigs --task android-tools-conf do_recipe_qa --signatur=
e 0b9fecbec98924f57499d5d53c4b08bebe50deac72f025ed0f4b5b2274c57463 d7473d9a=
ba93fba170cd904225f22485c12a8cbfbb90984d90014bc29ce47856
> 	...
>=20
> (That's without my change BTW.)
>=20
> > I am generally worried about the amount of things people "load" up
> > layer.conf with as whilst it seems easy, the scope of it can be
> > problematic as it affects other layers, and in general you don't want
> > to be doing that unless it is configurable.
>=20
> I understand your motivation, adding things there (even if they are ok)
> add to the things you stumble over.
>=20
> There is nothing I can say to rebut that objection. Still I think the
> addition we're discussing about is technically fine and reduces the
> surprises when working with meta-selinux. So in my subjective opinion
> it's a net win to add it.
>=20
> Best regards
> Uwe

I would like to add something to the discussion that I just found
yesterday.

By enabling the native patckages to have SELinux by default, GPG=20
breaks if secureboot is also being used. See the error below:

ERROR: linux-yocto-6.6.129+git-r0 do_sign: Failed to import gpg key
(user-keys/boot_keys/BOOT-GPG-PRIVKEY-BOOT-SecureCore): gpg: importing
secret keys not allowed
gpg: Total number processed: 1
gpg:=A0=A0=A0=A0=A0=A0 secret keys read: 1

This happens becaus of [0]. I had to specifically disable SELinux for
the GPG native package.

So, in this case, if we would to like to proceed with this patch, v2
would be a better option to prevent such errors.

[0] https://github.com/gpg/gnupg/blob/master/g10/import.c#L3319

Regards,
Hiago.

