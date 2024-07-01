Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4663C2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 12:40:05 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.18527.1719837601802190738
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jul 2024 05:40:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HHyskss4;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: gael.portay@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so17482845e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719837600; x=1720442400; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUJ3aA/qkYGuOpAw63HwRlpJDS3h2zXU1Wc/b/IJ2AE=;
        b=HHyskss4tlxFAwYTH4xxRM6XnBGveAryGnRbeT/9WvQoJ2yThNCuritqLKLN8PI2FQ
         oHQwr+1aWdhslMy9EHHAcX6GdixdVGJK8oktP/J87BCrjaJlJBPghVhIUkqrbGXJrVxV
         phbQ0ot1LwIw8d6r5WUuP9ir93k6FO+GOE9Nf1j6pOU10BAdlBiB12DoCFHDzlfE9r8u
         OSKYfcv/gUy2uqUBXJdy9PKSA2nr3gqvi9bHu4Kx6pp3GegarGMyTV3t1xLCqrclZWuH
         bp1d3tzke+QyhzI2HIdFT3UPaAr3vSpYDHOwiOPYjhPBH1/lYsRgT4HNPVhus2oVtMsv
         OBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719837600; x=1720442400;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MUJ3aA/qkYGuOpAw63HwRlpJDS3h2zXU1Wc/b/IJ2AE=;
        b=QJLpSydYZG2TlHgHLayDamL3nZ8yAfQR/QT/EOu7q6/Erq/Z/dhFtnBxBeSTZ9RAVF
         lu4k032Rwy4LQ98KBIq4V6xmrbD133Sni/j0rTC3ntmuBu3GMYHHW2hmT6Yi4/hDnP9j
         HxTcGU+ssh+QiHyjs0wUlGCBFsNE7I6y08jZa1aYQFQHeuEKY+MjWUE1IGrQ3gn4S6Vz
         5vGwnoA+MB5F3wcpeFRpJwjboIZIb8snkNoTHilmqMWYDKqrxdVfzSKuVRt0+EDq/VUG
         Q+5kjDbtgQzopTQ9K+VwqhedyAVNvtemkrBMp4ec81bMv0NVTRh+aZszQ2wwYqHZG9kv
         wWsA==
X-Forwarded-Encrypted: i=1; AJvYcCVGMDmJGHKpoSE70GSte8MivA/+TxlJl+SnWcQIPqNa5iCa+alLklLnWmejs8T3xiyytfwa+5h5nvB6Sm5XM31+wfReH7b7a6zm83Qidb7aipakiMA=
X-Gm-Message-State: AOJu0YxIFahO/NMJNuIoVfdy4LeehrRJ/tERRoNDqLpOfXQqBT9vK/cA
	85pOztFuv3x96fQxohTgeY+V41ymHbjhHrEGXyUfCrTRRFfgzd+kcCn865iS
X-Google-Smtp-Source: AGHT+IGS5iweQ16wrdsJt6hI/zi82kXiJeB0K6uvzkgbVv5leGayUOcM+kDdLJe2l+LZWsUcjiLN5Q==
X-Received: by 2002:a05:600c:3b88:b0:424:8acb:7d53 with SMTP id 5b1f17b1804b1-4257984deb1mr51818525e9.1.1719837599918;
        Mon, 01 Jul 2024 05:39:59 -0700 (PDT)
Received: from localhost ([2a01:e0a:ce:f2f0:3a7c:76ff:fe01:6f05])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd707sm10006420f8f.1.2024.07.01.05.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 05:39:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 14:39:58 +0200
Message-Id: <D2E7JPQ61HNG.3R2Z0KQWLZUJW@gmail.com>
Cc: <gael.portay+yocto@gmail.com>, =?utf-8?q?Ga=C3=ABl_PORTAY?=
 <gael.portay@rtone.fr>
Subject: Re: [yocto-patches] [meta-security,kirkstone][PATCH 1/5] sssd: fix
 missing python3.X-config script
From: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay@gmail.com>
To: "akuster808" <akuster808@gmail.com>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240626133913.790145-1-gael.portay@rtone.fr>
 <20240626133913.790145-2-gael.portay@rtone.fr>
 <d3296a3e-38f9-4ffc-bd16-4952e15e3b87@gmail.com>
In-Reply-To: <d3296a3e-38f9-4ffc-bd16-4952e15e3b87@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 12:40:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/401

Hello,

On Mon Jul 1, 2024 at 1:14 PM CEST, akuster808 wrote:
>
>
> On 6/26/24 9:39 AM, "Ga=C3=ABl PORTAY via lists.yoctoproject.org wrote:
> > The configure script checks for the utility python3.X-config to be in
> > $PATH; that script is shipped by the package python3-native.
> >
> > The recipe does not depend on the package python3-native which causes
> > the task do_configure to fail.
> >
> > The recipe inherits from the bbclass python3-dir that does not install
> > the required script to the sysroot. The bbclass python3native inherits
> > from (the already inherited bbclass) python3-dir and it adds the missin=
g
> > dependency to python3-native.\
>
> Does this apply to master?
>

The change does not apply as is because of the context has changed a
bit: the two lines above have been modified since kirkstone.

> - armin
> >
> > This fixes the configure error by "upgrading" the inherit bbclass from
> > python3-dir to python3-native.
> >
> > Fixes:
> >
> > 	| checking for python3.10-config... no
> > 	| configure: error:
> > 	| The program python3.10-config was not found in search path.
> > 	| Please ensure that it is installed and its directory is included in =
the search
> > 	| path. If you want to build sssd without python3 bindings then specif=
y
> > 	| --without-python3-bindings when running configure.
> > 	| NOTE: The following config.log files may provide further information=
.
> >
> > Signed-off-by: Ga=C3=ABl PORTAY <gael.portay@rtone.fr>
> > ---
> >   recipes-security/sssd/sssd_2.5.2.bb | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sss=
d/sssd_2.5.2.bb
> > index c07559c..fe82452 100644
> > --- a/recipes-security/sssd/sssd_2.5.2.bb
> > +++ b/recipes-security/sssd/sssd_2.5.2.bb
> > @@ -33,7 +33,7 @@ CVE_CHECK_IGNORE +=3D "\
> >       CVE-2018-16838 \

The two lines are now:
=20
 UPSTREAM_CHECK_URI =3D "https://github.com/SSSD/${BPN}/releases"

> >   "
> >  =20
> > -inherit autotools pkgconfig gettext python3-dir features_check systemd
> > +inherit autotools pkgconfig gettext python3native features_check syste=
md
> >  =20
> >   REQUIRED_DISTRO_FEATURES =3D "pam"
> >  =20

Regards,
Ga=C3=ABl

Here is the change (untested):

----- >8 ---------------------------------------------------------------

 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9=
.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index 0c75d8f..058d80d 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -30,7 +30,7 @@ SRC_URI[sha256sum] =3D "827bc65d64132410e6dd3df003f04829d=
60387ec30e72b2d4e22d93bb6

 UPSTREAM_CHECK_URI =3D "https://github.com/SSSD/${BPN}/releases"

-inherit autotools pkgconfig gettext python3-dir features_check systemd
+inherit autotools pkgconfig gettext python3native features_check systemd

 REQUIRED_DISTRO_FEATURES =3D "pam"


