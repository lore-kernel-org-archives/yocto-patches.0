Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573BCC55164
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 15:57:19 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15027.1785427034743205496
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 30 Jul 2026 08:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pDIUM6Ef;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92ed3993c1eso135166085a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 30 Jul 2026 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785427033; x=1786031833; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fi6l3BBZt6XUUOpwc1m1QIOwAv73Jb3UURQGcTB0nTc=;
        b=pDIUM6Efiq4XqMmH+ukrwzZQSW0J/sqodj48r9QFuEevi0l0gATUXaOTvR+isqO/ku
         w4gmF7S38NxrKvE9yCjZw0OVZHgw76ox2iSISOy6EwojwXkvVlnVXcpgZ3ChNbVNBxS4
         pVh0UMxnBTHS9gZx6IrYHuOKHZud4kRDscPjK6RcAEvlfHXIkwMt9hU27h3xVDMo3IV/
         9xZ7s9aF2+LNnBznNiusFaWeVoZC7cEgZpsq9WYq5vn3vE4bQi5bs7Kexg/x9eKE1hiQ
         y5QUZurjUr2KZFUcf1dM9K/71T6NuQvQDpk81DiVly8DJg/S8szILOY9wGC+k35/3UHP
         /wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427033; x=1786031833;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fi6l3BBZt6XUUOpwc1m1QIOwAv73Jb3UURQGcTB0nTc=;
        b=GJJujm9Fgm+gTANR2wYAI/OWL6+l6kx8jDH5gZhq1qSDtPMRMmwsI6+BvxfFXg5s3q
         cC0g2NIhaKFDQfMZUf1aIVP5OoeFtn3z70nbRVXzNdFsZ15n9krFfHhyitHdUF9O412r
         1rINMFSPFth31nr0XjOg5tjg47PkXFSrP0mCHCZebniWfqZJ6+n6/tDlSNYEXiOjgV/l
         QhPXSvpv0lkdJ3N0+LnPq1PD+GXxRm59FhmusQBn/wq2EceLPJT6llXaD3Z0RDDT3a0a
         HyiCyJscyN+Iakd9RHa7NLyr/iANqE7dzbQdAhg/T3ccQCmOFNV9aJsmzFf9VKSF+gTQ
         Cocw==
X-Gm-Message-State: AOJu0Yy6hHIRQR70+c184zQGrVCF+Igmu0SYqvsnt4x/mMR53b9YSpFk
	7xOrU8B+K1W3ZHmYupBTNBkid59WyosSCJ+2Q/cjBDEnTtl0o9yAtax/IWBGmQ==
X-Gm-Gg: AR+sD105QIxt+zS9fS0zW7MKhjam8orWCDzgfqeqUNwuauvEpwCpE4g7Aet/VIyNU2W
	1yu4bU2Fsll6l+M6tSDXbsXH3RHyLu0ER8gDNfDgbk39ruBIhntGOULF/noMEYHU+rIHp6G6c3+
	zZc0dNF15vBg2/wETlX++/l8BH74euzie02tEiYh6CP/+G1jcWmq6qTac7oSiSJMHvVy6zQu+r9
	AS1pi4vAds45vO1rxmsn6KTmmDOIeMBVRFZ2mTx5PzxHRH+Z77aP1V2+sj33crgDwhvHl9i+hIR
	HPOwvdALIHyHCbAbwPrl748uvhwbGq73luZ6Q4eEWZykLycqiHB/u0lTrCbA241qGq0sqJB48UH
	6fJLU49iuqQLEkHI87KNoE13xolThUU76di6OrP9VC9+M2Ak7IhQlLy1cZxPqVyJ2+5jIGfO8Df
	FlpS1FcRedXPW9E1BuRn1yiMu511pZ/5o0i0bJybnYU2JMl2YK9jmrQTo6nDDEn+NbZ2MsoU3d8
	o5cNjkO/XfOIbcG/3lUEjckLrwCKiM=
X-Received: by 2002:a05:620a:630f:20b0:92e:dbe9:be9c with SMTP id af79cd13be357-93486af7efamr243861785a.58.1785427033423;
        Thu, 30 Jul 2026 08:57:13 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3378db0sm442011785a.20.2026.07.30.08.57.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:57:12 -0700 (PDT)
Date: Thu, 30 Jul 2026 11:57:10 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [wic][PATCH v2 0/4] oe/path: three fixes plus
 unit coverage
Message-ID: <amt0VjtgxpZX2VkE@localhost.localdomain>
References: <20260724115020.38079-1-twoerner@gmail.com>
 <243b9b065b08ae79eb0c2f7dd2ac9b8d18ba54f8.camel@pbarker.dev>
 <ams7pWxsG4ZjkuyN@localhost.localdomain>
 <0db1bbae64602548db4132db0d1397254daf8949.camel@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0db1bbae64602548db4132db0d1397254daf8949.camel@pbarker.dev>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 Jul 2026 15:57:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4575

On Thu 2026-07-30 @ 01:04:05 PM, Paul Barker via lists.yoctoproject.org wrote:
> On Thu, 2026-07-30 at 07:55 -0400, Trevor Woerner via
> lists.yoctoproject.org wrote:
> > On Fri 2026-07-24 @ 04:04:55 PM, Paul Barker via lists.yoctoproject.org wrote:
> > > On Fri, 2026-07-24 at 07:50 -0400, Trevor Woerner via
> > > lists.yoctoproject.org wrote:
> > > > This series continues the standalone unit-test work, this time over
> > > > oe/path.py. It follows the same shape the suite settled on: each
> > > > source fix is its own standalone commit, and the green test module
> > > > lands last, so the suite passes at every commit.
> > > 
> > > LGTM, assuming these are direct copies of what was added to OE-core.
> > 
> > Almost. The 3 "fix" patches are identical, but the unit test patch is
> > different because wic uses pytest and oe-core uses unittest. The test
> > coverage and what is tested are the same between them, just expressed
> > differently depending on the test framework.
> 
> Thanks for clarifying. wic doesn't need to be limited to using unittest,
> so this makes sense to me :)
> 
> Reviewed-by: Paul Barker <paul@pbarker.dev>

Excellent! Thank you for your review!
This series has been applied to wic, master branch.

