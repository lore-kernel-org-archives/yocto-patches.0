Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DC1CD6E57
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:17:49 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12690.1780355860358939273
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ed1u1/GW;
 spf=pass (domain: konsulko.com, ip: 209.85.210.180, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842338c18e0so1277755b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355860; x=1780960660; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aj5mIolDKcN2KB0R0sZ7e7PSkpjyouxwZ/MqiYFx1kY=;
        b=Ed1u1/GWYyQJmhR9LF196Kd/3mOk+gWjFztmtHojEzhKzpZuccvTGsIpJEyNFsxBn7
         lBRRiqRm7OOOm/0uGMBSw8JEcj+/f69fMfmAvojgv2dvrG1q/G6Aj0doteoVze4CGI2z
         Vk9Ki5svToyue8MrXF+nQJU2QgAOwFodSpm4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355860; x=1780960660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aj5mIolDKcN2KB0R0sZ7e7PSkpjyouxwZ/MqiYFx1kY=;
        b=fwTVRiUFu3sedPMA06tA/OA+GREfVL7IQJZkUDmfcQUSWYNAylzv22sw6BPRZ/XGed
         8YLYZJ4nf3qb+7YnjRRFfRPw4j2158hkQVIEJt1l20/wg13c5ICQhkECn8Wcbk3YcJa5
         B5333N1M5JBuyMPa6dmp6F4F1tinO9s5gZ/JhD74//UfwGQGp6nwkjEkutxXS6NINjOd
         r+igcl9ICDOH4E4PH45DcirG2Zl3GCuSOHFBj7/V1G2nHtoX7k8P7lDT8DoT3aaUfdPB
         a7Mh6JFrTfmG7O99dObkO3TN/cSuPlg6KLdSjwwcdi1/R4AA87q/DUIq8thrgFONzHTh
         Lqlw==
X-Gm-Message-State: AOJu0YwI8fsBowvCNJcKrkcmBu2hhW0FUNhb0Lx48DmI3MqB1vEw49OG
	TkgBEvpe8uqfjE/dvcppj6nc0KWwUkuLtSWCUjs+FkNAB1FlHEltZenDCRhj7MvU/o1nH8Bhfvg
	lbGeh
X-Gm-Gg: Acq92OH6XceK+BBDPNwb69as0Va5JErAqCFwfJ6h+qShcxBbrLGGyfhJVPjeI6r0ukc
	CdZ39YDjA5u/7MYGivIKBI57+f/5fu16gUnIt84bGq+QWUFLrmDqTZoK6JcQ65XN/+hkCfZjC1i
	MqrOoN0mgOaGOmpwNeH/omPrlVd60Lzcv87kIa/0aAwZ8cTGrmbMrg6m74qOSJPuiduWdLaDRZD
	6lBv4Bmco5GqnQwYwME6CsQhHqKhqFZMr6ZgHgYCre9HiJLfZbECkUPsi0dxKHmFFRgSOqZZNEz
	pqwp6fxEnHOaXdpsvrksQ+OYNcxa+J61cjSWCa11fEiSCXhtxgO4LNHq9fJOu98tpFWbCHp0iMv
	1hj3ZPL/4zaY3gEh5IViGG9ksMZr07gim1qGe0xlQohseeauFuLXOk93gsZXw4XZKNt3iVSsO96
	6Nd9Fj0l609HP4+xUuKl3aNqUhuI9W2Ihh+iPcgMODxDyd8S/3orAYIWh1t2byBuUNXVPNz4CZe
	Q==
X-Received: by 2002:aa7:88d4:0:b0:842:7221:dbb8 with SMTP id d2e1a72fcca58-8427221e258mr244017b3a.15.1780355859592;
        Mon, 01 Jun 2026 16:17:39 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b00d64sm11196957b3a.10.2026.06.01.16.17.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:17:38 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v2 0/4] Implement 'containers' jobs
Date: Mon,  1 Jun 2026 16:17:25 -0700
Message-ID: <cover.1780354388.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:17:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4092

From: Tim Orling <tim.orling@konsulko.com>

This series contains the 'yocto-autobuilder2' patches to enable:

* building the 'vcontainer-tarball'
* building and pushing containers from:
  - meta-virtualization
* testing the 'vcontainer-tarball'
  - vcontainer-tests
* gating pushing of containers with push_containers property,
  similar to the "Do you want to deploy artefacts?" boolean.

Changes in v2:
* Simplify by submitting containers to meta-virtualization and merging
  meta-yocto-containers-demo build/push into one containers-library job
  - Depends on resolution of https://lists.yoctoproject.org/g/meta-virtualization/message/9826
* Simplify by merging vdkr-tests and vpdmn-tests into vcontainer-tests

The following changes since commit a999d97e0aab0059ee6dd25432740660511e6db2:

  builders/runconfig: Terminate release builds if output directory already exists (2026-05-26 10:57:08 +0100)

are available in the Git repository at:

  https://git.yoctoproject.org/yocto-autobuilder2 contrib/timo/containers-upstream-v2
  https://git.yoctoproject.org/yocto-autobuilder2/log/?h=contrib/timo/containers-upstream-v2

for you to fetch changes up to d56d939f7c17488ad09889c92cd21298defc4f0d:

  schedulers,builders: add push_containers property (2026-05-27 16:13:27 -0700)

----------------------------------------------------------------

Tim Orling (4):
  config.py: add vcontainers-tarball; containers tag
  config.py: add vcontainer-tests
  config.py: add containers-library job
  schedulers,builders: add push_containers property

 builders.py   |  2 ++
 config.py     | 12 +++++++++++-
 schedulers.py |  9 +++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.43.0


