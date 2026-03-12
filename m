Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B09106ACCD
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 16:19:34 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25862.1773332364653844076
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Mar 2026 09:19:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=a2xsVrdX;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899fbf92bdbso15392656d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 09:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773332364; cv=none;
        d=google.com; s=arc-20240605;
        b=TYA5J8GnufZtS772Wa0ZVtgeqqaN+8pT1A6lNB376KByW0DfbiTPZuOjVkKF2XkWxL
         VqoRHzEPYLI//M0Usl3otp9xSFMPdYrW4J0THX8YkSi6us7BKkuojop/1fxDeQ9lgwkZ
         SWYCT4evS62l4EAW198c+S3AvST0rmQ/QKEWUxkDlfq17+TREQR7VIf9bSYNDG/0PAPM
         Rc7pDSyoagD7S6ECqHsSduyB45aHQPHUbSxKJKnsunR2owfnrm4ac4crWwf6XfcVEC+F
         C5QJSGNbattVWKDP1fQJsy/hD9RD6ml452HCfsTH+xIZLW4ZnlPMGLES4ASseKWnAQuI
         QiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V8WsGzW06OEi1E0BsQ3BB3yBD2k8z3lZQRuvzXGgyC4=;
        fh=4kDRVRueUC4/pqfwC/ssklFNNAUW+HJmEk4n2wVOsJg=;
        b=YIleWD0ajhAoRIINeEeD4idhvhTL0unj3ZtxgmpiP1pdtnC/Uii9FfjjdT38ma6cdu
         8dXo9YCLYkMokEbOOgL25gW0hQPpUacosLFPh0bFblcuX94QPlLmEzHv9PyCedm24pFI
         PCzxBa7wMbJxk5K3eK7W3jYy+n51506tn/stdDaubRK/OAlW3WR0n1VpijNBouQQwEdn
         a39VV/J2pVHedwZkSynTUNScGjFMxoXjRqQI4Uy7uFcWgal5/gBQCXanD5WofEAe+Xmc
         yS8vHQIbttg4E80Qv5rxCgmVDkKwTmWVQOZNXYV9n9fQyTf9vwDqPdDYgzY7dQ8s6jwZ
         E0ag==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773332364; x=1773937164; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V8WsGzW06OEi1E0BsQ3BB3yBD2k8z3lZQRuvzXGgyC4=;
        b=a2xsVrdXHSZ1oKa2INy1w6R/QyYlEH+hRaruDDeCLuHcM+62wvCSvGbqQWxFZwdJhO
         5j9wZCt5CZIlKq23uOwhQnMAs1nqwcNilT93hyo2y0d5LWPNqo4PO5Qy4dJOxJ268msR
         S/ytmXJLHaLyP8GFDCvoO/B7C8jxg3AinPeqampKb1scOxfQSPLWawXst0nXr3euy/Jc
         eM0EoaXZy1DfLFyFX3s+CSsOM66yo238EBwsnmg+VYTLX8Gf+Qt4hw4acEsxPPqYc0zW
         pm+FyOqawYn2C2b/nR51adBuAPclcnFpFRxeNR3cFSlf3m447iqXxLObDUjxDyl+1RCI
         Hjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773332364; x=1773937164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8WsGzW06OEi1E0BsQ3BB3yBD2k8z3lZQRuvzXGgyC4=;
        b=X59q4WshVAeGbVG4EYPkOE1VmX7Lkx7adDxcXMul7MNOwwmY2JsqYF6qZWa/86ccnd
         pPJOuCGbeZWZIpkOk+jspBkQwSXh2ieF+6fE7EFuN75YH+51iTXVWKmxJneNiZIwUA9I
         fa6mNWiuMbunf1gJAwfKLzIdKsVz/7QejjOq3WQ34Sl3HulW6g7E62gbq4RFz9PrFjmk
         UyehMyMZQxMI9rQiL9AUxlforpjXxMg4EzUUYXTh3Tw9uz5h0paonc4OGvyPBZiyr04X
         nmPjw/eC44aHUoEtkaIu/TzV8CZUdoUTq+qkRAxI7HGwHgDNZdzvmtH3M2F1cwwsY6Jz
         gwXg==
X-Gm-Message-State: AOJu0Yw6VGkSVKszJXQ2BatqTV1g8Ogf+KcVwg1JLG2ysOXyzIzdhKmG
	6Ury7bfzPm6UypyUtsK1JzTbXGCtGShXkQ1krmGlgsDANDF2JYQ4hPAM75NbJ2sMjgbnXhS37eq
	+VxtY1zHxyNjj6Ra4o5Wx/N4xeBe+JQjIbQ==
X-Gm-Gg: ATEYQzzT5KzKy7UA/QWdmMWAz5IYLDrVcDFgJrLH3ZVWklvHSidgwlwJfv4RuSaMVRH
	pzUdOPPHL/7zKhMrILfP+MAR4BTlH9m6f3cAGJ0Ap9dNCqhiDOrGkHUR/UCl3QLmKcjhIa5OlF5
	P12t8NbE8ojvmB3NjFZTd0/yA+s/27xkNrlg37N7x5Krl+bc9cme5mJv9FaXHnE+b5D4EbdvtLl
	IDNzUBsrfd+a++OF4XpbMNOXQcMaqhlHrxOw59oBJZi10QLUHM2lAd9ZVMbRj7Xaz9LKa8Eq/pN
	EMbsdCFitmGKaMDoUF9k3GurQI517q1mzrx3JZySVw==
X-Received: by 2002:ad4:574e:0:b0:899:f5ca:f1b with SMTP id
 6a1803df08f44-89a81f50af5mr4679576d6.46.1773332363456; Thu, 12 Mar 2026
 09:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260311064813.619683-1-Qi.Chen@windriver.com>
 <20260311064813.619683-6-Qi.Chen@windriver.com> <CANNYZj8ZA0vN3FuUNaUktXvL_XpFm_GT=nB6g0KJQCz2Yx-5eA@mail.gmail.com>
 <CO6PR11MB560222D0F854CBBC58C8518DED44A@CO6PR11MB5602.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB560222D0F854CBBC58C8518DED44A@CO6PR11MB5602.namprd11.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 12 Mar 2026 17:19:12 +0100
X-Gm-Features: AaiRm529euviUAx3F3t-eJDI5qe_O8cZkfZZ1ltvCeevBTnoM2CGGevp0q-oLGM
Message-ID: <CANNYZj8u5mVc4cjpsDeDv+L+PPt1rrsUqzPsvUHzsniKeFzuAA@mail.gmail.com>
Subject: Re: [auh][PATCH V2 06/12] modules/utils/git.py: include repo_dir
 information in the raised exception
To: "Chen, Qi" <Qi.Chen@windriver.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
	"MacLeod, Randy" <Randy.MacLeod@windriver.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 16:19:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3450

On Thu, 12 Mar 2026 at 04:44, Chen, Qi <Qi.Chen@windriver.com> wrote:
> Thanks for your review. I'll fix this and send out V3.

Hello Qi,

I applied and pushed all 11 patches from v3. Note that AUH does not
have a test suite, it's basically tested twice a month by running
updates for oe-core, and fixing any possible issues after the fact.

Unfortunately AUH is prone to even simple and straightforward looking
changes causing some kind of regression in an unanticipated corner
case, so let's see how the next round goes, and I'd appreciate if you
are around, if/when problems occur.

Alex

