Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106C2F8809D
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 07:07:56 +0000 (UTC)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7876.1776323266423870570
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Apr 2026 00:07:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=clOLZDVE;
 spf=pass (domain: smile.fr, ip: 209.85.221.66, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43d7605ec91so3768051f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776323264; x=1776928064; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VPcpq4KXx8VgkkNbQkrwFlyetlDrGdPTEqG8J/MimGM=;
        b=clOLZDVEV0Y1i9+j8IOVXbxjQsP7JpY2qi0zuiZsme9Ru8EmapZGvTSrIvCQwEzt+O
         zFfGQ427hnbIUj+QaKvAxPe44lhYUPcakFWDr6NKsXIjH+TBN08h3z/t0EbhUTTs1IW1
         Rb0ZYHWBR7+gj3kp6osH57gELolLXjtpPdz6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776323264; x=1776928064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPcpq4KXx8VgkkNbQkrwFlyetlDrGdPTEqG8J/MimGM=;
        b=kg5+OPp2WqtKvEORjz1csZyTt2iW2xEK/5aOEY4Kkmv94GrLUM0YXDPW/SoWW3Nk2e
         oUhAUO05TnERmNGGtZCQFPVkS2Lq2oHLkBdEFb8/Fzz7BY7hSrMUqENXIkONdwKB5zm6
         tKkHOaDhbcVXgPCSJLcsTViuWlMYpfD5t0cvaTkvephS9UXmH6Yu+bJH+ymcmNFRj6BA
         cuQrgoDg6lxXw+78uAUZPz1R74NxdVw65+dG1m06tjbxsiu/f+4MoiA/USDDhFVLjQjk
         GlK54vDGbrcuWq5NK0X2+cfWVo0UQaiZ57aJ1J3hgijFXrNJJ/1v86pST8Sb81eGlkNX
         Qy/w==
X-Gm-Message-State: AOJu0YwJ8YoKE8gQP+FiEE2P91IBIuT3M06+PokZuyhcbjytLqusZIJ0
	mH9YKMCRJBlpCxlE316mr5cHN5O4akM4QWeln8dX3OqebAxiwMVafZdkINDQrGnE2ziR9abgLfu
	BGr+3n2HnZ0Vk
X-Gm-Gg: AeBDiev/t7f5ODFWidgqbgtvsPBr97nUNA824bnySPubw35Xc6vEoEkdXWomaWZlucs
	SdY0uu5ppRM60FzsyY9NCjErw045HEYB9ZHHiZzka+AtWeLbv/10w8WCU9rvUJUfqt+XTTeIE4Z
	XY3lUSjBhYRLmXB0y0w3eYW5koWUqJTmSCOiwfBP7ztiSKAEX6e7pKMI4z7VegGAojbD2KwMbCV
	9WSdIMbRrNJImjsahlRXyGglutRNT84W4KKIvqZwW1oA/XGp0glqbIkQtUVx1tmT3T5BQIcwC6M
	4akAEkettWfK7Z2EOvQuCUd/EHVQkcU9Gg1IGMEe6Mfyi5OCanUQvHTOLkRn0w++BesmI7QrAzP
	DWilHnUArSOfkWJsnHLSgQ+wThTGeRVWmu4pJil6XVTSLMLDUdSjXNBa9Pu263zRQ3TpB2bN1T3
	HpE5v/RXNZuyaqTnFS728dVFcheW2V77bQbX/CHm37ZlFBsVAzbYCJ4xDK4c7nmcncXRipvIlfa
	wNWriaRt3eKQDkeVDPqxNK+2xqYubNZ+Xmpww==
X-Received: by 2002:a05:6000:1842:b0:43d:7c99:6521 with SMTP id ffacd0b85a97d-43d7c99667amr18825235f8f.6.1776323263862;
        Thu, 16 Apr 2026 00:07:43 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm11602449f8f.17.2026.04.16.00.07.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 00:07:43 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][whinlatter 0/5] Patch review
Date: Thu, 16 Apr 2026 09:07:35 +0200
Message-ID: <cover.1776323183.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 07:07:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3716

Please review this set of changes for whinlatter and have comments back by
end of day Sunday, April 19. I plan to do the release build on Monday.

Please note: This will be the last review cycle for whinlatter.
If you expect a patch to get merged and it is not in this series ping
me as soon as possible.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3670

The following changes since commit 29abc96b6310fef8dd5ff34c22f0ff0d313ebe0a:

  config.json: Drop checkvnc usage (2026-03-16 20:28:25 +0000)

are available in the Git repository at:

  https://git.yoctoproject.org/yocto-autobuilder-helper contrib/ycongal/whinlatter
  https://git.yoctoproject.org/yocto-autobuilder-helper/log/?h=contrib/ycongal/whinlatter

for you to fetch changes up to 93894832c9a4ce0b96d16e503bed99a959f3d232:

  scripts/yocto-supported-distros: fix the centos stream regular expression (2026-04-14 10:10:51 +0200)

----------------------------------------------------------------

Antonin Godard (1):
  scripts/yocto-supported-distros: fix the centos stream regular
    expression

Richard Purdie (3):
  config.json: Set SSTATE_DIR unconditionally
  config.json: Fix bring up after bitbake-setup changes
  scripts/utils: Milestones are now yocto- prefixed

Yoann Congal (1):
  run-config: drop one more checkvnc usage

 config.json                     | 47 ++++++++++++++++++++++-----------
 scripts/run-config              |  2 +-
 scripts/utils.py                |  5 +---
 scripts/yocto-supported-distros | 12 ++-------
 4 files changed, 35 insertions(+), 31 deletions(-)


