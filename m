Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB0CCA490
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 22:03:23 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22484.1792360994230033010
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 15:03:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BYrY4r76;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so934345a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 15:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792360993; x=1792965793; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i6NaifV0qlmZ+Mqhk9cykfkIMyDb86hXhKBZLMdAneA=;
        b=BYrY4r7645DWc6KFQ2paVowwHycqPr7yJPOLFDuDv00NMv3euGfMJb5ZYRaQZws2k/
         7cOnRhvLQ0vmomMwDbmj/dEms/mvHMAlCWLUZOfi0neabp4bPPcjQzHSB2GJuXSEFkle
         cfhmRdbAA8wVcQjyGCUHmDNjWbVaO5rQOurpZuPwOkP7zTeOqJTpY8bdrIU/UpdAiwnG
         1sThtuInDWQGy0UgsY32dL85lI6y+qmxT0abzpN8pu+bG6H/eXI9E2Q4MY6KULItva+L
         YQj3BLOnCIbLQf+4n4RNoUq5KgmPZYW7AR8ZRySy0mpImYwJ6cOhqabAGKsD1IFplTez
         tYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792360993; x=1792965793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i6NaifV0qlmZ+Mqhk9cykfkIMyDb86hXhKBZLMdAneA=;
        b=i13B0KiIeA5D1B2ZQEzoSdDZ3oZahB0bYPv+AZEcb2o94OmzGGrMT3tPNYS5ACj6Ic
         +QB2iiGB0GysvCzjEzJC8jJZL5vXFHBUcwYsF+ZS6hFyKGZNVYO8Va6AVuxtoWsR6GhV
         7nDZNz/Yp69PqSVSkKvNIfjbychixh/lORRHz8ewY7nk4wgiYRtTN0Tf7GpBLzQRhKAz
         FrzOcUkMnXw2EppGGMGEp4Uz9ct51H51rI20EsjE/o6/0ZgyQZn538lFpR6qIGeJ6CIF
         FSbkVTZ6+G8NBYuuF4OLA/ddLLSDwhhkV8stmOY8p1+TT4tlXJIZJDD7P6ILQmBBAsqE
         a2YQ==
X-Gm-Message-State: AFq9FYKATBY8G33AKdDV9KfaYOnqZre9suAGruL+SX/cY4icBSgGnwLc
	QIekJEJjbIjMgqmcrgS2sdHXHafKW56kz4xQEu28dUNjaAIMrWx2X/+g39AoB4Vf
X-Gm-Gg: AYBFou00HBuE+asc5irHQJN2NSRjAgOcyy1txkO69iMbwWQ7a/iFryrKJp+VXbhUPGN
	2fMDf34zIrdQrtzgWbhCsX3FZGMRXlZ4p3Rvmp0+jNU8NjXXm2PfpVjvcf6di6Kj8uS4HguSlQW
	HWgRYzxMWioXYV0/WOjM3es1UILUMh+rHruRJOYP9ucPxTAbKVjw1IvLiodvHUYXctP+iwoxtIf
	lZhc6vEdk0dzsQ8FQ4Sb05EpAKyO2/7Q0bfeKrStjxUj6pswtlgU3ZXzcnf33QgvwABOrn/93wE
	4TIHXmRwaUPM81+vVa4Pq07sClvi49exL9MHF7OWFaoIXlLq55qJHIfZc6pjqBQVFmdTWF3kxUA
	a9o3Bx0X9HdjkwWES4DD8/h6Wvqq5xmqt68gLrLhP5Z+Ef2AKl7ZS380WVFyNIpZuVrwnp/TDNA
	MoUcS9HAZz6wL2+ZJ1IyrvPsgw+kaRiIViidv9Hrl9Q3xi6u7vCUBALi0TUC+/Zyh2bgff6BuvY
	AChTTZ1WfE1POLKO0Sb9DusgovA5pU=
X-Received: by 2002:a17:90a:d44d:b0:3ac:9176:e836 with SMTP id 98e67ed59e1d1-3aceefbddadmr5019983a91.21.1792360993222;
        Sun, 18 Oct 2026 15:03:13 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm17714440a91.5.2026.10.18.15.03.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 15:03:12 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 00/10] Documentation updates; README files as Markdown
Date: Sun, 18 Oct 2026 15:02:58 -0700
Message-ID: <20261018220308.72731-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 22:03:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5082

This series applies on top of the "Docker: environment files" and
"dockersetup.py" series, which patches 2 and 9 document.

Patches 1-4 update the content: running the tests and the current
requirements in README.devel, upgrading to the environment files and
the new settings in README, ENABLE_RRS in README.rrs, and removing the
obsolete docker/README.

Patches 5-7 convert the README files to Markdown in three steps to keep
the history readable: a pure rename, the updated references to the
files, and a formatting-only change that leaves the wording alone.

Patches 8-10 correct the REST API note (the API is enabled and
read-only, not disabled), fix a JSON example and a typo, use
"docker compose" in the examples, and show the git configuration for
sending patches to this list.

Tim Orling (10):
  README.devel: document running the tests; update requirements
  README: document upgrading to env files and the new settings
  README.rrs: mention ENABLE_RRS for the Docker-based setup
  docker/README: remove
  Rename the README files to .md
  Update references to the renamed README files
  Format the README files as Markdown
  README.md: fix the REST API note, a JSON example and a typo
  README.md: use "docker compose"
  README.md: show how to configure git for sending patches

 COPYING.MIT                 |   2 +-
 Dockerfile                  |   2 +-
 README.devel                | 159 --------------
 README.devel.md             | 228 ++++++++++++++++++++
 README => README.md         | 417 ++++++++++++++++++++----------------
 README.rrs => README.rrs.md |  48 +++--
 README.vscode               |  50 -----
 README.vscode.md            |  49 +++++
 SECURITY.md                 |   2 +-
 docker/README               |  52 -----
 10 files changed, 544 insertions(+), 465 deletions(-)
 delete mode 100644 README.devel
 create mode 100644 README.devel.md
 rename README => README.md (50%)
 rename README.rrs => README.rrs.md (53%)
 delete mode 100644 README.vscode
 create mode 100644 README.vscode.md
 delete mode 100644 docker/README


base-commit: e6040597ae0f614581de241fe78f20e34dae13ac
prerequisite-patch-id: 0cfb656e605b0ec4a84298986850c958648f94bf
prerequisite-patch-id: cf25fa25d9d94e47af321358b41c451717173512
prerequisite-patch-id: a3d6bb81b18633b51f922cc20a99b84ac423393b
prerequisite-patch-id: e1c00c40927a7db84488f2ce1b4ed40f3aa14aa0
prerequisite-patch-id: f957afb8dce214b3974e5c8c5924da1f7ba45ea4
prerequisite-patch-id: e67a8b6db7218cda1936f1b5d4eb9a9cad4c2dd0
prerequisite-patch-id: 6876328ca001cfedf7a4c9695dee294b40028ba6
-- 
2.56.0


