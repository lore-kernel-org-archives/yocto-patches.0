Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26564CC6B2D
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:55 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14680.1791987166954170833
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=UBImVVxk;
 spf=pass (domain: snapchat.com, ip: 209.85.128.44, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a02718da81so33617555e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987165; x=1792591965; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1iQKp3uEXTMxAJpSIOEbKRa6dnxrirTTmZShJjS1FK0=;
        b=UBImVVxk1J7Cw2NTEct5OjLnHg7yMknWVKNjRoxw+3YF1pru+oL41jUT5p/sK+Z0tN
         mPNI8+eAJ0fVYdzyXzhcF45wdi/i7BRPm4hmy4/34Ss9vb5XshHm6O2SdPf+ppj1Z0aQ
         E1xm203aE2rGcBuWRTmop9X26M91Py+a7UOxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987165; x=1792591965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1iQKp3uEXTMxAJpSIOEbKRa6dnxrirTTmZShJjS1FK0=;
        b=rQN8qqNxQpxiBWUBNaXKVECjB8XlBdGJuFqVDBOTs44xpzH6lyu4RGouOwYGk1EDyv
         fwGFhaUhPQXuad2Zb/l3uNPCJIdtPn2xaOhiqU+itwuCL3cLLExl4LX5cfSHsama0rE2
         uSLfs8G62tdyU93/8xgXpICDxh8jUyqSZ1/kgC/OjIoEh+RytTAOIFZTEDoD1AFlAcWQ
         oWTy1pGs6/Evo4brROe/igDXu5vsFnEJhUdDgTX/35oTrjQbYG7AAo2OpCDFwtMJAJa1
         lTSi2+e4WGfUpFaOFrktLBBWOTZKhVhpkj6XI4Wi19OknMP18Yzwncsb3ar0T1aRIyfy
         d9IQ==
X-Gm-Message-State: AFq9FYKn4g0paEzGHZCXyG/FEOxH36nbatYDW34qWpHQRXqEtdqYa6DC
	bL0xM+Qb3zBNqmdZ3khyJlL8yqsJYzFrftqjcvfhq6hKTUfIRAn6wainpeSzWaW/W//DD+Acl4h
	qR/lFir8=
X-Gm-Gg: AYBFou2qisnr7LtT0IgjqgcoYtEDIn9ny4/CdSXk31QHJJ/TPOfjnvdak6y+ZHeo0qS
	nL1lJ1ZWgkDwH44JW7zhsPeBVQ6GC6xsKqRl11kyofnlmh/VzA1jWPEOix3K65s7Elv0vQfuURJ
	4xcgGXI12zguBbCB123y04q2y2epvAWGQbb5OfFgydFePwr4cY+hpDXB7MkeQP2Mm4lIqtvchcW
	bEwBDNJgrgxV7rMui/ype1ah5fozrrXaMCkWmlOupcf8gRpPgl0CnlamwZZQrb2Qbf8hLkJZm1K
	3UYbcpBOmpDRk+V54J+ZxI0IBShJrOsDd/TZR4qJkJTKJHe/WQyPVTTIgpw6Qvb0OcOnfpBTwpB
	CIrVdjUghdxFpmIfi9cOxZMZRlCglaKsIEUcvrsylBBRtYwDHpsz7E2MoYEevv+LZ8F5jfaZgIE
	OBwL9UmhmOqnyv+CHoFxIqTrHcPf52AGBlJnpwEV7eUSnukdsslVUCe46iYDqPH96YWnNZB17hX
	I47BlcXHpoma6fbyTGr0AUimdt4/6/YjZi3YdK/Og==
X-Received: by 2002:a05:600c:524d:b0:4a1:80d8:aeb3 with SMTP id 5b1f17b1804b1-4a18e4a95c2mr315023365e9.12.1791987165043;
        Wed, 14 Oct 2026 07:12:45 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:44 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 20/21] bash: link the in-tree readline on Darwin nativesdk
Date: Wed, 14 Oct 2026 16:10:41 +0200
Message-ID: <20261014141209.488034-20-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5025

From: Etienne Cordonnier <ecordonnier@snap.com>

-lreadline resolves to the macOS SDK's libreadline.tbd stub, found via
the runtime/usr/lib -L path which precedes -L./lib/readline, instead of
the readline built in-tree. All rl_* symbols are then undefined at link
time. Link the in-tree archive by path.

Tested by building nativesdk-bash for x86_64-darwin.

AI-Generated: Claude Sonnet 5.5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-extended/bash/bash_%.bbappend | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 recipes-extended/bash/bash_%.bbappend

diff --git a/recipes-extended/bash/bash_%.bbappend b/recipes-extended/bash/bash_%.bbappend
new file mode 100644
index 0000000..31d46a6
--- /dev/null
+++ b/recipes-extended/bash/bash_%.bbappend
@@ -0,0 +1,5 @@
+# "-lreadline" resolves to the macOS SDK's libreadline.tbd stub (found via
+# the runtime/usr/lib -L path, which comes before -L./lib/readline) instead
+# of the readline built in-tree, which leaves all rl_* symbols undefined.
+# Link the in-tree archive by path.
+EXTRA_OEMAKE:append:darwin21 = " 'READLINE_LIB=$(READLINE_LIBRARY)'"
-- 
2.43.0


