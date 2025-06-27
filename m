Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25638C83000
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 18:46:39 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.699.1751049992493893707
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 11:46:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=izKKCdnL;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6face1d58dcso41410336d6.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751049991; x=1751654791; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxbEQA86uwyM/Ofxk2MP5yBxdfWbbC7ztpzPGjdJi0o=;
        b=izKKCdnLUl9/A2q/tLFiGUDpf5nYAR5xBKRH1KEDNBg3iUvcMc6AcTrFw1A0GX5lB6
         ULillgPlxAayHFcDTMNVElyBUqil3KTUQS6lhkqGOrd66tc8tHgDtiaHQikcdyS3Lsa1
         z+6uAHbIxyGiEBajSuW5+A9312eSxai9zQ5kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751049991; x=1751654791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxbEQA86uwyM/Ofxk2MP5yBxdfWbbC7ztpzPGjdJi0o=;
        b=Jnmp4ZJbgnGk0OtJ/xed1iwoOKLbhkmqgPojMWZWSxbF+IB1Ds4hAgin5Bv1n6eOQO
         EK3fPIhENOd1ShHF7AwfYuW/fUkmNHwlYsUhzfTThA/a+xmh8gFrQ8sUKsihgL5CTys4
         3HzTS6Bu/xK05f8G4Gm/3I98sZef7IZKqU3bOaguYXhWgm2C3q/ckfDw+Z6AXU/sVtEw
         BPOBfr71B06oMOdV51aI4YFIQnF2RRqOM0zpbg8xbcvS4SZ217cYFuGqc/NIq16u7iOe
         T5bEPd7gdN+CKYEaGOMU+gFPFDNCjcNGoI22fztczBvem4k7OqsD2hgVji8UE+zFR3bV
         8jHQ==
X-Gm-Message-State: AOJu0YzYNn64U13uA0R6XsHrgZdlVDpT+oNbb58OXVTRlxt276h+5m4j
	xaG7oknMkZD1YG3ZLCzsfYXdcCtbgJcwprHsqfRFKRN1dkMhQzjEZftP+jbeiunDxuau+BMj+41
	yBDql
X-Gm-Gg: ASbGncs610L780mUbezrqvDLHN2+f8h0LebDf+qe4ZKLagRVH45WK7gVDaUoFVOzZ9H
	W3xdr54bDeJU/ts/9j4+j24N+OBMeqMR1kmBGhtypCeyoxdvU9GH0oXsTJf/R7KhfySLA/ZROI4
	7UAQx6usFTj3lpxHfZlLEIna9064jYv2rgB8o/87BrsjcVO+nutcRgq1CpXQwoKd3EJu92D1k4J
	5MwuDmxB1FmtEg0WxIWskZ89ZG44BWWTnK5KdyEPfe1WMJfUKcPIM8nVg/8PoWqXfycejjkRox/
	/vDVtxoaly4VnIuAuOL/SRWcYws6oq7+NZ7BxzsGi+en9QobpYWdjz4KMZjod5rAbfoHzoMMuSQ
	MJ53pk0A0tG9XWQAJ8/uebQNPul57urkjzNS3pQ==
X-Google-Smtp-Source: AGHT+IGy4RsCauu4HiJwz4wOZsgviHb1pB8WuhKaX4ET/3e3hxbGXjhLDFfi3RFK1Nu9au65hYADpg==
X-Received: by 2002:a05:6214:2243:b0:6fa:fea5:4d7c with SMTP id 6a1803df08f44-70002ee6da9mr76907926d6.40.1751049991188;
        Fri, 27 Jun 2025 11:46:31 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7730ada5sm24979316d6.110.2025.06.27.11.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:46:30 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org,
	Marta Rybczynska <rybczynska@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [meta-security][PATCH 0/1] Update meta-security maintainers
Date: Fri, 27 Jun 2025 14:46:16 -0400
Message-ID: <cover.1751049467.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 18:46:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1723

After discussing it with Marta, we have agreed to co-maintain meta-security
and the other embedded layers that Armin had been previously maintaining.
If the TSC is onboard with the handover this patch can be merged, and
then we can start addressing the immediate concerns like whinlatter
compatibility on master branch once repo access has been sorted out.

Scott Murray (1):
  Update maintainers

 README.md                                     |  4 +-
 .../include/maintainers-meta-security.inc     | 72 +++++++++----------
 meta-hardening/README.md                      |  4 +-
 meta-integrity/README.md                      |  4 +-
 meta-tpm/README.md                            |  2 +
 .../distro/include/maintainers-meta-tpm.inc   | 32 ++++-----
 6 files changed, 63 insertions(+), 55 deletions(-)

-- 
2.49.0


