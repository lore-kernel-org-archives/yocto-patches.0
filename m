Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD963C83F1A
	for <webhook@archiver.kernel.org>; Mon, 21 Jul 2025 17:10:34 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web10.46785.1753117831399587704
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Jul 2025 10:10:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rY+TW7ik;
 spf=pass (domain: konsulko.com, ip: 209.85.222.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d5d1feca18so441405085a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 21 Jul 2025 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753117830; x=1753722630; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp8o1NEPEmE5n1PBrEpf3Zg3uvdfirNWI0xLnr+ilE4=;
        b=rY+TW7ik7/axK69nf0F9v+VB5AKP2whn/W0OAtrPEG0AulpZE5Y2A0cGAkwZQNAcbz
         LpINWN2RfCYpNHumzdvFK2eqaniXklDrki/frp1DvSs2fBc1BMpNLw0dd8fw4oBJZIFW
         73x75gv6YDfhFVBgRfNESw8eF0DOSOg/Ynbwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753117830; x=1753722630;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp8o1NEPEmE5n1PBrEpf3Zg3uvdfirNWI0xLnr+ilE4=;
        b=xMSxy1G+944hyDySE+Rhq4cz7p7gCYVJ8RHUpg6bpoKOGVQhjA9CRZ+qCJCCqfD0Tc
         yZ99r/cZzf/uoELCXRSsiNcxx9AQGJzBFceZAs1Meov9f21fYyA/jPN696SyjtOjQI/N
         Rv2NcOAmcaHHrA6jidE5UsA9QyaLoLFrnVAEPJR2cKALijPBExKYmW392nfA1ft/iMTu
         ZN4Hb1MTH4XLs8/bO0PjPogMBxO79BmL8udbFJKUp7VrlpgSGtOpHpf45h43AAyNqZpI
         rQrjDhC8fEIk551VIRG7iEQX1bXBMEO1NNyOYwOjVrkrJPkdpQxjMmhbVexPze+f/Qjl
         DjUQ==
X-Gm-Message-State: AOJu0Yyz1JzXU5W8IQSCe4B5mJAXdoTjyRww37zHxFWEEv/1qD0hihY4
	omFaGnY9WGzfjRbMQW8XptHrqCt0bRDTjq2zAdeHxl+aQ6764DE+dEdab0zDyRzKLKBcGTT9tzi
	i085a
X-Gm-Gg: ASbGnctkP7wNxfENW5khQx6jsqNGkTpyIkhLJ/BVZnGxBbA7JdX+6p16Px85ovb70BI
	Nd4m993Il3J8kdEVj++E45e5ORdomUZCFl0WRWkVMnqDagpbaqdO3PTA7RBvElNtWnVdEtlEsr7
	+b9baxAkK7skprbjyKNotUShcMT3lucN2T5OLM8wBlvt/gHqW4a3eHMqky5sajS1h7pcCMeiSkV
	kxTVwkyn/xyQXHNtoNeW4VazF4JyzAGOOmsh10LObJMv4E0EHnAyYH0deEIL2xFjrA5zAkTBvx/
	q2eH4UHbzBZqMBvTFodfZX+0Y9N8dsCrJSPypaI43u6oMIV2cDhfMTet+/Vjwy+w7uukCDz4L9N
	d9wkqv1hrcvJv1MlFuTifbhVUQ14At80QUWUXOBpf71SeH5n18KZPK9DS
X-Google-Smtp-Source: AGHT+IHrET9uf6MD06YmIuQE871fls3ORsuHiVYEo3FI70V765CB8T6lSLm9feVQrnuVkat2hYbiKw==
X-Received: by 2002:a05:620a:4623:b0:7e3:2c25:9b72 with SMTP id af79cd13be357-7e34356d5f9mr2990301385a.24.1753117830083;
        Mon, 21 Jul 2025 10:10:30 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b46b84sm428802085a.38.2025.07.21.10.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 10:10:29 -0700 (PDT)
Date: Mon, 21 Jul 2025 13:10:21 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: marta.rybczynska@ygreky.com, rybczynska@gmail.com
Subject: Re: [yocto-patches] [meta-security][PATCH 0/4] master-next updates
In-Reply-To: <CAApg2=Rs6QLgeErvpfFaAOP6ghbx+tBch7jFBBweZoNJ+M=24g@mail.gmail.com>
Message-ID: <aea68d87-0550-eda6-5f30-787ce856261f@konsulko.com>
References: <cover.1752846514.git.scott.murray@konsulko.com> <CAApg2=Rs6QLgeErvpfFaAOP6ghbx+tBch7jFBBweZoNJ+M=24g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-1155365993-1753117829=:19539"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Jul 2025 17:10:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1819

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1155365993-1753117829=:19539
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 20 Jul 2025, Marta Rybczynska via lists.yoctoproject.org wrote:

> On Fri, Jul 18, 2025 at 4:11 PM Scott Murray via lists.yoctoproject.org
> <scott.murray=konsulko.com@lists.yoctoproject.org> wrote:
>
> > Roll up the submissions since the first batch of whinlatter fixes,
> > plus an upgrade of scap-security-guide to get it building again
> > after the CMake 4.0 upgrade in oe-core.
> >
> > A note about the ptest removal for scap-security-guide; while
> > having comprehensive ptests is desirable, from the commit history
> > it is clear that there was no interest in banging these ones into
> > a working state in the last couple of years.  As well, ptests are
> > not enabled in most of the current CI build configurations, and it
> > seems clear that the build time hit would be massive in this case
> > if they were.  If someone motivated to try to investigate resolving
> > these issues appears, this decision can be revisited.
>
> Fine for me. This commit leads to a better situation in the CI, OK to merge.

I have gone ahead and merged the series to master.

Thanks,

Scott

---1463811583-1155365993-1753117829=:19539--

