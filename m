Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C76F4644E
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 11:05:00 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47812.1773659100471461913
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 04:05:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CEW4nFwP;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89c4f7f8650so14601136d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 04:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773659099; cv=none;
        d=google.com; s=arc-20240605;
        b=bvHlhM8feuA/U6udzAfn+/AbWt05AytM/3rQuDp6k2EDWlUsRkdnPwBPjIFIUdDvq4
         TQA/VwMl+E7mjZ4sZWNzCBlmBysy5hypuUCyQFHLy5z887gc/F0Ko5o0XrKtzUzaRdxR
         2taKE0mL2bSWZugrjX04P5AQ3AAJAIUccVoOaVB7xOVz2+jqL8eSdwyuj6Ry/6Kva+Cr
         w+a4BNkm662v+kae0JrclatTnlIHkXldFZF7YDhJg8UE54DV1Wxmfjo+YZ9GCal89vFH
         tU8N6cp80fPMVDIvPVJ8bl3nuA4Is0/vICGLG9bNjnKmd5eaZocB08exvD7ku2Jk/S3p
         kJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NnI9yv+5FV4s8S5cuozma7xQi93ydTj0dFD429xbvII=;
        fh=JxB+xQQzxzn4TJjBaUAIIoi4TXXQzOwT96M8B+ERoSg=;
        b=V/j59wCVgzcx8pZieLcZM0vq0pq5revws/VaJOQ7b6Xk+H+S0bsqrzJOGk0ZcZXrpE
         qR7T2IoSnGEKEUryP9waJQQ4Z6iWkxp0qqvWVxL2vK2o2bO4P+DSC5Hwj4FkiKwc1hlo
         FU6kNdpZDSB58b+eDc9ZYMG1xNp3ScDJooWbWdKuiuB8zqtG7FQXBzeuAPxAgKBK5FW0
         G+05BAXZge2aQM9UpDoOyZvNAjHYtVlfBRDN3WhXbWWtu4h+g4qUTRAvj2j2nloC9uoD
         7MT+jjGTJI5Qhn6MO6xXZ69o26ggjfigYCBLpuchtua3lJ0+PrQNEGjzbxulW71I8nA+
         nWdw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773659099; x=1774263899; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NnI9yv+5FV4s8S5cuozma7xQi93ydTj0dFD429xbvII=;
        b=CEW4nFwP9dzh9G2v7UVOwCN/HfzVVGZGITn6f5bdazR+YpB7snMYuJnvo0iN5MuoLA
         gcj5DjUtO5ocHNelkkJ5AWjRTh5z3+QKqmd2/KNBiTXCH5sb8Nl81DBAOypBwW9TrdwS
         GRyJLmJ5mbIoMArn/HR3Wh/9yy15U7bnZSuCyXSEuL1nohPkgRtPSnnK0pgiR2ObPa1B
         eyFxC/EtSdsVHO4LaSICmtCgdC7p9e3ptoxomDSdgATGkTJ3LCl/3+EMQHaWvXne0vXx
         v/gSg69fzbcsnDpe3kaNU3SeMW3UNfIWMxBMK+pUaEtFVkiz6XXYwAF8VYG5GwSOpSUf
         2E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659099; x=1774263899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnI9yv+5FV4s8S5cuozma7xQi93ydTj0dFD429xbvII=;
        b=SZ/umV01c6YW6j0FaUDjU4nRRbaD0BHuCuk489Rdx5M44dkQJAMud65LsNgfbmObm/
         x044yqFNU6fHWk3h2xmjXZn51sBBCGNSDW8S3TC7LxeXo+iV0U23N1hX8t1A1iSExzu/
         R5faJQyargX0VooBe63rF2wrB3P4cjnsHzyrgpWrItadiORQCAwvJPuSVZ4Q2sqFwJGO
         8TWNQZAre3oM+1HEfyktIwF54FvKq2rbpVkXT/pfY+aPLauX64gMJWfwkZIA23/eTEdq
         xZfF7JHwhKpfHiLEM6TEecK+i5Sio8XFlO0P3GS/8OHNF9apKmaykRQ51jEoTUFy6jgL
         rdmg==
X-Gm-Message-State: AOJu0Ywr+ExLfJ4z3ypQrd3NM97YkWXxf5NTR/ZFPo4ZOcE5CPWXYamv
	ZYxHSC5le0KaZRPsC1IVU+qgYvBVbTQaAjBuAPqSrIIO51KbX7rCXRfGJqQsjxpaOVKCm/IEpPM
	bdoFvT8rq4gSIeUyI6nsMWMN7jLY9Qhk=
X-Gm-Gg: ATEYQzwqHfLSxTA2+Hni64AT6f790mEXUSQNPFKbg1bg9oLt3mE6qdY2un1pWKprZyA
	4wRToBR4FZesZjsDskkCPXhS0Izjh9U0QTtCYBeFaBUeZuzkTyhffb/WlLK7g4xD6xvdBJAALQ4
	Vblh3LaAFCO18VFVEXEbdXewTJQNhPqGJKV+khdztjHpc3qMiLSrvRhTyrUHrdPu1civKp5m4zg
	87EzKv1fmvWZ/CmXCWfBeRL8SSY7KA1hMvt0wHMZNaASCulOxbgAI27JbsmdYk2MzBq3bVekhXr
	lxc2UB+MXuu/Ovmj9ROYLNLSWSEZux+Mw5wvmXOgYA==
X-Received: by 2002:a05:6214:124c:b0:895:7864:f69d with SMTP id
 6a1803df08f44-89a81f605femr183259746d6.40.1773659099357; Mon, 16 Mar 2026
 04:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260311064813.619683-1-Qi.Chen@windriver.com>
 <20260311064813.619683-6-Qi.Chen@windriver.com> <CANNYZj8ZA0vN3FuUNaUktXvL_XpFm_GT=nB6g0KJQCz2Yx-5eA@mail.gmail.com>
 <CO6PR11MB560222D0F854CBBC58C8518DED44A@CO6PR11MB5602.namprd11.prod.outlook.com>
 <CANNYZj8u5mVc4cjpsDeDv+L+PPt1rrsUqzPsvUHzsniKeFzuAA@mail.gmail.com> <827fea73-d96e-4ee0-ba19-7da4a1e58b87@windriver.com>
In-Reply-To: <827fea73-d96e-4ee0-ba19-7da4a1e58b87@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 16 Mar 2026 12:04:47 +0100
X-Gm-Features: AaiRm500_nLu-t1shy2xl3w-jvtBNBfESJScnOfk1A7qIg9PePN-xC3shhxp2Mo
Message-ID: <CANNYZj-k74E6WisEG5cnrWyjV=J92Ve8O+LOjr=fqyCuhrcKFw@mail.gmail.com>
Subject: Re: [yocto-patches] [auh][PATCH V2 06/12] modules/utils/git.py:
 include repo_dir information in the raised exception
To: ChenQi <Qi.Chen@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org, 
	"MacLeod, Randy" <Randy.MacLeod@windriver.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 11:05:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3471

On Fri, 13 Mar 2026 at 04:10, ChenQi <Qi.Chen@windriver.com> wrote:
> > I applied and pushed all 11 patches from v3. Note that AUH does not
> > have a test suite, it's basically tested twice a month by running
> > updates for oe-core, and fixing any possible issues after the fact.
> >
> > Unfortunately AUH is prone to even simple and straightforward looking
> > changes causing some kind of regression in an unanticipated corner
> > case, so let's see how the next round goes, and I'd appreciate if you
> > are around, if/when problems occur.
> Of course. If any program occurs, please let me know and I'll fix it.

I just went over the latest AUH-made round of oe-core upgrade patches,
and I'm not seeing anything unusual, so I think it's all good :)

Alex

