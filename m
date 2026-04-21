Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9593FF94CA7
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 18:30:52 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43333.1776796247537665430
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Apr 2026 11:30:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ACdR+In0;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d4f78fc9f6so496234185a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776796246; x=1777401046; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPaT+sUlalmz8rGf3ZnxO2b0lB6A7aDR8O788A+aMIE=;
        b=ACdR+In05N5w+qw5Bx85HBSMJPe0Med/Dv2/jXPcgQjK+XnG6Y0VRzY7W04HwcvGd4
         /QPbmRnkPzbPUvs9hXGztiqKnBaLa5WYmtRLdqgGOq48bc9on6i2gFM6UWC6N1rYrf0e
         rc4DoZjiBoGGb+PrYUadPJUyN1Q1ZkUa9QsL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776796246; x=1777401046;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPaT+sUlalmz8rGf3ZnxO2b0lB6A7aDR8O788A+aMIE=;
        b=i5FpjZWo7FyCXI1UcO992p7MUa2wWuu+D6gvCBw5S7CgDKlzg/U+/wpELGEBTQR8gN
         RT2HEZUUR14bAHUmlMSXPsTqz4uh5X/m9CM7Jl5A5e3QNQ791jusqUDCI03dIC9C/Y6c
         Ds1XaJtiJjPPHRRH3Ml8YFQzv1J1GOVM3APRCqfFoUrqlukoXGCXtqqRfHypkmgtENU3
         6pY1CEXjG+wVV+ZpB3/2VBmS+aAJmDJjFGFEvXJfUKGXTipd0IfSNRPe8DxM/dIFFzYn
         hzGfr++tG0UI4Ve5runI/uuJsSLsE5Y1IWgfwDel5Z+xb+UHimA6ogrs4LVGLBbEPBr3
         r5xg==
X-Gm-Message-State: AOJu0Yx2ifbsQD+53z8OGX9NN/LAqQH/ZUgs3dHTv29/1IpkHG0fUqOG
	rVvh8QpKEb0O6hf05orROiPPcBlQ3g8rP8J8o4Qh8XyybgMhi7FJaDbk+T8Fy2bJdpc=
X-Gm-Gg: AeBDievqU+8gqXocRTj5JusgDJem5US/Q/vsDWzK+uBJFOXzNSwoqOtG+0pBLLzdsYh
	KbZUUHQotzYjqJgPm/91TtF1Dn0qmEe0gLFSlEDcEF74FPbsCyYqwo31o5c15ryAwOU+MeYqb5s
	M6abV5Mq4NfF6dlYRNd+f2Nx4LKoP2xZbpf2bvz9vc9AHQkI9dwLmnICbEbjd163XsOyKnpVc2q
	9DE8crKxJVIFyPlQDTtzdDnnOlN1Yx3WPI9pUl0jJrdSTriR00JwoXBNa6uMxX9L+Q88ESy3mWw
	U79MAqMaGXwKk9NbiZEmS8PPpi4+MVfTrS5IV9OX9qN7HsgwYxo+8Rx3PkSyzA+e7ClCXJb69ip
	rcKSaJl3ICVkTP+HMWwO6H6uC0+CxR/kj1KFILLlj3NqWOAhF9Z1gNWFDnUz6WxjMshsvPBu4XZ
	AdTIprfDm8RYeFOtURcEaYMuXfBfW3cYe3GckvKD4f/a2EiwqTgkpz+kpUhkvxmKNNHg2f9RsLz
	8ZIwoCzszasMGvzzDi1AAHMGxd7grcoHtuH6H6qiFvQ6tQ5iCRc1nwjTwhOzNtkT2sx
X-Received: by 2002:a05:620a:6cc2:b0:8cd:c03d:b6db with SMTP id af79cd13be357-8e7922764e0mr2684488385a.52.1776796244667;
        Tue, 21 Apr 2026 11:30:44 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac6f670sm133402106d6.14.2026.04.21.11.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:30:44 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:30:34 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Jose Quaresma <quaresma.jose@gmail.com>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 0/7] Assorted updates
 04/15
In-Reply-To: <CANPvuRmtf1N+8gDgd+8bLZm69PY+pDkS2j0q7q_kfq51yONqOg@mail.gmail.com>
Message-ID: <73141261-00fd-01c4-a4db-e301c0f190fc@konsulko.com>
References: <cover.1776283733.git.scott.murray@konsulko.com> <CANPvuRkN7vGW+_Tu6qd0vxcw9BDZAF=ZUzb0hebDZSm2kOJXMg@mail.gmail.com> <a2ac6d5e-c0bb-70df-bd4b-756fbc026ef1@konsulko.com> <CANPvuRmtf1N+8gDgd+8bLZm69PY+pDkS2j0q7q_kfq51yONqOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-763600063-1776796244=:14624"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 18:30:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3752

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-763600063-1776796244=:14624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 21 Apr 2026, Jose Quaresma wrote:

> Scott Murray <scott.murray@konsulko.com> escreveu (terça, 21/04/2026 à(s)
> 17:57):
>
> > On Mon, 20 Apr 2026, Jose Quaresma via lists.yoctoproject.org wrote:
> >
> > > Hi Scott,
> > >
> > > Scott Murray via lists.yoctoproject.org <scott.murray=
> > > konsulko.com@lists.yoctoproject.org> escreveu (quarta, 15/04/2026 à(s)
> > > 21:19):
> > >
> > > > This patch series rolls up the contributed patches from the past few
> > > > weeks, barring the suricata 8.04 update that will need some rework for
> > > > Lua 5.5.  These changes are queued on the master-next branch if you
> > > > would like to check them out to test yourself.  I intend to merge these
> > > > to master branch at end of day tomorrow (Eastern Time, April 16) unless
> > > > there are objections.
> > > >
> > >
> > > Were there any objections or other restrictions?
> >
> > Sorry, no, I had forgotten to push to master before the weekend, but did
> > so yesterday morning.  I'll try to be more on the ball going forward.
> >
>
> No worries!
>
> It probably had already been integrated yesterday when I asked.
> I asked because I didn't see anything in [1], and for your information,
> it's still outdated.
>
> [1] https://git.yoctoproject.org/meta-security/

Odd, the commits seem to be there when I look, perhaps there's some behind
the scenes mirror issue?

Scott


> > > > Note that there are the following known issues atm:
> > > > * parsec-service currently fails to build with an error in the
> > > >   cryptoki crate.  This was likely triggered by the upgrade to
> > > >   Rust 1.94.x in oe-core.
> > > > * Including python3-privacyidea in an image results in packaging
> > > >   conflicts between python3-cryptography and python3-pyrad that
> > > >   need to be addressed in those recipes in oe-core/meta-python.
> > > >
> > > > I hope to get these addressed in the next week or so.
> > > >
> > > > Scott
> > > >
> > > >
> > > > Changes:
> > > >
> > > > Haiqing Bai (1):
> > > >   isic: fix RDEPNEDS typo
> > > >
> > > > Khem Raj (1):
> > > >   wic: wic need to be moved to files/wic within the layer to be
> > > >     found/used
> > > >
> > > > Peter Marko (2):
> > > >   libtpms: fix build with glibc 2.43
> > > >   tpm2-pkcs11: fix build failure
> > > >
> > > > Yi Zhao (2):
> > > >   scap-security-guide: upgrade 0.1.78 -> 0.1.80
> > > >   openscap: upgrade 1.4.2 -> 1.4.3
> > > >
> > > > Zhang Peng (1):
> > > >   meta-security: fix incorrect HOMEPAGE variable names
> > > >
> > > >  .../wic}/beaglebone-yocto-verity.wks.in       |  0
> > > >  .../systemd-bootdisk-dmverity-hash.wks.in     |  0
> > > >  .../wic}/systemd-bootdisk-dmverity.wks.in     |  0
> > > >  ...ilation-error-in-TPMLIB_GetPlaintext.patch | 34 +++++++++++++++++++
> > > >  meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |  4 ++-
> > > >  ...eturn-NULL-for-twist-on-auth-failure.patch | 28 +++++++++++++++
> > > >  .../tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb          |  1 +
> > > >  recipes-compliance/lynis/lynis_3.1.6.bb       |  2 +-
> > > >  .../{openscap_1.4.2.bb => openscap_1.4.3.bb}  |  4 +--
> > > >  ....1.78.bb => scap-security-guide_0.1.80.bb} |  4 +--
> > > >  recipes-scanners/arpwatch/arpwatch_3.3.bb     |  2 +-
> > > >  recipes-security/glome/glome_git.bb           |  2 +-
> > > >  .../google-authenticator-libpam_1.09.bb       |  2 +-
> > > >  recipes-security/isic/isic_0.07.bb            |  2 +-
> > > >  14 files changed, 75 insertions(+), 10 deletions(-)
> > > >  rename {wic => files/wic}/beaglebone-yocto-verity.wks.in (100%)
> > > >  rename {wic => files/wic}/systemd-bootdisk-dmverity-hash.wks.in
> > (100%)
> > > >  rename {wic => files/wic}/systemd-bootdisk-dmverity.wks.in (100%)
> > > >  create mode 100644
> > > >
> > meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-error-in-TPMLIB_GetPlaintext.patch
> > > >  create mode 100644
> > > >
> > meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
> > > >  rename recipes-compliance/openscap/{openscap_1.4.2.bb =>
> > > > openscap_1.4.3.bb} (96%)
> > > >  rename recipes-compliance/scap-security-guide/{
> > > > scap-security-guide_0.1.78.bb => scap-security-guide_0.1.80.bb} (93%)
> > > >
> > > > --
> > > > 2.53.0
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > >
> > >
>
>
>
>
---1463811583-763600063-1776796244=:14624--

