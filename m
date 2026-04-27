Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC60FF8861
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 10:49:11 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42544.1777286948649451874
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 03:49:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Ib3bJeyz;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e614fdb42so78229481cf.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 03:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777286947; cv=none;
        d=google.com; s=arc-20240605;
        b=Qa0uPihAs4rZp7VvHFvl3TKYCpk1HBwLmzKgvHi1+2UIIwn1bzeNZ8pTXevK3VwbbJ
         lIlelXEbz/LcLRJ2M1xQGw4/9b1SuSnmd1MHaAzYAiyJC3llBARZhEAjASEuYDuTDt3y
         znyksqQvr8e71NVspLLsnnugIcIIRSSpy6gZfFbnig8UiQzwStudmeAXsONQT+bSS8LR
         jce2KUN5JQhlpykXMQ6diPXR2hpXgXmRQPAZ/VPKi04cnIsQVkwcnOpHKlnhRQQ7vmW0
         7OE2L30HZSPZ/Z3kqtKvqk8YOs6Ka+9Fe1mU8OmvW+4s9Buxjd/iGD+ZUXnmZdlJRwHp
         P7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FyheHrd531rG/8f7+p8OSo70HcrtHTPT7i1PF0Btp0Q=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=I2wlE/17mvSgIztMS+GTMEQ8bMRXgkzRQpwbXhL4M7Pki3jUSmlSUPrmGF0hX385fn
         BWsNbnMBdIxGuvY9gW4NFz2Gfbo6iwLMHwmYyA0Mk00qFak8Y8r7QxlrZuASP5ZyLK2F
         xieTTf7j1JeyDk3ERVLHEePGjwPivQ0YCTJ0nWb+R81WhD5QNJOy8OIsjV2xARhBQKaV
         uyhvjwGRuJuPJipSIfCLxMoAaqK+9OplklBjuPrUCU03J1dO2jQcnnJvaLc0sxGN5Q8f
         V81iDhpc0OgoXp8BeLI63VTfdVd+QAX5nDgz3L1+cCRQB8vaBbXyCYZ/amzOV8sVKVHL
         g9qQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286947; x=1777891747; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FyheHrd531rG/8f7+p8OSo70HcrtHTPT7i1PF0Btp0Q=;
        b=Ib3bJeyz2HpbQUi7HGnw2bXfS7lVZkoOrhnuQd5Mm25wr4R45ZxGKRyLVfNHLMYLnH
         5otd+lQBrdnn66MOSWo7oH5iTjTNt/jKYw+hygHyma/nGIVd2mV2IEOzqOUwzW4cKbAn
         CcqlZM26ZdyQ4agl2j+yU+9x94s2ISRmrMGcW6m8kFjFozn7+NABL5yzP6yPK58La39E
         6BJDKB3EmYW/avO3/RnDhLM95pQR1nWX0kLYOMaw5ZimxQJIRg2K6MQBMsHH/UiC9U+E
         CuHWX80ltzWjjXr77dHTuidIsFPyGLT3BKfEOuMtigGFnxGz1Wuob/cNBwcYP9gkFF/R
         XMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286947; x=1777891747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyheHrd531rG/8f7+p8OSo70HcrtHTPT7i1PF0Btp0Q=;
        b=Mf1lH1p+qUZAanRnAeIDRCsnCDFlWBaQ5+i5qCxfo4SSOnVZnvAg4uqKn13KoehyTy
         D7O31ESwh7fo55GtEnRDSAaVQIietntEyWv/Z7bUxiY1+R0uBurq/QswD3PUomCfcgF6
         3glQaupgNh3tghtUIM7swp2Y8Qtl27CupZmRYxS3KnxEOEqpJzwYCNQz6Wwxhtnio3MK
         L1LNd3ZtR+imGFeuCQzxIh2t0QNu7/TW1CCgHPfDB8cHuQxIzVlg9ZBYcUSQhRAagHWh
         VvRGD6I0Pq6Jq7S8ou4K90taMM54udA4A9EgbBO8aCzpr1MH7FcG785o6T+WzszURBgW
         Pbdw==
X-Gm-Message-State: AOJu0Yyq9aEOzeUQ+r4pkEVqAbAsYQhoe794JphwHOLdQxfxXjhGEW2n
	kLHM7B96jNrrz2MmAUA5Z4V64JDokbCmNVcU618Df/HmPSF850bzXpyyvmTy/rifnrVUIkqJJBv
	8gzB/9nayJLHK01IhKHWmKJ+KV6I28o8=
X-Gm-Gg: AeBDietokwL5h0c/J9y0qfYOydwv9cUj3qG7+PHwTcYH5Y0xEnEZxISRpjtxqCYZbjV
	U3zs44cMVSXhgKNUSDhaPPO51ZEMNmeOK5Zraj3ItQogSW4keOjxq1rM7hvzBi5T+Vto7771WTy
	d/gf8ZsRo5Uz0pIBD+BvOJWfotgMXm6buAmVTySOvXbj86DIzGhkyz5Fzt8XvxrpnoR6LqCTDFu
	PKnFRHVnjVbVHBS1E82G1LujkUfpju4ZyxvFt9dLADDRiw8+q6rKUFdJIQHHRTgpPdMo9foNME9
	/ylpIOg1tEEpuUHWv/w/V6yisYGWdg4A2pTa7dxHRHXtgwEgR0sV
X-Received: by 2002:ac8:7e8f:0:b0:50f:817c:5d45 with SMTP id
 d75a77b69052e-50f817c676cmr437752551cf.23.1777286947520; Mon, 27 Apr 2026
 03:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com> <20260424114603.2444938-9-daniel.turull@ericsson.com>
In-Reply-To: <20260424114603.2444938-9-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Apr 2026 12:48:55 +0200
X-Gm-Features: AVHnY4J1eLxOwFeTH1eTNQ8L1m61ejyOCcecLYlaQ1kiE0iCsHeKGda_Lx2iqog
Message-ID: <CANNYZj9k84O+4u9ugAwV1D+S05VT=TGBbx1Bwft9qxG-u=O5bw@mail.gmail.com>
Subject: Re: [AUH][PATCH v2 8/9] upgrade-helper.py: Add resume option to skip
 already attempted recipes
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 10:49:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3838

On Fri, 24 Apr 2026 at 13:46, <daniel.turull@ericsson.com> wrote:
> The skip set is built by parsing 'Upgrading to' and 'Pre-build FAILED'
> lines from the previous run's upgrade-helper.log.

I wonder if this could be less brittle? For instance the skip set
could be built by checking if the upgrade output is symlinked in
failed/ or succeeded/. Currently those symlinks are created after
everything is finished, but it could be done directly after each
particular update.

Alex

