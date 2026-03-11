Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E724A104C001
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17314.1773223492450406825
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 03:04:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SPJI1lMr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439af00d33cso11122571f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773223490; x=1773828290; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ohiE+MGFBoRKu1zbEGV6P8m6OKgr2bn50AfqSUkjm/c=;
        b=SPJI1lMrLG7QyOzds5iWtYeeC0DeGA75cHcbTFD4HUBhbg6Vh3mm7ALg+3zAhHLwBG
         PAVBbqff3UNtzGFUnRNfHF7b9tl0yjxgL9U4KN0a32DK5ZuKzN2BA9FwQ/0ms5y73F0/
         8S08K+rlwZ8vwgmOARdck1TS9yHYBPRTRqUrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223490; x=1773828290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohiE+MGFBoRKu1zbEGV6P8m6OKgr2bn50AfqSUkjm/c=;
        b=Mu+39fV03oMHVbIna2JP4aehHWnS/mMsl/M+9Dt/K6Y65rSEnacvziL94JxrwUeDoo
         LADDrToASPorgt62AmueTnwStK3KFGb8/tvXvDYQ/CXWl8jukNFfunuf0+u7XShxi4gD
         TsnRfE3qM93s0nKQFFReULHufHZj8I5xtUED/xHdbxgeIWvTIoG5a4U5DABGyASnTzyD
         eQcq0R9O6GU3C6/QKOd8vLIzZL8ZmPdKJB7UJzONh4NltnwDAkCLznVI0nNUfL+oKwzx
         fmvxFgitVYSB7C4JiPeOGeMvectIbjClwT1U54UxnsQ8eLA0fofks7Jz4z3LsZgAOuOX
         FHdA==
X-Gm-Message-State: AOJu0YxCHOAJiygnYNlAGtd/J2I/Nz/MaLk+pLbI6oQmxQVaTUqtVwY3
	KvukYGzXQ8C0t2pRKsHsD/LAjlbG8Sz1aSj0lA/WPRPbVJCmQ2obYL922O/s19IkRGa2R09/P/A
	FGj9iQos=
X-Gm-Gg: ATEYQzyyNPYT52qbDKHaf74tk2rGdD2PXDe9b69iZ64k33m5PMns83rRovhfpWk5L+G
	ACmeCH0cODMxs6CT9NHhXNThngx/uZ/d0G4Dhb25OV3/Tbq9BaEOEkRx5wQnrFO/4wXRcKasszN
	FswJsM8m1DSfPoiNT3XqZBeyLR71QHnv/iMwaFQalopsrBc0/EW292mPJfYntCv+1Y+uh7SedEE
	j2K5Rzb/PEredvPwNCF1ZM1fQ8l7PoA3CIU87Z1q539oCFEbHDrUYm72P77Prywvr3Ss7kxR+Av
	Ii5OaBZUOEI/IzY239JhnLgn8CBnGdN04vAGyutNdmrLOxfk8pQF5j94RaTBjwIc6C3AbfMFxsp
	Y/l+KCgenubDUf+/ERstvLlVdbkMooJpBxyWcdUT3kbGfQqS2MXJ6F5QOHO/o4L4Uf4x65zVNva
	fazYpkeSo51/UOQ8xRV5cSMbKQ+VwlfKucgZUZljqn5q1X9JSQYCE=
X-Received: by 2002:a05:6000:24c2:b0:439:c62a:6dc2 with SMTP id ffacd0b85a97d-439f821deb7mr3794819f8f.41.1773223490234;
        Wed, 11 Mar 2026 03:04:50 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7fc5:b1af:c486:ad0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm5939994f8f.13.2026.03.11.03.04.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:04:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Set OEQA_TESTDISPLAY in autobuilder config
Date: Wed, 11 Mar 2026 10:04:48 +0000
Message-ID: <20260311100448.3407168-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3432

To allow the small number of important tests that really need a DISPLAY set to
run, set the new variable to point at that display.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index cf27ae4..96aa62e 100644
--- a/config.json
+++ b/config.json
@@ -46,6 +46,7 @@
         "extravars" : [
             "SANITY_TESTED_DISTROS = ''",
             "BB_HASHSERVE = '${AUTOBUILDER_HASHSERV}'",
+            "OEQA_TESTDISPLAY = ':1'",
             "OE_FRAGMENTS += 'core/yocto-autobuilder/autobuilder core/yocto-autobuilder/autobuilder-resource-constraints'",
             "EXTRA_IMAGE_FEATURES ?= 'allow-empty-password empty-root-password allow-root-login'"
         ]

