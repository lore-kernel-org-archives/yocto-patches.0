Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6005A105D988
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 22:45:54 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.94170.1775601946278515108
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Apr 2026 15:45:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=A0WaDsZu;
 spf=pass (domain: gmail.com, ip: 74.125.82.172, mailfrom: raj.khem@gmail.com)
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ce22328930so5273619eec.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775601945; x=1776206745; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sowhijnmIlplEQX6z+nC917wWQ1Se9IxEt/R931mNak=;
        b=A0WaDsZuwpTYmt6tbi3Sq16PbReeON+AJBL4xLmOpJxf7mEOrY0QdYlBfun17S4wov
         v4GeqFS1WbVydGlkQKFUK8fOR1zBnlRBB+9loK/P0CJqoJM8WJuO4v1bGQL2yDbASdVt
         V2jzSQL74QQWc3xM5z30gtlKR0PF/W4cKNgyDFsJXaQSJLWX3V39kiL2kBd6tXJ/0Cli
         D5gO/EvJ02N2Z0pNb8Uu4GT4nC/eG4dqJ+7mwia9IIdcE6FQPUwsB2sU0PNrWWQCHABE
         rEQD6PYK4hcDoAvwco/xzD3D1mqJ7Acvhgn05B/dg7+H/4Vj44DvTUZGIkUhUxULwFg3
         aKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775601945; x=1776206745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sowhijnmIlplEQX6z+nC917wWQ1Se9IxEt/R931mNak=;
        b=hD/h7I+v2ZCOwQgMcPIYySFJggWMOYudiirP4xXve+9ec8HHgpZe6DETA/q5CiQuk0
         f9kXkoVV0WuVf5KAdZVt9ATHimpxwkK1IIj/KN/wd4teXOvd52FwUWftbKtBaXEESls2
         sJelhm5Adc0mYuDqgbjySDzh9JrXwcwQXtY8Om1hlWYCTHSWzU4Uq2Cn9EPXEOZDLMyI
         QA6tqQ/XfFhfA15yfz6sSfGISCcFAkNoqHsQ/ne9nAK7bxHaMvb8C8TASpMGH3+xKRuK
         +wQPuE33Dg1R+k7dhr4dvRMX/lT3Jwwvg/g2/y4fiQ8SKjm39/pOnHU1yoRdzZNAaC+2
         VH/A==
X-Gm-Message-State: AOJu0YzEd//yMex1MDeblJwsUcR+0xUKWrb5iIGYFvxM8ZYuyck9yAqm
	UhL2jL68NNT9GpsZf7lhNdK9iSiHjt9R8O2nd1jtokCpOObfoYFNAn145W/QTQ==
X-Gm-Gg: AeBDies86Jv57GNHbvdTTXjho5uDyjg/Q+xwOzZB45aEQBDOFHiivsjvJ/hv+BjIQfu
	SnxINRHcvo2JTq3M4/2Y0eZ6PEctVmhMPrGWBbakc4PVJG4BJpYK1Nt3kXgqBM9nRTskV3pv2xH
	nGbOjdqi5O7WWNhh0yapbIcnsnK4sIEC6QiZ+5rmEy/j87UKPWns/GP12Jsr8+j9T8aZhxznSid
	nE4oqv1wl06iuQDiPqOP4DoZ9KiwVCfQc+PxKCNOhrKBok+fQfDUBkaZ3OZvDfbSZsD6NJ/Ktku
	GFY+rIGhPShtTxu2RMKpKnMG1qAWneZFXoj+WsyxxvhIYyH78EvhUK/TzWbwzNtqZJCxw/ePaoQ
	HgNYqj4z+UC+Doh+uQK8zKmruyZZykt1C9l6F5CyhCxmC5XhbGKTJ9rRQstlEmMMJhaURQ06Jee
	fQ4iBWrqYwQrJBstUAzBqwb/X4l7US/pC4Zdm1tuKX4DdRKnFNvnv7Pmb2sQyOioN9Bm0US0Fah
	mexJGqY6X/t/8N4IcEdAqTcIV+Z8yUr7L8hwqe2vJesMrMUXjlvupXoWYWx
X-Received: by 2002:a05:7300:e78d:b0:2c5:b972:b436 with SMTP id 5a478bee46e88-2cbfbe7dcecmr9935115eec.23.1775601945315;
        Tue, 07 Apr 2026 15:45:45 -0700 (PDT)
Received: from apollo.localdomain ([208.95.233.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d1b152f3adsm4442296eec.20.2026.04.07.15.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:45:44 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
X-Google-Original-From: Khem Raj <khem.raj@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <khem.raj@oss.qualcomm.com>
Subject: [meta-security][PATCH] wic: wic need to be moved to files/wic within the layer to be found/used
Date: Tue,  7 Apr 2026 15:45:41 -0700
Message-ID: <20260407224541.3158784-1-khem.raj@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 22:45:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3657

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
---
 {wic => files/wic}/beaglebone-yocto-verity.wks.in        | 0
 {wic => files/wic}/systemd-bootdisk-dmverity-hash.wks.in | 0
 {wic => files/wic}/systemd-bootdisk-dmverity.wks.in      | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename {wic => files/wic}/beaglebone-yocto-verity.wks.in (100%)
 rename {wic => files/wic}/systemd-bootdisk-dmverity-hash.wks.in (100%)
 rename {wic => files/wic}/systemd-bootdisk-dmverity.wks.in (100%)

diff --git a/wic/beaglebone-yocto-verity.wks.in b/files/wic/beaglebone-yocto-verity.wks.in
similarity index 100%
rename from wic/beaglebone-yocto-verity.wks.in
rename to files/wic/beaglebone-yocto-verity.wks.in
diff --git a/wic/systemd-bootdisk-dmverity-hash.wks.in b/files/wic/systemd-bootdisk-dmverity-hash.wks.in
similarity index 100%
rename from wic/systemd-bootdisk-dmverity-hash.wks.in
rename to files/wic/systemd-bootdisk-dmverity-hash.wks.in
diff --git a/wic/systemd-bootdisk-dmverity.wks.in b/files/wic/systemd-bootdisk-dmverity.wks.in
similarity index 100%
rename from wic/systemd-bootdisk-dmverity.wks.in
rename to files/wic/systemd-bootdisk-dmverity.wks.in

