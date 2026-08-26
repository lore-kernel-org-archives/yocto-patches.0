Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE101C61DC4
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:58:52 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22430.1787777929745230859
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ClMmUUGE;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-90cd4631090so2795316d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777929; x=1788382729; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iwGb7IfXmzwXKCAT2zQ4MK4glKNTE+PJxtde1KfEQ8A=;
        b=ClMmUUGE3ROGF5hvLSQxNxzarWN/GjbwtDAVGhFMfi3/4MnEhSEBohKPOFRjMb8UdC
         BrrfGnetgxo7LfAZo3QQzT2SnXVYhE9Qx9K0G3mKcWIQLiIOwQN/pVDwwcKIL8Rx3UrI
         GtN81KZNwcxsgUnQtZ0qH8h5vlmglLo/619Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777929; x=1788382729;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iwGb7IfXmzwXKCAT2zQ4MK4glKNTE+PJxtde1KfEQ8A=;
        b=gJIBPn6Zt0MBdsogc0VY6urzGLn13l8TyTBDcJwSmcbfbdlK2fW2M3MCJt+jg+mkMr
         1zfT7qwezpwP45128o5DZS0MoSgQqDZq2sQHpVPQE0FXP6CoNssV9vqntqI/39cWpN6J
         fZV2ZCkbPfYnGDvoyMjSncl9QHJc668w0w+CkMHMAM7ltJB1lfsL5aNkNClEn4KymPPt
         q3Z3U8NUrHOuKHvLXAsDrgs8Aj6NxOYlgLx1MDdt/3l7RSbeg6aCAb21y3HIstU7IZun
         GtVcKP3yvSsNwF5AkU2TiRZ5jDn050Dw9M6H07cgZDOGyJYN/1pGHMD1SmnfaoVa2VZS
         rJRg==
X-Gm-Message-State: AFuF++mQ6PdTmY8qgsZL2xrhcDgiUVruytkAlLDGbBrLu4jgInPv+6Uq
	jujsfh3F5nGe5PpDcWxcOKap7L9Rzr8vtEA4A4jTSFCYHa9nvfJHbNp/idC3jxcjuebKatBaOym
	sSH6v
X-Gm-Gg: AR+sD11mYWsJUOlfEYyTjlOv9OETMJ2H7eAOxAFk606jj+gLKyxw3ycfnsYLP1+zpTG
	xxLg/N3kDdcUq7FwSy+nrcNPHQGCY0rSSum3DBXIUuRp4v2vXcT9wGALoBKa3gdSKM94D5U7qc/
	MLPVHoWzS0gxCy2AUBjfgdpxYToazPK6PphJiJ6fGNhgbcfijZYRbfnL1cXvTwZ1oG13Dn4uPqH
	HNGmuST4STWMFoz+pU6fwOFjDTqL91qu0SKoh3Lt4izCg0CVAfvN9fXpcTM6q8+jEzO47XWVD47
	7B6plrhvco5c0FiUbvJ/9gPoaD+OUI9IEut9oNMGqSEyf1xrz7Pic9T2Bj0iv6rHwY88tqOkWzy
	5CJRhhi/0EW75yhzHyRtuJNHtmyvYU3dfGuk5AwIxL0Ago+cyCzkFONwdEtKFy8ot8ixRET8YIp
	52gYj7VAbisxL5H14u9vUuXwXnmUf2nIJucACdwSUkIlpla6wNfqpPinXQiesgDP8J63De76xsY
	4tDDDjoHVWjX3vkXSOWqX1KvbNWjwaVu2PV6zGAefeI8A1Ss/ioocMHdRfh8WUvjDm9enVsMAB3
	MbuWyLWiOltx0GbgrXp27rA2dg==
X-Received: by 2002:a05:6214:5d05:b0:90c:d1c3:534f with SMTP id 6a1803df08f44-90cd4369161mr28070926d6.4.1787777928553;
        Wed, 26 Aug 2026 13:58:48 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 06/15] dm-verity: remove unused variable
Date: Wed, 26 Aug 2026 16:57:40 -0400
Message-ID: <013ac8517413fd8fe96a303ffccd084853d1aa03.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:58:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4698

From: Gaël PORTAY <gael.portay+rtone@gmail.com>

This removes unused variable that was dropped by commit d80cd2ba6a
("dm-verity: Set the IMAGE_FSTYPES correctly when dm-verity is
enabled").

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
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
2.55.0


