Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9557DF9D0D4
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 14:32:24 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20291.1776177134949969693
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Apr 2026 07:32:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=eF81/WJc;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d76492e51bso538354685a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776177134; x=1776781934; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gu4mhwQTPwPz8D9hEOnOyVoppb5jTid8jPs/eF20gg=;
        b=eF81/WJcmfO6Uy5ZKNeI6Cr8tkhqbyxerjbEMvWD/90eZ33mFc6O1Vym3Ie6uxCdEU
         gS5TXY+rhzSM7lXIi7QhitMl0IXCDjA44Q7Tku35gD4tDCW15mnzxLWcKFcAZ9WWaWhE
         uoZViPqoCqGDZraFvPH+wj/Ng7FCMSMJGuQFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177134; x=1776781934;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Gu4mhwQTPwPz8D9hEOnOyVoppb5jTid8jPs/eF20gg=;
        b=QJ32kQW8ArL86fxEmbiyfoElAvMjuoz3Hpn4OmUWCGTvWIGFGAvNv4TZ33sMwofgoq
         NauniL56Z4a9B/HjXveIJlXaVdin9NN1gYQBp6RLTaxVGzrfq6rtjiIB7w6u3/OixirD
         ZPT8PWePcYKX81NVv34NsyKpwMX3uz8izlN+jH8/b9cLjG77HyXOQfgea5jRhN3wBopt
         PxM2nANlU1G3iba7R3FzS352eyXLT3PsryNJo9dSwr94oGCuZkp3B8fmjDqq9n6Ec5rG
         7SwboWFZGIGImynkMMlEw5dtNy77I79Eb4XPR1p4eDZ9/q7eweMUXbgLe+Vu5hhI+det
         oSRA==
X-Gm-Message-State: AOJu0Yy0fTgDtSk5qqsmrC75Rwmhoex9H/Mpt6kqOq2g5ZOaB6j0gvGP
	dxETGZXmkc1NFPtOpclE/3RJmO6LfTd1+k9dXNFCyjPcUvJZhvG/4egvnBWaHwHb+rA=
X-Gm-Gg: AeBDietxHW9cwjQ5OnPEhWBCtzDSc74SzlNQuJuwDJG2GxtMaZos/uhbSAP87LyJOZE
	Nuk+wWUmkLsSJS+f3GWbfsYO3rQM9CWKX8i40QOTyFfRswriU5mGftdCQbMwkFasdJ1M6MH63ZN
	GMda5PqpP+h1XOHeVUoDVS0CnM1hGjlEzaPKq7Xgc1MA5IYZOczhv4p5LMXkLQT0BhBvbvD9ZRu
	57VWVNKnAOErXEwsL49e2aO9YcUlkVIaZHHcqGoVGdC2pKq4bpjW1jDtc5SAdogjO6HLEqBrg+U
	HMRssqub0Py+DmmGYHZ95yFnJuVU8RlaJAaNbSpeRru0/b09SvbwZ5XciF427JdKRyHC3UaSabi
	r1OWLEm6QWPbVFH4XwSkYuutWis85UcXwAcepOcBtz0OVPDQsFQ7Dt/ohazfu7hFhAbgA0idtLD
	BrZJ4pZiV8KKgbIPaRH5cnCN9MrfaUvB48JpHjjEKIWCbNhHIxVidlqKXgQhTddviCjSXy2nGJP
	HLEnGhlY1QggMnLLEIeCeaUn7pBIu3cOxi4noIGrWgf96E=
X-Received: by 2002:a05:620a:1a11:b0:8cf:d386:1db1 with SMTP id af79cd13be357-8ddcefc1235mr2631617285a.31.1776177133588;
        Tue, 14 Apr 2026 07:32:13 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8deb5d9b336sm912430785a.9.2026.04.14.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:32:12 -0700 (PDT)
Date: Tue, 14 Apr 2026 10:32:00 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Martin Jansa <martin.jansa@gmail.com>
cc: yocto-patches@lists.yoctoproject.org, 
    Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH] wic: move to files/wic
In-Reply-To: <CA+chaQeUfObYUY=iKFdz5YmZkCq8bp9Ex44uqn4Xf8VTgo=w5w@mail.gmail.com>
Message-ID: <75455d5a-4119-ec29-7700-d31f20479e3d@konsulko.com>
References: <18A45B2EA8F8EC11.657799@lists.yoctoproject.org> <CA+chaQeUfObYUY=iKFdz5YmZkCq8bp9Ex44uqn4Xf8VTgo=w5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-1193958172-1776177132=:4425"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 14:32:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3702

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1193958172-1776177132=:4425
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Apr 2026, Martin Jansa wrote:

> Gentle ping as the builds cannot be started with recent oe-core (since
> last week) when meta-security is included.

My apologies, I have been dealing with some family matters the past couple
of weeks, but aim to get recent submissions pushed out in the next day or
two.

Scott


> oe-core $ bitbake -k ovmf-native
> NOTE: Started PRServer with DBfile:
> /OE/build/oe-core/cache/prserv.sqlite3, Address: 127.0.0.1:36907, PID:
> 407062
> ERROR:  OE-core's config sanity checker detected a potential misconfiguration.
>     Either fix the cause of this error or at your own risk disable the
> checker (see sanity.conf).
>     Following is the list of potential problems / advisories:
>
>     wic/wks files at /OE/build/oe-core/meta-security/wic need to be
> moved to files/wic within the layer to be found/used
> wic/wks files at /OE/build/oe-core/meta-security/wic need to be moved
> to files/wic within the layer to be found/used
>
> Cheers,
>
> On Wed, Apr 8, 2026 at 12:33 PM Martin Jansa via
> lists.yoctoproject.org <martin.jansa=gmail.com@lists.yoctoproject.org>
> wrote:
> >
> > From: Martin Jansa <martin.jansa@gmail.com>
> >
> > To avoid sanity check failure
> > https://git.openembedded.org/openembedded-core/commit/?id=07e410600c41103098b670f12abe87f64419a624
> >
> > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > ---
> >  {wic => files/wic}/beaglebone-yocto-verity.wks.in        | 0
> >  {wic => files/wic}/systemd-bootdisk-dmverity-hash.wks.in | 0
> >  {wic => files/wic}/systemd-bootdisk-dmverity.wks.in      | 0
> >  3 files changed, 0 insertions(+), 0 deletions(-)
> >  rename {wic => files/wic}/beaglebone-yocto-verity.wks.in (100%)
> >  rename {wic => files/wic}/systemd-bootdisk-dmverity-hash.wks.in (100%)
> >  rename {wic => files/wic}/systemd-bootdisk-dmverity.wks.in (100%)
> >
> > diff --git a/wic/beaglebone-yocto-verity.wks.in b/files/wic/beaglebone-yocto-verity.wks.in
> > similarity index 100%
> > rename from wic/beaglebone-yocto-verity.wks.in
> > rename to files/wic/beaglebone-yocto-verity.wks.in
> > diff --git a/wic/systemd-bootdisk-dmverity-hash.wks.in b/files/wic/systemd-bootdisk-dmverity-hash.wks.in
> > similarity index 100%
> > rename from wic/systemd-bootdisk-dmverity-hash.wks.in
> > rename to files/wic/systemd-bootdisk-dmverity-hash.wks.in
> > diff --git a/wic/systemd-bootdisk-dmverity.wks.in b/files/wic/systemd-bootdisk-dmverity.wks.in
> > similarity index 100%
> > rename from wic/systemd-bootdisk-dmverity.wks.in
> > rename to files/wic/systemd-bootdisk-dmverity.wks.in
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#3662): https://lists.yoctoproject.org/g/yocto-patches/message/3662
> > Mute This Topic: https://lists.yoctoproject.org/mt/118722653/3617156
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13388836/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
> >
>
---1463811583-1193958172-1776177132=:4425--

