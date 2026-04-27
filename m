Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C01FF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 11:17:02 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42920.1777288611921994833
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 04:16:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BuVtqkn1;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8acb3dab8dfso63210406d6.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 04:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777288611; cv=none;
        d=google.com; s=arc-20240605;
        b=TkzRiDI2S3Am5+3OSLChlvLveQVuVc0Kqi3q401whJ+y83oFLAFgLBnuL7EgNkbfkL
         dRj/3XgSGKZDT4PfaPvcbU8MQgGUOuILgMW5ei5Ag3FuETEDSnxQG5L+Z4toqikecPYh
         ULhknbG1tbD/lZdn5O1gbsIo2IHqyE5A4KKV/fkR/j0EfkZUP10s4hkmedyb1PweY5/R
         eWOdyVR/+U+6k6mpd1Jup2lxtnEylf9OU1Dgqh4aVwcIGee+181+zluwzYUVotwiHV2s
         CfzgQJhaN+IRTLHee/X0PEQlQoeq4lwXUk7BhWwOBUzHgKeFMCG882QlWpGxMbr/con5
         JToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=24+HODxV6d28bexsdWydu/ORTRSQ8E9+9YslbwlRiJA=;
        fh=W2upFRU3r7kYTdZupd/uqrxTBa8V0K3uUVNSHTfq7l4=;
        b=WcFPQ7z5yf4Zb1As1BuPClVDannpGN/XrCy7x/6PkH0YtTeAZbbZLM82GGe/Tav0m4
         VpVXKJ3SNaeCNhX3QTLeSLfaXWHiUqXdV3aHgG62yD5u+yj0dg2R7rZFn8d7o5c8ky67
         XV8RBiAyj2p+0cqRW/bxNfzogYEJRUskm8N2upk4vMKVk6nO/NPi8jT4y4+HXW/LeLoH
         E4Tdp96uQcGrN3sdrp0DlQgKwo9/xcGlKggq+dyS3xzqt6imiBHF5BD8cYWWP+r3GaEQ
         YljlRYZX0xQDAH9wbulT2kw+i2JHNVb+o5HEotO4mSLlpsIt3tdqC2T4cD1SxQshiL4j
         RRRg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777288611; x=1777893411; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=24+HODxV6d28bexsdWydu/ORTRSQ8E9+9YslbwlRiJA=;
        b=BuVtqkn1R3g5M8yh1gg/n1XHAtQF3Y9vX5hJseYBu4VoAJbYA2/luQol5WHCsz5ujN
         vfymxAkqmL8DatbjuNrMB6Tg9sRvDIl4sgxmHDgfzU9zXgpyWyRPRz/qrj9Qz89tBh2h
         +nwIDvMRc30wspsperObyfQKCyXtsLvXnxuIzHNUzwGCOaxLXUb6SUnuMVHpB7szMRBm
         N/Gg2wCZqu/niehNkS/sOwCl+HhAM+O9GjStOzOQ/TSHlwr/XLu6WByVMfXy2EkHMazF
         TWYO66TZcdNw6EkkLVgi7M4Frtr8IPiQifyJiK2uVGt8dSoCwSqfOtyu9KKZO+h0VV6G
         ndMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777288611; x=1777893411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24+HODxV6d28bexsdWydu/ORTRSQ8E9+9YslbwlRiJA=;
        b=UJJsvw8gH1bLRho9V4Occ/zcGS9h6IUOEj93wds3V05Nqebq8NHlHoJyCTRiMDp3Sx
         URO1OEF00/EUXynwHlgfoiBnOb8NHw+ZB3yBicgRq+elQtkbwxvPPz1QlhZ8L2SDqOh1
         6bv6ajqZVGHiXlb0/MOx2vu1ct8wwDlINzK4xRA8n13fOfZ5fPm8XHklyiAPuxMGno7L
         GBV6lNIlK920M1EC5AJVGa459C7aH4eRodO9rU6ycCk7nD3THlpZWZnZ/B4fN3zA1qfB
         0x2AzIaQYs0DlHUoRJ30btd67DBVvG4udL+cTWa62cOcKYEOnMnA1iNoMWlFR4yYzstn
         fgKA==
X-Gm-Message-State: AOJu0YyCkwICpZGjoOdEb1ww77ewVzVq2Ma55uYUqRXTI5ZUhTvwX+/l
	GHPAzngfqELvF7+ZYTADynWIPthRBpPyZUGsXF9dzKVSb3SCvtafLhpFwcOqAO9uw8azYsIWrbn
	Fw7IXzHd5YFWXEPHik5Zj3GGB9GMF32RItTWW
X-Gm-Gg: AeBDieuZmtfrCa8DI4Xv+NTolk2J0jjART+kiaHxsDHN79p13Swx1+vnDrIREB6HQOE
	bBdaup9hg46r7cj59yCMxSn6O4dknxn+mKgBBhC/XYk5QZkequPc8snz8rJXI1oLEXTTriIs5fR
	vgVhgbFPW67RkOuTTk3ppLp/7j/Cw7FP3FcPdRYnH03z7IeIUdpT0IMwxUH8Ng/GVD1+KnHIWM2
	Tvsh7b8OxYOO5UKZsfY/RnLG/5KAJYSY58yF8dZUNhoE/KxnoG3zU4tpUVYGDSrTZ/86+XOS+2A
	WE5mrg5uR6J/i4SjYfJ6pAsCUTtVQAcfQr8qZOH40+IjZbWwbryjrLIV7T4NVO0=
X-Received: by 2002:a05:6214:27ef:b0:8a6:1216:fb78 with SMTP id
 6a1803df08f44-8b02815a617mr657320586d6.46.1777288610798; Mon, 27 Apr 2026
 04:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
 <20260424114603.2444938-5-daniel.turull@ericsson.com> <18AA2E7887D04BD3.1773850@lists.yoctoproject.org>
In-Reply-To: <18AA2E7887D04BD3.1773850@lists.yoctoproject.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Apr 2026 13:16:39 +0200
X-Gm-Features: AVHnY4Ip1SagBqO9nnxlmIY4ezHEUB_NpwOzYDtJIp6XQsKfne7PWLZtcbRCRrI
Message-ID: <CANNYZj-1u7A9cjE6Uqyah0oaVWKBxcTe0-VLtcSzOwj=JwEV4w@mail.gmail.com>
Subject: Re: [yocto-patches] [AUH][PATCH v2 4/9] upgrade-helper.py: add
 changelog flag
To: yocto-patches@lists.yoctoproject.org
Cc: daniel.turull@ericsson.com, paul@pbarker.dev, ross.burton@arm.com, 
	yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 11:17:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3840

On Mon, 27 Apr 2026 at 12:01, Alexander Kanavin via
lists.yoctoproject.org <alex.kanavin=gmail.com@lists.yoctoproject.org>
wrote:
> Can you add examples please? This implements three different
> 'strategies', all of them are doing 'guessing', so it would be really
> beneficial to see what they actually produce.
>
> It would also be super nice to have tests for this module, especially
> if people start tweaking it further. It looks like something that can
> break super easily. I know AUH has no tests (I inherited it in that
> condition), but at least this particular part could.

I still need to see examples, but come to think of, this changelog
extraction should be in devtool, at least partially. devtool can diff
the source tree between the old and new version (it creates specific
devtool specific tags for both, even when upgrading tarballs), and
then filter the difference to only files that carry information about
changes, which will eliminate most of the 'guessing'. Then it could
write that into a file somewhere in workspace, and then further filter
it to highlight CVEs or anything else that looks particularly
important. Then AUH only needs to pick up those files and incorporate
them into commit messages or emails.

Alex

