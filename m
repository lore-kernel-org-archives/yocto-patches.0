Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19CDC54F51
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 14:42:33 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13000.1785336151118392940
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jul 2026 07:42:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=B2rQdAZL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590dde14so10853785e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785336149; x=1785940949; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FuxKcv0tktvrkcZOWq7/toriKQduMOduYP2xXM5+CcE=;
        b=B2rQdAZLHGT5tc0YkMq37HPirAFqRl1yKMVfmTHazaZOx9ks+A8CHS/4rnsf1MeNhk
         14H3P+9NRDiaq1XSsohzqK2qClsICbi/g3YNwelOd5rmyaiwgyeewHPEoPjnZYhFXJPl
         6Aa+56zlaLtN1xLyXukAIk1dB1jtv5bZG5VgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336149; x=1785940949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FuxKcv0tktvrkcZOWq7/toriKQduMOduYP2xXM5+CcE=;
        b=pS4OTR5cCmzhWtxbs3l0ELPyLvNJpMoiPQClBMua6SfnMLXpjndlIvfQWEsZFgFyr4
         8KODehudRNB56fIuLaBLShmdYmKxcb3qLU7mG8RjrwqJ0lAd3ciMFNFW8k+32g/Ajjpu
         vwZ8ZKvTgEmkyfE+wBLyHuJoLpXk4brcxoSKn0UqaxVe1B5s8ML/HC/KkhpwyqSUa0pe
         xm85WcJAkJAduohFhtgCKGRCSCQwccVafVN/DRXDPuJN+bW7tboUW7bwKA9fvYkeW51e
         7mcMf3UmEPRmgBtTZ1blk7pUqeKgeilL3dn4ncTBZm7a8E5XY9Z8BS8h+VazD1heHthF
         G9QQ==
X-Gm-Message-State: AOJu0YwcKEICewFiyE49chJgLLJhg0P7W/kbJ5syjgVp0pO4+TPxIkma
	1m12BibUxhMmchx7V57A6/1rEa6CUB1n0sk1YDNYu4mRuQnzaGC48fvsI7GG4FlKn7kEsSmqKrR
	OJyTUH00=
X-Gm-Gg: AR+sD10tz0qiEWojmbg6XD6X7DneeJpeApyG9fuT+Q93tzobFr8WsjTisobZ3cIABWE
	01j6UxMITK5wGxdUuEyb2pJFxByweqMPszdk073caB/o08w9N3Wffqt4BXv80QzAFErrH0JsA+8
	TbBw/sPXRZqFRHkjomctYLT5MMHETweJJvEYGS6mBXF7+Ao/QeEPcptJAUVCcJXTj+OfeeyxfFY
	Ye38FxHy2qogSsNb4R//Y4pYbWii5ET0HR77miru1YU7+ZsNcFJDLPbED2YNtLZWlnYVgBYYKx8
	zk1GO/VmC8ldyQV4k2o3RRZPAQesUtk/FTo46xY3OXyl8Dm0Me6SAFL3HdIcG9gXx0RUOQ0EkKv
	iAuHvlHotDeAqqCysw1zeagUw9G7bxOIbjqS5xsYOQ8GP9kbBmznid78tT4szJpySQRQgZ/kbF5
	/Yc4XwpVDJiIoB/LKJ1d/tQ6Gb/bo/lsosqjDnQqDXyhkD7qJshLSP0ELquj/HpNDTWnKFWuOuz
	tCZb0mcIbirp41Olw==
X-Received: by 2002:a05:600c:470d:b0:493:e365:7630 with SMTP id 5b1f17b1804b1-496c6431d1fmr77992225e9.14.1785336149274;
        Wed, 29 Jul 2026 07:42:29 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3647:86f2:68ea:efc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3a32sm8602233f8f.2.2026.07.29.07.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:42:28 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 2/2] makewrappers: Avoid efault workaround if using AT_EMPTY_PATH
Date: Wed, 29 Jul 2026 15:42:26 +0100
Message-ID: <20260729144226.2680004-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729144226.2680004-1-richard.purdie@linuxfoundation.org>
References: <20260729144226.2680004-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 14:42:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4566

The efault workaround shouldn't apply if AT_EMPTY_PATH is specified
as in that case, an empty path is allowed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 makewrappers | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makewrappers b/makewrappers
index 83f5ca6..19508fa 100755
--- a/makewrappers
+++ b/makewrappers
@@ -415,7 +415,7 @@ class Function:
             if self.efault and path in self.efault.split('|'):
                 fix_paths.append(
                     # Emulate EFAULT when path is null
-                    "if (%s == NULL) {\n"
+                    "if ((%s == NULL) && !(flags & AT_EMPTY_PATH)) {\n"
                     "\t\t\terrno = EFAULT;\n"
                     "\t\t\t%s -1;\n"
                     "\t\t\tgoto quick_exit;\n"

