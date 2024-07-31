Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4FFC3DA7F
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 09:59:57 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web10.39244.1722419990304864440
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 31 Jul 2024 02:59:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eHO92g36;
 spf=pass (domain: gmail.com, ip: 209.85.166.54, mailfrom: twoerner@gmail.com)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f96eaa00fso213766639f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 31 Jul 2024 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722419989; x=1723024789; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3T/lO8snIu3o06c+bNHY2XxAWWsV12Yqw2tLbc3eF4=;
        b=eHO92g36kWh5coj5PS+m9tIWPIaYxv3kzsVtjwa0UmAsRgSQfgejAbOw20/UAUDBEE
         jh/iX/f1j04FKFTipq+BT71518zht6wq1RisR9t24T3NtAmtpjLS+zPQgi8I+/hePFOO
         XDnR3Y9UO8R82Wwga/18VhHfHHPvmVLDhjpgWE9iiyp8M7EoEAvZc1jNxsyXkoxDTOmd
         rsgJgVNZYU5003C+O1gFLUkcCwDxDyVxx/4FlvZxznZb1OKsNtfED4+0sYSxqK1jcXm3
         U3oe7nAtu4uENUjQCiSWdp5KlnH49Y0SQnqScc0Fx/Uz1qoSDKo2LoTYT1dSVTAS2KgK
         Nb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419989; x=1723024789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3T/lO8snIu3o06c+bNHY2XxAWWsV12Yqw2tLbc3eF4=;
        b=asTKidSRfm9dBkcppE87LozXJFqOxQgGjPAuGipBYQCk/RrpxJt85BVXNMWdVZeitS
         lmlrMGjD77xZmC3wNAnQjm9DMztrRmBdk9Pq3BcoKNucy1upflF+fNXEXfXIJ498uiku
         DAvqVz5KVS75aquus/SYU7LazoIMqYBh353BUZtrL7UIap292/2eEiRqKVVuoEMSo/rJ
         UJyAtnLGrl90tqL5KrU45MD8T1JAudiSoUDVZLPrcqCP4BJj1jBRYcXHa1AettNCXN/8
         p60+VUmxV0GHff+yY7cG4C06eFujsUH6fqS8FRYnQ6WIbfi4/DRsw9wfZnycu/niwT24
         lE7A==
X-Gm-Message-State: AOJu0Yx6bzFmKXDyz5NkXpiZAZ7MhWHKJ+eBRrVMoAlltCAe6ihiw0Ce
	0fjAjdEMlcrx4d9fJVAenulJtm0nX9mCD0XDZOJpue/v9oZjYnYSwtCuXg==
X-Google-Smtp-Source: AGHT+IEpDUg62ugkb/vCkzniBh/HOETcWeT/Olf6wdA/pCL88DSg2o99BRwd2pbzp5QETssDj6oi9g==
X-Received: by 2002:a05:6602:2b84:b0:806:560:92b5 with SMTP id ca18e2360f4ac-81f95a9fa41mr1953564839f.11.1722419988392;
        Wed, 31 Jul 2024 02:59:48 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29faed368sm3117738173.75.2024.07.31.02.59.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 02:59:47 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] linux-torvalds-next: add rauc config
Date: Wed, 31 Jul 2024 05:59:42 -0400
Message-ID: <20240731095942.20677-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 31 Jul 2024 09:59:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/500

The kernel needs a couple configuration tweaks in order to work with RAUC, and
the default upstream kernel recipes already have this built-in due to
meta-rauc. The non-upstream, one-off kernel required to support the Radxa Zero
3{e|w} boards (linux-torvalds-next) needs a similar tweak.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../rk-rauc-demo/recipes-kernel/linux/files/rauc.cfg       | 7 +++++++
 .../recipes-kernel/linux/linux-torvalds-next_%.bbappend    | 7 +++++++
 2 files changed, 14 insertions(+)
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-kernel/linux/files/rauc.cfg
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend

diff --git a/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/files/rauc.cfg b/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/files/rauc.cfg
new file mode 100644
index 000000000000..3fa86bb87186
--- /dev/null
+++ b/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/files/rauc.cfg
@@ -0,0 +1,7 @@
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_SQUASHFS=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_DM=y
+CONFIG_BLK_DEV_NBD=y
+CONFIG_DM_VERITY=y
+CONFIG_CRYPTO_SHA256=y
diff --git a/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend
new file mode 100644
index 000000000000..e35f9db61fa2
--- /dev/null
+++ b/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend
@@ -0,0 +1,7 @@
+FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
+
+inherit rk-rauc-demo-features-check
+
+SRC_URI:append:rk-rauc-demo = " \
+	file://rauc.cfg \
+	"
-- 
2.44.0.478.g7774cfed6261


