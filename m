Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C49ECD5BD1
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:06 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7097.1779624958810064257
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:15:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pevl9nQU;
 spf=pass (domain: konsulko.com, ip: 209.85.221.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-575267e3398so7327626e0c.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624958; x=1780229758; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0h4IMj1xafCDkR6Bmp1bZLBgYlry7jUmO56RVKS4uI=;
        b=pevl9nQU2pa1t5NxY3/pq9nhI899sybTYgliQpmpSOGkJx7FS1oyEBBMh2ndOlTfWK
         uyRmPs5OqhjFbvsYz1cnGLes+QKRK9HDiieba4fXCRg4EzfKN9rkvnv6BB5NWMfPcn/E
         G7TZJpC+4VahKlJ+haPpxsPLqRezRmwy4rVi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624958; x=1780229758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V0h4IMj1xafCDkR6Bmp1bZLBgYlry7jUmO56RVKS4uI=;
        b=owCGLmUVifnBBsCqLAqtOSdheRE6rW9f7Owjnd5B5u80Qg/BStmrm4DEczFx4QyaHM
         ucBU1+r0hXKMmbMcm5Tb5hLkz2AZZp2+N9bRlB4Ek7PEvTpxzbzLQR65yO0fh5WhfvL3
         kKbgKxuCK3aAqlW1YBoQpHnozqUyVEd57p8lLOZ56nR0KujeqrMfdPK8NX/RlWscuJ/A
         +DiaK1qTShIm6VAbFppQxhyqnU47mktFMytO1skS7ly1rYYAAF5tqOGtHC7sI42bZuYp
         Tguva/Vahf41ELU8cDxkWLulO9pgPT+he+RywKKj82rnb6bcFHNjWNF9g72XuFcC610r
         7lYA==
X-Gm-Message-State: AOJu0YzmjX5sinjEVeMZGOSLzBTCvqtoxDj7xxSIBwSO2oWGI+4Q/jNA
	qcjO6WO5+SmJYpPLEcsBc3/VXMG9RlBZa2kYjdCSThJl6vOH6v1iaQLfD/W6+TWw6aQPdYDHlsG
	/jMJJ
X-Gm-Gg: Acq92OEX3XdSNxcktZzDyXmP6HT9AxFwRiClTL5qOmUyCCxB7qdYlI3gRxCBLl7ZipS
	fTVDxLElEYxZu02iHxe0pijpWwqSAfdfCw+kWgWqaIGldqyMpOzK8Mt6aokAQ3tLLJbtZ3b7fGI
	T4zkT2TGAfmy5Bi8ptudElJSiKcyv/wzvdq/rfZmrMwLUsLDf1mtixfYsAc4IiL0aArM848n12U
	1sITarQbVwBfZ6zg2VonuhYfdOuq/YrDRYNXcXFc0sKLuHmkNc+VMrQletO0ul7aX79kLcIiLI3
	Jch3d5RdmDdWkb8iMtboudhZ1MZ4S6WpfGNEpsf84DMFD245gzfQAKk01p2zAfagG0uQB14hEVR
	by9MKX2/2qaQXUWTgYVmh81zaHhlTXiVaRkZSxPsiO4r7oIZ9z6m+jLMeCQbgHbmwesCVOrbudC
	VZs+59kkNTkykTgPCNO+97+FckxDvjQkAobYc651tY3CuWfrvw3WRVRafc4SaBZGuEpYimappw6
	pToUXys+yI5jtd1hqV5eppFE7iYr6w2lb5kIntCp1TxNLCh9VZxlqvylGgcrfA+
X-Received: by 2002:a05:6122:924:b0:56d:451b:e4dd with SMTP id 71dfb90a1353d-5866395de75mr5556050e0c.12.1779624957431;
        Sun, 24 May 2026 05:15:57 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.15.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:15:57 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 02/13] layer.conf: correct WARN_QA
Date: Sun, 24 May 2026 08:15:29 -0400
Message-ID: <07ea3222dbeace90b2ae81a34ca6222aef300d4f.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4008

From: Li Zhou <li.zhou@windriver.com>

Fix the typo "tmp-layer" in "WARN_QA:append".
The right name for this layer in OVERRIDES is layer-tpm-layer
by checking "bitbake -e <recipe_name> | grep ^OVERRIDES=".

Signed-off-by: Li Zhou <li.zhou@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index c0fd7a7..3ea7c08 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -27,4 +27,4 @@ networking-layer:${LAYERDIR}/dynamic-layers/meta-networking/recipes-*/*/*.bbappe
 
 addpylib ${LAYERDIR}/lib oeqa
 
-WARN_QA:append:tmp-layer = " patch-status missing-metadata"
+WARN_QA:append:layer-tpm-layer = " patch-status missing-metadata"
-- 
2.53.0


