Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C69FD8FC6
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 15:18:11 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72402.1772119081975577276
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 07:18:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=rDdYrZAn;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371119eacso11548325e9.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 07:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772119080; x=1772723880; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH5+gT5iaXq/OHOmqMAOp/Jvyj893/MaW5/sIghuL9g=;
        b=rDdYrZAnAWPxPmhBty0mpQa/Eg8q18h9f4qWT+ecqe4FTu7YtKVWduT1xsEBOTPKf5
         sAaepZe7LhK9MEy8c9AUYxjIiSZYns+jSl31f2u44QTiBPei1w+ZZ/Vx0G4H65XH40yY
         V4amSNdoxIfhR0kEkxzSaQq/1NrIiqNyqycmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119080; x=1772723880;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PH5+gT5iaXq/OHOmqMAOp/Jvyj893/MaW5/sIghuL9g=;
        b=aFnW4wLgzl83MzOL1VksIm6S/Q0t1R6alNZWbtgVaY5C+/ZSls8Su7SPjSe0GL2ajj
         DUMNDHG2mQu325K5shAiE24rsE7oVKigEwbfnlDFGPFXR49o2L3AV76s/x/+tXMPHZ2P
         cHC+uo+Q0xhMXRciKiPfpAvZuJfoQ8KhACM+8uIFBg4/5O2oi/7CtbAGtc6HUYB/Gqm1
         kuNRO06S/F2lpHldj8vqaSmzvzOQFtjXgzjVwYtoBgCSrKSH86LFL84bnGz4iPznz2NP
         uVPiK+XKYTdKTQuscZHpvBSyVneDrTCXK7XE+WkqIuhDnCKhzQA4dbjs3t3I1LP8aieb
         ucXg==
X-Forwarded-Encrypted: i=1; AJvYcCVnLmD+rPZEthFHuceSxTQ0YylTpliYMkfN4IuchqxCb2Ug7nm0HrwAJVnUxFXlZeuQfm2prRIdZ+hp67S+@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzqRWcHb0yaL1Aum89Tl6Yoq7wVTBrXiybDNwZzXlK7pixxYM41
	M8mEW0qRPA/2UAoeOOxGHtTVjm/Aankpor838Lnkm3/fhTmbd74/j/6UVFuceVkV02I=
X-Gm-Gg: ATEYQzwQzB01819a6E2f7hF7k0GH+hOxpLwUfM2ot37u3p+/lZfaEFUn5sKkDCcH1nv
	VikHrsM+wgTSXSxGEIfTVsz6iK1Ho3yLmLVwokVNus5KXzEcTGDp43sQJYh0fTs4nyPjRiB7Hd0
	KYlZKIjnEecq+r+j4W7iwsaWNEoJnM38BIRGUkoDrbQ3pdgh1JGdaiuX8QOOEj2g+v7IH8B/5or
	+DiitXIbEdum3EW21xSFEhrEDWb1TR3ab11GKXfMJpNDpWtdSiNXuK864S5JaRwIRi0iTwIK79s
	MO1f9dTldj0c6srnmJvLMJnnZdaLPoIkp1Xfw0pVFju8YWRHO8Cdt5txAHOCLE0Ma0TCtYmtw0M
	sC2qa/X7maBuuiqEsGZx7l+Fqs6Yo/TqjOcWyyAd0NMl01XeEz3PtYo2M05oldttHX/39NGckM9
	KrM767Dx3jVErwHoFdqkbzTwdL2NeXsH1Ri0pURJcIlhmjLx/wk/hMN+vp+kovNlnbEo0FrQ467
	xJU2YiuOqqrKsTZ
X-Received: by 2002:a05:6000:2006:b0:439:8dcd:f873 with SMTP id ffacd0b85a97d-43997f31719mr5122042f8f.29.1772119080325;
        Thu, 26 Feb 2026 07:18:00 -0800 (PST)
Received: from localhost (2a01cb001331aa002c0b752a8b25831e.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:2c0b:752a:8b25:831e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b40esm113627f8f.36.2026.02.26.07.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 07:17:59 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Feb 2026 16:17:59 +0100
Message-Id: <DGOZSACRJBVH.18WU5AD0T6D8@smile.fr>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH v2] schedulers: Add
 stable -next/-nut builds to the branch selector
From: "Yoann Congal" <yoann.congal@smile.fr>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <20260226144201.47577-1-yoann.congal@smile.fr>
 <433b819f2977f580713495429fab3cad59a5c430.camel@linuxfoundation.org>
In-Reply-To: <433b819f2977f580713495429fab3cad59a5c430.camel@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 15:18:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3291

On Thu Feb 26, 2026 at 4:11 PM CET, Richard Purdie wrote:
> On Thu, 2026-02-26 at 15:42 +0100, Yoann Congal via lists.yoctoproject.or=
g wrote:
>> From: Yoann Congal <yoann.congal@smile.fr>
>>=20
>> These build setups are frequently used for stable maintenance
>> work. A shortcut is appreciated.
>>=20
>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>> ---
>> =C2=A0schedulers.py | 76 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
>> =C2=A01 file changed, 75 insertions(+), 1 deletion(-)
>
> Do we need both -next and -nut?

It depends on what you want to see in my pull requests for stable
branches. If you find a -nut AB build convincing enough, -nut is enough
and I don't need -next.

I will send a v3 without -next.

> Cheers,
>
> Richard


--=20
Yoann Congal
Smile ECS


