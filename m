Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC6710BA451
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 08:59:12 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.67734.1774601948407624523
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Mar 2026 01:59:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Bb6sGvoR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.176, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38bcdda57b0so14214131fa.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 01:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774601946; cv=none;
        d=google.com; s=arc-20240605;
        b=Unxfz7TmK94q1A1b/moCLz1RZO9dAIgjJyPqPCaagqBehejmvSkMswuH5pUVxCtNYR
         vI/a5eFdIwo30mpbTYVTZR5LQf3OyUwpwQbKY9ZMOLJeX0pR8ZgUAgcma6iVqvYTYIID
         lWeNyulO3uJ9Gu0XNkK06eLzwF4mASKWhjxVJctJUTqi7H2M/Ha4vj9LYXYDEWIJFYHu
         r4vjpc6G2fDDzHpHm5gyt8suTA618fj/OnyF41v648P8HaNYxYuXrF2DMYiswV4XlEi2
         9Ea+OvMhDxEvtwU2X2bj+rEvhYDDfTWAh1uvAGGa+f6HRSwMqJlHpbiiJtRGQpQVEPpn
         ZrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1+ycCPrifvzqUGzu0H3+gPBuo8cq1xL7Hlk3NcGfvsY=;
        fh=DNYDzT5n8z4iPmFfkNVVDKAFI+w2EZi2Bx6GkXUrPvs=;
        b=YlO9rHCzctxWFZtG0h9ZD1jeKltBseYKUAW6dXmuoLFNlTjvliJTiHikrGLZIw7HmV
         u467Ky7X4o8dr2x5fAegiL8Twntc+RxdYhlEpaLvBI9xEtTl13sqHYWIGw9aHpjZmWwu
         qGvNmE/WoEuSyDL/XNtpt6hjWisLDylk2BxNC/FlWo6WWNzRfAw+dgAMMKuEP/sDs/h+
         hlSCwmUUh+UNcuQJ1ubW4UzbYFEGRu8cgx4gVnPiEr927ON9D6gMz46LkHOqOyojXPYp
         olpRIJYTZFR2G5jk8u4fCd/82vXCql3Z2gdMNM9BvwoFnPikul0lRo18LuYq51wll+NQ
         IUHw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774601946; x=1775206746; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1+ycCPrifvzqUGzu0H3+gPBuo8cq1xL7Hlk3NcGfvsY=;
        b=Bb6sGvoRr4/S6l1LpE4X92FmZSEuF4YJrc5HmKJPhneZYxWG6+V/W7snNbuFHLxI3I
         y5+E8LLJBKSpQOOEaRAVrNxuYO77GdlBzZ9p3R5qR7QoU7gxt5j9IG/TrX4gWsVdrb+b
         81axClqeUidLdAscEeI1K/PcZd1P5rBHA1y5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774601946; x=1775206746;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+ycCPrifvzqUGzu0H3+gPBuo8cq1xL7Hlk3NcGfvsY=;
        b=DPU1ditZAjNo1D3e2Hd3ecNDm4grNs9dYDfEXynMkrL6C29CAuYiY4+QzKPCIghzCh
         GAnYNnDeKXN1HiWRCzYw4V4L8HlFIIhkDkrb+iXyacWvD1qSNPQQY8aYMo+rnCDwtj94
         brFvI1gKaCJ74OlagTOg6QBkpqJZNByYzxn0JIzn/2deerOJFzqV/4vuxGg/xMxa4zdD
         Eju5mcjMD6L4d81cNuOgSDe6sUGDQ38Yuc+G7cOAlP3XxH3nDLxwWOZVHiLexQkyWeNH
         I1oQLAb1vOp6k2YUfoZtQkzGthxYlMDtNuAAippFB2/vrK/edGetIbZkHAZk6d1w6Wot
         m4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSB/kV2ZmWBX+W+U3BPf1J+i9qXZV1K3bOdK04J4UQbJHTic5ziaeovqTx//Is9aAIqMW6Jq6PSelusdh6@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxNGm/qLJaLKCirUQYxOG6ZJrYVJzZxlMZE/ro1N5FIOw0PQ1QQ
	BViinAiolU7mGGo8JQUijKzuQ1IpiiD+V/Mb0NzV+sRccBDQqE8tq223sloIvvGHwsoZx4y/Z19
	OHPSEvZhGHT2BnG+xG+B0CGlCsY6qgkDWKzQdP/LBoQ==
X-Gm-Gg: ATEYQzwJXb5qZKA/XTSVUzGSHdCC4zCB7LoPCgFUMOBU3svfb9y5TjQgLsAKruyOuku
	0TfvSqhHv+XgNROG7pp7H15yvLPjh5yu9kvqH9hnqXT7oCLF9AdmXtBPrznwDrrCMt8HznkJpWy
	1NrGseKNFmtcklJNLKHL29BuTW4Vu69PJcAyjHwQYiDRDM0wxKiEBZsz3J41IwLL31gvJfTrD/M
	q5AE/xvegBKS735nDQiphF1gfDiGis6DwwjLz4bTrltjrx1/3NXJN9qlwAT5APhXQmT9sJZiW8G
	bEuIWA98dvCtUBj2zhda
X-Received: by 2002:a05:651c:41d4:b0:38a:5584:cea2 with SMTP id
 38308e7fff4ca-38c73106e37mr5695881fa.3.1774601946374; Fri, 27 Mar 2026
 01:59:06 -0700 (PDT)
MIME-Version: 1.0
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Fri, 27 Mar 2026 01:58:53 -0700
X-Gm-Features: AQROBzBq2Lp86M3l5iEcDH43NO8gwtGW6XFVllh6eNEtbfVodOeDHqFt5EjPulY
Message-ID: <CADfgfobj5xkU4ypgEq5YQU7T3NNzpVqgAENvZXE5nFvKX0aizA@mail.gmail.com>
Subject: [yocto-autobuilder-helper][PATCH][0/2] base branch names on branches
 instead of tags
To: Antonin Godard <antonin.godard@bootlin.com>, yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000a1b286064dfdb649"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 08:59:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3562

--000000000000a1b286064dfdb649
Content-Type: text/plain; charset="UTF-8"

I have pushed updates to the following location:
https://git.yoctoproject.org/yocto-autobuilder-helper/log/?h=contrib/halstead/master

This change updates the release-parser reference branches instead of the
branchname tags in order to remove the branchname style tags. These changes
are needed for docs builds to complete successfully.

-- 
Michael Halstead
Linux Foundation / Yocto Project
Staff IT Engineer

--000000000000a1b286064dfdb649
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>I have pushed updates to the followi=
ng location:</div><div><a href=3D"https://git.yoctoproject.org/yocto-autobu=
ilder-helper/log/?h=3Dcontrib/halstead/master">https://git.yoctoproject.org=
/yocto-autobuilder-helper/log/?h=3Dcontrib/halstead/master</a></div><div><b=
r></div><div>This change updates the release-parser reference branches inst=
ead of the branchname tags in order to remove the branchname style tags. Th=
ese changes are needed for docs builds to complete successfully.</div><div>=
<br></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"=
ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Michael Halstead<div>Linux Foundation / Yocto Project</div><div>St=
aff IT Engineer</div></div></div></div>
</div>

--000000000000a1b286064dfdb649--

