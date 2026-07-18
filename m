Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079FAC44521
	for <webhook@archiver.kernel.org>; Sat, 18 Jul 2026 23:23:14 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3434.1784416991046666285
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 18 Jul 2026 16:23:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FZYoO7m3;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f611b3af9so68759f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jul 2026 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784416989; x=1785021789; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xrrWZPpWjFisRU9E4a2J3IqsYQUdA2IgjJILYTF3Bf0=;
        b=FZYoO7m3UEcqui1RGXT77ZLxAZ4W107m8xCUMd2ROVth+KJvMcRgg0X7JVp16Nihg4
         3999QK+VIey52gkTQoiFus5e1+xDQyD4CIymig9rNp7Q9znbQW/4qKA2fX+oGCpGgKIi
         kVFC9V0OLjft3ziQhyzEjDet2+ygOZGEIaCflJWePPR+EXmAkjHqhQAhaDi3gDn+/Sd+
         ujQGa+/gFgMGQXfTUkVN0XKl5pcnYoXIZJbZqSFDb7ShViyWQC2QjERfjCxFMqEDs7ZC
         2qsNeb7rzFBVKEq1I1seKonVGTVWsdcaCvA05Wq1XFb5akg/6Q0jnDDzo6vUkg2IWnDQ
         Cw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784416989; x=1785021789;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xrrWZPpWjFisRU9E4a2J3IqsYQUdA2IgjJILYTF3Bf0=;
        b=S2bEkL7435/4xjgX9m2A+zvpn3dZMDN010Rq9Y9lbLRV+/GF2KCz+MiZGWBf0/HZIe
         zlWOH8Bcd7BvU9dnJpliweCV5x66diz5EIjgXNRhN/GYugcA0yBnYPmuFCO6nKHUdAfA
         7z7QiFe5DNTCPyZBjhwwSALK2ziJwKiAK/G1Rzwb2GDJ+2uOWTNMIT3WT5UmZQDHRzBQ
         jcnZkd9HhHUuWCIVUri63A0exFZj6tFviMGcQoViJIu3l3kO34RoPDRdPHcHjsSFXD5D
         CyEYLWzPWCwR4jKgP+pllbR7SPBKo31k7LPpMcNIywHsUCG2tx0vlLUXUkRjAOmP5y4b
         awOA==
X-Gm-Message-State: AOJu0YwOr+UXB1GZLhL4DzO064yh6Iso3yPzLsM3oqwTGIOF4wyUpKho
	2lickQYxmyI/wvFIlPGFwozddRiR5qpbTeCs2IzDTLAR1iOxYaJzk2KBeqhcFjvf
X-Gm-Gg: AfdE7clg3oOwbWobQbxI12VR8X5YwXHNhx9HRGL0AzbGsOi1pBKGtFA57rGmgW9ETl2
	+qrzMRYsYMPLEtIXbe4y+Q/MdWKgpq7ONdjxTxWto+cVkHryAT9ZEoWrvezzG3EhdyK0j2FCxHO
	zenGFQQDBZFXgdQor34tC8i1KloyNX6N3fNgSiFmfhjT/BZIQj6CT3oK+hSK6/OEySnecrAhuMg
	9fmQ9c4nE5Bz3aSr1CbSTtG+t8ax5w1y4bLURsGLjVnBhRPQBtxvwNsWjWvKw8wsXi6EFcsuGCT
	ZkMieO5AnK89HCOPrclMal+cj4Nk2H3v7TThIqbc3oTRECbgUuCgG4FlW1DZNHwHkC4EKHjb/7c
	I7mIJD/uPfHGm8lxBPTLyaln49L8Xrxh8youBbtsQqJObWvUf6cBKimLxed5v3ZRsGhpQzbu8na
	L9dy/mMFpGj5FQQcEkyLIUMxqSs+SzcdMnfGeNWse8mLSybB8=
X-Received: by 2002:a05:6000:420e:b0:47f:6c7e:b32d with SMTP id ffacd0b85a97d-47f6c7eb9d1mr2658491f8f.1.1784416988981;
        Sat, 18 Jul 2026 16:23:08 -0700 (PDT)
Received: from chipmunk-161.. ([78.243.54.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f6980582csm9845482f8f.13.2026.07.18.16.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:23:08 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH] dm-verity: remove unused variable
Date: Sun, 19 Jul 2026 01:19:48 +0200
Message-ID: <20260718231947.2821727-2-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jul 2026 23:23:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4512

This removes unused variable that was dropped by commit d80cd2ba6a
("dm-verity: Set the IMAGE_FSTYPES correctly when dm-verity is
enabled").

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
Hello Maitainers,

Unless I am mistaken, that verity_hash variable can be removed, right?

Regards,
Gaël
 classes/dm-verity-img.bbclass | 1 -
 1 file changed, 1 deletion(-)

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
index 48557e9..619cda8 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -202,7 +202,6 @@ IMAGE_FSTYPES += "${@get_verity_fstypes(d)}"
 python __anonymous() {
     verity_image = d.getVar('DM_VERITY_IMAGE')
     verity_type = d.getVar('DM_VERITY_IMAGE_TYPE')
-    verity_hash = d.getVar('DM_VERITY_SEPARATE_HASH')
     image_fstypes = d.getVar('IMAGE_FSTYPES')
     pn = d.getVar('PN')
 
-- 
2.43.0


