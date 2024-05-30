Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4D4C25B74
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 07:48:24 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.2906.1717055293312635274
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 30 May 2024 00:48:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bTaCwIsZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-356c4e926a3so555413f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 30 May 2024 00:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717055291; x=1717660091; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eInB+l0d29fFq+Y07PiXPgVBLcCqKhPDLua1vwivtfw=;
        b=bTaCwIsZUmx5nMHxwUxznFKQN5BsiB9/ehP0werokFnmKR6CzYJoAVUuoVYe9bAcpm
         K1EOEc5926x3mxOBd18d8ujHiv1Z6gf2SX7G/Pl8OepzJrKhgylY5FJc+3MLaRaimtEk
         eVrfMLoz1QBqIlzPGrWIWqLENULaSliTsURJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717055291; x=1717660091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eInB+l0d29fFq+Y07PiXPgVBLcCqKhPDLua1vwivtfw=;
        b=WFDBXmkHd/Et77tGxkTSGFopWwTmbJ5zzC79yvxn81AfQT13y4VpS/TRAyFQwVb09R
         Dt9MElJ2EVqxAgjz6ZLwV4qPV2Z1eUZk5Hz/9cHH5U2O/vYP/+ihlFyLRG3PBb485fvZ
         n50FXpK4aBApczUv02ndKaq9yCeWO6S3G6K2ESyrHZgJdqYMY12vyDTK21Iw5pYWynty
         FDOvRHWTX8yyHf6jgRXAqnszpn6tq3u1Ga0Tpen64+bJtHnVCHtp9oUHzbljJjAuzQSC
         BF0Un6luahep1lVNRHKFwNEiUF9uCx24JYIGKe88bxRP/FSX7kcucAg9cteXxqeoBqzq
         vgZg==
X-Gm-Message-State: AOJu0YxPvSYyycSG5lX1NqEVauxMysYMIIPr20ZzU+cJiwdxeVgYBqN9
	Nv55Iuk0faq/hquRctdiidOcsQLeX3SQJlGVSCbtxC6/nzi4y6FGhyyBuWyrszRZisvDvfbhECY
	P
X-Google-Smtp-Source: AGHT+IHiHdmcxsi5Y9zJGg6aNTclc9fsECcaK2cIFBanKSkqHPEkUeDB3jS1/M1Cos/uQCLIToDa2w==
X-Received: by 2002:a5d:500f:0:b0:351:d78e:875e with SMTP id ffacd0b85a97d-35dc0086fbbmr854587f8f.14.1717055291417;
        Thu, 30 May 2024 00:48:11 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e2db:3695:26f3:1f11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dcb8db5b8sm459283f8f.86.2024.05.30.00.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 00:48:11 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH] qemu: Disable incompatible-pointer-types warning as error on mingw
Date: Thu, 30 May 2024 08:48:10 +0100
Message-Id: <20240530074810.3051406-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 May 2024 07:48:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/247

GCC-14 promoted this warning into error by default but code does not
build cleanly and now this warning becomes a hard error. Work around
it for now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/qemu/qemu_%.bbappend | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 recipes-devtools/qemu/qemu_%.bbappend

diff --git a/recipes-devtools/qemu/qemu_%.bbappend b/recipes-devtools/qemu/qemu_%.bbappend
new file mode 100644
index 0000000..3aae4b6
--- /dev/null
+++ b/recipes-devtools/qemu/qemu_%.bbappend
@@ -0,0 +1,3 @@
+# GCC-14 treats this warning as error which results in
+# build failures
+CFLAGS:append:mingw32 = " -Wno-error=incompatible-pointer-types"

