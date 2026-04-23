Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FF6F589DD
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 14:16:56 +0000 (UTC)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20689.1776953808367335130
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Apr 2026 07:16:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=LhAtYuRG;
 spf=pass (domain: gmail.com, ip: 74.125.82.47, mailfrom: rybczynska@gmail.com)
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c6df0b9bbso1151092c88.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 07:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776953808; cv=none;
        d=google.com; s=arc-20240605;
        b=FP22XKOv2GkjgxVUe79zcGnPQx7UTeZnKwafxUy/gpIyMm1QxatMvJZxmpqpE5Eg4D
         5wrwQuGYVR03qUhEPC3YR4crZp2JcAmlt1FqXgr6XGW+L0SkV0Z/F9MzRsgiZVVdqqlw
         oTOC/hb6E0aMjrvuaoIFixzp5KCxUVBSXhudvp95EW59mERk+o7nMVS5fuI5RjtPqwv2
         GY+OJZ9Df8vmzR/X7cxm6mnrBEqEPuAHZUsToL4OLEXLZNoNtbcNJEmlr5BnTyX+6NvR
         i4ZjlzvFWhrQ2V6U7pSl1OMax8w13Wb0GgLV4haeE+eGBWiWTuSJoS3g2UcQW4PF7GfU
         zk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hLPE45TwXmLvjMSXtBqyRzjGSxbyWqi8v3bevX+QNpA=;
        fh=Mxt1puISTqLl9kib845RWf9XmHsha4gsJU1CKwPylGU=;
        b=AjZGdFQT9tfI5WiImxljVuL2Xoi0wG7tw/Kv4WgSbeMjrfa0QEFJMNYvCNtEUIGwHm
         CdEwdmodYERDxSvQRSJotYDGoqhiQqVsyDDAX4ScaBYxfcjTBw+ndtZvEirwLApMOQTS
         2EhgqhESfw/dMUOm/Zyf1BSa1k8imQC7W+tUT+t1TPVxVuHfldajSQE1sA4AhQwlJCur
         uYsbGN9i7DrJpjXD1lrixpqAezWhMVfGv0GqslO9jEbBGiUHkQAGARUqqSQKQdN8t0SZ
         MbA/0LnClGMfgFofhRT2oVjhZjbnJ+eGQhxM7lijzj+Zb2T+0casG7wUt7wJKzvM+1Iu
         qT9Q==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776953808; x=1777558608; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hLPE45TwXmLvjMSXtBqyRzjGSxbyWqi8v3bevX+QNpA=;
        b=LhAtYuRGgOWbRdk89o2gWPg5pZBEqQ5tWG7kH8nrJrs/lTJuR+iGcenvu8J4+bpjbT
         WrWRGGWY4WmvHo9H4zVukWqyBCCiCWnV0oIi0wU3s5VTyVHj0LFWGea95EZH3B+eqhz5
         dFFxJ8WY+W4McowYC6SVjxgoxpDDTnXPg6Ef5RoqAYE+n5NHNLobAVG1zP5qmLs8TD0T
         cAF3Xa45JRo3tSAy5d70y7B0TRinabj1h7NhQkHsFQf7EEUuR+qpbd21XBDs7W9YXqPz
         AxqyYUNg4hfH7OBSRf5V2P17A/cixa0EW6yW4Fv7jE9WUKJ6D0kW8kited23/TniK/fF
         O6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953808; x=1777558608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLPE45TwXmLvjMSXtBqyRzjGSxbyWqi8v3bevX+QNpA=;
        b=nesSWlyOJxV+KSyznrj6SmlwJV8MBvgdNMFnku6ce2MeyauTIwGNTCJU3laRR/QL0w
         a6e9TyGBZtTm0NAs2CQhflpsh02FsbiJwIpqNsqicm1XvZgMhZNkiUw+2bw5OiKctn7+
         a3UBEsKhh3A3rvDENkJwGEXbTgubSZxLIifqlW3UkQy8/E3ISH/1JJjDcD+jQEjlH+RV
         swiYMRmqvOlp0RUGnapMuyBjsrOn+z4zduMQOT+VqhiTMum+9QcyXYtQu3F191zeC9Gg
         3uAtuZJNQSa3Hsh9ouv/1NsjQg/p7WLznjtql2DrDxJeUXTsGPIaUTBh+Vd51mWtEjjI
         JtnQ==
X-Gm-Message-State: AOJu0YyVbY6AlNmJRUO+Mcs0ixd/xUZX8Xom4Fcpk9rjXji9P4Mbm6pL
	p1MSnqU3iNgxmJDDITuUPt4X3XIWfbOo7OH3KA99PNcNZuxNy6fvqdhqaXm0PtcfuAltmrUZpEJ
	CQOJAOr79OIVDPYRvtxCiI42hVGCY90U=
X-Gm-Gg: AeBDievzgozTqILH3otzMGWBNf4ZbAfLY36OWxPnyLiPdlRdcQxHRIu0iqddy1TD/Pc
	+z+i5yyDsptqGq9tO8hbsr17Sr9w+S/AUtUECqKyyrb5Y9hXRUq7VOr4yzRtuk+EjEYErdF/GGL
	Pj4PzvnyMPPcMnlz5ZWTJMupx/TBOwy7Xva4P4pZhI2AfniHNWQBTYgB+MSao9/U4NMNQoiHbqv
	Hxn96ty3eFWnZZ9NhwaQcVe1I/jPbk071QBj8nUpYlS0QKO7luuLw6VJo5weDsWHpvrLTrc1yj2
	t3RZDHZu891pDhdwyQTXQYg+Xs3c022D/2w7mQOGxspcaJSpxg8=
X-Received: by 2002:a05:7022:90a:b0:119:e56b:958a with SMTP id
 a92af1059eb24-12c73f82134mr14913214c88.15.1776953807238; Thu, 23 Apr 2026
 07:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260420135525.130421-1-ayoub.zaki@embetrix.com>
 <6518c92a-bca5-0dbd-65fe-4d61bd5c6178@konsulko.com> <0d8fbd63-efc4-4047-9964-c1bd492835a4@embetrix.com>
 <258554ca-9212-2f90-5f91-4ebbf2c69777@konsulko.com>
In-Reply-To: <258554ca-9212-2f90-5f91-4ebbf2c69777@konsulko.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Thu, 23 Apr 2026 16:16:35 +0200
X-Gm-Features: AQROBzDRSOiX0WzQC27an-R7GuCU0AcxJIIq3VZIcb4RffdKLJJYikINzbLj6E0
Message-ID: <CAApg2=QHn1yxOTmRxT2uiVT+1wg+gDp4y7CAsyKdZdypzjnc-A@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH] dm-verity: add PKCS#7 root
 hash signature support
To: Scott Murray <scott.murray@konsulko.com>
Cc: yocto-patches@lists.yoctoproject.org, Ayoub Zaki <ayoub.zaki@embetrix.com>
Content-Type: multipart/alternative; boundary="000000000000767b030650214c34"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 14:16:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3775

--000000000000767b030650214c34
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026, 18:54 Scott Murray, <scott.murray@konsulko.com> wrote:

> On Wed, 22 Apr 2026, Ayoub Zaki via lists.yoctoproject.org wrote:
>
> > Hi Scott, Marta,
> >
> > Thanks for the review and for testing effort.
> >
> > On 4/21/26 22:45, Scott Murray via lists.yoctoproject.org wrote:
> > > On Mon, 20 Apr 2026, Ayoub Zaki via lists.yoctoproject.org wrote:
> > >
> > >> The dm-verity root hash stored in the initramfs is vulnerable to
> TOCTOU
> > >> attacks. Mitigate this by signing the root hash at build time and
> > >> verifying it from the kernel via CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG.
> > >> The signature is deployed into the initramfs while the signing
> certificate
> > >> is embedded in the kernel's built-in trusted keyring.
> > >>
> > >> - dm-verity-img.bbclass: sign root hash with openssl smime when
> > >> DM_VERITY_SIGN=1
> > >> - kernel-trusted-keys.bbclass: new shared class to collect PEM certs
> > >>    into trusted_keys.pem via KERNEL_TRUSTED_CERTS variable
> > >> - linux-yocto_security.inc: add kernel config fragments and append
> > >>    signing cert via KERNEL_TRUSTED_CERTS
> > >> - dm-verity-image-initramfs.bb: deploy .p7s signature
> > >> - dmverity initrd script: pass --root-hash-signature to veritysetup
> > >> - linux_ima.inc: use KERNEL_TRUSTED_CERTS instead of absolute path in
> > >>    CONFIG_SYSTEM_TRUSTED_KEYS, fixing buildpaths QA
> > >> - Add debug/test keys and documentation
> > >>
> > >> Signing is not enabled by default for backward compatibility but is
> > >> strongly recommended for production deployments.
> > >
> > > I believe Marta is doing some testing of this, and I'll try to do some
> > > as well in the next couple of days.  I do have some comments that I'll
> put
> > > inline below.
> > >
> > >> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
> > >> ---
> > >>   classes/dm-verity-img.bbclass                 | 46 +++++++++++-
> > >>   classes/kernel-trusted-keys.bbclass           | 34 +++++++++
> > >>   docs/dm-verity.txt                            | 73
> +++++++++++++++++++
> > >>   meta-integrity/data/debug-keys/README.md      |  7 ++
> > >>   .../data/debug-keys/privkey_verity.pem        | 52 +++++++++++++
> > >>   .../data/debug-keys/x509_verity.crt           | 30 ++++++++
> > >>   .../recipes-kernel/linux/linux_ima.inc        |  9 +--
> > >>   .../images/dm-verity-image-initramfs.bb       |  6 ++
> > >>   .../initramfs-framework-dm/dmverity           |  7 ++
> > >>   .../linux/files/dm-verity-verify.cfg          | 10 +++
> > >>   .../linux/files/dm-verity-verify.scc          |  5 ++
> > >>   recipes-kernel/linux/linux-yocto_security.inc | 10 +++
> > >>   12 files changed, 283 insertions(+), 6 deletions(-)
> > >>   create mode 100644 classes/kernel-trusted-keys.bbclass
> > >>   create mode 100644 meta-integrity/data/debug-keys/privkey_verity.pem
> > >>   create mode 100644 meta-integrity/data/debug-keys/x509_verity.crt
> > >>   create mode 100644 recipes-kernel/linux/files/dm-verity-verify.cfg
> > >>   create mode 100644 recipes-kernel/linux/files/dm-verity-verify.scc
> > >>
> > >> diff --git a/classes/dm-verity-img.bbclass
> b/classes/dm-verity-img.bbclass
> > >> index 48557e9..fba8454 100644
> > >> --- a/classes/dm-verity-img.bbclass
> > >> +++ b/classes/dm-verity-img.bbclass
> > >> @@ -3,6 +3,12 @@
> > >>   # Copyright (C) 2020 BayLibre SAS
> > >>   # Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >>   #
> > >> +# Copyright 2026 Embetrix Embedded Systems Solutions
> > >> <ayoub.zaki@embetrix.com>
> > >
> > > Please use "Copyright (C)" for consistency, this applies to the other
> > > files changed/added as well.
> >
> > Agreed, will fix for consistency.
> >
> [snip]
> > >> +do_shared_workdir:append() {
> > >> +    if [ -f trusted_keys.pem ]; then
> > >> +        cp trusted_keys.pem $kerneldir/
> > >> +    fi
> > >> +}
> > >
> > > Since you're storing this aggregated set of keys in work-shared, it
> > > probably needs to be explicitly documented that TMPDIR should not be
> > > accessible by other users, as that may not be obvious to some folks.
> > >
> >
> > Worth noting that the "trusted keys" naming here is inherited from the
> > kernel's own CONFIG_SYSTEM_TRUSTED_KEYS convention and is somewhat
> misleading:
> > these are certificates only. The kernel's built-in trusted keyring does
> not
> > handle private keys at all.
> > The same pattern is already used by the kernel-modsign.bbclass which
> this was
> > modeled after.
> > That said, I'm happy to add a note clarifying this in the documentation
> to
> > avoid confusion.
>
> Okay, that sounds good.
>
> > >> diff --git a/docs/dm-verity.txt b/docs/dm-verity.txt
> > >> index a538fa2..9d326bf 100644
> > >> --- a/docs/dm-verity.txt
> > >> +++ b/docs/dm-verity.txt
> > >> @@ -121,3 +121,76 @@ INFO: The image(s) were created using OE
> kickstart
> > >> file:
> > >>   The "direct" image contains the partition table, bootloader, and
> > >>   dm-verity
> > >>   enabled ext4 image all in one -- ready to write to a raw device,
> such as
> > >>   a
> > >>   u-SD card in the case of the beaglebone.
> > >> +
> > >> +Root Hash Signature Verification
> > >> +--------------------------------
> > >> +By default, dm-verity stores the root hash as plain text in the
> initramfs
> > >> +at /usr/share/misc/dm-verity.env. This creates a TOCTOU
> (time-of-check to
> > >> +time-of-use) vulnerability: an attacker who can modify the initramfs
> can
> > >> +replace both the root hash and the filesystem image, defeating
> dm-verity.
> > >
> > > Just to double check I'm clear wrt the attack scenario, this only works
> > > if the initramfs is outside the secure boot chain, i.e. stored as a
> > > separate file from the kernel?  I'm thinking that perhaps secure boot
> > > with FIT images avoids the problem, and that's not uncommon these days.
> > > And I'm guessing initramfs bundled with the kernel might also avoid
> TOCTOU
> > > w/o a more elaborate attack.  If so, it might be good to be more
> explicit
> > > here wrt the insecure scenario.
> > >
> >
> > The scenario this addresses is precisely when the initramfs is verified
> at an
> > earlier boot stage (e.g. bundled with the kernel or part of a signed FIT
> > image) but there is a multi-second window between that verification and
> the
> > actual use of the root hash where memory contents can be modified: The
> > specific techniques to exploit this window vary depending on hardware
> (DMA
> > attacks, JTAG, etc.). I'll clarify this in the documentation so readers
> > understand the attack surface more precisely.
>
> Gotcha.  I'm all for your changes as they will add another layer of
> defense, but I am curious if a determined attacker with that capability
> might also be able to flip off the signature verification flag, or
> potentially overwrite the kernel keyring?
>
> [snip]
> > >> +These are insecure debug/test keys. Generate your own for production
> use.
> > >> +
> > >
> > > I would strongly prefer that we not add any more debug keys in-tree, as
> > > there's a chance someone might go ahead and use them, and they
> sometimes
> > > generate spam from folks running scanners on public repos (I've
> > > experienced this on other projects).  If we were to add a selftest, it
> > > can generate a key on the fly.  If there's a strong reason they should
> be
> > > added that I'm missing, I'd say these ones should probably not be in
> > > meta-integrity, as dm-verity-img.bbclass is in the base layer, not
> > > meta-integrity.
> > >
> >
> > Fully agree. I'll remove the in-tree debug keys. On a related note I
> think the
> > verity related implementation should probably land in meta-integrity as
> well,
> > rather than in base layer.
>
> I can see that view, but I suspect the ship has maybe already sailed given
> the bbclass has been in meta-security for a while now.  If we were going
> to move it, we're currently in a narrow window before we create the
> wrynose branch for LTS where it might make sense.  Marta may have a
> better idea of how much impact that would be for downstreams, I'm actually
> not sure myself.
>
>
The meta-integrity layer has a separate DISTRO_FEATURE to enable and it adds
kernel options and such. This makes big change for users of this class and
am not
sure how many are using it separately from meta-integrity. So I think it is
too late to
move in this cycle.

Kind regards,
Marta

--000000000000767b030650214c34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"auto"><br></div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 22 Ap=
r 2026, 18:54 Scott Murray, &lt;<a href=3D"mailto:scott.murray@konsulko.com=
" target=3D"_blank">scott.murray@konsulko.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On Wed, 22 Apr 2026, Ayoub Zak=
i via <a href=3D"http://lists.yoctoproject.org" rel=3D"noreferrer noreferre=
r" target=3D"_blank">lists.yoctoproject.org</a> wrote:<br>
<br>
&gt; Hi Scott, Marta,<br>
&gt;<br>
&gt; Thanks for the review and for testing effort.<br>
&gt;<br>
&gt; On 4/21/26 22:45, Scott Murray via <a href=3D"http://lists.yoctoprojec=
t.org" rel=3D"noreferrer noreferrer" target=3D"_blank">lists.yoctoproject.o=
rg</a> wrote:<br>
&gt; &gt; On Mon, 20 Apr 2026, Ayoub Zaki via <a href=3D"http://lists.yocto=
project.org" rel=3D"noreferrer noreferrer" target=3D"_blank">lists.yoctopro=
ject.org</a> wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; The dm-verity root hash stored in the initramfs is vulnerable=
 to TOCTOU<br>
&gt; &gt;&gt; attacks. Mitigate this by signing the root hash at build time=
 and<br>
&gt; &gt;&gt; verifying it from the kernel via CONFIG_DM_VERITY_VERIFY_ROOT=
HASH_SIG.<br>
&gt; &gt;&gt; The signature is deployed into the initramfs while the signin=
g certificate<br>
&gt; &gt;&gt; is embedded in the kernel&#39;s built-in trusted keyring.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; - dm-verity-img.bbclass: sign root hash with openssl smime wh=
en<br>
&gt; &gt;&gt; DM_VERITY_SIGN=3D1<br>
&gt; &gt;&gt; - kernel-trusted-keys.bbclass: new shared class to collect PE=
M certs<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 into trusted_keys.pem via KERNEL_TRUSTED_CERTS v=
ariable<br>
&gt; &gt;&gt; - linux-yocto_security.inc: add kernel config fragments and a=
ppend<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 signing cert via KERNEL_TRUSTED_CERTS<br>
&gt; &gt;&gt; - <a href=3D"http://dm-verity-image-initramfs.bb" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">dm-verity-image-initramfs.bb</a>: depl=
oy .p7s signature<br>
&gt; &gt;&gt; - dmverity initrd script: pass --root-hash-signature to verit=
ysetup<br>
&gt; &gt;&gt; - linux_ima.inc: use KERNEL_TRUSTED_CERTS instead of absolute=
 path in<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 CONFIG_SYSTEM_TRUSTED_KEYS, fixing buildpaths QA=
<br>
&gt; &gt;&gt; - Add debug/test keys and documentation<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signing is not enabled by default for backward compatibility =
but is<br>
&gt; &gt;&gt; strongly recommended for production deployments.<br>
&gt; &gt;<br>
&gt; &gt; I believe Marta is doing some testing of this, and I&#39;ll try t=
o do some<br>
&gt; &gt; as well in the next couple of days.=C2=A0 I do have some comments=
 that I&#39;ll put<br>
&gt; &gt; inline below.<br>
&gt; &gt;<br>
&gt; &gt;&gt; Signed-off-by: Ayoub Zaki &lt;<a href=3D"mailto:ayoub.zaki@em=
betrix.com" rel=3D"noreferrer" target=3D"_blank">ayoub.zaki@embetrix.com</a=
>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 =C2=A0classes/dm-verity-img.bbclass=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 46 +++++++++++-<br>
&gt; &gt;&gt;=C2=A0 =C2=A0classes/kernel-trusted-keys.bbclass=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 34 +++++++++<br>
&gt; &gt;&gt;=C2=A0 =C2=A0docs/dm-verity.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 73 +++=
++++++++++++++++<br>
&gt; &gt;&gt;=C2=A0 =C2=A0meta-integrity/data/debug-keys/README.md=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 7 ++<br>
&gt; &gt;&gt;=C2=A0 =C2=A0.../data/debug-keys/privkey_verity.pem=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 52 +++++++++++++<br>
&gt; &gt;&gt;=C2=A0 =C2=A0.../data/debug-keys/x509_verity.crt=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 ++++++++<br>
&gt; &gt;&gt;=C2=A0 =C2=A0.../recipes-kernel/linux/linux_ima.inc=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 9 +--<br>
&gt; &gt;&gt;=C2=A0 =C2=A0.../images/<a href=3D"http://dm-verity-image-init=
ramfs.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">dm-verity-image-i=
nitramfs.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++<br>
&gt; &gt;&gt;=C2=A0 =C2=A0.../initramfs-framework-dm/dmverity=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 ++<br>
&gt; &gt;&gt;=C2=A0 =C2=A0.../linux/files/dm-verity-verify.cfg=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 10 +++<br>
&gt; &gt;&gt;=C2=A0 =C2=A0.../linux/files/dm-verity-verify.scc=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 ++<br>
&gt; &gt;&gt;=C2=A0 =C2=A0recipes-kernel/linux/linux-yocto_security.inc | 1=
0 +++<br>
&gt; &gt;&gt;=C2=A0 =C2=A012 files changed, 283 insertions(+), 6 deletions(=
-)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0create mode 100644 classes/kernel-trusted-keys.bb=
class<br>
&gt; &gt;&gt;=C2=A0 =C2=A0create mode 100644 meta-integrity/data/debug-keys=
/privkey_verity.pem<br>
&gt; &gt;&gt;=C2=A0 =C2=A0create mode 100644 meta-integrity/data/debug-keys=
/x509_verity.crt<br>
&gt; &gt;&gt;=C2=A0 =C2=A0create mode 100644 recipes-kernel/linux/files/dm-=
verity-verify.cfg<br>
&gt; &gt;&gt;=C2=A0 =C2=A0create mode 100644 recipes-kernel/linux/files/dm-=
verity-verify.scc<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verit=
y-img.bbclass<br>
&gt; &gt;&gt; index 48557e9..fba8454 100644<br>
&gt; &gt;&gt; --- a/classes/dm-verity-img.bbclass<br>
&gt; &gt;&gt; +++ b/classes/dm-verity-img.bbclass<br>
&gt; &gt;&gt; @@ -3,6 +3,12 @@<br>
&gt; &gt;&gt;=C2=A0 =C2=A0# Copyright (C) 2020 BayLibre SAS<br>
&gt; &gt;&gt;=C2=A0 =C2=A0# Author: Bartosz Golaszewski &lt;<a href=3D"mail=
to:bgolaszewski@baylibre.com" rel=3D"noreferrer" target=3D"_blank">bgolasze=
wski@baylibre.com</a>&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0#<br>
&gt; &gt;&gt; +# Copyright 2026 Embetrix Embedded Systems Solutions<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:ayoub.zaki@embetrix.com" rel=3D"norefer=
rer" target=3D"_blank">ayoub.zaki@embetrix.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Please use &quot;Copyright (C)&quot; for consistency, this applie=
s to the other<br>
&gt; &gt; files changed/added as well.<br>
&gt;<br>
&gt; Agreed, will fix for consistency.<br>
&gt;<br>
[snip]<br>
&gt; &gt;&gt; +do_shared_workdir:append() {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 if [ -f trusted_keys.pem ]; then<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cp trusted_keys.pem $kerneldir/<=
br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 fi<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;<br>
&gt; &gt; Since you&#39;re storing this aggregated set of keys in work-shar=
ed, it<br>
&gt; &gt; probably needs to be explicitly documented that TMPDIR should not=
 be<br>
&gt; &gt; accessible by other users, as that may not be obvious to some fol=
ks.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Worth noting that the &quot;trusted keys&quot; naming here is inherite=
d from the<br>
&gt; kernel&#39;s own CONFIG_SYSTEM_TRUSTED_KEYS convention and is somewhat=
 misleading:<br>
&gt; these are certificates only. The kernel&#39;s built-in trusted keyring=
 does not<br>
&gt; handle private keys at all.<br>
&gt; The same pattern is already used by the kernel-modsign.bbclass which t=
his was<br>
&gt; modeled after.<br>
&gt; That said, I&#39;m happy to add a note clarifying this in the document=
ation to<br>
&gt; avoid confusion.<br>
<br>
Okay, that sounds good.<br>
<br>
&gt; &gt;&gt; diff --git a/docs/dm-verity.txt b/docs/dm-verity.txt<br>
&gt; &gt;&gt; index a538fa2..9d326bf 100644<br>
&gt; &gt;&gt; --- a/docs/dm-verity.txt<br>
&gt; &gt;&gt; +++ b/docs/dm-verity.txt<br>
&gt; &gt;&gt; @@ -121,3 +121,76 @@ INFO: The image(s) were created using OE=
 kickstart<br>
&gt; &gt;&gt; file:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0The &quot;direct&quot; image contains the partiti=
on table, bootloader, and<br>
&gt; &gt;&gt;=C2=A0 =C2=A0dm-verity<br>
&gt; &gt;&gt;=C2=A0 =C2=A0enabled ext4 image all in one -- ready to write t=
o a raw device, such as<br>
&gt; &gt;&gt;=C2=A0 =C2=A0a<br>
&gt; &gt;&gt;=C2=A0 =C2=A0u-SD card in the case of the beaglebone.<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +Root Hash Signature Verification<br>
&gt; &gt;&gt; +--------------------------------<br>
&gt; &gt;&gt; +By default, dm-verity stores the root hash as plain text in =
the initramfs<br>
&gt; &gt;&gt; +at /usr/share/misc/dm-verity.env. This creates a TOCTOU (tim=
e-of-check to<br>
&gt; &gt;&gt; +time-of-use) vulnerability: an attacker who can modify the i=
nitramfs can<br>
&gt; &gt;&gt; +replace both the root hash and the filesystem image, defeati=
ng dm-verity.<br>
&gt; &gt;<br>
&gt; &gt; Just to double check I&#39;m clear wrt the attack scenario, this =
only works<br>
&gt; &gt; if the initramfs is outside the secure boot chain, i.e. stored as=
 a<br>
&gt; &gt; separate file from the kernel?=C2=A0 I&#39;m thinking that perhap=
s secure boot<br>
&gt; &gt; with FIT images avoids the problem, and that&#39;s not uncommon t=
hese days.<br>
&gt; &gt; And I&#39;m guessing initramfs bundled with the kernel might also=
 avoid TOCTOU<br>
&gt; &gt; w/o a more elaborate attack.=C2=A0 If so, it might be good to be =
more explicit<br>
&gt; &gt; here wrt the insecure scenario.<br>
&gt; &gt;<br>
&gt;<br>
&gt; The scenario this addresses is precisely when the initramfs is verifie=
d at an<br>
&gt; earlier boot stage (e.g. bundled with the kernel or part of a signed F=
IT<br>
&gt; image) but there is a multi-second window between that verification an=
d the<br>
&gt; actual use of the root hash where memory contents can be modified: The=
<br>
&gt; specific techniques to exploit this window vary depending on hardware =
(DMA<br>
&gt; attacks, JTAG, etc.). I&#39;ll clarify this in the documentation so re=
aders<br>
&gt; understand the attack surface more precisely.<br>
<br>
Gotcha.=C2=A0 I&#39;m all for your changes as they will add another layer o=
f<br>
defense, but I am curious if a determined attacker with that capability<br>
might also be able to flip off the signature verification flag, or<br>
potentially overwrite the kernel keyring?<br>
<br>
[snip]<br>
&gt; &gt;&gt; +These are insecure debug/test keys. Generate your own for pr=
oduction use.<br>
&gt; &gt;&gt; +<br>
&gt; &gt;<br>
&gt; &gt; I would strongly prefer that we not add any more debug keys in-tr=
ee, as<br>
&gt; &gt; there&#39;s a chance someone might go ahead and use them, and the=
y sometimes<br>
&gt; &gt; generate spam from folks running scanners on public repos (I&#39;=
ve<br>
&gt; &gt; experienced this on other projects).=C2=A0 If we were to add a se=
lftest, it<br>
&gt; &gt; can generate a key on the fly.=C2=A0 If there&#39;s a strong reas=
on they should be<br>
&gt; &gt; added that I&#39;m missing, I&#39;d say these ones should probabl=
y not be in<br>
&gt; &gt; meta-integrity, as dm-verity-img.bbclass is in the base layer, no=
t<br>
&gt; &gt; meta-integrity.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Fully agree. I&#39;ll remove the in-tree debug keys. On a related note=
 I think the<br>
&gt; verity related implementation should probably land in meta-integrity a=
s well,<br>
&gt; rather than in base layer.<br>
<br>
I can see that view, but I suspect the ship has maybe already sailed given<=
br>
the bbclass has been in meta-security for a while now.=C2=A0 If we were goi=
ng<br>
to move it, we&#39;re currently in a narrow window before we create the<br>
wrynose branch for LTS where it might make sense.=C2=A0 Marta may have a<br=
>
better idea of how much impact that would be for downstreams, I&#39;m actua=
lly<br>
not sure myself.<br><br></blockquote><div><br></div><div>The meta-integrity=
 layer has a separate=C2=A0DISTRO_FEATURE to enable and it adds</div><div>k=
ernel options and such. This makes big change for users of this class and a=
m not</div><div>sure how many are using it separately from meta-integrity. =
So I think it is too late to</div><div>move in this cycle.</div><div><br></=
div><div>Kind regards,</div><div>Marta</div></div>
</div>

--000000000000767b030650214c34--

