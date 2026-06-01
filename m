Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B467CD6E61
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:18:29 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12803.1780355902160640955
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:18:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=asdkbXnL;
 spf=pass (domain: konsulko.com, ip: 209.85.214.179, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so13117875ad.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355901; x=1780960701; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/PapTO555Zbtj7dGETT/4qUfocXXoHmtyI+DW+vSLI=;
        b=asdkbXnLbIvi6rDG7/WXVIHz1lMAlVYXLOJGEeCvPl6uWrhd0F8KkLo5I52RM/PUrJ
         FuUED+Z/OdOm16VbpyYpzPqEK4iTys6vkthENAGbdZi3wnFhrHg1QrvScjYda5WtSDjz
         GPlO/ABOslQhd7zjT3Ie7Zp5TWWWvo41SssnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355901; x=1780960701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/PapTO555Zbtj7dGETT/4qUfocXXoHmtyI+DW+vSLI=;
        b=jeE11PKEauVsW6yN3JrtqwLiDpYRPIKOYXXHpT4UJWBSPogCOBXYBQtVGZm24ScPYs
         nwBM6F8HT4gCPpGie4MKAzc49xBGiRChNnlSX5qhFtXStWnQXIGHZiybBuOq7UotLZln
         SobRMpSIJotH8CG6sJXfuJNENuinbL0n7C9ew36ioA9QaCk346JG0tZGShDSRf9z0eYT
         vYR0mI0ZZ2hWui62+Je5eq2dtv3q6V7QjwZMvfeSyJpQbAMHj7nkWdjS61gNJnyhFnLh
         fh8UvZ/q29I6/L/qNaJA2pblZgWtReGPPoGN/T8W5AKhv1LOfhrDcITwr0XmKUC/H1vR
         SQww==
X-Gm-Message-State: AOJu0Yz2eFp+SsqlbyoMlTCP6Gm3AFQq+tkVl2ooJVj91I+jS33T+xHD
	B9BaIV1YMRg1uiWSluMSurCPf513eN9uXC8i9IAKWAznOr7A0mUyGxRPKqiWuIxGu3MhRHucIHq
	F8DEi
X-Gm-Gg: Acq92OEgeOQTcu85IKmpgHMiHwbkoEfS4tvk4VSajArDFe7z6rBrw/986yJ1p9lOCux
	mUd+zMZZYYaelxjb+XyohS4Wr6WQZX8E7DpGqHsCSlLpIhlRYbrlU6LQp4F4IR4CCyjvUNvTb2m
	X4gn40ZK7fbu9qqD5CFmt555Y3GgR4hL4t701FTIbF4Y99kfXO8EowdEuUavXpZcWWlKvuIfnY3
	SOMI4WTPASS+BHrJMyDT7S05aWoNkpNIrC4NSe3HamJbDX+O5P06qZgpU9ujB4nVntubssp4ZNH
	8pRThl/raYubJH1K2uIy3nw89H6Kgk19EWgROzmVkj56rqF0FOyBqDe7emSCaCYxUWt4TD5yDB2
	bVyt2ZqMJ02eW+ZZkHPq0FnvsAih+xBXyU4rHpilS5hfZtQmbGxxkNqSDjRSC+9JzyKiDQswLBb
	fWM7zveckNJTVmVzu2V3niXFlTxtz8JS9jkjMQflHrTJ6SHf9972OJL7MhcpN2nsW7x5nccwYqP
	Q==
X-Received: by 2002:a17:903:41c6:b0:2c0:abd3:32f1 with SMTP id d9443c01a7336-2c0abd33503mr120660545ad.24.1780355901511;
        Mon, 01 Jun 2026 16:18:21 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c26d66sm114323105ad.66.2026.06.01.16.18.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:18:21 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v2 00/10] Implement 'containers' jobs
Date: Mon,  1 Jun 2026 16:17:59 -0700
Message-ID: <cover.1780354513.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:18:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4097

From: Tim Orling <tim.orling@konsulko.com>

This series contains the 'yocto-autobuilder-helper' patches to enable:
* building, testing and publishing of 'vcontainer-tarball'
  - the tarball is checked to see if a newer version exists and if so
    extracts the new version before testing
  - vcontainer-tests job
* building and pushing containers from:
  - meta-virtualization
* containers are pushed when the push_containers boolean is set in the
  AutoBuilder UI
  - regstries are set with CONTAINER_REGISTRIES variable
* added getconfigdict() to scripts/utils to allow container names to mapped
  from recipe name to a more commonly used upstream container name (e.g.
  app-container-python -> python)
* authentication uses local user credentials (e.g. ~/.docker/config.json
  or .../auth.json for podman)
* containers are tagged with PV_MAJOR, PV_MAJOR.PV_MINOR, DISTRO_CODENAME
  and yocto-x.y release (yocto-x.y.z for release builds).

Additional features, such as container signing and attaching SLSA provenance
attestations will come in a future series, once this initial functionality
is agreed upon an stable.

Changes in v2:
* Simplify by  merging vdkr-tests and vpdmn-tests into vcontainer-tests
* Simplify by building containers from meta-virtualization:
- Depends on resolution of: https://lists.yoctoproject.org/g/meta-virtualization/message/9826
* Workaround for recent (since Friday May 29, 2026) errors:
  Error: reading blob sha256:<hash>: file integrity checksum failed for "<file>"
  - This is probably related to either sstate changes or recent changes in vcontainer-common...


The following changes since commit b98a54a334d15179673207169cab00c1385bab2a:

  config.json: Drop qemuarm testing from meta-virtualization (2026-05-31 18:18:44 +0100)

are available in the Git repository at:

  https://git.yoctoproject.org/yocto-autobuilder-helper contrib/timo/containers-upstream-v2
  https://git.yoctoproject.org/yocto-autobuilder-helper/log/?h=contrib/timo/containers-upstream-v2

for you to fetch changes up to aff1838ffcfb3e4c2aa1fe455dc0f74f87effdf6:

  config.json: add 'containers-library' build job (2026-06-01 14:55:21 -0700)

----------------------------------------------------------------

Tim Orling (10):
  scripts/utils: fix stale extraction dir when tarball is updated
  scripts/utils: warn and force re-download for HTTPS sources without
    SHA256
  config.json: add sha256sum for BUILDTOOLS URLs
  scripts/utils: add getconfigdict() for dict-type config values
  scripts: add vcontainer-tarball setup, integration, and publishing
  config.json: add vcontainer-tarball build target
  scripts: add run-vcontainer-tests for meta-virtualization
  scripts: add container registry push, auth, tagging, runtime selection
  scripts/run-config: push_containers workaround
  config.json: add 'containers-library' build job

 config.json                  | 129 ++++++++++++++++++++++++++-
 scripts/publish-artefacts    |   5 ++
 scripts/run-config           | 150 ++++++++++++++++++++++++++++++++
 scripts/run-vcontainer-tests | 164 +++++++++++++++++++++++++++++++++++
 scripts/shared-repo-unpack   |   1 +
 scripts/utils.py             | 109 +++++++++++++++++------
 6 files changed, 527 insertions(+), 31 deletions(-)
 create mode 100755 scripts/run-vcontainer-tests

-- 
2.43.0


