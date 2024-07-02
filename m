Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240BAC3064D
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 09:06:18 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web11.20234.1719911169463885690
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Jul 2024 02:06:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dBzN1exh;
 spf=pass (domain: gmail.com, ip: 209.85.208.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso787233a12.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jul 2024 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719911168; x=1720515968; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iay3Q47KNVdDA+BAG/8dUoL6VbbzZotgrZ/WgxW9Wf4=;
        b=dBzN1exhK3gB+MCAaDphhMRNSUuMgKLeb4EPnYht6razfbvY34Wt4NpDVUKroFrkUh
         dE/q3/aHvr5id3Os67psuoSAKxRwuzCL5mW6x0NjUfEsqzYzt3M2so0BSYnczlqwTSms
         3g2u9sJzWLU5epBnbV1mTEaMHtb4szUqBK/XwEFMJwZK8kw6CJncuF3FYzuTQuqhuC26
         3zyXubLE8bBIm7kdHl3Ie/68tL94lmdhKjW1kZ7beSLh9xhJ8LYeU/msCwrFHyZqD8G0
         7O5CABZN/gSWPpWXuzgyI/E8pwSrxKlczIWcsFx6CeM/QN1crsX8zBbSzJPgrF01NDC6
         4NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719911168; x=1720515968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iay3Q47KNVdDA+BAG/8dUoL6VbbzZotgrZ/WgxW9Wf4=;
        b=a6DtJQtHHuqUL2F1HE9ekpOWVIg4tjgpUcXYu6pZ0UeUTQ3cg0bVS+xTwgGUQUrKB/
         nWnYxJt3ZNeoQM1MTyWs2QJthSr2Hp6H21go0NX7tdlxUJElboP1E5bKVNhqLBpe4Pru
         2daTyh1r8cKeLNI8pguibLTqhy42I2iA0N47GOg00fsbCjMtS0rXnbBRQZJUQx7mqg+g
         BOtyW2IQTbNsskJu2ZmQTSKcF3W/MTwaYvoP5zC+m5fmeonqJxTa1iN3hzWfb19KsxDW
         eBaThw3Rc93ga9UZbgZoOGoFqOdQPby5tGcO2eW7fFyUSpHVXV/OHGHH6ckx8R9KK/PD
         DziA==
X-Gm-Message-State: AOJu0YyqNq2WKUMmo6zzPD5nRC3FxKdRxcmfo18jbPsziTeYZI4FDoPC
	0NRCDolXk5WQhEMAXhPgTPm9DiSMakjI/TQs/82doXYR/V8Wcrbc4nlVSg==
X-Google-Smtp-Source: AGHT+IFQDpPtBOGz2gKTgJ1zN8jSAJnUkggqAN99vYJiBChy/etVasfbOrbY0dUeuIrmJixR6n6LRw==
X-Received: by 2002:a05:6402:845:b0:57c:9c5d:d195 with SMTP id 4fb4d7f45d1cf-587a0bfeb46mr5426876a12.27.1719911167476;
        Tue, 02 Jul 2024 02:06:07 -0700 (PDT)
Received: from fedora.fritz.box ([2a02:2454:299:c100:b25:37c3:ea9f:574c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58bce1922c8sm255217a12.13.2024.07.02.02.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:06:07 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>
Subject: [yocto-autobuilder-helper][PATCH] config.json: use private DL_DIR for AUH runs
Date: Tue,  2 Jul 2024 11:06:01 +0200
Message-ID: <20240702090601.885502-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jul 2024 09:06:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/408

AUH can produce broken recipes that can't complete do_fetch, and
this results in removal of files in DL_DIR, which races with
other builds, as seen here:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=15540

[YOCTO #15540]

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
---
 config.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.json b/config.json
index 799b2b3..4a7099a 100644
--- a/config.json
+++ b/config.json
@@ -1554,6 +1554,7 @@
         "auh" : {
             "NEEDREPOS" : ["poky", "auto-upgrade-helper"],
             "extravars" :[
+                "DL_DIR = '${TOPDIR}/downloads'",
                 "INHERIT += 'buildhistory'",
                 "LICENSE_FLAGS_ACCEPTED = 'commercial'",
                 "DISTRO_FEATURES:append:libc-glibc = ' systemd usrmerge'",
@@ -1579,6 +1580,7 @@
         "auh-meta-oe": {
             "NEEDREPOS": ["poky", "auto-upgrade-helper", "meta-openembedded"],
             "extravars": [
+                "DL_DIR = '${TOPDIR}/downloads'",
                 "INHERIT += 'buildhistory'",
                 "LICENSE_FLAGS_ACCEPTED = 'commercial'",
                 "DISTRO_FEATURES:append:libc-glibc = ' systemd usrmerge'",
-- 
2.45.1


