Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6808FCCFA18
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 18:31:59 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11356.1762626716671453546
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 10:31:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=m+gZeKFB;
 spf=pass (domain: konsulko.com, ip: 209.85.219.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-880576ebe38so17280416d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 10:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762626716; x=1763231516; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FM4nT9uALLzzj5sDwofo5hNJs88um+8p9k2gqg1aEzY=;
        b=m+gZeKFBAxdT0UkYwAt9mF8XpxFM/toH4iGzFjE5HMcZoxVL4qgTSTzwfSXxRf8oHv
         bK7A8/TNmgLKSjBwvLRzugo7KFSpi18PTq5rfAfVxj0M/VmD0ZnHMZD3YQFGDluqjBw5
         wI+E2pWXUII4yQPzHjvngVCgj7Dv/M/tCZ+J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762626716; x=1763231516;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FM4nT9uALLzzj5sDwofo5hNJs88um+8p9k2gqg1aEzY=;
        b=YuFTM+TFtUdVEQxPpPvYDIV301Jr7EPvd4I7+apeQABLFPvIRkBx+w75RbEByswM7t
         T5DjVSH/zhIAutQ2HMDW4xzfBBIvYgKbYgEprO5I4wIfuS1gRrTU+eCXy5p3pHknsRn6
         gvYIAjEWsT3wuo3HXwwo8qT9n6YAtQ+Jp4ZL8AGuP2aaDzRtPwipi+alRorykRPk8vnh
         Rca47D7gU/j0TtzOtJ756xomYsBin1PLscwxEE2/HSugPxhDCAjL16HPVkQvH4qS+pks
         0IrBjP0WpSYGjkv6Lp7vSLT8Bt93lg0nZqZRGJd6H8xqAmrh2zpEDPTqiUGh68r+NNAV
         hPXQ==
X-Gm-Message-State: AOJu0Yxrl4gIkGcDYHTE8t0UR/N1WR2y1WMFp8RPw8m4D+3jKnbl2k/d
	2G08tRt1VdTGEvyZRrYEA7fPss3//UI/Rg8rbqasy3Ea8v0gmOXxnGSbbbng3CdrHKQ=
X-Gm-Gg: ASbGncsGfU+8c4g+p5xfE4hTuUZlw29jwZ/OVt5QfQu+LG8t0Xtx0I4Nd8dFtdHQS+K
	nvP3f+OSUUGDYNvxq6xFb2yejlYW854FuLdlhx05/Y/2WWsaorMgRf4hziWk27FN0M3g4VPYunx
	GtX6Ux8ha+ZiGnp5gYDM6HMbAAG1pFR2b2wZEfd6qhXQjwKDPQcGEP9+9bi3EWfrZjaHFf8QLo1
	zAOc2xuep968jinxHXHv5D27Jpi/U0LjJQu7qDAw9VowlmSdjY5TzDDLZaFK7HmbqAop22odRjU
	WzxrdRcElZgCDvsU12AUmRKWYY25+Br3oaKE8Cl2BTrauZzECXvOfuvDgeE7oUxdrJMqcdvoPmf
	UHwBIgx2OHf+7cUSKUPEfLCcos5Olj+P7SuxvNx/zaThZX/2bYVXIefuDle+eB5lLh339+eCn8I
	vM8nXFBw9VbkSRBfp/fML4qxQkvyyg/znJGTE=
X-Google-Smtp-Source: AGHT+IETTR7WwqD2/RlABbgdXVTU3sBBl2r/RJEK3WFZooSNXfDCAaOGb23Aga46fk3RIISkM8GhDQ==
X-Received: by 2002:a05:6214:cc4:b0:721:7a6a:b703 with SMTP id 6a1803df08f44-882386e3624mr43562256d6.53.1762626715455;
        Sat, 08 Nov 2025 10:31:55 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b287c1sm18774956d6.36.2025.11.08.10.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 10:31:54 -0800 (PST)
Date: Sat, 8 Nov 2025 13:31:41 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Vijay Anusuri <vanusuri@mvista.com>
cc: yocto-patches@lists.yoctoproject.org, rybczynska@gmail.com
Subject: Re: [yocto-patches] [meta-security][scarthgap][PATCH] fail2ban:
 update to 1.1.0+
In-Reply-To: <CANQUz1_YMw4=cg=6RMqJfPSou-ns5dPVO6uXNqeJNz5Be9ycaQ@mail.gmail.com>
Message-ID: <90de25e8-6eba-1fd9-d801-b2e1068dd93a@konsulko.com>
References: <20250909065853.1959573-1-yi.zhao@windriver.com> <CANQUz1_YMw4=cg=6RMqJfPSou-ns5dPVO6uXNqeJNz5Be9ycaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-1803669749-1762626714=:3510"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 18:31:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2433

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1803669749-1762626714=:3510
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 7 Nov 2025, Vijay Anusuri wrote:

> Hi Team,
>
> Any update on this ?

Sorry for the delay, I'm working up a patch series for master, should be
out in the next few days.

Thanks,

Scott


> Thanks & Regards,
> Vijay
>
> On Tue, Sep 9, 2025 at 12:29 PM Yi Zhao via lists.yoctoproject.org <yi.zhao=
> eng.windriver.com@lists.yoctoproject.org> wrote:
>
> > From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> >
> > Current 1.0.2 version does not work with scarthgap or later releases,
> > as the asynchat module has been removed (as scheduled) from python's
> > stdlib as of v3.12.
> >
> > fail2ban 1.1.0 also does not work out-of-the-box, as the distutils
> > module which the pyinotify and systemd backends depend has also been
> > removed.
> >
> > So update the recipe to point at commit ac62658c10f4, which fixes
> > those two backends to no longer depend on distutils.
> >
> > Upstream's out-of-the-box ban action now uses the 'nft'
> > command. People can still override and customize that in
> > jail.conf/jail.local, but to make the recipe useful without
> > customizing things back to use iptables, change the dependency
> > iptables->nftables.
> >
> > Since 1.1.0, fail2ban has been python3-only, so the recipe becomes
> > somewhat simpler since the whole do_compile preparation step can be
> > removed.
> >
> > Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > Signed-off-by: Armin Kuster <akuster808@gmail.com>
> > Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> > ---
> >  ...fail2ban_1.0.2.bb => python3-fail2ban_git.bb} | 16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
> >  rename dynamic-layers/meta-python/recipes-security/fail2ban/{
> > python3-fail2ban_1.0.2.bb => python3-fail2ban_git.bb} (89%)
> >
> > diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/
> > python3-fail2ban_1.0.2.bb
> > b/dynamic-layers/meta-python/recipes-security/fail2ban/
> > python3-fail2ban_git.bb
> > similarity index 89%
> > rename from dynamic-layers/meta-python/recipes-security/fail2ban/
> > python3-fail2ban_1.0.2.bb
> > rename to dynamic-layers/meta-python/recipes-security/fail2ban/
> > python3-fail2ban_git.bb
> > index bf5f87d..1d0fb62 100644
> > --- a/dynamic-layers/meta-python/recipes-security/fail2ban/
> > python3-fail2ban_1.0.2.bb
> > +++ b/dynamic-layers/meta-python/recipes-security/fail2ban/
> > python3-fail2ban_git.bb
> > @@ -11,12 +11,14 @@ LIC_FILES_CHKSUM =
> > "file://COPYING;md5=ecabc31e90311da843753ba772885d9f"
> >
> >  DEPENDS = "python3-native"
> >
> > -SRCREV = "e1d3006b0330e9777705a7baafe3989d442ed120"
> > +SRCREV = "ac62658c10f492911f8a0037a0bcf97c8521cd78"
> >  SRC_URI = "git://
> > github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
> >             file://initd \
> >             file://run-ptest \
> >             "
> >
> > +PV = "1.1.0+git"
> > +
> >  UPSTREAM_CHECK_GITTAGREGEX = "(?P<pver>\d+(\.\d+)+)"
> >
> >  inherit update-rc.d ptest setuptools3_legacy
> > @@ -26,16 +28,6 @@ SYSTEMD_SERVICE:${PN} = "fail2ban.service"
> >
> >  S = "${WORKDIR}/git"
> >
> > -do_compile () {
> > -    cd ${S}
> > -
> > -    #remove symlink to python3
> > -    # otherwise 2to3 is run against it
> > -    rm -f bin/fail2ban-python
> > -
> > -    ./fail2ban-2to3
> > -}
> > -
> >  do_install:append () {
> >      rm  -f ${D}/${bindir}/fail2ban-python
> >      install -d ${D}/${sysconfdir}/fail2ban
> > @@ -66,7 +58,7 @@ INITSCRIPT_PARAMS = "defaults 25"
> >
> >  INSANE_SKIP:${PN}:append = "already-stripped"
> >
> > -RDEPENDS:${PN} = "${VIRTUAL-RUNTIME_base-utils-syslog} iptables
> > python3-core python3-pyinotify"
> > +RDEPENDS:${PN} = "${VIRTUAL-RUNTIME_base-utils-syslog} nftables
> > python3-core python3-pyinotify"
> >  RDEPENDS:${PN} += "python3-sqlite3"
> >  RDEPENDS:${PN} += " python3-logging python3-fcntl python3-json"
> >  RDEPENDS:${PN}-ptest = "python3-core python3-io python3-modules
> > python3-fail2ban"
> > --
> > 2.34.1
> >
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#2148):
> > https://lists.yoctoproject.org/g/yocto-patches/message/2148
> > Mute This Topic: https://lists.yoctoproject.org/mt/115146393/7301997
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe:
> > https://lists.yoctoproject.org/g/yocto-patches/leave/13419208/7301997/1335553898/xyzzy
> > [vanusuri@mvista.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
> >
> >
>
---1463811583-1803669749-1762626714=:3510--

