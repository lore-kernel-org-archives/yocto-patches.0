Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F265CD343F
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:00:54 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4504.1778205646960872677
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Eo+S1f/r;
 spf=pass (domain: konsulko.com, ip: 209.85.210.177, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-834f1075805so994241b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205646; x=1778810446; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QB33nWSanFCH1RfOliGmxlzvL6XDwsqtCBwGNRJohDo=;
        b=Eo+S1f/rBD7fHOLX4gAj4x17wBOsPPwi9wKf3X2jIjtDMdECeQ53yPK6zVWJ2QWvKS
         rm59DgH/R7ThSOWNcSUY5WWMZLA0ySePqa1cwfQVvCudAguSmKqQ1RYaf3vmEhEPkVYj
         RS7KIjvmHGNiiM9iQSzdOKBGCAfRwhuWCw23E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205646; x=1778810446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QB33nWSanFCH1RfOliGmxlzvL6XDwsqtCBwGNRJohDo=;
        b=SPv9Dh688VuJWARt3qzZL7eOaaQycWZ/8DEpT32fYoZK/t5X8JAF6JXik3I2O5edfv
         CV7cWvpojaaWJ0KmxFMTKCS2zh5xqiY0m1UXBkNnQ6a9zXYM5leXoP867U2XM4A+bgzr
         ppdw8r33J/DcquOkVcUIyJVdfgkSh4Y3CpyxVmqcrcgULJ9gCzt8KoKGcL5VchIFQFI6
         YDeRUlvoKAvmmrK6h2BFuhVVnIHH3/aVW6IStQguAJ/ygIfL+omGc21eNOBlSNx5GJEj
         QLL6ZG6MRZL7kpArV9fzgmC0gXVuyK196BddyJe4yIxj/H1mqDcPNroU79ayHezrN5S+
         vOwA==
X-Gm-Message-State: AOJu0YwyelsZgEQO5BCgdABQGdAxo2aG2cG+qjqD7v7W63nqiWeLXQi4
	+igIrtcchDOMnZFgPhWrAWsbX3NSAc2qMB4xRfENWXwWGzAE4YJ9gpEtRpQnCgZAjNsepgam9Z2
	7ntFJ
X-Gm-Gg: AeBDieurV7/XcZ1lmG0Bt4xKVLREMaeRSqytLsIpxU/92OlxQCrIbhGYnf2ON8S8Hc2
	fbne7zwPL6QUbF3B/hPLlxtqeOInrR/kNhbokaTF9PmQoQ/yGqQ8RBid1U6GGLcHXuh/Vi/gaBA
	gK9/G9yv48CCdIQInvE7fySFEF5vxtUmwkw9B2XhPzlSvhQqi47lKagEKrILv3clI5M2l6EBZ5/
	RpBl3a3fava0JkqZwhHBxVQLHT98UO4QFCjWKDJMmcvnTy3vj3yb7P9tyZRTk8Bp9s9eMlWVnOi
	Y3I/Di8On5lw935nhPlLlDBPn0C1VXwUViKSz4YMA5DHBPyzX0GrAWe9BJz4FDeNER0IO0j1VoV
	RwADNV+/HRRWZSbqFpTDTLkmZdZ5VXJQfyEdv0eil+HJob7ok2TDx/QWG1xc5cPGUOj1NW7Qu9+
	Ne7N6eCjzCGTjiPL/dqmSBkLE5GH8e60RVBm8X5dpUkcXehfKiAFkTwfD8V9lcZ+U=
X-Received: by 2002:aa7:88cc:0:b0:838:a61e:62cf with SMTP id d2e1a72fcca58-83a5bade5admr10234438b3a.11.1778205646185;
        Thu, 07 May 2026 19:00:46 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d314f7sm10759380b3a.23.2026.05.07.19.00.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:45 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 00/11] Implement 'containers' jobs
Date: Thu,  7 May 2026 19:00:23 -0700
Message-ID: <cover.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:00:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3939

From: Tim Orling <tim.orling@konsulko.com>

This series contains the 'yocto-autobuilder-helper' patches to enable:
* building, testing and publishing of 'vcontainer-tarball'
  - the tarball is checked to see if a newer version exists and if so
    extracts the new version before testing
  - vcontainer-tests, vdkr-tests and vpdmn-tests are run as individual
    jobs
* building and pushing containers from:
  - meta-virtualization
  - meta-yocto-containers-demo
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

This series depends on a related series for 'yocto-autobuilder2'.

The following changes since commit bfc6a42aa4df89878a1b0d950c7d0146ce20672c:

  publish-artefacts: Update to include newer machines (2026-05-06 17:33:36 +0100)

are available in the Git repository at:

  https://git.yoctoproject.org/yocto-autobuilder-helper contrib/timo/containers-upstream
  https://git.yoctoproject.org/yocto-autobuilder-helper/log/?h=contrib/timo/containers-upstream

for you to fetch changes up to 601c281165450b2be14de46bb9601e82229ca5f6:

  config.json: containers-library: add mosquitto and valkey demos (2026-05-07 12:53:00 -0700)

----------------------------------------------------------------

Tim Orling (11):
  scripts/utils: fix stale extraction dir when tarball is updated
  scripts/utils: warn and force re-download for HTTPS sources without
    SHA256
  config.json: add sha256sum for BUILDTOOLS URLs
  scripts/utils: add getconfigdict() for dict-type config values
  scripts: add vcontainer-tarball setup, integration, and publishing
  config.json: add vcontainer-tarball build target
  config.json: add 'containers-' build jobs
  scripts: add run-vcontainer-tests for meta-virtualization
  config.json: add vcontainer-tests, vdkr-tests, vpdmn-tests jobs
  scripts: add container registry push, auth, tagging, runtime selection
  config.json: containers-library: add mosquitto and valkey demos

 config.json                  | 151 ++++++++++++++++++++++++++++++--
 scripts/publish-artefacts    |   5 ++
 scripts/run-config           | 147 +++++++++++++++++++++++++++++++
 scripts/run-vcontainer-tests | 164 +++++++++++++++++++++++++++++++++++
 scripts/shared-repo-unpack   |   1 +
 scripts/utils.py             | 109 +++++++++++++++++------
 6 files changed, 545 insertions(+), 32 deletions(-)
 create mode 100755 scripts/run-vcontainer-tests

-- 
2.43.0


