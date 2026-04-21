Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBC4F8FA9E
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 16:57:58 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39208.1776790677279222105
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Apr 2026 09:57:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DSjFNXGw;
 spf=pass (domain: konsulko.com, ip: 209.85.219.52, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a3b0242631so55815296d6.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776790676; x=1777395476; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmtkL6gtPo567QnfGOg/dk1zZF76rMBz86oC/LijWTY=;
        b=DSjFNXGwpbxLUIBHg9e3mIBXNaMTMwbt/9So9CfuGa5Fat4ca18A4dKRsVqqqJEP3B
         GDj9okk/QMF3y60Tg+c1ZBrc8rqHIepCmFdGEcdfdOFjt5ghyZ9XhID4y9ja1hV6j1CJ
         Ob323vp9om2E+ri10L73zPB9jLZmlSI8a751I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790676; x=1777395476;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmtkL6gtPo567QnfGOg/dk1zZF76rMBz86oC/LijWTY=;
        b=iIwybs4gpk8HMDOHr/FAXhO+nd5EOMdYWaRN9IDDNw5kDrM1drGoMJDxUoHQ9x2DTw
         8/SeE2EOE153ndC9XYtSVwmG3BheCTV4xP9m+3wBFj3nqSImjegooa9RWUjwfKB/zDH1
         hI4k1VC9dxvMQebfTyOrqtLjSusfl4dxPZFZXLA82N280oLrtRIgZkZnZ2meSAHGdfQb
         uth9coD8MjoCyCVOUY/6y++y921Uge5hKeGZdas0VHCkWTT2+T5izIybPSxVsuQm5HBW
         lx2oLveMigduqKfeGFJ5B5CjkQ30DgJ8P4IoO/eNPbuLbQtOCaqfH4LVQGjMdQ7HE5mU
         tBTQ==
X-Gm-Message-State: AOJu0YxGmqunDU0n4KG0G+Owh4/NizVKUx8njz+r1AhWjJZGykEa6Xt5
	1UYhaDmsLoSqB5pbdQff2FJN49oT2Kpn+jkpz8lJFofL/p8TsUwQ5J/G8Q/ZjuUJDT41JIWe7tr
	BcNgO
X-Gm-Gg: AeBDieuLo/uNf1obqrKFFD+8Cx1M4HJQj10dyENFw2+9I8ips73nh7Bfa8AkpCM2MSE
	jsx1EnuRqWI8apgp3ADbx6G2wwpY/UTh9NSfJTXrggf+HqX0lbLqGM2iYkhzNHQ2oA/pl4lupYy
	+zK9ZXp4KuiIMTvFPNFrKTL4Wsxx+qZ6mtFm+M8EESPgfzyVgbxkVpMqItkdjGUUoqe5lAMOy/m
	/FF7wDZt7QzGPMn4RvgzRG0poReb2VSfF+/0u51/kXlGh6nv6OLRQnWJWba3idML4NXsYfp9AI/
	3ZQcYDiCB+M9dipQJjcWqU//3pgqg23f2UuzMhd7HEf//37b1GZzvN+h0GndkuBbWIsUOARZSb7
	G9sZ8XOQc1gkGrj9kMO0g8JBfWwRH7t/j9R4EDw2uy7QKOclJdMvLLt9zgWfWs8m4asK4BhYT3O
	bo6tJwBpXgSKQhWfkRjM1BI8mo1Cthu+YbZwDG7y7BSCDqVJdvDr0riPDFPi9kESOjnA7zUhx8D
	Q3rjwdYR1HwxiRCRIaYw+8avXyiqdgpV0jdBhHLWjLkyIWr9DFt5JAnxA==
X-Received: by 2002:a05:6214:300c:b0:8ac:abc5:8762 with SMTP id 6a1803df08f44-8b0280d0e83mr300787146d6.31.1776790675738;
        Tue, 21 Apr 2026 09:57:55 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae9dbe7sm108100006d6.43.2026.04.21.09.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:57:55 -0700 (PDT)
Date: Tue, 21 Apr 2026 12:57:54 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: quaresma.jose@gmail.com
Subject: Re: [yocto-patches] [meta-security][PATCH 0/7] Assorted updates
 04/15
In-Reply-To: <CANPvuRkN7vGW+_Tu6qd0vxcw9BDZAF=ZUzb0hebDZSm2kOJXMg@mail.gmail.com>
Message-ID: <a2ac6d5e-c0bb-70df-bd4b-756fbc026ef1@konsulko.com>
References: <cover.1776283733.git.scott.murray@konsulko.com> <CANPvuRkN7vGW+_Tu6qd0vxcw9BDZAF=ZUzb0hebDZSm2kOJXMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-1581446124-1776790675=:15595"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 16:57:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3750

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1581446124-1776790675=:15595
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 20 Apr 2026, Jose Quaresma via lists.yoctoproject.org wrote:

> Hi Scott,
>
> Scott Murray via lists.yoctoproject.org <scott.murray=
> konsulko.com@lists.yoctoproject.org> escreveu (quarta, 15/04/2026 à(s)
> 21:19):
>
> > This patch series rolls up the contributed patches from the past few
> > weeks, barring the suricata 8.04 update that will need some rework for
> > Lua 5.5.  These changes are queued on the master-next branch if you
> > would like to check them out to test yourself.  I intend to merge these
> > to master branch at end of day tomorrow (Eastern Time, April 16) unless
> > there are objections.
> >
>
> Were there any objections or other restrictions?

Sorry, no, I had forgotten to push to master before the weekend, but did
so yesterday morning.  I'll try to be more on the ball going forward.

Scott


> > Note that there are the following known issues atm:
> > * parsec-service currently fails to build with an error in the
> >   cryptoki crate.  This was likely triggered by the upgrade to
> >   Rust 1.94.x in oe-core.
> > * Including python3-privacyidea in an image results in packaging
> >   conflicts between python3-cryptography and python3-pyrad that
> >   need to be addressed in those recipes in oe-core/meta-python.
> >
> > I hope to get these addressed in the next week or so.
> >
> > Scott
> >
> >
> > Changes:
> >
> > Haiqing Bai (1):
> >   isic: fix RDEPNEDS typo
> >
> > Khem Raj (1):
> >   wic: wic need to be moved to files/wic within the layer to be
> >     found/used
> >
> > Peter Marko (2):
> >   libtpms: fix build with glibc 2.43
> >   tpm2-pkcs11: fix build failure
> >
> > Yi Zhao (2):
> >   scap-security-guide: upgrade 0.1.78 -> 0.1.80
> >   openscap: upgrade 1.4.2 -> 1.4.3
> >
> > Zhang Peng (1):
> >   meta-security: fix incorrect HOMEPAGE variable names
> >
> >  .../wic}/beaglebone-yocto-verity.wks.in       |  0
> >  .../systemd-bootdisk-dmverity-hash.wks.in     |  0
> >  .../wic}/systemd-bootdisk-dmverity.wks.in     |  0
> >  ...ilation-error-in-TPMLIB_GetPlaintext.patch | 34 +++++++++++++++++++
> >  meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |  4 ++-
> >  ...eturn-NULL-for-twist-on-auth-failure.patch | 28 +++++++++++++++
> >  .../tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb          |  1 +
> >  recipes-compliance/lynis/lynis_3.1.6.bb       |  2 +-
> >  .../{openscap_1.4.2.bb => openscap_1.4.3.bb}  |  4 +--
> >  ....1.78.bb => scap-security-guide_0.1.80.bb} |  4 +--
> >  recipes-scanners/arpwatch/arpwatch_3.3.bb     |  2 +-
> >  recipes-security/glome/glome_git.bb           |  2 +-
> >  .../google-authenticator-libpam_1.09.bb       |  2 +-
> >  recipes-security/isic/isic_0.07.bb            |  2 +-
> >  14 files changed, 75 insertions(+), 10 deletions(-)
> >  rename {wic => files/wic}/beaglebone-yocto-verity.wks.in (100%)
> >  rename {wic => files/wic}/systemd-bootdisk-dmverity-hash.wks.in (100%)
> >  rename {wic => files/wic}/systemd-bootdisk-dmverity.wks.in (100%)
> >  create mode 100644
> > meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-error-in-TPMLIB_GetPlaintext.patch
> >  create mode 100644
> > meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
> >  rename recipes-compliance/openscap/{openscap_1.4.2.bb =>
> > openscap_1.4.3.bb} (96%)
> >  rename recipes-compliance/scap-security-guide/{
> > scap-security-guide_0.1.78.bb => scap-security-guide_0.1.80.bb} (93%)
> >
> > --
> > 2.53.0
> >
> >
> >
> >
> >
> >
> >
>
>
---1463811583-1581446124-1776790675=:15595--

