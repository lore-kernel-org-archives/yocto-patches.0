Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A579AFF886D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 10:43:13 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10091.1777372989577828857
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Apr 2026 03:43:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=eYqV7bkC;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a58057d7baso131517046d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 03:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777372988; cv=none;
        d=google.com; s=arc-20240605;
        b=b9I51W+7KQH0RoK2qM6RKHbLNU1XCkqEHQG/nCDhgWI2/UKzqRTYU6zQcv28C6cfuA
         eKcJh4FE7Q21ctGPk2Uu+W4ZWxj4uOswzex8U+8rL+ihsVsWiOMS3qF9SODhdUws+CQY
         Vek9/T86qLBuv5Qvm9p40ndpOQzmHTUS58LGtrgYVcwN4fzd+TeSNEL6d5h70O/+sk8Q
         gYYvmd1ToBVe/+vR/mFmt/csMvcaxB7ZPjXn10VBXI3wL+Y88o1AEM2kv7bZT24c063I
         DozCeyNVHxZ+j5X827zSPmGfucpbRwdWhrlzdgD00sE4XIcVn2qCFlQItqEDkj9jdPaQ
         OuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gt18gS73cU0AwPz/PSJ/O+yzLoVJ1GCOy2m1WdTuqtk=;
        fh=5f3juoVmFZAcDZXxw6MpSCyKznmuK5IWEecktzwNVBw=;
        b=A5Ugu0sJNmmQfHpE6lfk7o++SPvgjAxUrqYLqnVUAUk3xd9/2inFKTsEWxfRzEQsti
         DSBCX2ZGIKbzQ14aTesIY8Ojvv0AYozQgNG61VILYoKixEg7g7q4m79snC5dZE0ChEw2
         0UsfqsXluzVve+q6aGOtIXGh915H5aeoZe/Pj6Y/4EKcK2yRD45/V48Ju98HG9bTUn/v
         bIEVKWiFl1wcXly6KXGfjUKpwT+qz1wtQhloDZgCNt9xm8iHpJTxn/OGqUE0NVxHHE8t
         0T21YPr+HUORIoh6aatRCyIGtS/08prHf8hdKPZYEb0kBLIMHIeeXoykSftsxuK35nK9
         yd9g==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777372988; x=1777977788; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gt18gS73cU0AwPz/PSJ/O+yzLoVJ1GCOy2m1WdTuqtk=;
        b=eYqV7bkCTBD4WKnkCcw2UCTStbuekdsGNAFRT+5zYKJPLLAb8Fh8S2s+OKchoYrOns
         22KC5dugoVZy9b1XJ5mdB64WU+W3tVs2ejdoyEOiNoU1cXIJibGwH0mF9PUoG9IPBLTk
         b55jABCC28ZsXpLNSv0GoTG4PLejEhAo1niEOSUIV8y+sTN3VoORjCMlKmLSKKndR86a
         xTtJURlgly6f8XUSMuN4jlahOx4SnAUk0N5laWe+dk80j10IvWENwx1OSJDbO96FJW5n
         gjhj8rLzJw5ZR/JSZc9l+2ebWb9e4sSxpuMRfaGN3tIQeF/kUfnw/3k36C8QKHYzFTv4
         V7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777372988; x=1777977788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt18gS73cU0AwPz/PSJ/O+yzLoVJ1GCOy2m1WdTuqtk=;
        b=fCcQwo61oPeHaoxcPOycof9V62Fhj9ajG2osWxw8AAMsS+Pqkl+PlDRv2y6Gukal0h
         hNEHWu7S4GgzqCiS+m/lmwC2j25LoaoCC3rltTarcAGOFKEp4eWnP87NjNgHXZobPxDd
         mrEk55Bb2Xu8xD8ezNlkY7Heb5GuKXeAXt/Z0f/I/zPELShnuuP1/6oa08reFcuXqNrJ
         3LKn1iGBZEWjBZtMmcYW1V27/Mamnal4LHnpgIYxGNz2JN+s6z3C37pe9TZaygElBFRV
         GxkaoPxq8Fu64C2glTZaJ8MxBPfSWzN3G5OA64Z6DfnaDlwz07ZgVgCZKqDiHUGO6V6e
         jbPQ==
X-Gm-Message-State: AOJu0YxxHIUCWHNJ9tfEPYUJ0c7ZVdwGYVUDzCrbxxryHuNQ0U33+VuH
	HbVP1Q5OWUyROj6WjIMQyIZTfR9UtVgNnF8a9muf/BQEsHu/0iiOSkZ1hzrS+goro7Hcgdikrv4
	FcFBgHn/a7/LuU4oF8IBRIbpscBWW3tHkzA==
X-Gm-Gg: AeBDietLo3N72AwOr5t/LJ4ymysXacEAasRW9KKH1Nyvd+rMKvA6CX1ZpBJ32ik2XEZ
	Q9ezJWvag0KlTj7qkKpFF8p4KM3sVzyvsbgJjBY4+igdQYSKeXs60bU2RSjL219Uf45yJW9w4CI
	BuKaw/nw6Fv/3zSSjFarSMo9mG1UlQJ+hLGscjJCTXAqD5wIxKjY68Vs+3fHuJbSWRDa/V2C3lR
	soMRghaN23Qn/71ojjXC6YEToIhMKJUCM0d/pV+b4hhOtj6iqG/ixszqHQD/6lrJrVYI3+sjHAm
	ARtIZfA4OptBq1laqWZL4oAhT6Fl8ihjir2cohu65311fRUe2CvI
X-Received: by 2002:a05:6214:5098:b0:89f:123c:4d9c with SMTP id
 6a1803df08f44-8b3e300049bmr39379306d6.18.1777372988563; Tue, 28 Apr 2026
 03:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
 <20260424114603.2444938-5-daniel.turull@ericsson.com> <18AA2E7887D04BD3.1773850@lists.yoctoproject.org>
 <CANNYZj-1u7A9cjE6Uqyah0oaVWKBxcTe0-VLtcSzOwj=JwEV4w@mail.gmail.com> <PA3PR07MB10721A91191F9AD24E138AB028A362@PA3PR07MB10721.eurprd07.prod.outlook.com>
In-Reply-To: <PA3PR07MB10721A91191F9AD24E138AB028A362@PA3PR07MB10721.eurprd07.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 28 Apr 2026 12:42:59 +0200
X-Gm-Features: AVHnY4LkPEzPvKUnaSa5JmjYrTsq4u8kbeCXz-kRNu73LyTB8CkkqPzUtsiGpZU
Message-ID: <CANNYZj9-GVM=o4b4XsF_-=g=GdyhV6qe+PZe7bKofG=HZRTgmw@mail.gmail.com>
Subject: Re: [yocto-patches] [AUH][PATCH v2 4/9] upgrade-helper.py: add
 changelog flag
To: Daniel Turull <daniel.turull@ericsson.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
	"paul@pbarker.dev" <paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>, 
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 10:43:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3866

On Mon, 27 Apr 2026 at 15:56, Daniel Turull <daniel.turull@ericsson.com> wrote:
> For now, keeping it in AUH lets us iterate on the extraction logic without requiring oe-core changes. If you prefer the devtool path, we can put the changelog path on hold

I absolutely do, yes. Devtool handles individual recipe upgrades, and
extracting changelogs is a part of that. It also has actual tests,
which massively helps with having confidence in adding complex, easily
breakable code.

We shouldn't be adding features to AUH just to work around oe-core
maintenance policies. It needs to remain short and simple.

Alex

