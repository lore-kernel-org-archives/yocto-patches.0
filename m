Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EC2CD3427
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:00:24 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4497.1778205619378677029
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DUgxelmA;
 spf=pass (domain: konsulko.com, ip: 209.85.216.50, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36643b96b99so425676a91.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205618; x=1778810418; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jbmfj10r2FcEmyyBMaXxvJEJFQsVeTvDHQIU9+bPbzY=;
        b=DUgxelmA5RUTnMmXnqh6qHa0EnDHsXuwgyOIS6xUm1qvnES7QD2KyZXSRs/mdSrqZY
         zk+4jagC4gaqBWthEadxPML2/psdek38h2jiTFj60x2LXCCAOBkJK6UJ7xF2DhPgUboe
         tcyDSSm8oHmYMWETYNiTOlVTOflvp0Wo6b0mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205618; x=1778810418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jbmfj10r2FcEmyyBMaXxvJEJFQsVeTvDHQIU9+bPbzY=;
        b=QtIsuDMlYqRkyQMXqBT8inqUOtXjd+XW6OlReH8vbcrTQ9QKEWB8Xit1M261UIWSKw
         rNsHFzCC7DG9NOJnUkXgLVLmJr8/dkVlIWDEsKaAlsq2ZEOs4ovyDunDZPztuXNtPev7
         BGX/1n5B+5qt5UOmlI37kuq20wmRCDCsP38o8OYNkc46H/Rvg22sHuXfheW/4QH98G5F
         MSBrE4ml+3ryJP3tyd9FOolZyDsvjEZqCm8ovlpl6Vj53vZY8lkytRyaQ7FMy4DdzOQ0
         vcKJeQNHJWV5tdhjQPFcXazuUFcHWw/jyYb2dfHFT23hvHyB/4KP9VkocwQEIiWKMhMh
         nw1g==
X-Gm-Message-State: AOJu0YzXD/cJMeRD3rKTaNCwLWLuD7/h+B7lZwFFpzVRkZtGchFDO7oo
	EEI1dHrWGl+Rw/w5IPYcymlCqqGyH14T3jMCCN+LRrERG6hH0e8fI09Tmtncr4chQK7dF9jWMr2
	t5G9/
X-Gm-Gg: Acq92OGA7k41n2arNM/FXUZN+6jC6+0SkLvoj4s9v1x3LZCr7duspm1Jv7Kv6jgJgWm
	EKZpVZaK/GHiPNgORQ4VLb1r6loZXO6AzH/+1y3IUsShnX+MjUfXx71cYdQ7dvSfwaj8QowxpYB
	csi8MMY1j0ESHzqvc0Imu1qJIvjlAve7EoNGATsRJfP/Lq8sx6fgRnw/l4Titbmrw0inDxvS5t7
	dKCiStFHrGCD4bNOGXKibeyzWD3hsWw/lIofETUcEoKYmS9WHAi7bBn5jL7CglBLIlF06BC9nKZ
	LU4ECuB0DcAa4OU4V05VKd/NZT8X3NxgvZzEw1UqdZcVMYpQg/1+SguhUbDD8aSa6F/W217Gt2/
	qSZdtczwlYTjoeqxT/aEl1iJcqVdtcraGoq98hmX5AlFU9PgKlR9ZWCOluFfKD1pwWBNToAF3Fn
	J2NTUMS8lFt7rm551tZhuuNL/3LW5G2P1vkWKRGnHIGp0ICItNkgnNvXY441ttgx8=
X-Received: by 2002:a17:90b:57eb:b0:366:132:fda7 with SMTP id 98e67ed59e1d1-36601331e37mr5843705a91.10.1778205616489;
        Thu, 07 May 2026 19:00:16 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664da40df8sm226757a91.4.2026.05.07.19.00.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:16 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH 0/4] Implement 'containers' jobs
Date: Thu,  7 May 2026 19:00:02 -0700
Message-ID: <cover.1778202070.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:00:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3934

From: Tim Orling <tim.orling@konsulko.com>

This series contains the 'yocto-autobuilder2' patches to enable:

* building the 'vcontainer-tarball'
* building and pushing containers from:
  - meta-virtualization
  - meta-yocto-containers-demo
* testing the 'vcontainer-tarball'
  - vcontainer-tests
  - vdkr-tests
  - vpdmn-tests
* gating pushing of containers with push_containers property,
  similar to the "Do you want to deploy artefacts?" boolean.

The jobs are associated with a 'containers' tag, so they will be
grouped in the Yocto console view.

The following changes since commit 80ce858b499f7c91cd7a2a0990f6e28e879f0fca:

  schedulers: Add wrynose scheduled jobs (2026-04-23 22:44:34 +0100)

are available in the Git repository at:

  https://git.yoctoproject.org/yocto-autobuilder2 contrib/timo/containers-upstream
  https://git.yoctoproject.org/yocto-autobuilder2/log/?h=contrib/timo/containers-upstream

for you to fetch changes up to 9ed602f7dfbc72d96966167a1114dd23aa8b3ca6:

  schedulers,builders: add push_containers property (2026-05-07 17:22:40 -0700)

----------------------------------------------------------------

Tim Orling (4):
  config.py: add vcontainers-tarball; containers tag
  config.py: add containers-meta-virt;-library jobs
  config.py: add vcontainer-tests, vdkr-tests, vpdmn-tests builders
  schedulers,builders: add push_containers property

 builders.py   |  2 ++
 config.py     | 23 ++++++++++++++++++++++-
 schedulers.py |  9 +++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.43.0


