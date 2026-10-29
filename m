Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.810.1793298878683364412
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Oct 2026 11:34:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GKamxbJH;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5364042eecfso33806981cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Oct 2026 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1793298877; x=1793903677; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0bXLD/GqPecVUk62vYJLsbEGHNYtP9oVbBtqV9Lt7lc=;
        b=GKamxbJHmWc5AwdQq/JELqtt2MnWwXc5UG4jHS6vx+uw98ujsmU0y6ZTSEPbnZdztY
         cdWECZqTVYV2F1TZ8Uc3T4n9OIFTooQxsHnq/pOlLt0ZCh+EABKRzHF8a6l9ckI3MoAh
         r/QKqWpX53Uj4C3emKhDdX9UTYjUQotQwysOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793298877; x=1793903677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0bXLD/GqPecVUk62vYJLsbEGHNYtP9oVbBtqV9Lt7lc=;
        b=j1wtC8AX6mulN9DS0IZwTskRzAmT1IsIwwZCCa4VEJkV6OzHn8PLv05IY0ucwJcThE
         DN1qkIlyWlijv1lX+Fu16rqEdm+4JN6izXp/q5fBHdo/4uj9OnUivFs+MngkLHBRxRXt
         0PQkwsDIpsyK6aXAJBWbIiQ5bzNR8ZWrw7me1gsZXvwQsJ5HUK7kZKjCSMwjJAWPslX9
         mfENdV7egt+E8ivHPc41rgG1YwZ/bin10nunVftIL9I08rYzA+lItgYUTHMjnYnypOQP
         kJSYYz8h1vNTWMv2UmXv0NL1l+BoBxJZ7qRVxaylrlIWUyELvjI3xGZfFNe9cvgWCcFD
         a0Cg==
X-Gm-Message-State: AFq9FYIFmQ8zwxK2kAo/JhkiGEQpkv/8JxTLvFXewMGjZyxccChtpRSZ
	KEszfaTMRY/MLoAsq1qqK1BvKJwPZ8pouMO+Hd8llHM2KnFNuwscP5C6fx6IU912BfkoFUlWsCF
	c5jYf
X-Gm-Gg: AYBFou1ggSWVwbvAaVOhgQiPp0k49bjxvGUM29L1MxjJ/y874kaI12z5Axqoz7KkpZi
	RIqPDkoilNcgVM686cepYZfnn/ET1np8ckUNtxu7vlDu8swhW80IImVc5lpQzJtUgNqFUZdOfcl
	UCgG0bAWinx1CFfwYH8H35ZbnHwUMVCkl6eLi6mtWffSW7DEp2CK70sUJ/BlLb9fdjR/eW3dR1U
	NLgjJ0O9PN/lA+2b5NJ8ihgwpdmwEf8wqC5C431+5ZxcTTMpIcKdOnYXgMqZFOubVUuaKPbAQ2W
	EcvvIRJdobZZJ7xXiFGpTo0oBsu86A5zAYZqxB4XeaAxCwhG1u4W6PE1GrJIBpZ20Vh8DIm83gD
	CqWIu9Nf/xXrTpttdCYy8IRrL3h3bx/FtnQjMBabwsAu9UTWKSsAjsdog3ialuiCL5Op/inghzW
	Y9TgYG3rew2x6NrM75LFjcKaN7QGQmcwBxER3dWJfni2/e2NJhJvAIZP1ak3ldUbA8GpcjYFw2p
	DxJ4KrcPtF8Sohwj4fgqvEFh/6FXmiVaBskY6eGhgn9MGBFBZeJiAyPyMpCSWpXICJ7+tG9UA0f
	nTzaJ93QBh3f0ICHWAZLX151r+5GBORZJzKHuB3S+hZVwhrZ+97X7AHcVNNHf92VNfj07pAMXkg
	ubGTn6lg4X+XNhbPoqaKN7+898cPpQAK6+0qd1a2uv6Yqb5G1d7fflpx5dqoFWlsdPQ==
X-Received: by 2002:ac8:5ac4:0:b0:535:f9dd:cb97 with SMTP id d75a77b69052e-53fcccb5ef9mr106533961cf.48.1793298877376;
        Thu, 29 Oct 2026 11:34:37 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca31b46f3sm2878276d6.45.2026.10.29.11.34.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:34:36 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][blacksail][PATCH 0/5] Branch initialization (cover letter only)
Date: Thu, 29 Oct 2026 14:34:19 -0400
Message-ID: <cover.1793298086.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Oct 2026 18:34:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5186
Content-Type: text/plain; charset="utf-8"

My apologies for the delay, this got hung up by travel and a few
issues cropping up in CI.  I have gone ahead and pushed this to
unblock folks since the glome and ding-libs changes are required
build break fixes, and should not be contentious.

I have a master branch update cooking that fixes another new build
breakage, it should be out later today or early tomorrow, and then
I plan to get on scarthgap update out for early next week.

Scott


Changes:

Khem Raj (1):
  layer: Add blacksail YP 6.1 to compatible releases

Scott Murray (4):
  meta-parsec: prune LAYERSERIES_COMPAT
  glome: update branch name
  kas: Switch to blacksail branch
  ding-libs: update to 0.7.0

 conf/layer.conf                               |  2 +-
 kas/kas-security-base.yml                     |  8 ++++----
 meta-hardening/conf/layer.conf                |  2 +-
 meta-integrity/conf/layer.conf                |  2 +-
 meta-parsec/conf/layer.conf                   |  2 +-
 meta-tpm/conf/layer.conf                      |  2 +-
 recipes-security/ding-libs/ding-libs_0.7.0.bb | 11 +++++++++++
 recipes-security/glome/glome_git.bb           |  2 +-
 recipes-security/libdhash/ding-libs_0.6.1.bb  | 12 ------------
 9 files changed, 21 insertions(+), 22 deletions(-)
 create mode 100644 recipes-security/ding-libs/ding-libs_0.7.0.bb
 delete mode 100644 recipes-security/libdhash/ding-libs_0.6.1.bb

-- 
2.56.0

