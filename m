Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED50BFEA82C
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 07:34:42 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17321.1774424070548192590
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Mar 2026 00:34:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=MhEGbDMp;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a278e0f7f6so2719155e87.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 00:34:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774424068; cv=none;
        d=google.com; s=arc-20240605;
        b=EUyBI7GIYw1A1O8YAjjOHmcCOG/cBihNxy3do1BCnOFulF7HqgjFLBr93tOTKuhaSW
         QX9g+xk7z5HayMlJq5EZVrUYhxmsc1WjFCZ1pyyZCezUNTqyjSfrFTGs9QdYR7GSpv6p
         EWTLplh3PxFWzphZggFL3XecS38NuxQ3NwOSv7TSm1DfRo7WvmVGFak72n0tXv1bLxFw
         C3YupEoUw2hHO2twsIPB/usbXd75jMTILwzxfgCA5ndMDD6FXzgw4XA50ArBnHGaArRs
         UeV1vBQEIieSkUmwLQoI1cEWG/ttaK0J2q2nQMxR4X3OVL6KIf9yXWfl0/G4k8vE5SUc
         3nLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=74MjZ9H/jLxYbwGPRRahpPCobaFDEkLHVw4OEO3tOmw=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=HIrs34c7U/x6JE6kS5nuuREwdNkP/q5bKzIlKRvTbBYjnseO+Zu47VC5Ed573+vsrT
         QmzhAssHHSsGSTnUI6wofMAwVcqQI/JuBsjqgkU6gCRoqcZNBZExUZ4oIp3QzvDhRrIJ
         8AVPTWQAhQh7yLvz7AqlYn1bPxj5uWoqAGN2f9fkfzsrc8hsF9cPw4Nn0Xbsynzywj58
         AUB+D4gooZb3zpgYbTHbv8wAT8Men9fEVGQpPEujOiVErxnHOsufciqy0TehX5kCwx1W
         F0ECYsqwc+b11dMdIvblVF8p/m5qVGEmFDxaLi0ceSkWmSfuCgJlL8zpIUVL6rx1m+mk
         L+NQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774424068; x=1775028868; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74MjZ9H/jLxYbwGPRRahpPCobaFDEkLHVw4OEO3tOmw=;
        b=MhEGbDMpXoI1ovyWVRcJVcmhtk3N+g7hr+nCn5vN0fKLyh6BJW0VkzHtxtXoWZFiMP
         SkWtlOVYUazT/GXBoKLq748V1iVax1HEV+6KJj/83G1ZrwEx9M+1eCvWJQyCkXVmlYZN
         21mgsQKdHw2VOyffZhm1fHcHbNpNwE/MmAJTd3enXkmIdw7d9Vyj3Gk/IqfkwNes42NX
         2YdBivUPkpzNkU6PlHtGPmqX5+MGaJomNXTWebOYuVDjhC6Y0Zc6QkKh5kOdBVtXFwAn
         hkygl91Qtm3p6GGXb5Dg1cqBPXWdwh83HHWmdU3MHd/nXWNfiCIqjuHU/PKKDf2Vv3wq
         4JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774424068; x=1775028868;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=74MjZ9H/jLxYbwGPRRahpPCobaFDEkLHVw4OEO3tOmw=;
        b=abzmW5FbZhzSubYkP0FUdsJu5+vUxOQrWeGlBlvZsQswFhIe+JXXsPfFoAtIjqZks7
         E5qZCG8n/kDNjz5g0GxJkeaf74o5mNXTsr9NP1uUxE0TDrrO1lPtNq//y3vTTUl5AIyV
         8PD1y0gkwIyc0oFGRLcRaoklkbXIepZn/LeLDr5ZBpMGH+V0f+FDGCel9BoBqBLB8CRc
         CfnPbHNfbW10gSCQIAWSCnzcosYsSUGa6Kqx4Pcg4Z9fUyQxIWascQhytYrGZ6RredR3
         Uap/UIdqGb2UABeN8mbT76cAcGgtorleWro8gjTEe1tAlvAIH1JYCCwyugwpy5jjvTex
         /U6w==
X-Gm-Message-State: AOJu0Yw3y1a9mo7Y5vAQwtjAOCvJyiANrGSnrIEUjGwfgDFpL3E1gEHZ
	yBeTLZevpzZc5ZMIhubFI5htGAuGhkS112MDSOyexJJLkjcQKmtLHjlXcwQVPgyvGnrFbLeHgby
	jxc/r7Pxdv+83ElOHBT8Bv/DQeFSUqcOJ+x/h
X-Gm-Gg: ATEYQzzRiiANX0ruiVBG7hJyVTqUSrQh+jMwro2bS3ytA1zgS4XctWHudZKXQtYKdDU
	AUz3oCCnqQr0unUtRPxRizBVq38piKNvjqTt6VA54ogUB3B3pk5GyQxvgI3LdJjlhDicpXFbolc
	j7uho0M6ACrx4szLNTCnoZp8KHyc7BHMW72qW5kSfOujyZt6klniAS/avNEcebubIsjtSZbOXUf
	kIS9kP//05/Si44HZicMMs5tiGLEPr5uXeDyuENGqnQeeJNKGiG2n0GshwCsiLzoLYGA8yf5icB
	ubg8gB/nwA==
X-Received: by 2002:a05:6512:a8f:b0:5a1:2835:379e with SMTP id
 2adb3069b0e04-5a29b9af9e6mr929741e87.45.1774424068091; Wed, 25 Mar 2026
 00:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 25 Mar 2026 08:34:16 +0100
X-Gm-Features: AQROBzB-aZ7VCUb1DlXWnvOlcJU1Z2FZSbtKvL394_5QrvqGKLFGT1-UQcTmnr4
Message-ID: <CA+chaQe_-D3ei532xoP8UVqXE=KdQ0EtPkXwD_fqZZtdpOwwyw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][master][0/14] Upgrade
 tensorflow from 2.19.0 to 2.21.0
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 07:34:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3552

On Wed, Mar 25, 2026 at 3:17=E2=80=AFAM hongxu via lists.yoctoproject.org
<hongxu.jia=3Dwindriver.com@lists.yoctoproject.org> wrote:
>
> Summary: Upgrade meta-tensorflow from 2.19.0 to 2.21.0

Thanks you, can you please push it to master-next or somewhere else to
make it easier to test these changes in our CI as well? Or what's ETA
for merging this to master (as it cannot be used with latest oe-core
without wrynose in compatibility list)?

