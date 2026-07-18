Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE03FC44521
	for <webhook@archiver.kernel.org>; Sat, 18 Jul 2026 23:25:03 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3455.1784417098606068955
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 18 Jul 2026 16:24:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PKGXHrFC;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495502852d1so878565e9.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jul 2026 16:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784417097; x=1785021897; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kXpdr1ZYKOh4KfeWl4jUIyNiQg7zHFHrGV+mmcDDbCQ=;
        b=PKGXHrFCstIJp+JjJ03+saxqHJ3Ys5xlQ0AK6pxgUOlfz0SYlTtfAJA3DqxlwbtUtb
         wtBtOc9lNijo5jDj2CcnxEVOQcVEbS8FXTwycIXVR59fYxAJ3YF7QBEAjDqM4eTE6xgX
         jIFxGA+36LUiw2i9Xx/DBchfVG/jKTWo8da8zzQBv4t11jXIeQV3SRaypGXiXnpcRMO1
         1gPfYw9UsDUShkVF0DAP9Fxit2hSevZka3yqH4f8rm6I+XXwfhTos0hsD9ztqoHQqjJu
         l8r+Heivd9t4YLxidtasubzuCwiMnf1464xRVvNsHOuafLxUNnYEvIyLv/pBUxD6wwwi
         qH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784417097; x=1785021897;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kXpdr1ZYKOh4KfeWl4jUIyNiQg7zHFHrGV+mmcDDbCQ=;
        b=Aq5rz1c68eIlkoZgWZGaNGNF130v7n4qj0uGT2KY/oCWhCEsh4fJBZL8s5ce74BnAR
         PZLyOh1gPDHs8FWZsaMcafF3LM2syOQOeEnrfTFu2xtSVwr9oLkPseJJTuL+Dy/nEH4D
         qL9gQf0zkiAvUs4cvDN0WttUPuiA2UVqsoWMsYa3qRltycOzkyu8R7vUQn8EyNlj/syp
         D/acbbLlru5uZRjIE62fqxM4X1U3ln4eRANiS7Cci+aOmO+WVuvwv4xWG/wlp74kFxQP
         bnUpYDaF/xV4dUEhxD8kMBVk6pe4zwQmtk/wCpEfVRv5+dXD+pOelt5QCjrylL/qZcti
         V3Tg==
X-Gm-Message-State: AOJu0YyS3JeoVT31E3JfnDUgAXSbSHMwyxL1RK8LtpSiymtoGH2Cc3sc
	9U6Zf375oS2b463qcRzGVqADU2tBfayl5N5lobRFH8FW5d5+zsj6Oq70zLZrUXCw
X-Gm-Gg: AfdE7ckZkv02Uz1OsEoErp7TVVnc90Gp6B2O33p96G9ouCWXK1S7eLm+K3nUU9zpjwB
	S5jbxbj6vhhjCUbKIKmKa4CWBKFWRnlWiF+7oemRdOxrzRYmT2N9Gzq8OE/s5FAyLvWrM75k6DV
	oEH6DdXwb4vnrKXlOSaY75U4nHeMkW6sNnaIuaWH3Jz6n6UrI/vMKQUIT9mlHBUBRIiqeF8h17I
	A5SrtJOpMAWQntTbSgzOfoscwxQwk89XiVCU7Tb3H60s7Uy1GVEBB8lnDAIgdWvNTSrSzAYNPjz
	AZiQAlAlCS3rr/t8tc31DK7zhjS7ucnwmn8nh4uZSXsQXvl+mdWkiU5MwaMy9Op4lzjejHg9NIB
	p/57FBAW9lrOoGR87M6oGu0WySgwYgRWhRzMGqVCHu3PzN03rZs6Oql4ObsBVTgJESgL1yBlKZN
	Kbz/8kF8/e2t0CX1tUuVoVXr85qQV1UY8PLx+dkpk00+sQKTEJ3xI/K7Usrg==
X-Received: by 2002:a05:600c:3b9c:b0:495:41f1:8ed7 with SMTP id 5b1f17b1804b1-4954a4137e3mr67695955e9.5.1784417096847;
        Sat, 18 Jul 2026 16:24:56 -0700 (PDT)
Received: from chipmunk-161.. ([78.243.54.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49559e00c8csm3113615e9.3.2026.07.18.16.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:24:56 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH] wic: document the meta-intel dependency in the dm-verity hash example
Date: Sun, 19 Jul 2026 01:24:45 +0200
Message-ID: <20260718232445.2822613-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jul 2026 23:25:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4513

The dependency might not be obvious to everyone, so leave a hint as in
commit 2fbeebc18c ("dm-verity: document the meta-intel dependency in the
systemd example").

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 files/wic/systemd-bootdisk-dmverity-hash.wks.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/files/wic/systemd-bootdisk-dmverity-hash.wks.in b/files/wic/systemd-bootdisk-dmverity-hash.wks.in
index e400593..67abaa6 100644
--- a/files/wic/systemd-bootdisk-dmverity-hash.wks.in
+++ b/files/wic/systemd-bootdisk-dmverity-hash.wks.in
@@ -6,6 +6,7 @@
 # Based on OE-core's systemd-bootdisk.wks and meta-security's beaglebone-yocto-verity.wks.in file
 #
 # This .wks only works with the dm-verity-img class and separate hash data. (DM_VERITY_SEPARATE_HASH)
+# Also note that the use of microcode.cpio introduces a meta-intel layer dependency.
 
 part /boot --source bootimg-efi --sourceparams="loader=systemd-boot,initrd=microcode.cpio" --ondisk sda --label msdos --active --align 1024 --use-uuid
 
-- 
2.43.0


